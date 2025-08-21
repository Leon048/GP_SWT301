/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package dao;

import static org.junit.Assert.*;
import dto.ProductDTO;
import org.junit.Before;
import org.junit.Test;
import java.util.List;

public class ProductDAOTest {
    
    private ProductDAO productDAO;
    
    @Before
    public void setUp() {
        productDAO = new ProductDAO();
    }
    
    @Test
    public void testGetFilteredProductsWithAllNullParameters() {
        // Arrange
        String name = null;
        String category = null;
        String sort = null;
        int page = 1;
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithName() {
        // Arrange
        String name = "tomato";
        String category = null;
        String sort = null;
        int page = 1;
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithCategory() {
        // Arrange
        String name = null;
        String category = "1";
        String sort = null;
        int page = 1;
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithSortAsc() {
        // Arrange
        String name = null;
        String category = null;
        String sort = "asc";
        int page = 1;
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithSortDesc() {
        // Arrange
        String name = null;
        String category = null;
        String sort = "desc";
        int page = 1;
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithAllParameters() {
        // Arrange
        String name = "tomato";
        String category = "1";
        String sort = "asc";
        int page = 2;
        int pageSize = 10;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithEmptyStrings() {
        // Arrange
        String name = "";
        String category = "";
        String sort = "";
        int page = 1;
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithDifferentPagination() {
        // Arrange
        String name = null;
        String category = null;
        String sort = null;
        int page = 3;
        int pageSize = 12;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
    
    @Test
    public void testGetFilteredProductsWithInvalidSort() {
        // Arrange
        String name = null;
        String category = null;
        String sort = "invalid";
        int page = 1;   
        int pageSize = 6;
        
        // Act
        List<ProductDTO> result = productDAO.getFilteredProducts(name, category, sort, page, pageSize);
        
        // Assert
        assertNotNull("Result should not be null", result);
        assertTrue("Result should be a List", result instanceof List);
    }
}

