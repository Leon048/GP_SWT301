/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;
import jdk.jfr.Timestamp;

/**
 *
 * @author xuant
 */
public class OrderDTO {

    private int orderID;
    private int userID;
    private Date orderDate;
    private double totalAmount;
    private String status;
    private String shippingAddress;
    private int paymentMethodID;
    private int usePoints;
    private String note;
    private String name;
    private String statusOrder;
    private String email;
    private String phone;
    private String shipCode;

    @Override
    public String toString() {
        return "OrderDTO{" + "orderID=" + orderID + ", userID=" + userID + ", orderDate=" + orderDate + ", totalAmount=" + totalAmount + ", status=" + status + ", shippingAddress=" + shippingAddress + ", paymentMethodID=" + paymentMethodID + ", usePoints=" + usePoints + ", note=" + note + ", name=" + name + ", statusOrder=" + statusOrder + ", email=" + email + ", phone=" + phone + ", shipCode=" + shipCode + '}';
    }

    

    public String getShipCode() {
        return shipCode;
    }

    public void setShipCode(String shipCode) {
        this.shipCode = shipCode;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public OrderDTO() {
    }

    public OrderDTO(int orderID, int userID, Date orderDate, double totalAmount, String status, String shippingAddress, int paymentMethodID, int usePoints, String note, String name, String statusOrder, String email, String phone, String shipCode) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
        this.paymentMethodID = paymentMethodID;
        this.usePoints = usePoints;
        this.note = note;
        this.name = name;
        this.statusOrder = statusOrder;
        this.email = email;
        this.phone = phone;
        this.shipCode = shipCode;
    }

    public String getStatusOrder() {
        return statusOrder;
    }

    public void setStatusOrder(String statusOrder) {
        this.statusOrder = statusOrder;
    }

    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public int getPaymentMethodID() {
        return paymentMethodID;
    }

    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }

    public int getUsePoints() {
        return usePoints;
    }

    public void setUsePoints(int usePoints) {
        this.usePoints = usePoints;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

}
