<%-- 
    Document   : product
    Created on : Jun 5, 2025, 6:36:46 PM
    Author     : xuant
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Veggie Market - Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            .footer {
                background-color: #4b8f3c;
                color: white;
                padding: 30px 0;
            }
            .footer a {
                color: #d0f0c0;
                text-decoration: none;
            }

            .navbar-nav-center {
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
            }
            .navbar-nav .nav-link {
                color: #4b8f3c;
                font-weight: 500;
                font-size: 1.15rem;
                padding: 0.5rem 1rem;
                transition: all 0.3s ease;
            }
            .navbar-nav .nav-link:hover {
                color: orange;
                font-size: 1rem;
                text-decoration: underline;
            }
            .navbar-nav .nav-link.active {
                color: orange;
                font-weight: 700;
                border-bottom: 2px solid orange;
            }
            .cart-icon {
                position: relative;
            }
            .cart-icon .bi-cart3 {
                font-size: 2rem;
            }
            .cart-icon .badge {
                position: absolute;
                top: -5px;
                right: -10px;
                background-color: red;
                color: white;
                font-size: 0.7rem;
                border-radius: 50%;
                padding: 3px 6px;
            }
            .cart-dropdown-wrapper {
                position: relative;
                display: inline-block;
            }

            .cart-dropdown {
                display: none;
                position: absolute;
                right: 0;
                top: 150%;
                background-color: #fff;
                width: 300px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                z-index: 1000;
                max-height: 300px;
                overflow-y: auto;
            }

            .cart-dropdown-wrapper:hover .cart-dropdown {
                display: block;
            }

            .cart-item {
                padding: 10px 0;
                display: flex;
                gap: 10px;
                align-items: center;
                border-bottom: 1px solid #e0e0e0;
            }

            .cart-item-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 6px;
            }

            .cart-item-info {
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .cart-item-name {
                font-size: 14px;
                font-weight: 500;
            }

            .cart-item-quantity {
                font-size: 12px;
                color: gray;
            }
            .cart-icon:hover .cart-dropdown {
                display: block !important;
            }
            .user-dropdown {
                position: relative;
            }
            .user-dropdown .bi-person-circle {
                font-size: 1.7rem;
            }
            .user-dropdown:hover .dropdown-menu {
                display: block;
            }
            .dropdown-menu {
                right: 0;
                left: auto;
                display: none;
            }
            .sidebar {
                background-color: #f8f9fa;
                padding: 20px;
                border-right: 1px solid #ddd;
                height: 100%;
            }
            .sidebar h5 {
                color: #4b8f3c;
                font-weight: 600;
            }
            .product-section {
                padding: 50px 0;
            }
            .product-section h2 {
                color: #4b8f3c;
                font-weight: 700;
                margin-bottom: 30px;
            }
            .product-card {
                border: 1px solid #eee;
                border-radius: 8px;
                overflow: hidden;
                transition: box-shadow 0.3s ease;
                background: #fff;
            }
            .product-card:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
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
            .product-card img {
                width: 100%; /* Đảm bảo hình ảnh chiếm đầy card */
                height: 200px; /* Cố định chiều cao */
                object-fit: cover; /* Cắt ảnh cho phù hợp mà không bị biến dạng */
            }
            .product-card .original-price {
                text-decoration: line-through;
                color: #888;
                font-size: 0.9rem;
            }
            .product-card .add-cart {
                background: #fdd835;
                border: 1px solid #ccc;
                border-radius: 30px;
                padding: 8px 16px;
                font-weight: 600;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 5px;
                transition: 0.3s;
            }
            .product-card .add-cart:hover {
                background: #fbc02d;
            }
            .price {
                color: red;
                font-weight: bold;
            }
            .original-price {
                text-decoration: line-through;
                color: #888;
                font-size: 0.9rem;
            }
            .search-bar {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
            }
            .form-check {
                margin-bottom: 10px;
            }
            .section-title {
                color: #4b8f3c;
                font-weight: bold;
                font-size: 1.5rem;
                margin-bottom: 20px;
            }
            .footer {
                background-color: #4b8f3c;
                color: white;
                padding: 30px 0;
            }
            .footer a {
                color: #d0f0c0;
                text-decoration: none;
            }

        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm position-relative">
            <div class="container position-relative">
                <a class="navbar-brand fw-bold text-success" href="#"><i class="bi bi-basket-fill"></i> Veggie Market</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                    <ul class="navbar-nav navbar-nav-center">
                        <li class="nav-item"><a class="nav-link" href="MainController?action=Home">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="MainController?action=Product">Products</a></li>
                       <li class="nav-item"><a class="nav-link" href="MainController?action=Chat">Chats</a></li>                        
                    </ul>
                </div>
                <div class="d-flex align-items-center gap-4">
                    <div class="cart-icon">
                        <div class="cart-icon position-relative">
                            <a href="MainController?action=ViewCart" class="text-dark position-relative" id="cartIcon">
                                <i class="bi bi-cart3 fs-5"></i>
                                <span class="badge">${empty cartCount ? 0 : cartCount}</span>
                            </a>

                            <!-- Dropdown hover -->
                            <div class="cart-dropdown" id="cartDropdown">
                                <c:forEach var="item" items="${cartItems}">
                                    <a href="MainController?action=ProductDetail&productID=${item.productID}" class="text-decoration-none text-dark">
                                        <div class="cart-item d-flex align-items-center mb-2">
                                            <img src="${item.imageUrl}" class="me-2 rounded" alt="Product" width="50" height="50">
                                            <div>
                                                <p class="mb-0 fw-semibold">${item.productName}</p>
                                                <small>Qty: ${item.quantity}</small>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                                <a href="MainController?action=ViewCart" class="btn btn-sm btn-success w-100 mt-2">View Cart</a>

                            </div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-4">
                        <c:choose>                       
                            <c:when test="${not empty sessionScope.LOGIN_USER}">                             
                                <div class="user-dropdown dropdown">
                                    <a href="#" class="text-dark d-flex align-items-center gap-1" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle fs-5"></i> <span class="fw-medium">${sessionScope.LOGIN_USER.fullName}</span>
                                    </a>
                                    <ul class="dropdown-menu">
                                         <li><a class="dropdown-item" href="MainController?action=OrderHistory">Order History</a></li>    
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="MainController?action=Logout">Logout</a></li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="login.jsp" class="btn btn-outline-success">Login</a>
                                <a href="register.jsp" class="btn btn-success">Register</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>


        <div class="container mt-4 px-4">
            <div class="row">
                <!-- Sidebar left 30% -->
                <div class="col-md-3 sidebar">
                    <form action="MainController" method="get">                      
                        <!-- Category Filter -->
                        <h5>Categories</h5>
                        <c:forEach var="c" items="${categories}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="categoryId" value="${c.categoryId}" 
                                       ${param.categoryId == c.categoryId ? "checked" : ""}>
                                <label class="form-check-label">${c.categoryName}</label>
                            </div>
                        </c:forEach>

                        <!-- Price Sort -->
                        <hr>
                        <h5>Sort by Price</h5>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="sort" value="asc" 
                                   ${param.sort == 'asc' ? "checked" : ""}>
                            <label class="form-check-label">Low to High</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="sort" value="desc" 
                                   ${param.sort == 'desc' ? "checked" : ""}>
                            <label class="form-check-label">High to Low</label>
                        </div>

                        <button type="submit" class="btn btn-success mt-3 w-100" name="action" value="Product">Apply Filters</button>
                    </form>
                </div>

                <!-- Right content 70% -->
                <div class="col-md-9">
                    <div class="search-bar">
                        <form class="d-flex w-50" action="MainController" method="get">                          
                            <input class="form-control me-2" type="search" name="search" placeholder="Search products..." value="${param.search}">
                            <button class="btn btn-outline-success" type="submit" name="action" value="Product" >Search</button>
                        </form>
                    </div>

                    <div class="section-title">All Product</div>

                    <div class="row row-cols-1 row-cols-md-3 g-4">
                        <c:forEach var="p" items="${productList}">
                            <div class="col">
                                <div class="card product-card position-relative">
                                    <a href="MainController?action=ProductDetail&productID=${p.id}" class="text-decoration-none text-dark">
                                        <c:if test="${p.discountPercent != 0}">
                                            <span class="badge-discount">-${p.discountPercent}%</span>
                                        </c:if>

                                        <img src="${p.imageUrl}" class="card-img-top" alt="${p.name}">
                                        <div class="view-icon"><i class="bi bi-eye"></i></div>
                                        <div class="card-body">
                                            <small class="text-muted">${p.origin}</small>
                                            <h6 class="mt-1">${p.name}</h6>
                                            <p class="mb-1">
                                                <span class="price"><fmt:formatNumber value="${p.discountPrice}" type="currency" currencySymbol="₫"/></span>
                                                <c:if test="${p.discountPercent != 0}">
                                                    <span class="original-price ms-2"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></span>
                                                </c:if>
                                            </p>
                                            <p class="mb-1">
                                                <span class="text-warning">
                                                    <c:forEach begin="1" end="${p.rating}">
                                                        <i class="bi bi-star-fill"></i>
                                                    </c:forEach>
                                                    <c:forEach begin="${p.rating + 1}" end="5">
                                                        <i class="bi bi-star"></i>
                                                    </c:forEach>
                                                </span>
                                                <span class="ms-1">${p.reviewCount} reviews</span>
                                            </p>
                                            <p class="text-muted">Sold: ${p.sold}</p>
                                    </a>
                                    <form method="post" action="MainController">
                                        <input type="hidden" name="userID" value="${sessionScope.loginUser.userID}" />
                                        <input type="hidden" name="productID" value="${p.id}" />
                                        <button type="submit" class="add-cart w-100" name="action" value="AddToCart">
                                            ADD TO CART <i class="bi bi-bag-plus"></i>
                                        </button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </c:forEach>       

                </div>
                <nav>
                    <ul class="pagination justify-content-center mt-3">
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="MainController?action=Product&page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <p class="mb-1">&copy; 2025 Veggie Market. All rights reserved.</p>
            <small>Follow us on
                <a href="#"><i class="bi bi-facebook"></i></a>
                <a href="#"><i class="bi bi-instagram"></i></a>
                <a href="#"><i class="bi bi-twitter"></i></a>
            </small>
        </div>
    </footer>
</body>
</html>
<script>
    const cartIcon = document.getElementById("cartIcon");
    const cartDropdown = document.getElementById("cartDropdown");
    let hideTimeout;

    cartIcon.addEventListener("mouseenter", () => {
        clearTimeout(hideTimeout);
        cartDropdown.style.display = "block";
    });

    cartIcon.addEventListener("mouseleave", () => {
        hideTimeout = setTimeout(() => {
            cartDropdown.style.display = "none";
        }, 500); // 2 giây
    });

    cartDropdown.addEventListener("mouseenter", () => {
        clearTimeout(hideTimeout);
    });

    cartDropdown.addEventListener("mouseleave", () => {
        hideTimeout = setTimeout(() => {
            cartDropdown.style.display = "none";
        }, 500); // 2 giây
    });
</script>