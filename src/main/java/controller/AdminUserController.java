package controller;

import dao.AccountDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

@WebServlet(name = "AdminUserController", urlPatterns = { "/admin/users" })
public class AdminUserController extends HttpServlet {

    private final AccountDao accountDao = new AccountDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters
        String searchKeyword = request.getParameter("keyword");
        String roleKeyword = request.getParameter("role");
        String pageStr = request.getParameter("page");

        int page = 1;
        int size = 10;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1)
                    page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Fetch Stats
        long totalUsers = accountDao.countAllUsers();
        long activeUsers = accountDao.countActiveUsers();
        long newUsers = accountDao.countNewUsers(30);

        // Fetch Table Data & Pagination
        long filteredUserCount = accountDao.countUsers(roleKeyword, searchKeyword);
        int totalPages = (int) Math.ceil((double) filteredUserCount / size);
        if (totalPages == 0)
            totalPages = 1;

        List<Account> usersList = accountDao.findUsers(roleKeyword, searchKeyword, page, size);

        // Set Attributes
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("newUsers", newUsers);

        request.setAttribute("usersList", usersList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalFilteredUsers", filteredUserCount);

        // Pass back params for pagination and tabs
        request.setAttribute("paramRole", roleKeyword);
        request.setAttribute("paramKeyword", searchKeyword);

        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("toggleStatus".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    accountDao.toggleUserStatus(id);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }

        // Preserve query parameters on redirect
        StringBuilder redirectUrl = new StringBuilder(request.getContextPath() + "/admin/users?");
        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");
        String page = request.getParameter("page");

        if (keyword != null && !keyword.isEmpty()) {
            redirectUrl.append("keyword=").append(java.net.URLEncoder.encode(keyword, "UTF-8")).append("&");
        }
        if (role != null && !role.isEmpty()) {
            redirectUrl.append("role=").append(java.net.URLEncoder.encode(role, "UTF-8")).append("&");
        }
        if (page != null && !page.isEmpty()) {
            redirectUrl.append("page=").append(page).append("&");
        }

        response.sendRedirect(redirectUrl.toString());
    }
}
