/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import dto.OrderDTO;
import dto.OrderHistoryDTO;
import dto.ProductOrderDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author xuant
 */
@WebServlet(name = "OrderHistoryController", urlPatterns = {"/OrderHistoryController"})
public class OrderHistoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession();           
        UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");     
        int page = 1;
        int pageSize = 1;
        try {          
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {          
            page = 1;
        }
        if (user != null) {
            OrderDAO dao = new OrderDAO();         
            List<OrderHistoryDTO> orders = dao.getOrderHistory(user.getUserID(), page, pageSize);                     
            for (OrderHistoryDTO orderDTO : orders) {               
                List<ProductOrderDTO> products = dao.getProductsByOrderId(orderDTO.getOrderID());               
                List<ProductOrderDTO> updatedProducts = new ArrayList<>();
                for (ProductOrderDTO product : products) {                  
                    ProductOrderDTO p = new ProductOrderDTO();
                    p.setProductID(product.getProductID());
                    p.setProductName(product.getProductName());
                    p.setImageUrl(product.getImageUrl());
                    p.setPrice(product.getPrice());
                    p.setQuantity(product.getQuantity());                   
                    updatedProducts.add(p); 
                }             
                orderDTO.setProduct(updatedProducts);
            }                     
            int totalOrders = dao.getTotalOrdersCount(user.getUserID());         
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);                
            request.setAttribute("orderHistory", orders);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);                     
            request.getRequestDispatcher("order-history.jsp").forward(request, response);
        } else {          
            response.sendRedirect("login.jsp");
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
