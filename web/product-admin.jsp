<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Veggie Market - Product Management</title>
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
            .product-card {
                border: 1px solid #eee;
                border-radius: 8px;
                overflow: hidden;
                transition: box-shadow 0.3s ease;
                background: #fff;
            }
            .product-card img {
                width: 100%;
                height: 150px;
                object-fit: cover;
            }
            .product-card .badge-discount {
                position: absolute;
                top: 10px;
                left: 10px;
                background: #2980b9;
                color: white;
                font-size: 0.8rem;
                padding: 4px 8px;
                border-radius: 4px;
            }
            .product-card .view-icon {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: rgba(255,255,255,0.7);
                border-radius: 50%;
                padding: 8px;
                display: none;
            }
            .product-card:hover .view-icon {
                display: block;
            }
            .product-card .price {
                color: red;
                font-weight: bold;
            }
            .product-card .original-price {
                text-decoration: line-through;
                color: #888;
                font-size: 0.9rem;
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
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4>Product Management</h4>
                <a href="MainController?action=CategoryProduct" class="btn btn-success add-product-btn">
                    <i class="bi bi-plus-circle"></i> Add Product
                </a>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                <c:forEach var="p" items="${productList}">
                    <div class="col">
                        <div class="card product-card h-100 position-relative">
                            <a href="MainController?action=ProductDetail&productID=${p.id}" class="text-decoration-none text-dark">
                                <span class="badge-discount">-${p.discountPercent}%</span>
                                <img src="${p.imageUrl}" class="card-img-top" alt="${p.name}">
                                <div class="view-icon"><i class="bi bi-eye"></i></div>
                                <div class="card-body">
                                    <small class="text-muted">Origin: ${p.origin}</small>
                                    <h6 class="mt-1">${p.name}</h6>
                                    <p class="mb-1">
                                        <span class="price text-success"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></span>
                                    </p>
                                </div>
                            </a>
                            <div class="card-body d-flex justify-content-between gap-2 pt-0">
                                <!-- Form to delete product -->
                                <form method="post" action="MainController" class="w-50 m-0" onsubmit="return confirmDelete()">
                                    <input type="hidden" name="productID" value="${p.id}">
                                    <button type="submit" name="action" value="DeleteProduct" class="btn btn-sm btn-outline-danger w-100">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </form>
                                <a href="MainController?action=ProductInfo&productID=${p.id}" class="btn btn-sm btn-outline-primary w-50">
                                    <i class="bi bi-pencil"></i> Edit
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <nav>
                <ul class="pagination justify-content-center mt-3">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="MainController?action=ProductManagement&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>

        <script>
            // Function to confirm delete action
            function confirmDelete() {
                return confirm("Are you sure you want to delete this product?");
            }
        </script>
    </body>
</html>
