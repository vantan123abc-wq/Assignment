package controller;

import dao.AccountDao;
import dao.OrderDao;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Order;
import utils.EmailService;

@WebServlet(name = "AdminOrderController", urlPatterns = { "/admin/orders", "/admin/orders/update-status" })
public class AdminOrderController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();
    private final AccountDao accountDao = new AccountDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null || !"ADMIN".equals(account.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Order> orders = orderDao.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/admin-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null || !"ADMIN".equals(account.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/admin/orders/update-status".equals(path)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String newStatus = request.getParameter("status");

                Order order = orderDao.getOrderById(orderId);

                boolean success = orderDao.updateOrderStatus(orderId, newStatus);

                if (success) {
                    // Gửi email thông báo nếu admin chấp nhận yêu cầu trả hàng
                    if ("RETURN_ACCEPTED".equals(newStatus) && order != null) {
                        sendReturnAcceptedEmail(order);
                        // Thêm thông báo chuông server-side cho khách hàng (cross-session)
                        utils.NotificationHelper.returnAccepted(
                                order.getAccountId(), order.getId(), request.getContextPath());
                    }
                    session.setAttribute("message", "Cập nhật trạng thái đơn hàng thành công.");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Cập nhật trạng thái thất bại.");
                    session.setAttribute("messageType", "error");
                }
            } catch (Exception e) {
                session.setAttribute("message", "Dữ liệu không hợp lệ.");
                session.setAttribute("messageType", "error");
            }
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    private void sendReturnAcceptedEmail(Order order) {
        try {
            Account customer = accountDao.findById(order.getAccountId());
            if (customer == null || customer.getEmail() == null || customer.getEmail().isEmpty()) {
                Logger.getLogger(AdminOrderController.class.getName()).warning(
                        "Cannot send return email: customer not found or has no email for orderId=" + order.getId());
                return;
            }

            String customerName = customer.getFullName() != null ? customer.getFullName() : customer.getUsername();
            String formattedAmount = NumberFormat.getNumberInstance(new Locale("vi", "VN"))
                    .format(order.getTotalAmount()) + " ₫";

            String subject = "✅ [Nông Sản Việt] Yêu cầu hoàn trả đơn hàng #" + order.getId() + " đã được chấp nhận";
            String htmlContent = buildReturnEmail(customerName, order.getId(), formattedAmount);

            EmailService emailService = new EmailService();
            emailService.sendMail(customer.getEmail(), subject, htmlContent);

            Logger.getLogger(AdminOrderController.class.getName()).info(
                    "Return accepted email sent to: " + customer.getEmail() + " for orderId=" + order.getId());

        } catch (Exception e) {
            // Không để lỗi mail ảnh hưởng đến logic chính
            Logger.getLogger(AdminOrderController.class.getName()).log(Level.WARNING,
                    "Failed to send return confirmation email for orderId=" + order.getId(), e);
        }
    }

    private String buildReturnEmail(String customerName, int orderId, String amount) {
        return "<!DOCTYPE html>"
                + "<html lang='vi'><head><meta charset='UTF-8'/>"
                + "<style>"
                + "body{font-family:'Segoe UI',Arial,sans-serif;background:#f4f7f4;margin:0;padding:0;}"
                + ".container{max-width:600px;margin:30px auto;background:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.08);}"
                + ".header{background:#4cae4f;padding:32px 40px;text-align:center;}"
                + ".header h1{color:white;margin:0;font-size:22px;font-weight:800;letter-spacing:-0.5px;}"
                + ".header p{color:rgba(255,255,255,0.85);margin:8px 0 0;font-size:14px;}"
                + ".body{padding:36px 40px;}"
                + ".icon-box{text-align:center;margin-bottom:28px;}"
                + ".icon-box span{font-size:56px;}"
                + "h2{color:#1a2e1a;font-size:20px;margin:0 0 16px;}"
                + "p{color:#4a5568;line-height:1.7;margin:0 0 16px;font-size:15px;}"
                + ".info-box{background:#f0faf0;border:1px solid #c6e8c6;border-radius:10px;padding:20px 24px;margin:24px 0;}"
                + ".info-box strong{display:block;color:#1a2e1a;font-size:13px;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:4px;}"
                + ".info-box span{color:#2d6a2f;font-weight:700;font-size:18px;}"
                + ".step{display:flex;align-items:flex-start;gap:12px;margin-bottom:14px;}"
                + ".step-num{background:#4cae4f;color:white;border-radius:50%;width:24px;height:24px;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:12px;flex-shrink:0;padding-top:1px;}"
                + ".step-text{color:#4a5568;font-size:14px;padding-top:2px;}"
                + ".footer{background:#f8faf8;border-top:1px solid #e8f0e8;padding:24px 40px;text-align:center;}"
                + ".footer p{color:#718096;font-size:12px;margin:0;}"
                + ".footer a{color:#4cae4f;text-decoration:none;}"
                + "</style></head><body>"
                + "<div class='container'>"
                + "  <div class='header'>"
                + "    <h1>🌿 Nông Sản Việt</h1>"
                + "    <p>Tươi sạch từ Nông Trại đến Bàn Ăn</p>"
                + "  </div>"
                + "  <div class='body'>"
                + "    <div class='icon-box'><span>✅</span></div>"
                + "    <h2>Xin chào " + customerName + ",</h2>"
                + "    <p>Chúng tôi rất vui được thông báo rằng yêu cầu <strong>hoàn trả hàng</strong> của bạn đã được <strong style='color:#4cae4f;'>chấp nhận thành công</strong>.</p>"
                + "    <div class='info-box'>"
                + "      <strong>Đơn hàng</strong><span>#" + orderId + "</span>"
                + "      <br/><br/>"
                + "      <strong>Số tiền hoàn lại (dự kiến)</strong><span>" + amount + "</span>"
                + "    </div>"
                + "    <p>Tiền hoàn trả sẽ được xử lý theo quy trình sau:</p>"
                + "    <div class='step'><div class='step-num'>1</div><div class='step-text'>Chúng tôi xác nhận đã nhận được hàng trả lại từ bạn.</div></div>"
                + "    <div class='step'><div class='step-num'>2</div><div class='step-text'>Tiền hoàn sẽ được chuyển về tài khoản/ví nguyên thủy của bạn trong vòng <strong>3–5 ngày làm việc</strong>.</div></div>"
                + "    <div class='step'><div class='step-num'>3</div><div class='step-text'>Nếu có vấn đề, đội hỗ trợ sẽ liên hệ bạn qua email hoặc số điện thoại đã đăng ký.</div></div>"
                + "    <p>Cảm ơn bạn đã tin tưởng và mua sắm tại <strong>Nông Sản Việt</strong>. Chúng tôi luôn nỗ lực cải thiện chất lượng dịch vụ.</p>"
                + "  </div>"
                + "  <div class='footer'>"
                + "    <p>Email này được gửi tự động. Vui lòng không trả lời trực tiếp.<br/>"
                + "    Liên hệ hỗ trợ: <a href='mailto:lienhe@nongsanviet.vn'>lienhe@nongsanviet.vn</a> | Hotline: 1900 6789</p>"
                + "  </div>"
                + "</div>"
                + "</body></html>";
    }
}
