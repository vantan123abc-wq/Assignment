<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="dao.SubscriberDAO" %>
        <%@ page import="java.util.List" %>
            <%@ page import="utils.EmailService" %>
                <%@ page import="config.EmailInfomation" %>
                    <% out.println("<h3>Testing Email Configuration</h3>");
                        out.println("MAIL_USERNAME: " + EmailInfomation.MAIL_USERNAME + "<br />");
                        // Don't print the whole password, just length to verify
                        out.println("APP_PASSWORD length: " + (EmailInfomation.APP_PASSWORD != null ?
                        EmailInfomation.APP_PASSWORD.length() : "null") + "<br />");

                        try {
                        SubscriberDAO dao = new SubscriberDAO();
                        List<String> emails = dao.getAllActiveEmails();
                            out.println("<h4>Active Subscribers (" + emails.size() + "):</h4>");
                            for (String email : emails) {
                            out.println("- " + email + "<br />");
                            }

                            if (emails.isEmpty()) {
                            out.println("<p style='color:red'>No active subscribers to send emails to!</p>");
                            } else {
                            out.println("<h4>Trying to send test email to first subscriber: " + emails.get(0) + "</h4>
                            ");
                            EmailService service = new EmailService();
                            service.sendMail(emails.get(0), "Test email from diagnostic script", "<h1>If you see this,
                                email sending works!</h1>");
                            out.println("<p style='color:green'>Test email sent successfully without exception!</p>");
                            }

                            } catch (Exception e) {
                            out.println("<h4 style='color:red'>Exception Occurred:</h4>");
                            out.println("
                            <pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
                            }
                            %>