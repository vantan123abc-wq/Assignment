package controller;

import dao.OrderDao;
import model.Account;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.CartItem;

@WebServlet(name = "MyOrdersServlet", urlPatterns = {"/users-orders"})
public class UserOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account"); // Lấy user đang đăng nhập
        
        // Nếu chưa đăng nhập, bắt ra trang login
        if (account == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDao orderDao = new OrderDao();
        List<Order> myOrders = orderDao.getOrdersByAccountId(account.getId());
        for (Order order : myOrders) {
    // Tận dụng lại hàm getItemsByOrderId đã viết ở chức năng Admin
    List<CartItem> itemsInThisOrder = orderDao.getItemsByOrderId(order.getId());
    order.setItems(itemsInThisOrder);
}
        
        request.setAttribute("myOrders", myOrders);
        request.getRequestDispatcher("users-orders.jsp").forward(request, response);
        
    }
}