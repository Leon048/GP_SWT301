/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.PaymentMethodDTO;
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
public class PaymentMethodDAO {
     public List<PaymentMethodDTO> getAllPaymentMethods() {
        List<PaymentMethodDTO> list = new ArrayList<>();
        String sql = "SELECT MethodID, MethodName FROM PaymentMethods";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new PaymentMethodDTO(
                        rs.getInt("MethodID"),
                        rs.getString("MethodName")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
