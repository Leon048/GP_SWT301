/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

/**
 *
 * @author xuant
 */
public class EmailUtils {
    public static void sendRegistrationEmail(String recipientEmail, String fullName, String password) throws MessagingException {
        final String fromEmail = ""; 
        final String appPassword = "";  

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
                Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Registration Confirmation");

        String emailContent = "Dear " + fullName + ",\n\n"
                + "Thank you for registering with us.\n"
                + "Here are your registration details:\n\n"
                + "Full Name: " + fullName + "\n"
                + "Email: " + recipientEmail + "\n"
                + "Password: " + password + "\n\n"
                + "Please keep this information safe.\n\n"
                + "Best regards,\nYour Company";

        message.setText(emailContent);

        Transport.send(message);
    }
}
