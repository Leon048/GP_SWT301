/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author xuant
 */
public class ProductDTO {
   private int id;
    private String name;
    private String origin;
    private String imageUrl;
    private double discountPercent;
    private double price;
    private double discountPrice;
    private int sold;
    private double rating;
    private int reviewCount;

    public ProductDTO() {
    }

  
    

    public ProductDTO(int id, String name, String origin, String imageUrl, double discountPercent, double price, double discountPrice, int sold, double rating, int reviewCount) {
        this.id = id;
        this.name = name;
        this.origin = origin;
        this.imageUrl = imageUrl;
        this.discountPercent = discountPercent;
        this.price = price;
        this.discountPrice = discountPrice;
        this.sold = sold;
        this.rating = rating;
        this.reviewCount = reviewCount;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    @Override
    public String toString() {
        return "ProductDTO{" + "id=" + id + ", name=" + name + ", origin=" + origin + ", imageUrl=" + imageUrl + ", discountPercent=" + discountPercent + ", price=" + price + ", sold=" + sold + ", rating=" + rating + ", reviewCount=" + reviewCount + '}';
    }

   
    
    
}
