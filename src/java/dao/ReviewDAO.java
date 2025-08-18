/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author xuant
 */
public class ReviewDAO {

    private final String INSERT_REVIEW_SQL = "INSERT INTO Reviews(UserID, ProductID, Rating, Comment) VALUES (?, ?, ?, ?)";

    public boolean addReview(int userID, int productID, String comment, int rating) {
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(INSERT_REVIEW_SQL)) {

            ps.setInt(1, userID);
            ps.setInt(2, productID);
            ps.setInt(3, rating);
            ps.setString(4, comment);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
