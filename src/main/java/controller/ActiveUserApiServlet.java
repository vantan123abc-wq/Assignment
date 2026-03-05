package controller;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/api/active-users") // Đường dẫn API để Frontend gọi xuống
public class ActiveUserApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Lấy số người dùng đang online từ ServletContext (đã được lưu bởi Listener trước đó)
        ServletContext context = getServletContext();
        Integer activeUsers = (Integer) context.getAttribute("activeUsers");
        
        if (activeUsers == null) {
            activeUsers = 0;
        }

        // Cấu hình response trả về định dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Trả về chuỗi JSON. Ví dụ: {"count": 15}
        response.getWriter().write("{\"count\": " + activeUsers + "}");
    }
}