/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author admin
 */
public class ExceptionTest {

    public void validateUser(String username, int age, String email) {
        if (username == null || username.isEmpty()) {
            throw new IllegalArgumentException("Username cannot be null or empty");
        }

        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }

        if (!email.contains("@")) {
            throw new IllegalArgumentException("Invalid email format");
        }
    }

    public void processPayment(double amount, String method, boolean isVerified) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than 0");
        }

        if (method == null || (!method.equals("CASH") && !method.equals("CARD"))) {
            throw new IllegalArgumentException("Payment method must be CASH or CARD");
        }

        if (!isVerified) {
            throw new SecurityException("User is not verified to make payment");
        }

    }

    public void uploadFile(String fileName, long fileSize, String fileType) {
        if (fileName == null || fileName.trim().isEmpty()) {
            throw new IllegalArgumentException("File name cannot be null or empty");
        }

        if (fileSize <= 0 || fileSize > 10_000_000) { // giới hạn 10MB
            throw new IllegalArgumentException("Invalid file size");
        }

        if (!fileType.equals("jpg") && !fileType.equals("png") && !fileType.equals("pdf")) {
            throw new UnsupportedOperationException("Unsupported file type");
        }

    }
}
