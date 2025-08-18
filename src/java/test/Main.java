package test;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CartDAO;
import dao.ChatDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.VoucherDAO;
import dto.ChatProductDTO;
import dto.ImageProductDTO;
import dto.OrderDTO;
import dto.ProductDTO;
import dto.ProductDetailDTO;
import dto.ReviewDTO;
import dto.VoucherDTO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Scanner;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import utils.DBUtils;
import utils.EmailUtils;

public class Main {

    public static void main(String[] args) throws Exception {
//        String jsonData = buildOrderData("Thanh", "0397258963", "adfasdfdas","HCM","Quận 10","Phường 14", 32423423,1);
//        System.out.println(jsonData);
//        String orderCode = createGHNOrder(jsonData);  // Corrected the variable name here
//        if (orderCode != null) {  // Corrected the variable name here
//            System.out.println("API Response: Order created successfully with order code: " + orderCode);
//        } else {
//            System.out.println("Failed to create order.");
//        }

//           OrderDAO orderDAO = new OrderDAO();
//            List<OrderDTO> orders = orderDAO.getOrders(1,4);
//            for (OrderDTO order : orders) {
//            System.out.println(orders.toString());
////           boolean success = orderDAO.updateOrderStatusDelivery(92, "Delivering");
//            }
//          ProductDAO dao = new ProductDAO();
//          List<ReviewDTO> sc = dao.getProductReviews(12);
//          System.out.println(sc.toString());
//         Scanner scanner = new Scanner(System.in);
//        ChatDAO chatDAO = new ChatDAO();
//        
//        System.out.println("Chatbot: Hi! How can I assist you today?");
//        
//        while (true) {
//            System.out.print("You: ");
//            String userInput = scanner.nextLine();
//
//            if (userInput.equalsIgnoreCase("exit")) {
//                System.out.println("Chatbot: Goodbye!");
//                break;
//            }
//
//            // Send user input to the ChatDAO and get the AI response
//            String botResponse = chatDAO.getChatbotResponse(userInput);
//
//            // Output the response
//            System.out.println("Chatbot: " + botResponse);
//            
//            
//        }
//
//        scanner.close();
//        String API_KEY = "AIzaSyDWnZEKpCEr3LhWKILpjr8wVSb6QP8qwrs";
//        String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY;
//        OkHttpClient client = new OkHttpClient();
//        MediaType mediaType = MediaType.parse("application/json");
//        String jsonBody = "{\"contents\":[{\"parts\":[{\"text\":\"I want to vegetable fresh\"}]}]}";
//        RequestBody body = RequestBody.create(mediaType, jsonBody);
//
//        Request request = new Request.Builder()
//                .url(apiUrl) // URL API với key
//                .post(body)
//                .addHeader("Authorization", "Bearer " + API_KEY)
//                .addHeader("Content-Type", "application/json")
//                .build();
//        Response response = client.newCall(request).execute();
//         if (response.isSuccessful()) {
////            return response.body().string();
//System.out.println(response.body().string());
//        } else {
////            return "Error: " + response.code();
//             System.out.println(response.code());
//        }
//        System.out.println(request);
//        System.out.println(request.headers());
//        ChatDAO dao = new ChatDAO();
//        String message = dao.getChatbotResponse("I want to vegetable fresh");
//
//        System.out.println(message);
//         EmailUtils.sendRegistrationEmail("xuanthanh01122003@gmail.com", "Thanhlee", "12345");

//     ProductDAO dao = new ProductDAO();
//            List<ChatProductDTO> productList = dao.getAllProducts();
//            for (ChatProductDTO productDTO : productList) {
//                System.out.println(productDTO.toString());
//        }
//        VoucherDAO dao = new VoucherDAO();
//        List<VoucherDTO> v = dao.getAllVouchers();
//        for (VoucherDTO voucherDTO : v) {
//            System.out.println(v.toString());
//        }

//        boolean sc = dao.addVoucher(new VoucherDTO("EQNAHAFDC", 10, true));
//        System.out.println(sc);
        
//         int productID = 15;
//            ProductDAO dao = new ProductDAO();
//            CartDAO cartDAO = new CartDAO();
//            ProductDetailDTO product = dao.getProductById(productID);
//            List<ProductDetailDTO> relatedProducts = dao.getRelatedProducts(productID);
//            List<ImageProductDTO> imageProducts = dao.getProductImages(productID);

        
        System.out.println(DBUtils.getConnection());
        

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

            // Prepare the payload
            String payload = "{\"order_code\": \"" + shipCode + "\"}";
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = payload.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Read the response
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
