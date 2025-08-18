/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.CartDTO;
import dto.CartItemDTO;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author xuant
 */
public class CartDAO {

    public boolean addToCart(int userId, int productId) {
        String getStockSql = "SELECT StockQuantity FROM Products WHERE ProductID = ?";
        String getCartQuantitySql = "SELECT Quantity FROM Cart WHERE UserID = ? AND ProductID = ?";
        String updateCartSql = "UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID = ? AND ProductID = ?";
        String insertCartSql = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (?, ?, 1)";

        try (Connection conn = DBUtils.getConnection()) {
            int stockQuantity = 0;
            int cartQuantity = 0;

          
            try (PreparedStatement ps = conn.prepareStatement(getStockSql)) {
                ps.setInt(1, productId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    stockQuantity = rs.getInt("StockQuantity");
                }
            }

            
            try (PreparedStatement ps = conn.prepareStatement(getCartQuantitySql)) {
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    cartQuantity = rs.getInt("Quantity");

                    if (cartQuantity < stockQuantity) {
                        try (PreparedStatement psUpdate = conn.prepareStatement(updateCartSql)) {
                            psUpdate.setInt(1, userId);
                            psUpdate.setInt(2, productId);
                            return psUpdate.executeUpdate() > 0;
                        }
                    } else {
                        return false; 
                    }
                } else {
                    if (stockQuantity > 0) {
                        try (PreparedStatement psInsert = conn.prepareStatement(insertCartSql)) {
                            psInsert.setInt(1, userId);
                            psInsert.setInt(2, productId);
                            return psInsert.executeUpdate() > 0;
                        }
                    } else {
                        return false; 
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<CartDTO> getCartByUser(int userID) {
        List<CartDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE UserID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CartDTO cart = new CartDTO(
                        rs.getInt("CartID"),
                        rs.getInt("UserID"),
                        rs.getInt("ProductID"),
                        rs.getInt("Quantity")
                );
                list.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getCartCount(int userId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Cart WHERE UserID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<CartItemDTO> getCartItems(int userID) {
        List<CartItemDTO> list = new ArrayList<>();
        String sql = "SELECT c.ProductID, p.ProductName, p.ImageUrl, c.Quantity, p.DiscountPrice "
                + "FROM Cart c JOIN Products p ON c.ProductID = p.ProductID WHERE c.UserID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CartItemDTO item = new CartItemDTO(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("ImageUrl"),
                        rs.getInt("Quantity"),
                        rs.getDouble("DiscountPrice")
                );
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getTotalAmount(int userID) {
        String sql = "SELECT SUM(c.Quantity * p.DiscountPrice) AS Total FROM Cart c "
                + "JOIN Products p ON c.ProductID = p.ProductID WHERE c.UserID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("Total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean deleteItem(int userID, int productID) {
        String sql = "DELETE FROM Cart WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, productID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean decreaseFromCart(int userId, int productId) {
        String getQuantitySql = "SELECT Quantity FROM Cart WHERE UserID = ? AND ProductID = ?";
        String updateSql = "UPDATE Cart SET Quantity = Quantity - 1 WHERE UserID = ? AND ProductID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement getStmt = conn.prepareStatement(getQuantitySql)) {

            getStmt.setInt(1, userId);
            getStmt.setInt(2, productId);
            ResultSet rs = getStmt.executeQuery();

            if (rs.next()) {
                int quantity = rs.getInt("Quantity");
                if (quantity > 1) {
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, userId);
                        updateStmt.setInt(2, productId);
                        return updateStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void clearCart(int userId) throws Exception {
        String sql = "DELETE FROM Cart WHERE UserID = ?";
        try (Connection con = DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }

    public CartItemDTO getCartItemForBuyNow(int productId, int quantity) throws SQLException, ClassNotFoundException {
        String sql = "SELECT ProductName, ImageUrl, DiscountPrice FROM Products WHERE ProductID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CartItemDTO item = new CartItemDTO();
                item.setProductID(productId);
                item.setProductName(rs.getString("ProductName"));
                item.setImageUrl(rs.getString("ImageUrl"));
                item.setDiscountPrice(rs.getDouble("DiscountPrice"));
                item.setQuantity(quantity);
                return item;
            }
        }
        return null;
    }

}
