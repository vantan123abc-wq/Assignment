package utils;

import java.util.List;
import dao.ProductDao;
import model.ChatMessage;

public class PromptBuilder {

    private static final String SYSTEM_INSTRUCTION = "Bạn là một nhân viên tư vấn bán hàng chuyên nghiệp cho cửa hàng Nông Sản Việt. "
            +
            "Chỉ tư vấn dựa trên danh sách sản phẩm hiện có của cửa hàng. " +
            "Không tự bịa ra giá bán, không bịa ra sản phẩm không có thực. " +
            "Trả lời ngắn gọn, lịch sự, chuyên nghiệp. ";

    public static String buildJsonPayload(String userMessage, List<ChatMessage> history) {
        ProductDao productDao = new ProductDao();
        String shopData = productDao.getShopDataAsText();

        StringBuilder promptText = new StringBuilder();
        promptText.append(SYSTEM_INSTRUCTION).append("\n\n");
        promptText.append(shopData).append("\n\n");

        // Append history
        if (history != null && !history.isEmpty()) {
            promptText.append("Lịch sử trò chuyện:\n");
            for (ChatMessage msg : history) {
                promptText.append(msg.getRole().equals("user") ? "Khách: " : "Bạn: ")
                        .append(msg.getContent()).append("\n");
            }
        }

        promptText.append("Khách: ").append(userMessage).append("\nBạn (hãy trả lời): ");

        // Escape JSON safely
        String escapedText = promptText.toString()
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "");

        return "{\n" +
                "  \"contents\": [\n" +
                "    {\n" +
                "      \"parts\": [\n" +
                "        {\n" +
                "          \"text\": \"" + escapedText + "\"\n" +
                "        }\n" +
                "      ]\n" +
                "    }\n" +
                "  ]\n" +
                "}";
    }
}
