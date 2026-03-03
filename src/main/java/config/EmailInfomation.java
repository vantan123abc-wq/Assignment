package config;

/**
 * Cấu hình email. Đọc từ biến môi trường, fallback về giá trị mặc định khi dev local.
 *
 * Để bảo mật khi deploy production:
 *   - Windows: setx GMAIL_USERNAME "your@gmail.com" && setx GMAIL_APP_PASSWORD "xxxx xxxx xxxx xxxx"
 *   - Linux/Mac: export GMAIL_USERNAME=your@gmail.com
 *   - Tomcat: thêm vào setenv.sh hoặc catalina.properties
 */
public class EmailInfomation {
    public static final String MAIL_HOST = "smtp.gmail.com";
    public static final String MAIL_PORT = "587";

    // Đọc từ biến môi trường, nếu không có thì dùng giá trị dev local
    public static final String MAIL_USERNAME = getEnvOrDefault("GMAIL_USERNAME", "vantan123abc@gmail.com");
    public static final String APP_PASSWORD   = getEnvOrDefault("GMAIL_APP_PASSWORD", "tqbg elaf pqlk kcvh");
    public static final String MAIL_NAME      = getEnvOrDefault("GMAIL_DISPLAY_NAME", "banhang@shopnongsan.vn");

    private static String getEnvOrDefault(String envKey, String defaultValue) {
        String val = System.getenv(envKey);
        return (val != null && !val.isBlank()) ? val : defaultValue;
    }
}
