/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;
import java.util.List;
import jdk.jfr.Timespan;
import jdk.jfr.Timestamp;

/**
 *
 * @author xuant
 */
public class OrderHistoryDTO {

    private int orderID;
    private Date orderDate;
    private String address;
    private String phone;
    private String fullName;
    private int paymentMethodID;
    private String status;
    private String statusOrder;
    private String shipCode;
    private double totalAmount;
    private List<ProductOrderDTO> product;

    public OrderHistoryDTO() {
    }

    public OrderHistoryDTO(int orderID, Date orderDate, String address, String phone, String fullName, int paymentMethodID, String status, String statusOrder, String shipCode, double totalAmount, List<ProductOrderDTO> product) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.address = address;
        this.phone = phone;
        this.fullName = fullName;
        this.paymentMethodID = paymentMethodID;
        this.status = status;
        this.statusOrder = statusOrder;
        this.shipCode = shipCode;
        this.totalAmount = totalAmount;
        this.product = product;
    }

    public String getStatusOrder() {
        return statusOrder;
    }

    public void setStatusOrder(String statusOrder) {
        this.statusOrder = statusOrder;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getShipCode() {
        return shipCode;
    }

    public void setShipCode(String shipCode) {
        this.shipCode = shipCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getPaymentMethodID() {
        return paymentMethodID;
    }

    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    @Override
    public String toString() {
        return "OrderHistoryDTO{" + "orderID=" + orderID + ", orderDate=" + orderDate + ", address=" + address + ", phone=" + phone + ", fullName=" + fullName + ", paymentMethodID=" + paymentMethodID + ", status=" + status + ", totalAmount=" + totalAmount + ", product=" + product + '}';
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<ProductOrderDTO> getProduct() {
        return product;
    }

    public void setProduct(List<ProductOrderDTO> product) {
        this.product = product;
    }

}
