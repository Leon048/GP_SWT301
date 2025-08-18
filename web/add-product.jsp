<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Veggie Market - Add Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: #f4f7fa;
            }

            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #343a40;
                color: white;
                position: fixed;
                font-family: 'Segoe UI', sans-serif;
            }

            .sidebar a {
                color: #e2f4e6;
                padding: 12px 20px;
                display: flex;
                align-items: center;
                gap: 10px;
                text-decoration: none;
                transition: 0.3s;
            }

            .sidebar a:hover {
                background: #495057;
                color: white;
            }

            .main-content {
                margin-left: 240px;
                padding: 20px;
            }

            .form-container {
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-title {
                color: #28a745;
                font-weight: bold;
                margin-bottom: 30px;
            }

            .row .form-group {
                margin-bottom: 1.5rem;
            }

            .form-container .form-group input,
            .form-container .form-group select,
            .form-container .form-group textarea {
                width: 100%;
            }

            .form-container .form-group .col-md-6 {
                margin-bottom: 1.5rem;
            }

            .add-product-btn {
                font-size: 0.95rem;
                border-radius: 6px;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .form-group {
                display: flex;
                justify-content: space-between;
            }

            .form-group .col-md-6 {
                width: 48%;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
            }

            .form-group textarea {
                height: 150px;
            }

            .form-group button {
                width: auto;
                float: right;
            }
             .sidebar a .bi-speedometer2 {
                color: #f39c12;
            }  /* Dashboard - cam nhạt */
            .sidebar a .bi-box-seam     {
                color: #3498db;
            }  /* Products - xanh dương */
            .sidebar a .bi-tags         {
                color: #9b59b6;
            }  /* Category - tím */
            .sidebar a .bi-cart4        {
                color: #e74c3c;
            }  /* Orders - đỏ */
            .sidebar a .bi-people       {
                color: #1abc9c;
            }  /* Accounts - xanh ngọc */
            .sidebar a .bi-box-arrow-right {
                color: #ecf0f1;
            } /* Logout - trắng nhạt */
            .sidebar a .bi-ticket-perforated {
                color: #e67e22; /* Màu cam đậm - riêng cho Voucher */
            }

        </style>
    </head>

    <body>
        <div class="sidebar d-flex flex-column p-3">
            <div class="text-center mb-2">
                <a class="navbar-brand fw-bold" href="#" style="font-size: 1.3rem;">
                    <i class="bi bi-basket-fill me-1" style="color: #28a745;"></i> Veggie Market
                </a>
            </div>
            <hr>
            <h6 class="text-uppercase text-secondary px-3">MAIN ACTION</h6>
     <a href="MainController?action=dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
            <a href="MainController?action=ProductManagement"><i class="bi bi-box-seam"></i> Products</a>
            <a href="MainController?action=Category"><i class="bi bi-tags"></i> Category</a>
            <a href="MainController?action=VoucherManager"><i class="bi bi-ticket-perforated text-danger"></i> Voucher</a>
            <a href="MainController?action=OrderManagement"><i class="bi bi-cart4"></i> Orders</a>
            <a href="MainController?action=GetAccount"><i class="bi bi-people"></i> Accounts</a>

            <hr>
            <a href="MainController?action=Logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>

        <div class="main-content">
            <a href="MainController?action=ProductManagement" class="btn btn-secondary"><i class="bi bi-arrow-left"></i></a>
            <div class="d-flex justify-content-center text-center mb-3">
                <h3 class="form-title"><i class="bi bi-plus-circle"></i> Add New Product</h3>
            </div>

            <div class="container form-container">
               <form action="MainController" method="POST">
                    <!-- Product Name and Description -->
                    <div class="form-group">
                        <div class="col-md-6">
                            <label for="productName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" name="productName" id="productName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" name="description" id="description" rows="3"></textarea>
                        </div>
                    </div>

                    <!-- Category and Price -->
                    <div class="form-group">
                        <div class="col-md-6">
                            <label for="category" class="form-label">Category</label>
                            <select name="categoryID" class="form-select" required>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="price" class="form-label">Price (VND)</label>
                            <input type="number" class="form-control" name="price" id="price" required>
                        </div>
                    </div>

                    <!-- Discount Percent and Stock Quantity -->
                    <div class="form-group">
                        <div class="col-md-6">
                            <label for="discountPercent" class="form-label">Discount (%)</label>
                            <input type="number" class="form-control" name="discountPercent" id="discountPercent" min="0" max="100">
                        </div>
                        <div class="col-md-6">
                            <label for="stockQuantity" class="form-label">Stock Quantity</label>
                            <input type="number" class="form-control" name="stockQuantity" id="stockQuantity" required>
                        </div>
                    </div>

                    <!-- Image URL and Origin -->
                    <div class="form-group">
                        <div class="col-md-6">
                            <label for="imageUrl" class="form-label">Image URL</label>
                            <input type="text" class="form-control" name="imageUrl" id="imageUrl" required>
                        </div>
                        <div class="col-md-6">
                            <label for="origin" class="form-label">Origin</label>
                            <input type="text" class="form-control" name="origin" id="origin" required>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="form-group">
                        <button type="submit" class="btn btn-success" name="action" value="AddProduct">
                            <i class="bi bi-check-circle"></i> Add Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
