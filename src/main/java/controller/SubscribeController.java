package controller;

import dao.SubscriberDAO;
import utils.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebServlet(name = "SubscribeController", urlPatterns = { "/subscribe" })
public class SubscribeController extends HttpServlet {

    private final SubscriberDAO subscriberDAO = new SubscriberDAO();
    private final EmailService emailService = new EmailService();
    private final ExecutorService executorService = Executors.newFixedThreadPool(2);

    @Override
    public void destroy() {
        super.destroy();
        if (executorService != null && !executorService.isShutdown()) {
            executorService.shutdown();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=error&email=");
            return;
        }

        email = email.trim().toLowerCase();

        if (subscriberDAO.exists(email)) {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=exists&email="
                    + java.net.URLEncoder.encode(email, "UTF-8"));
            return;
        }

        boolean success = subscriberDAO.insert(email);
        if (success) {
            final String submittedEmail = email;
            executorService.submit(() -> sendConfirmationEmail(submittedEmail));

            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=success&email="
                    + java.net.URLEncoder.encode(email, "UTF-8"));
        } else {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=error&email="
                    + java.net.URLEncoder.encode(email, "UTF-8"));
        }
    }

    private void sendConfirmationEmail(String toEmail) {
        try {
            String subject = "Đăng ký nhận thông báo thành công - Nông Sản Việt";
            String content = "<div style=\"font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 8px; overflow: hidden;\">"
                    + "<div style=\"background-color: #28a745; color: #ffffff; padding: 20px; text-align: center;\">"
                    + "<h2 style=\"margin: 0;\">Chào mừng bạn đến với Nông Sản Việt!</h2>"
                    + "</div>"
                    + "<div style=\"padding: 20px; background-color: #f9f9f9;\">"
                    + "<p style=\"font-size: 16px; color: #333;\">Cảm ơn bạn đã đăng ký nhận thông tin từ chúng tôi.</p>"
                    + "<p style=\"font-size: 16px; color: #333;\">Từ nay, bạn sẽ là một trong những người đầu tiên nhận được thông báo về các chương trình khuyến mãi, giảm giá sốc và sản phẩm mới nhất của Nông Sản Việt.</p>"
                    + "<p style=\"font-size: 16px; color: #333;\">Chúc bạn có những trải nghiệm mua sắm tuyệt vời cùng chúng tôi!</p>"
                    + "</div>"
                    + "<div style=\"background-color: #e9ecef; color: #6c757d; padding: 15px; text-align: center; font-size: 14px;\">"
                    + "Trân trọng,<br><strong>Đội ngũ Nông Sản Việt</strong>"
                    + "</div>"
                    + "</div>";
            emailService.sendMail(toEmail, subject, content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }
}
