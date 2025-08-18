/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.CartItemDTO;
import dto.OrderDTO;
import dto.OrderDetailDTO;
import dto.OrderHistoryDTO;
import dto.ProductDTO;
import dto.ProductDetailDTO;
import dto.ProductOrderDTO;
import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jdk.jfr.Timestamp;

/**
 *
 * @author xuant
 */
public class OrderDAO {

    public int createOrderAndReturnId(int userId, String name, String email, String phone, String address, int paymentMethodId, double totalAmount, String statusOrder, String orderCodeGHN) {
        String sql = "INSERT INTO Orders (UserID, FullName, Email, Phone, Address, PaymentMethodID, TotalAmount, OrderDate, Status, StatusOrder, ShippingCode) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), 'Pending', ?, ?);";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userId);
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, address);
            stmt.setInt(6, paymentMethodId);
            stmt.setDouble(7, totalAmount);
            stmt.setString(8, statusOrder);
            stmt.setString(9, orderCodeGHN);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean addOrderDetail(int orderId, List<CartItemDTO> cartItems) {
        String sql = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (CartItemDTO item : cartItems) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProductID());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getDiscountPrice());
                stmt.addBatch();
            }

            int[] result = stmt.executeBatch();
            for (int count : result) {
                if (count == 0) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "Update Orders SET Status = ? WHERE OrderID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);
            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateOrderStatusDelivery(int orderId, String newStatusDelivery) {
        String sql = "Update Orders SET StatusOrder = ? WHERE OrderID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatusDelivery);
            stmt.setInt(2, orderId);
            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<OrderDTO> getOrders(int page, int pageSize) {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = "SELECT OrderID, UserID, OrderDate, TotalAmount, Status, Address, PaymentMethodID, ShippingCode, StatusOrder, "
                + "UsedPoints, Note, FullName, Email, Phone "
                + "FROM Orders "
                + "ORDER BY OrderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {         
            ps.setInt(1, (page - 1) * pageSize);         
            ps.setInt(2, pageSize);           
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(new OrderDTO(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getTimestamp("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        rs.getString("Status"),
                        rs.getString("Address"),
                        rs.getInt("PaymentMethodID"),
                        rs.getInt("UsedPoints"),
                        rs.getString("Note"),
                        rs.getString("FullName"),
                        rs.getString("StatusOrder"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("ShippingCode")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // Method to get the total number of orders
    public int getTotalOrdersCount() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Orders";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public OrderDTO getOrderById(int orderID) {
        OrderDTO order = null;
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new OrderDTO(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getTimestamp("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        rs.getString("Status"),
                        rs.getString("Address"),
                        rs.getInt("PaymentMethodID"),
                        rs.getInt("UsedPoints"),
                        rs.getString("Note"),
                        rs.getString("FullName"),
                        rs.getString("StatusOrder"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("ShippingCode")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }

    // Get order items by Order ID
    public List<OrderDetailDTO> getOrderDetailsByOrderId(int orderID) {
        List<OrderDetailDTO> orderDetails = new ArrayList<>();
        String sql = "SELECT od.OrderDetailID, od.OrderID, od.ProductID, p.ProductName, p.ImageUrl, "
                + "od.Quantity, od.UnitPrice "
                + "FROM [Vegetable].[dbo].[OrderDetails] od "
                + "JOIN [Vegetable].[dbo].[Products] p ON od.ProductID = p.ProductID "
                + "WHERE od.OrderID = ?";  // Ensuring that deleted products are excluded

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                orderDetails.add(new OrderDetailDTO(
                        rs.getInt("OrderDetailID"),
                        rs.getInt("OrderID"),
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("ImageUrl"),
                        rs.getInt("Quantity"),
                        rs.getDouble("UnitPrice")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public List<OrderHistoryDTO> getOrderHistory(int userId, int page, int pageSize) {
        List<OrderHistoryDTO> orderHistory = new ArrayList<>();
        String sql = "WITH PaginatedOrders AS ("
                + "    SELECT DISTINCT o.OrderID, o.OrderDate, o.Status,o.StatusOrder,o.ShippingCode, o.TotalAmount, o.FullName, o.Email, o.Phone, o.PaymentMethodID, o.Address, "
                + "           p.ProductID, p.ProductName, p.ImageUrl, oi.Quantity, oi.UnitPrice, "
                + "           ROW_NUMBER() OVER (PARTITION BY o.OrderID ORDER BY o.OrderDate DESC) AS RowNum "
                + "    FROM Orders o "
                + "    JOIN OrderDetails oi ON o.OrderID = oi.OrderID "
                + "    JOIN Products p ON oi.ProductID = p.ProductID "
                + "    WHERE o.UserID = ? "
                + ") "
                + "SELECT * FROM PaginatedOrders "
                + "WHERE RowNum = 1 "
                + "ORDER BY OrderDate DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();
            Map<Integer, OrderHistoryDTO> orderMap = new HashMap<>();

            while (rs.next()) {
                int orderId = rs.getInt("OrderID");

                OrderHistoryDTO order = orderMap.get(orderId);

                if (order == null) {
                    order = new OrderHistoryDTO();
                    order.setOrderID(orderId);
                    order.setOrderDate(rs.getDate("OrderDate"));
                    order.setStatus(rs.getString("Status"));
                    order.setStatusOrder(rs.getString("StatusOrder"));
                    order.setShipCode(rs.getString("ShippingCode"));
                    order.setAddress(rs.getString("Address"));
                    order.setPhone(rs.getString("Phone"));
                    order.setFullName(rs.getString("FullName"));
                    order.setPaymentMethodID(rs.getInt("PaymentMethodID"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setProduct(new ArrayList<>());
                    orderMap.put(orderId, order);
                }
            }
            orderHistory.addAll(orderMap.values());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderHistory;
    }

    public int getTotalOrdersCount(int userId) {
        int totalOrders = 0;
        String sql = "SELECT COUNT(*) FROM Orders WHERE UserID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalOrders;
    }

    public List<ProductOrderDTO> getProductsByOrderId(int orderId) {
        List<ProductOrderDTO> products = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.DiscountPrice, p.ImageUrl, oi.Quantity "
                + "FROM OrderDetails oi "
                + "JOIN Products p ON oi.ProductID = p.ProductID "
                + "WHERE oi.OrderID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductOrderDTO product = new ProductOrderDTO();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getDouble("DiscountPrice"));
                product.setImageUrl(rs.getString("ImageUrl"));
                product.setQuantity(rs.getInt("Quantity"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

}
