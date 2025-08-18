package dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import okhttp3.*;
import utils.DBUtils;

public class ChatDAO {

    private String API_KEY = "AIzaSyDWnZEKpCEr3LhWKILpjr8wVSb6QP8qwrs";
//    private String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY;

    public String getAllProductsInfo() throws ClassNotFoundException {
        StringBuilder productInfo = new StringBuilder();
        String sql = "SELECT ProductID, ProductName FROM Products";

        try (Connection conn = DBUtils.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");

                String productLink = "MainController?action=ProductDetail&productID=" + productId;

                productInfo.append("Found product: " + productName + "\n")
                        .append("You can check the product details here: " + productLink + "\n");
            }

            if (productInfo.length() == 0) {
                productInfo.append("Sorry, no products found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            productInfo.append("There was an error fetching product details.");
        }

        return productInfo.toString();
    }

    public String getChatbotResponse(String userMessage) throws IOException {
        String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY;

        // Build the request body
        String jsonPayload = "{\n"
                + "  \"messages\": [\n"
                + "    { \"role\": \"user\", \"content\": \"" + userMessage + "\" }\n"
                + "  ]\n"
                + "}";

        // Create the connection
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Authorization", "Bearer " + API_KEY);  
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);

        // Send the request
        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = jsonPayload.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // Read the response
        try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"))) {
            StringBuilder response = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            return response.toString();  // Return the response from the API
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + connection.getResponseCode();
        }
    }

}
