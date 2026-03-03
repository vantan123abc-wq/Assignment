package utils;

public class TestEmail {
    public static void main(String[] args) {
        System.out.println("Starting email test...");
        try {
            EmailService service = new EmailService();
            service.sendMail("vantan123abc@gmail.com", "Test Subject", "<h1>Hello</h1>");
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
