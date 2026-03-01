/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // Clean Bypass for public paths
        // Cho phép anonymous dùng chat (vì khách chưa đăng nhập) và các trang công khai
       
        if (uri.endsWith("/chat") ||
                uri.endsWith("/index_1.jsp") ||
                uri.endsWith("/index.jsp") ||
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

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            req.setAttribute("error", "Vui l\u00f2ng \u0111\u0103ng nh\u1eadp tr\u01b0\u1edbc khi xem!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }
        chain.doFilter(request, response);

    }
}
