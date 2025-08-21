/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package test;

import org.junit.Test;
/**
 *
 * @author admin
 */
public class ExceptionTestTest {

private ExceptionTest exceptionTest = new ExceptionTest();

    // Test case 1: Username null -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testUsernameNullThrowsException() {
        exceptionTest.validateUser(null, 20, "test@example.com");
    }

    // Test case 2: Tuổi âm -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testNegativeAgeThrowsException() {
        exceptionTest.validateUser("John", -5, "test@example.com");
    }

    // Test case 3: Email không hợp lệ -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testInvalidEmailThrowsException() {
        exceptionTest.validateUser("John", 20, "invalidEmail");
    }

    // Test case 4: Số tiền <= 0 -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testAmountZeroOrNegativeThrowsException() {
        exceptionTest.processPayment(0, "CASH", true);
    }

    // Test case 5: Phương thức thanh toán không hợp lệ -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testInvalidPaymentMethodThrowsException() {
        exceptionTest.processPayment(100, "CRYPTO", true);
    }

    // Test case 6: Người dùng chưa xác minh -> SecurityException
    @Test(expected = SecurityException.class)
    public void testUnverifiedUserThrowsException() {
        exceptionTest.processPayment(100, "CARD", false);
    }

    // Test case 7: Tên file null -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testFileNameNullThrowsException() {
       exceptionTest.uploadFile(null, 1000, "jpg");
    }

    // Test case 8: Kích thước file không hợp lệ -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testInvalidFileSizeThrowsException() {
        exceptionTest.uploadFile("image.jpg", -500, "jpg");
    }

    // Test case 9: Loại file không hỗ trợ -> UnsupportedOperationException
    @Test(expected = UnsupportedOperationException.class)
    public void testUnsupportedFileTypeThrowsException() {
        exceptionTest.uploadFile("document.docx", 1000, "docx");
    }
}
