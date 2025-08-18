/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.MessagingException;
import utils.EmailUtils;

/**
 *
 * @author xuant
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    private static final String SUCCESS = "login.jsp";
    private static final String ERROR = "register.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = ERROR;
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String address = request.getParameter("address");

            if (fullName == null || fullName.trim().isEmpty()) {
                request.setAttribute("ERROR", "Full name is required.");
            } else if (email == null || email.trim().isEmpty()) {
                request.setAttribute("ERROR", "Email is required.");
            } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
                request.setAttribute("ERROR", "Invalid email format.");
            } else if (password == null || password.trim().isEmpty()) {
                request.setAttribute("ERROR", "Password is required.");
            } else if (password.length() < 6) {
                request.setAttribute("ERROR", "Password must be at least 6 characters.");
            } else if (!password.equals(confirmPassword)) {
                request.setAttribute("ERROR", "Password and confirm password do not match.");
            } else {
                UserDAO dao = new UserDAO();
                boolean exists = dao.checkEmailExists(email);
                if (exists) {
                    request.setAttribute("ERROR", "Email already registered.");
                } else {
                    UserDTO newUser = new UserDTO();
                    newUser.setFullName(fullName);
                    newUser.setEmail(email);
                    newUser.setPasswordHash(password);
                    newUser.setPhone(phone);
                    newUser.setAddress(address);
                    newUser.setRoleID(1);
                    newUser.setLoyaltyPoints(0);
                    newUser.setIsActive(true);

                    boolean success = dao.insertUser(newUser);
                    if (success) {
                        try {
                            EmailUtils.sendRegistrationEmail(email, fullName, password);
                        } catch (MessagingException e) {
                            log("Email sending failed: " + e.toString());
                        }

                        url = SUCCESS;
                        request.setAttribute("success", "Register successfully. Please login.");
                    } else {
                        request.setAttribute("ERROR", "Registration failed. Please try again.");
                    }
                }

            }

        } catch (Exception e) {
            log("Error at RegisterController: " + e.toString());
            request.setAttribute("ERROR", "System error. Please try again.");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
