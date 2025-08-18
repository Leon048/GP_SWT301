/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.OrderDTO;
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
public class AdminDAO {

    public double getTotalRevenue() throws ClassNotFoundException {
        double totalRevenue = 0;
        String sql = "SELECT SUM(TotalAmount) FROM Orders WHERE Status = 'Completed'";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalRevenue = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }

    public int getTotalProducts() throws ClassNotFoundException {
        int totalProducts = 0;
        String sql = "SELECT COUNT(*) FROM Products WHERE IsDelete = 0";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalProducts = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProducts;
    }

    public int getTotalUsers() throws ClassNotFoundException {
        int totalUsers = 0;
        String sql = "SELECT COUNT(*) FROM Users WHERE IsActive = 1";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalUsers = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalUsers;
    }

    public int getTodaysOrders() throws ClassNotFoundException {
        int totalProducts = 0;
        String sql = "SELECT COUNT(*) \n"
                + "FROM Orders \n"
                + "WHERE CAST(OrderDate AS DATE) = CAST(GETDATE() AS DATE) \n"
                + "  AND Status = 'Completed';";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalProducts = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProducts;
    }

    public int getPendingOrders() throws ClassNotFoundException {
        int totalProducts = 0;
        String sql = "SELECT COUNT(*) FROM Orders WHERE Status = 'Pending'";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalProducts = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProducts;
    }

    public int getLowStockProducts() throws ClassNotFoundException {
        int totalOrders = 0;
        String sql = "SELECT COUNT(*) \n"
                + "FROM Products \n"
                + "WHERE StockQuantity < 5; ";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalOrders;
    }

    public List<Integer> getMonthlyRevenue() throws ClassNotFoundException {
        List<Integer> monthlyRevenue = new ArrayList<>();
        String sql = "WITH MonthList AS (\n"
                + "    SELECT 1 AS Month\n"
                + "    UNION ALL SELECT 2\n"
                + "    UNION ALL SELECT 3\n"
                + "    UNION ALL SELECT 4\n"
                + "    UNION ALL SELECT 5\n"
                + "    UNION ALL SELECT 6\n"
                + "    UNION ALL SELECT 7\n"
                + "    UNION ALL SELECT 8\n"
                + "    UNION ALL SELECT 9\n"
                + "    UNION ALL SELECT 10\n"
                + "    UNION ALL SELECT 11\n"
                + "    UNION ALL SELECT 12\n"
                + ")\n"
                + "SELECT\n"
                + "    MonthList.Month,\n"
                + "    COALESCE(SUM(Orders.TotalAmount), 0) AS TotalRevenue\n"
                + "FROM MonthList\n"
                + "LEFT JOIN Orders ON MONTH(Orders.OrderDate) = MonthList.Month \n"
                + "    AND YEAR(Orders.OrderDate) = YEAR(GETDATE())  -- Get data for the current year only\n"
                + "    AND Orders.Status = 'Completed'  -- Filter for successful orders (replace 'Completed' with your status if necessary)\n"
                + "GROUP BY MonthList.Month\n"
                + "ORDER BY MonthList.Month;";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                monthlyRevenue.add(rs.getInt("TotalRevenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlyRevenue;
    }

    public List<OrderDTO> getNewOrders() throws ClassNotFoundException {
        List<OrderDTO> newOrders = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM Orders ORDER BY OrderDate DESC";  // Corrected query
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                newOrders.add(new OrderDTO(
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newOrders;
    }
}
