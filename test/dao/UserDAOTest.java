/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package dao;

import dto.UserDTO;
import org.junit.Test;
import static org.junit.Assert.*;

public class UserDAOTest {

    // Case 1: Login thành công (email và password hợp lệ, tồn tại trong DB)
    @Test(timeout = 2000) // timeout 2s
    public void testCheckLogin_Success() throws Exception {
        UserDAO dao = new UserDAO();
        String email = "hoalove@gmail.com";   // <-- sửa lại đúng với DB của bạn
        String password = "123456";           // <-- sửa lại đúng với DB của bạn

        UserDTO user = dao.checkLogin(email, password);
        assertNotNull("User should not be null when login success", user);
        assertEquals(email, user.getEmail());
    }

    // Case 2: Sai password
    @Test(timeout = 2000)
    public void testCheckLogin_WrongPassword() throws Exception {
        UserDAO dao = new UserDAO();
        String email = "admin@example.com";   // email đúng
        String password = "wrongpass";        // password sai

        UserDTO user = dao.checkLogin(email, password);
        assertNull("User should be null when password is incorrect", user);
    }

    // Case 3: Email không tồn tại
    @Test(timeout = 2000)
    public void testCheckLogin_EmailNotExist() throws Exception {
        UserDAO dao = new UserDAO();
        String email = "notfound@example.com";
        String password = "123456";

        UserDTO user = dao.checkLogin(email, password);
        assertNull("User should be null when email does not exist", user);
    }

    // Case 4: Email và Password null (giá trị biên)
    @Test(timeout = 2000)
    public void testCheckLogin_NullValues() throws Exception {
        UserDAO dao = new UserDAO();
        String email = null;
        String password = null;

        UserDTO user = dao.checkLogin(email, password);
        assertNull("User should be null when email/password is null", user);
    }
}
