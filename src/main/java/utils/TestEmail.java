package utils;

public class TestEmail {
    public static void main(String[] args) {
        System.out.println("Testing email service...");
        EmailService service = new EmailService();
        try {
            service.send("vantan123abc@gmail.com", "Test from script", "Hello world!");
            System.out.println("Email sent successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
