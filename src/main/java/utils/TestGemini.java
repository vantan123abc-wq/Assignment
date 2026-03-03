package utils;

import java.util.ArrayList;
import java.util.List;
import model.ChatMessage;

public class TestGemini {
    public static void main(String[] args) {
        System.out.println("Building Prompt Payload...");
        List<ChatMessage> history = new ArrayList<>();

        String payload = PromptBuilder.buildJsonPayload("Cửa hàng có bán táo không?", history);
        System.out.println("Payload: \n" + payload);

        System.out.println("\nCalling Gemini...");
        String response = GeminiClient.callGemini(payload);

        System.out.println("\nFinal Response: ");
        System.out.println(response);
    }
}
