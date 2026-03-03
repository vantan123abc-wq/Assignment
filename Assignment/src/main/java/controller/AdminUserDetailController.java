package controller;

import dao.AccountDao;
import dao.AddressDao;
import dao.OrderDao;
import dao.ReviewDao;
import dao.UserStatsDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Address;
import model.Order;
import model.Review;
import model.UserStats;

@WebServlet(name = "AdminUserDetailController", urlPatterns = { "/admin/users/detail" })
public class AdminUserDetailController extends HttpServlet {

    private final AccountDao accountDao = new AccountDao();
    private final OrderDao orderDao = new OrderDao();
    private final AddressDao addressDao = new AddressDao();
    private final ReviewDao reviewDao = new ReviewDao();
    private final UserStatsDao userStatsDao = new UserStatsDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        Account user = accountDao.findById(userId);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        // Current tab (default: orders)
        String tab = request.getParameter("tab");
        if (tab == null || tab.isEmpty())
            tab = "orders";

        // Pagination
        int page = 1;
        int size = 5;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException ignored) {
            }
        }

        // Stats
        UserStats stats = userStatsDao.getStats(userId);

        // Tab data
        int totalItems = 0;
        if ("orders".equals(tab)) {
            List<Order> orders = orderDao.findOrdersByAccount(userId, page, size);
            totalItems = orderDao.countOrdersByAccount(userId);
            request.setAttribute("orders", orders);
        } else if ("addresses".equals(tab)) {
            List<Address> addresses = addressDao.getAddressesByAccountId(userId);
            totalItems = addresses.size();
            request.setAttribute("addresses", addresses);
        } else if ("reviews".equals(tab)) {
            List<Review> reviews = reviewDao.findReviewsByAccount(userId, page, size);
            totalItems = reviewDao.countReviewsByAccount(userId);
            request.setAttribute("reviews", reviews);
        }

        int totalPages = (int) Math.ceil((double) totalItems / size);
        if (totalPages == 0)
            totalPages = 1;

        request.setAttribute("detailUser", user);
        request.setAttribute("stats", stats);
        request.setAttribute("activeTab", tab);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);

        request.getRequestDispatcher("/admin/user-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        int userId = 0;
        try {
            userId = Integer.parseInt(idStr);
        } catch (NumberFormatException ignored) {
        }

        if (userId > 0) {
            // Prevent admin from modifying themselves
            HttpSession session = request.getSession(false);
            Account currentAdmin = (session != null) ? (Account) session.getAttribute("account") : null;
            boolean isSelf = (currentAdmin != null && currentAdmin.getId() == userId);

            if ("toggleStatus".equals(action) && !isSelf) {
                accountDao.toggleUserStatus(userId);
            } else if ("changeRole".equals(action) && !isSelf) {
                String newRole = request.getParameter("newRole");
                if (newRole != null && !newRole.isEmpty()) {
                    accountDao.changeRole(userId, newRole);
                }
            }
        }

        // Redirect back preserving tab
        String tab = request.getParameter("tab");
        String redirect = request.getContextPath() + "/admin/users/detail?id=" + userId;
        if (tab != null && !tab.isEmpty())
            redirect += "&tab=" + tab;
        response.sendRedirect(redirect);
    }
}
