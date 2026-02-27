package utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import config.GeminiConfig;

public class GeminiClient {

    public static String callGemini(String jsonPayload) {
        try {
            URL url = new URL(GeminiConfig.getModelEndpoint());
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            connection.setRequestProperty("X-goog-api-key", GeminiConfig.getApiKey());
            connection.setDoOutput(true);
            connection.setConnectTimeout(10000); // 10 seconds connect timeout
            connection.setReadTimeout(30000); // 30 seconds read timeout

            // Send payload
            System.out.println("--- GEMINI PAYLOAD ---");
            System.out.println(jsonPayload);
            System.out.println("----------------------");

            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonPayload.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Read response
            int status = connection.getResponseCode();
            BufferedReader in;
            if (status >= 200 && status < 300) {
                in = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
            } else {
                in = new BufferedReader(new InputStreamReader(connection.getErrorStream(), StandardCharsets.UTF_8));
                StringBuilder errorResponse = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    errorResponse.append(inputLine);
                }
                in.close();
                System.err.println("Gemini API Error (" + status + "): " + errorResponse.toString());
                return "Xin lỗi, hiện tại hệ thống AI đang bận hoặc gặp lỗi kết nối. Vui lòng thử lại sau.";
            }

            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Very Basic JSON parsing to extract "text" field without external library
            return parseGeminiTextResponse(response.toString());

        } catch (Exception e) {
            System.err.println("Exception calling Gemini: ");
            e.printStackTrace();
            return "Lỗi khi kết nối với AI: " + e.getMessage();
        }
    }

    private static String parseGeminiTextResponse(String json) {
        try {
            // Looking for "text": "..."
            String searchStr = "\"text\": \"";
            int startIndex = json.indexOf(searchStr);
            if (startIndex != -1) {
                startIndex += searchStr.length();
                // Find the next unescaped quote
                int endIndex = startIndex;
                while (endIndex < json.length()) {
                    if (json.charAt(endIndex) == '"' && json.charAt(endIndex - 1) != '\\') {
                        break;
                    }
                    endIndex++;
                }
                if (endIndex < json.length()) {
                    String text = json.substring(startIndex, endIndex);
                    // Unescape newlines and quotes
                    text = text.replace("\\n", "\n").replace("\\\"", "\"").replace("\\\\", "\\");
                    return text;
                }
            }
        } catch (Exception e) {
            System.err.println("Error parsing Gemini response: " + e.getMessage());
        }
        return "Xin lỗi, tôi không thể xử lý câu trả lời ngay bây giờ.";
    }
}
