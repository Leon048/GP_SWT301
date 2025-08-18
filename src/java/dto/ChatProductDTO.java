/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author xuant
 */
public class ChatProductDTO {
         private int productID;
    private String productName;
    private String description;

    public ChatProductDTO() {
    }

    
    public ChatProductDTO(int productID, String productName, String description) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
    }

    
    public int getProductID() {
        return productID;
    }

    @Override
    public String toString() {
        return "ChatProductDTO{" + "productID=" + productID + ", productName=" + productName + ", description=" + description + '}';
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
