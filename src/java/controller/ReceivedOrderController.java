/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 *
 * @author xuant
 */
@WebServlet(name="ReceivedOrderController", urlPatterns={"/ReceivedOrderController"})
public class ReceivedOrderController extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String orderId = request.getParameter("orderID");
        String shipCode = request.getParameter("shipCode");      
        String apiUrl = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/detail";
        String responseString = callApiWithShipCode(apiUrl, shipCode);

        PrintWriter out = response.getWriter();
        if (responseString != null) {          
            processShippingOrderResponse(orderId, responseString, out, request, response);
        } else {
            out.write("Error calling the API.");
        }
    } 
    private String callApiWithShipCode(String apiUrl, String shipCode) {
        String responseString = null;
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Token", "a4cf5c26-7379-11ef-8e53-0a00184fe694");
            connection.setRequestProperty("ShopId", "194471");  
            connection.setDoOutput(true);          
            String payload = "{\"order_code\": \"" + shipCode + "\"}";
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = payload.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }

            responseString = response.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }

  
    private void processShippingOrderResponse(String orderId, String responseString, PrintWriter out, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        
            JsonObject jsonResponse = new Gson().fromJson(responseString, JsonObject.class);

         
            if (jsonResponse.has("data") && jsonResponse.getAsJsonObject("data").has("log")) {
            
                JsonArray logArray = jsonResponse.getAsJsonObject("data").getAsJsonArray("log");

                if (logArray != null && logArray.size() > 0) {
                  
                    JsonObject latestLog = logArray.get(logArray.size() - 1).getAsJsonObject();
                    String latestStatus = latestLog.has("status") ? latestLog.get("status").getAsString() : null;

              
                    if ("delivered".equals(latestStatus)) {                     
                        OrderDAO dao = new OrderDAO();
                        int orderIdInt = Integer.parseInt(orderId);
                        boolean success = dao.updateOrderStatusDelivery(orderIdInt, "Delivered");

                        if (success) {
                            request.setAttribute("orderStatusMessage", "The order has been successfully updated to 'Delivered'.");
                        } else {
                            request.setAttribute("orderStatusMessage", "Failed to update the order status.");
                        }
                    } else {
                        request.setAttribute("orderStatusMessage", "The order has not been picked yet. Latest status: " + latestStatus);
                    }
                } else {
                    request.setAttribute("orderStatusMessage", "No log entries found for the order.");
                }
            } else {
                request.setAttribute("orderStatusMessage", "The shipper has not delivered the order yet.");
            }

            
            request.getRequestDispatcher("MainController?action=OrderHistory").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("orderStatusMessage", "Error processing the API response.");
            request.getRequestDispatcher("orderdetail-admin.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
