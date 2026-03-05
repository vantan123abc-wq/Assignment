package controller;

import dao.OrderDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Order;

@WebServlet(name = "ReturnRequestController", urlPatterns = { "/return-request" })
public class ReturnRequestController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = orderDao.getOrderById(orderId);

            // Security check: ensure the order belongs to the logged-in user
            if (order != null && order.getAccountId() == account.getId()) {
                // Check if the order status is eligible for return (e.g., DELIVERED)
                if ("DELIVERED".equals(order.getStatus()) || "COMPLETED".equals(order.getStatus())) {
                    String returnReason = request.getParameter("returnReason");
                    if (returnReason == null || returnReason.trim().isEmpty()) {
                        returnReason = "Không có lý do cụ thể";
                    }
                    boolean success = orderDao.updateOrderStatusWithReason(orderId, "RETURN_REQUESTED", returnReason);
                    if (success) {
                        utils.NotificationHelper.returnRequested(session, orderId, request.getContextPath());
                        session.setAttribute("message", "Yêu cầu trả hàng đã được gửi thành công.");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Có lỗi xảy ra khi gửi yêu cầu trả hàng.");
                        session.setAttribute("messageType", "error");
                    }
                } else {
                    session.setAttribute("message", "Đơn hàng này không đủ điều kiện để trả lại.");
                    session.setAttribute("messageType", "error");
                }
            } else {
                session.setAttribute("message", "Đơn hàng không tồn tại hoặc không thuộc về bạn.");
                session.setAttribute("messageType", "error");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("message", "ID đơn hàng không hợp lệ.");
            session.setAttribute("messageType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/order-history");
    }
}
