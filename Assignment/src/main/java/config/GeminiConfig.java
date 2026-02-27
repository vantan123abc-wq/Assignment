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
            return "AIzaSyAzbIXzuW_fZsnWaBFK1JCiUNQ06cEIa80"; // DO NOT COMMIT TO PUBLIC REPO
        }
        return key;
    }

    public static String getModelEndpoint() {
        return "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";
    }
}
