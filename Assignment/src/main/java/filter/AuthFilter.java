package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account; // BẮT BUỘC PHẢI THÊM IMPORT NÀY

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // 1. Cho phép truy cập công khai không cần đăng nhập
        if (uri.endsWith("/chat") ||
                uri.endsWith("/index_1.jsp") ||
                uri.endsWith("/index.jsp") ||
                uri.equals(req.getContextPath() + "/") || // Chừa đường dẫn gốc
                uri.endsWith("/login.jsp") ||
                uri.endsWith("/login") ||
                uri.endsWith("/register.jsp") ||
                uri.endsWith("/register") ||
                uri.endsWith("/forget.jsp") ||
                uri.endsWith("/forget") ||
                uri.endsWith("/verify.jsp") ||
                uri.endsWith("/verify") ||
                uri.contains("/assets/")) {

            chain.doFilter(request, response);
            return;
        }

        // 2. Kiểm tra ĐĂNG NHẬP
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            req.setAttribute("error", "Vui lòng đăng nhập trước khi xem!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }

        // 3. PHÂN QUYỀN (AUTHORIZATION) - Bảo vệ trang admin
        if (uri.contains("demo.jsp") || uri.contains("/admin")) {
            Account acc = (Account) session.getAttribute("account");
            String role = acc.getRole();
            
            System.out.println("=== FILTER CHECK: Người dùng truy cập trang Admin có role là: " + role + " ===");
            
            if (role == null || !role.trim().equalsIgnoreCase("ADMIN")) {
                System.out.println("=== FILTER CHẶN: Không phải Admin, đẩy về trang chủ! ===");
                res.sendRedirect(req.getContextPath() + "/index.jsp");
                return;
            }
        }

        // Hợp lệ, cho phép đi tiếp đến file JSP/Servlet
        chain.doFilter(request, response);
    }
}