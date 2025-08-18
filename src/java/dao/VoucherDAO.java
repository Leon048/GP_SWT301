/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.VoucherDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author xuant
 */
public class VoucherDAO {

    public VoucherDTO getVoucherByCode(String code) {
        VoucherDTO voucher = null;
        try {
            Connection conn = DBUtils.getConnection();
            String sql = "SELECT code, discountAmount, isActive FROM Voucher WHERE code = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                voucher = new VoucherDTO();
                voucher.setCode(rs.getString("code"));
                voucher.setDiscountAmount(rs.getDouble("discountAmount"));
                voucher.setIsActive(rs.getBoolean("isActive"));
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return voucher;
    }

    public List<VoucherDTO> getAllVouchers() {
        List<VoucherDTO> list = new ArrayList<>();
        String sql = "SELECT TOP (1000) [code], [discountAmount], [isActive] FROM [Voucher]";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VoucherDTO voucher = new VoucherDTO();
                voucher = new VoucherDTO();
                voucher.setCode(rs.getString("code"));
                voucher.setDiscountAmount(rs.getDouble("discountAmount"));
                voucher.setIsActive(rs.getBoolean("isActive"));
                list.add(voucher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deactivateVoucher(String code) {
        String sql = "UPDATE Voucher SET isActive = 0 WHERE code = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addVoucher(VoucherDTO voucher) {
        String sql = "INSERT INTO Voucher (code, discountAmount, isActive) VALUES (?, ?, ?)";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode());
            ps.setDouble(2, voucher.getDiscountAmount());
            ps.setBoolean(3, voucher.isIsActive());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVoucher(VoucherDTO voucher) {
        String sql = "UPDATE Voucher SET discountAmount = ?, isActive = ? WHERE code = ?";
        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, voucher.getDiscountAmount());
            ps.setBoolean(2, voucher.isIsActive());
            ps.setString(3, voucher.getCode());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
