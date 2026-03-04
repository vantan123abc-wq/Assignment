package filter;

import java.io.IOException;
import java.util.Arrays; 
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    // 1. Định nghĩa danh sách các URL chính xác được phép truy cập tự do
    private static final String[] PUBLIC_EXACT_URLS = {
        "/", "/chat", "/index_1.jsp", "/index.jsp", 
        "/login.jsp", "/login", "/register.jsp", "/register", 
        "/forget.jsp", "/forget", "/verify.jsp", "/verify", 
        "/inventory.jsp"
    };

    // 2. Định nghĩa các thư mục/tiền tố được truy cập tự do (như CSS, JS, Images)
    private static final String[] PUBLIC_PREFIXES = {
        "/assets/"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Lấy đường dẫn chính xác (đã loại bỏ ContextPath để so sánh chuẩn hơn)
        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = requestURI.substring(contextPath.length()); 

        // --- BƯỚC 1: KIỂM TRA TRANG CÔNG KHAI ---
        boolean isPublicExact = Arrays.stream(PUBLIC_EXACT_URLS).anyMatch(path::equals);
        boolean isPublicPrefix = Arrays.stream(PUBLIC_PREFIXES).anyMatch(path::startsWith);

        if (isPublicExact || isPublicPrefix) {
            chain.doFilter(request, response);
            return;
        }

        // --- BƯỚC 2: KIỂM TRA ĐĂNG NHẬP ---
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            req.setAttribute("error", "Vui lòng đăng nhập trước khi xem!");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        // --- BƯỚC 3: PHÂN QUYỀN (AUTHORIZATION) ---
        if (path.startsWith("/admin")) { // Dùng startsWith an toàn hơn contains
            Account acc = (Account) session.getAttribute("account");
            String role = acc.getRole();
            
            if (role == null || !role.trim().equalsIgnoreCase("ADMIN")) {
                res.sendRedirect(req.getContextPath() + "/index.jsp");
                return;
            }
        }

        // Hợp lệ, đi tiếp
        chain.doFilter(request, response);
    }
}