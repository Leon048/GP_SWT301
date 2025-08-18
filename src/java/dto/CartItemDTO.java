/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author xuant
 */
public class CartItemDTO {
     private int productID;
    private String productName;
    private String imageUrl;
    private int quantity;
    private double discountPrice;

    public CartItemDTO() {
    }

    public CartItemDTO(int productID, String productName, String imageUrl, int quantity, double discountPrice) {
        this.productID = productID;
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.quantity = quantity;
        this.discountPrice = discountPrice;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    @Override
    public String toString() {
        return "CartItemDTO{" + "productID=" + productID + ", productName=" + productName + ", imageUrl=" + imageUrl + ", quantity=" + quantity + ", discountPrice=" + discountPrice + '}';
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

  
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
