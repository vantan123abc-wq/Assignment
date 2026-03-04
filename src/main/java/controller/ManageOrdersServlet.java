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

// Đánh dấu URL này để trình duyệt truy cập không bị 404
@WebServlet(name = "ManageOrdersServlet", urlPatterns = {"/admin/orders", "/admin/update-order-status"})
public class ManageOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        OrderDao orderDao = new OrderDao();
        List<Order> orderList = orderDao.getAllOrdersForAdmin();
        
        request.setAttribute("orderList", orderList);
        
        // Đảm bảo file orders.jsp của bạn đang nằm trong folder admin nhé
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Nhận dữ liệu AJAX khi Admin đổi trạng thái
        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        if (orderIdStr != null && status != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                OrderDao orderDao = new OrderDao();
                boolean isUpdated = orderDao.updateOrderStatusAdmin(orderId, status);
                
                if (isUpdated) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Success");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}