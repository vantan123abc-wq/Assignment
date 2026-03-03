package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ChatMessage;
import utils.GeminiClient;
import utils.PromptBuilder;
import utils.RateLimiter;

@WebServlet(name = "ChatController", urlPatterns = { "/chat" })
public class ChatController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String ip = request.getRemoteAddr();
        if (!RateLimiter.isAllowed(ip)) {
            response.setStatus(429); // Too Many Requests
            out.print("{\"reply\": \"Bạn gửi quá nhanh! Vui lòng chờ 5 giây rồi thử lại.\"}");
            out.flush();
            return;
        }

        // Read request payload
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String jsonPayload = sb.toString();

        // Extract message (rudimentary parsing to avoid external gson/jackson
        // dependencies)
        String userMessage = extractMessage(jsonPayload);
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.setStatus(400);
            out.print("{\"reply\": \"Tin nhắn trống.\"}");
            out.flush();
            return;
        }

        // Manage History via HttpSession (In memory)
        HttpSession session = request.getSession(true);
        List<ChatMessage> history = (List<ChatMessage>) session.getAttribute("chatHistory");
        if (history == null) {
            history = new ArrayList<>();
        }

        // Add user message to history
        history.add(new ChatMessage("user", userMessage));

        // Build prompt and call Gemini
        String promptJson = PromptBuilder.buildJsonPayload(userMessage, history);
        String aiResponseText = GeminiClient.callGemini(promptJson);

        // Add AI response to history
        history.add(new ChatMessage("model", aiResponseText));

        // Keep max history to 10 latest messages (5 pairs) to save token cost
        if (history.size() > 10) {
            history = history.subList(history.size() - 10, history.size());
        }
        session.setAttribute("chatHistory", history);

        // Escape JSON response
        String safeResponse = aiResponseText
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "");

        out.print("{\"reply\": \"" + safeResponse + "\"}");
        out.flush();
    }

    private String extractMessage(String json) {
        // Find {"message":"something"}
        try {
            String target = "\"message\":\"";
            int start = json.indexOf(target);
            if (start != -1) {
                start += target.length();
                int end = json.indexOf("\"", start);
                if (end != -1) {
                    return json.substring(start, end).replace("\\n", "\n").replace("\\\"", "\"");
                }
            }
            // Sometimes fetch sends {"message": "something"} with a space
            target = "\"message\": \"";
            start = json.indexOf(target);
            if (start != -1) {
                start += target.length();
                int end = json.indexOf("\"", start);
                if (end != -1) {
                    return json.substring(start, end).replace("\\n", "\n").replace("\\\"", "\"");
                }
            }
        } catch (Exception e) {
        }
        return null;
    }
}
