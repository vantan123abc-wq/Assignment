package controller;

import dao.OrderDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Order;

@WebServlet(name = "OrderHistoryController", urlPatterns = { "/order-history" })
public class OrderHistoryController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Order> orders = orderDao.getOrdersByAccountId(account.getId());

        // You could also fetch order items here if you want to display details entirely
        // in one view,
        // but for a summary view, just the orders might be enough.

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/order-history.jsp").forward(request, response);
    }
}
