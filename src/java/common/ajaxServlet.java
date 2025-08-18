/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package common;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CartDAO;
import dao.OrderDAO;
import dto.CartItemDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import javax.crypto.interfaces.PBEKey;

/**
 *
 * @author xuant
 */
@WebServlet(name = "CheckoutByVnPayController", urlPatterns = {"/CheckoutByVnPayController"})
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String name = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");            
            String province = req.getParameter("provinceSelected");        
            String district = req.getParameter("districtSelected");
            String ward = req.getParameter("wardSelected");
            String fullAddress = address + ", " + ward + ", " + district + ", " + province;
            int paymentMethodId = Integer.parseInt(req.getParameter("payment"));
            HttpSession session = req.getSession();
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user != null) {

                CartDAO dao = new CartDAO();
                String[] productIDs = req.getParameterValues("productID");
                String[] productNames = req.getParameterValues("productName");
                String[] imageUrls = req.getParameterValues("imageUrl");
                String[] discountPrices = req.getParameterValues("discountPrice");
                String[] quantities = req.getParameterValues("quantity");
                double totalAmount = Double.parseDouble(req.getParameter("totalAmount"));

                List<CartItemDTO> cartItems = new ArrayList<>();
                for (int i = 0; i < productIDs.length; i++) {
                    CartItemDTO item = new CartItemDTO();
                    item.setProductID(Integer.parseInt(productIDs[i]));
                    item.setProductName(productNames[i]);
                    item.setImageUrl(imageUrls[i]);
                    item.setDiscountPrice(Double.parseDouble(discountPrices[i]));
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    cartItems.add(item);
                }

                int cartCount = dao.getCartCount(user.getUserID());
                if (paymentMethodId == 1) {

                    String jsonData = buildOrderData(name, phone, address, province, district, ward, (int) totalAmount, 2);
                    System.out.println(jsonData);
                    String orderCodeGHN = createGHNOrder(jsonData);
                    if (orderCodeGHN != null) {
                    
                        OrderDAO orderDAO = new OrderDAO();
                        int orderId = orderDAO.createOrderAndReturnId(user.getUserID(), name, email, phone, fullAddress, paymentMethodId, totalAmount, "Pending", orderCodeGHN);
                        boolean success = orderDAO.addOrderDetail(orderId, cartItems);
                        if (success) {
                            req.getRequestDispatcher("checkout-success.jsp").forward(req, resp);
                        } else {
                            req.getRequestDispatcher("error.jsp").forward(req, resp);
                        }
                    } else {
                        req.getRequestDispatcher("MainController?action=CheckOut").forward(req, resp);
                    }

                } else {

                    String jsonData = buildOrderData(name, phone, address, province, district, ward, (int) totalAmount, 1);
                    System.out.println(jsonData);
                    String orderCodeGHN = createGHNOrder(jsonData);
                    if (orderCodeGHN != null) {
                        OrderDAO orderDAO = new OrderDAO();
                        int orderId = orderDAO.createOrderAndReturnId(user.getUserID(), name, email, phone, fullAddress, paymentMethodId, totalAmount, "Pending", orderCodeGHN);
                        boolean success = orderDAO.addOrderDetail(orderId, cartItems);
                        if (success) {
                            String vnp_Version = "2.1.0";
                            String vnp_Command = "pay";
                            String orderType = "other";
                            long amount = (long) (totalAmount * 100);
                            String bankCode = req.getParameter("bankCode");

                            String vnp_TxnRef = orderId + "";
                            String vnp_IpAddr = Config.getIpAddress(req);

                            String vnp_TmnCode = Config.vnp_TmnCode;

                            Map<String, String> vnp_Params = new HashMap<>();
                            vnp_Params.put("vnp_Version", vnp_Version);
                            vnp_Params.put("vnp_Command", vnp_Command);
                            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                            vnp_Params.put("vnp_Amount", String.valueOf(amount));
                            vnp_Params.put("vnp_CurrCode", "VND");

                            if (bankCode != null && !bankCode.isEmpty()) {
                                vnp_Params.put("vnp_BankCode", bankCode);
                            }
                            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                            vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
                            vnp_Params.put("vnp_OrderType", orderType);

                            String locate = req.getParameter("language");
                            if (locate != null && !locate.isEmpty()) {
                                vnp_Params.put("vnp_Locale", locate);
                            } else {
                                vnp_Params.put("vnp_Locale", "vn");
                            }
                            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
                            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                            String vnp_CreateDate = formatter.format(cld.getTime());
                            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                            cld.add(Calendar.MINUTE, 15);
                            String vnp_ExpireDate = formatter.format(cld.getTime());
                            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

                            List fieldNames = new ArrayList(vnp_Params.keySet());
                            Collections.sort(fieldNames);
                            StringBuilder hashData = new StringBuilder();
                            StringBuilder query = new StringBuilder();
                            Iterator itr = fieldNames.iterator();
                            while (itr.hasNext()) {
                                String fieldName = (String) itr.next();
                                String fieldValue = (String) vnp_Params.get(fieldName);
                                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                                    //Build hash data
                                    hashData.append(fieldName);
                                    hashData.append('=');
                                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                                    //Build query
                                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                                    query.append('=');
                                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                                    if (itr.hasNext()) {
                                        query.append('&');
                                        hashData.append('&');
                                    }
                                }
                            }
                            String queryUrl = query.toString();
                            String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
                            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
//                com.google.gson.JsonObject job = new JsonObject();
//                job.addProperty("code", "00");
//                job.addProperty("message", "success");
//                job.addProperty("data", paymentUrl);
//                Gson gson = new Gson();
//                resp.getWriter().write(gson.toJson(job));
                            resp.sendRedirect(paymentUrl);
                        } else {
                            req.getRequestDispatcher("error.jsp").forward(req, resp);
                        }
                    } else {
                        req.getRequestDispatcher("MainController?action=CheckOut").forward(req, resp);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }

    }

    private static String buildOrderData(String name, String phone, String address, String province, String district, String ward, int totalAmount, int type) {
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{")
                .append("\"payment_type_id\": ").append(type).append(",")
                .append("\"note\": \"Tintest 123\",")
                .append("\"required_note\": \"KHONGCHOXEMHANG\",")
                .append("\"to_name\": \"").append(name).append("\",")
                .append("\"to_phone\": \"").append(phone).append("\",")
                .append("\"to_address\": \"").append(address).append("\",")
                .append("\"to_ward_name\": \"").append(ward).append("\",")
                .append("\"to_district_name\": \"").append(district).append("\",")
                .append("\"to_province_name\": \"").append(province).append("\",")
                .append("\"cod_amount\": ").append(totalAmount).append(",")
                .append("\"content\": \"Theo New York Times\",")
                .append("\"pick_station_id\": 1444,")
                .append("\"deliver_station_id\": null,")
                .append("\"service_type_id\": 2,")
                .append("\"weight\": ").append(1000)
                .append("}");

        return jsonBuilder.toString();
    }

    private static String createGHNOrder(String jsonData) {
        try {
            // Define the API endpoint
            URL url = new URL("https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/create");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Token", "a4cf5c26-7379-11ef-8e53-0a00184fe694");  // GHN API Token
            connection.setRequestProperty("ShopId", "194471");  // Your shop ID
            connection.setDoOutput(true);

            // Write the request body
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonData.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Read the API response
            BufferedReader br;
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // Success (200)
                br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
            } else { // Error
                br = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
            }

            // Build response
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }

            // Parse the JSON response to extract the order code
            String responseBody = response.toString();
            JsonObject jsonResponse = new Gson().fromJson(responseBody, JsonObject.class);

            // Check if the response code is 200 and fetch the order_code
            if (jsonResponse.get("code").getAsInt() == 200) {
                String orderCode = jsonResponse.getAsJsonObject("data").get("order_code").getAsString();
                return orderCode;  // Return the order code
            } else {
                System.out.println("Error: " + jsonResponse.get("message").getAsString());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;  // Return null if there's an issue
    }

}
