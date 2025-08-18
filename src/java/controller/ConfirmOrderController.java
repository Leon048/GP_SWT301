package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import dao.OrderDAO;
import dao.ProductDAO;
import dto.CartItemDTO;
import dto.OrderDetailDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

@WebServlet(name = "ConfirmOrderController", urlPatterns = {"/ConfirmOrderController"})
public class ConfirmOrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderID");
        String shipCode = request.getParameter("shipCode");

        // Send the shipCode to the external API
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

    // Method to process the response and check the status of the order
    private void processShippingOrderResponse(String orderId, String responseString, PrintWriter out, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            JsonObject jsonResponse = new Gson().fromJson(responseString, JsonObject.class);
            if (jsonResponse.has("data") && jsonResponse.getAsJsonObject("data").has("log")) {
                JsonArray logArray = jsonResponse.getAsJsonObject("data").getAsJsonArray("log");
                if (logArray != null && logArray.size() > 0) {
                    JsonObject latestLog = logArray.get(logArray.size() - 1).getAsJsonObject();
                    String latestStatus = latestLog.has("status") ? latestLog.get("status").getAsString() : null;
                    if ("picked".equals(latestStatus)) {
                        OrderDAO dao = new OrderDAO();
                        int orderIdInt = Integer.parseInt(orderId);
                        boolean success = dao.updateOrderStatusDelivery(orderIdInt, "Delivering");
                        if (success) {
                            List<OrderDetailDTO> items = dao.getOrderDetailsByOrderId(orderIdInt);
                            ProductDAO productDAO = new ProductDAO();
                            for (OrderDetailDTO item : items) {
                                productDAO.updateProductAfterPurchase(item.getProductID(), item.getQuantity());
                            }
                            request.setAttribute("orderStatusMessage", "The order has been successfully updated to 'Delivering'.");
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
                request.setAttribute("orderStatusMessage", "The shipper has not picked up the order yet.");
            }

            request.getRequestDispatcher("MainController?action=OrderDetailManagement").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("orderStatusMessage", "Error processing the API response.");
            request.getRequestDispatcher("orderdetail-admin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for confirming order and checking shipper's pickup status";
    }
}
