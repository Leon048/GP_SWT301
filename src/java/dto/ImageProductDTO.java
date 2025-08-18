/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author xuant
 */
public class ImageProductDTO {
    private int imageID;
    private int productID;
    private String imageUrl;

    public ImageProductDTO() {
    }

    public ImageProductDTO(int imageID, int productID, String imageUrl) {
        this.imageID = imageID;
        this.productID = productID;
        this.imageUrl = imageUrl;
    }

    public int getImageID() {
        return imageID;
    }

    @Override
    public String toString() {
        return "ImageProductDTO{" + "imageID=" + imageID + ", productID=" + productID + ", imageUrl=" + imageUrl + '}';
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    
}
