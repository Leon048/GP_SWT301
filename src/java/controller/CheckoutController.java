/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import dao.PaymentMethodDAO;
import dao.VoucherDAO;
import dto.CartItemDTO;
import dto.PaymentMethodDTO;
import dto.UserDTO;
import dto.VoucherDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.List;

/**
 *
 * @author xuant
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user != null) {
                CartDAO dao = new CartDAO();
                VoucherDAO voucherDAO = new VoucherDAO();
                PaymentMethodDAO payDao = new PaymentMethodDAO();

                String isBuyNow = request.getParameter("action");
                String voucherCode = request.getParameter("voucherCode");

                double totalAmount = 0;
                double discount = 0;
                double finalTotal = 0;

               
                if ("BuyNow".equals(isBuyNow)) {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));

                    CartItemDTO item = dao.getCartItemForBuyNow(productId, quantity);
                    List<CartItemDTO> cartItems = List.of(item);
                    totalAmount = item.getDiscountPrice() * quantity;

                    
                    if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                        VoucherDTO voucherDTO = voucherDAO.getVoucherByCode(voucherCode);
                        if (voucherDTO != null) {
                            discount = totalAmount * (voucherDTO.getDiscountAmount() / 100.0);
                            finalTotal = totalAmount - discount;
                            request.setAttribute("voucherError", null);
                        } else {
                            finalTotal = totalAmount;
                            request.setAttribute("voucherError", "❌ Voucher invalid! ");
                        }
                    } else {
                        finalTotal = totalAmount;
                    }

                  

                    request.setAttribute("buyNow", true);
                    request.setAttribute("cartItems", cartItems);
                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("discount", discount);
                    request.setAttribute("total", finalTotal);

                } else {
                    List<CartItemDTO> cartItems = dao.getCartItems(user.getUserID());
                    totalAmount = dao.getTotalAmount(user.getUserID());

                   
                    if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                        VoucherDTO voucherDTO = voucherDAO.getVoucherByCode(voucherCode);
                        if (voucherDTO != null) {
                            discount = totalAmount * (voucherDTO.getDiscountAmount() / 100.0);
                            finalTotal = totalAmount - discount;
                            request.setAttribute("voucherError", null);
                        } else {
                            finalTotal = totalAmount;
                            request.setAttribute("voucherError", "❌ Voucher invalid! ");
                        }
                    } else {
                        finalTotal = totalAmount;
                    }

                   

                    request.setAttribute("cartItems", cartItems);
                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("discount", discount);
                    request.setAttribute("total", finalTotal);
                }

                
                int cartCount = dao.getCartCount(user.getUserID());
                request.setAttribute("cartCount", cartCount);

               
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
