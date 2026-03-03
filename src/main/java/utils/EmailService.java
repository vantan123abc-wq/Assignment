package utils;

import config.EmailInfomation;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailService {
    private final Session session;
    private final String from;

    public EmailService() {
        Properties prop = new Properties();
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", EmailInfomation.MAIL_HOST);
        prop.put("mail.smtp.port", EmailInfomation.MAIL_PORT);
        this.from = EmailInfomation.MAIL_NAME;
        this.session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EmailInfomation.MAIL_USERNAME, EmailInfomation.APP_PASSWORD);
            }
        });
    }

    /**
     * Gửi email văn bản thuần.
     */
    public void send(String to, String subject, String content) {
        sendMail(to, subject, content, false);
    }

    /**
     * Gửi email hỗ trợ HTML. Dùng cho notification giảm giá.
     */
    public void sendMail(String to, String subject, String content) {
        sendMail(to, subject, content, true);
    }

    private void sendMail(String to, String subject, String content, boolean isHtml) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            if (isHtml) {
                message.setContent(content, "text/html; charset=UTF-8");
            } else {
                message.setText(content);
            }
            Transport.send(message);
        } catch (Exception e) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, "Gửi email thất bại tới: " + to, e);
            throw new RuntimeException(e);
        }
    }
}
