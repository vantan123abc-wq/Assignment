package utils;
  import com.google.gson.*;
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
            URL url = new URL(GeminiConfig.getModelEndpoint() + "?key=" + GeminiConfig.getApiKey());
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            
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
                return "Gemini lỗi HTTP " + status + ": " + errorResponse.toString();
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
    JsonObject root = JsonParser.parseString(json).getAsJsonObject();

    JsonArray candidates = root.getAsJsonArray("candidates");
    if (candidates == null || candidates.size() == 0) return "AI không trả candidates.";

    JsonObject cand0 = candidates.get(0).getAsJsonObject();
    JsonObject content = cand0.getAsJsonObject("content");
    if (content == null) return "AI không có content.";

    JsonArray parts = content.getAsJsonArray("parts");
    if (parts == null || parts.size() == 0) return "AI không có parts.";

    JsonObject part0 = parts.get(0).getAsJsonObject();
    JsonElement textEl = part0.get("text");
    if (textEl == null) return "AI không có text.";

    return textEl.getAsString();
}
}