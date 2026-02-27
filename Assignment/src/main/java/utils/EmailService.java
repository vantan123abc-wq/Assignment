/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;
import Config.EmailInfomation;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author DELL
 */
public class EmailService {
    private  Session session;
    private String from;
    public EmailService(){
        Properties prop=new Properties();
        prop.put("mail.smtp.auth","true");
        prop.put("mail.smtp.starttls.enable","true");
        prop.put("mail.smtp.host", EmailInfomation.MAIL_HOST);
        prop.put("mail.smtp.port", EmailInfomation.MAIL_PORT);
        this.from=EmailInfomation.MAIL_NAME;
        this.session=Session.getInstance(prop,new Authenticator(){
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(EmailInfomation.MAIL_USERNAME,EmailInfomation.APP_PASSWORD);
            }
        });
    }
    public void send(String to,String subject,String content){
        try {
            Message message=new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
        } catch (Exception e) {
            throw  new RuntimeException(e);
        }
    }
    
}
