/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.AddProductDTO;
import dto.ChatProductDTO;
import dto.ImageProductDTO;
import dto.ProductDTO;
import dto.ProductDetailDTO;
import dto.ReviewDTO;
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
public class ProductDAO {

    public List<ProductDTO> getBestSellers(int limit) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Products WHERE IsBestSeller = 1 ORDER BY Sold DESC";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO p = new ProductDTO(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Origin"),
                        rs.getString("ImageUrl"),
                        rs.getDouble("DiscountPercent"),
                        rs.getDouble("Price"),
                        rs.getDouble("DiscountPrice"),
                        rs.getInt("Sold"),
                        rs.getDouble("Rating"),
                        rs.getInt("ReviewCount")
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> getHotProducts(int limit) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Products WHERE IsHot = 1 ORDER BY CreatedAt DESC";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO p = new ProductDTO(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Origin"),
                        rs.getString("ImageUrl"),
                        rs.getDouble("DiscountPercent"),
                        rs.getDouble("Price"),
                        rs.getDouble("DiscountPrice"), // hoặc Price tùy yêu cầu
                        rs.getInt("Sold"),
                        rs.getDouble("Rating"),
                        rs.getInt("ReviewCount")
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> getFilteredProducts(String name, String category, String sort, int page, int pageSize) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE isDelete = 0";

        if (name != null && !name.isEmpty()) {
            sql += " AND ProductName LIKE ?";
        }
        if (category != null && !category.isEmpty()) {
            sql += " AND CategoryID = ?";
        }
        if ("asc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY Price ASC";
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql += " ORDER BY Price DESC";
        } else {
            sql += " ORDER BY ProductID DESC";
        }

        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;

            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (category != null && !category.isEmpty()) {
                ps.setString(index++, category);
            }

            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Origin"),
                        rs.getString("ImageUrl"),
                        rs.getDouble("DiscountPercent"),
                        rs.getDouble("Price"),
                        rs.getDouble("DiscountPrice"),
                        rs.getInt("Sold"),
                        rs.getDouble("Rating"),
                        rs.getInt("ReviewCount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public int getTotalFilteredCount(String name, String category) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Products WHERE isDelete = 0";
        if (name != null && !name.isEmpty()) {
            sql += " AND ProductName LIKE ?";
        }
        if (category != null && !category.isEmpty()) {
            sql += " AND CategoryID = ?";
        }

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (category != null && !category.isEmpty()) {
                ps.setString(index++, category);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public ProductDetailDTO getProductById(int productID) throws Exception {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductDetailDTO(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getInt("CategoryID"),
                        rs.getDouble("Price"),
                        rs.getString("Unit"),
                        rs.getInt("StockQuantity"),
                        rs.getString("ThumbnailUrl"),
                        rs.getBoolean("IsAvailable"),
                        rs.getInt("DiscountPercent"),
                        rs.getDouble("DiscountPrice"),
                        rs.getDouble("OriginalPrice"),
                        rs.getDouble("Discount"),
                        rs.getInt("Sold"),
                        rs.getDouble("Rating"),
                        rs.getInt("ReviewCount"),
                        rs.getString("Origin"),
                        rs.getString("ImageUrl"),
                        rs.getBoolean("IsHot"),
                        rs.getBoolean("IsBestSeller")
                );
            }
        }
        return null;
    }

    public List<ProductDetailDTO> getRelatedProducts(int productID) throws Exception {
        List<ProductDetailDTO> list = new ArrayList<>();
        String sql = "SELECT TOP 4 * FROM Products WHERE ProductID <> ? ORDER BY NEWID()";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetailDTO(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getInt("CategoryID"),
                        rs.getDouble("Price"),
                        rs.getString("Unit"),
                        rs.getInt("StockQuantity"),
                        rs.getString("ThumbnailUrl"),
                        rs.getBoolean("IsAvailable"),
                        rs.getInt("DiscountPercent"),
                        rs.getDouble("DiscountPrice"),
                        rs.getDouble("OriginalPrice"),
                        rs.getDouble("Discount"),
                        rs.getInt("Sold"),
                        rs.getDouble("Rating"),
                        rs.getInt("ReviewCount"),
                        rs.getString("Origin"),
                        rs.getString("ImageUrl"),
                        rs.getBoolean("IsHot"),
                        rs.getBoolean("IsBestSeller")
                ));
            }
        }
        return list;
    }

    public List<ImageProductDTO> getProductImages(int productID) {
        List<ImageProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM ProductImages WHERE ProductID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ImageProductDTO img = new ImageProductDTO(
                        rs.getInt("ImageID"),
                        rs.getInt("ProductID"),
                        rs.getString("ImageUrl")
                );
                list.add(img);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean addProduct(AddProductDTO product) throws ClassNotFoundException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtils.getConnection(); // Assuming you have a Database class that handles DB connections
            String sql = "INSERT INTO Products (ProductName, Description, CategoryID, Price, DiscountPercent, StockQuantity, ImageUrl, Origin) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getCategoryID());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, (int) product.getDiscountPercent());
            ps.setInt(6, product.getStockQuantity());
            ps.setString(7, product.getImageUrl());
            ps.setString(8, product.getOrigin());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public boolean updateProduct(AddProductDTO product) throws ClassNotFoundException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtils.getConnection();

            String sql = "UPDATE Products SET "
                    + "ProductName = ?, "
                    + "Description = ?, "
                    + "CategoryID = ?, "
                    + "Price = ?, "
                    + "DiscountPercent = ?, "
                    + "StockQuantity = ?, "
                    + "ImageUrl = ?, "
                    + "Origin = ? "
                    + "WHERE ProductID = ?";

            ps = conn.prepareStatement(sql);

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getCategoryID());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getDiscountPercent());
            ps.setInt(6, product.getStockQuantity());
            ps.setString(7, product.getImageUrl());
            ps.setString(8, product.getOrigin());
            ps.setInt(9, product.getProductID());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public boolean deleteProduct(int productId) throws ClassNotFoundException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "UPDATE Products SET isDelete = ? WHERE ProductID = ?";
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, true);
            ps.setInt(2, productId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public boolean incrementReviewCount(int productId) {
        String sql = "UPDATE Products SET ReviewCount = ISNULL(ReviewCount, 0) + 1 WHERE ProductID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProductAfterPurchase(int productId, int quantity) {
        String sql = "UPDATE Products "
                + "SET Sold = ISNULL(Sold, 0) + ?, "
                + "StockQuantity = ISNULL(StockQuantity, 0) - ? "
                + "WHERE ProductID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, quantity);
            ps.setInt(3, productId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ReviewDTO> getProductReviews(int productID) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT r.Rating, r.Comment, u.FullName "
                + "FROM Reviews r "
                + "JOIN Users u ON r.UserID = u.UserID "
                + "WHERE r.ProductID = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setFullName(rs.getString("FullName"));
                review.setImageUrl("https://blog.cpanel.com/wp-content/uploads/2019/08/user-01.png");
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public List<ChatProductDTO> getAllProducts() {
        List<ChatProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE isDelete = 0";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ChatProductDTO product = new ChatProductDTO();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

}
