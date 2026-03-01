package config;

public class GeminiConfig {

    // Reads from environment variables, falls back to static key string if not
    // present.
    // NOTE: Hardcoding the fallback is for demonstration only.
    // In production, ensure GEMINI_API_KEY is set in your server's system
    // properties or env vars.
    public static String getApiKey() {
        String key = System.getenv("GEMINI_API_KEY");
        if (key == null || key.isEmpty()) {
            key = System.getProperty("GEMINI_API_KEY");
        }
        // Fallback for demo if properties aren't configured natively
        if (key == null || key.isEmpty()) {
            return "AIzaSyDstpVzSC9PPN-aqQB7Ghr8rtKpY4h_Xx8"; // User provided key
        }
        return key;
    }

    public static String getModelEndpoint() {
        return "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";
    }
}
