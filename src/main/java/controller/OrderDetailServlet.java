package controller;

import dao.OrderDao;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.CartItem;
@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/admin/order-detail"})
public class OrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        OrderDao dao = new OrderDao();
        
        Order order = dao.getOrderDetail(orderId);
        List<CartItem> items = dao.getItemsByOrderId(orderId);
        
        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }
}