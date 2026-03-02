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

/**
 *
 * @author DELL
 */
@WebFilter(filterName = "BlockJspFilter", urlPatterns = { "/*" })
public class BlockJspFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        
        // Thêm điều kiện !uri.endsWith("/admin.jsp") vào đây
        if (uri != null && uri.endsWith(".jsp") 
                && !uri.endsWith("/index.jsp") 
                && !uri.endsWith("/index_1.jsp")
                && !uri.endsWith("/watch.jsp")
                && !uri.endsWith("/admin.jsp") 
                && !uri.endsWith("/dashboard.jsp")) { // Thêm cả dashboard.jsp nếu bạn đang dùng nó để test
            
            res.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }
        chain.doFilter(request, response);
    }

    /**
     * Return the filter configuration object for this filter.
     */

}
