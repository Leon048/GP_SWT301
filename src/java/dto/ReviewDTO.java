/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author xuant
 */
public class ReviewDTO {   
    private String fullName;
    private int rating;
    private String comment;   
    private String imageUrl;

    public ReviewDTO(String fullName, int rating, String comment, String imageUrl) {
        this.fullName = fullName;
        this.rating = rating;
        this.comment = comment;
        this.imageUrl = imageUrl;
    }

    public ReviewDTO() {
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    @Override
    public String toString() {
        return "ReviewDTO{" + "fullName=" + fullName + ", rating=" + rating + ", comment=" + comment + ", imageUrl=" + imageUrl + '}';
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    
    
}
