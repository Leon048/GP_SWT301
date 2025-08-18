<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Veggie Market - Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            .banner {
                position: relative;
                background: url('https://th.bing.com/th/id/OIP.5zsV9soe6bH3uObEyF8sOAHaEj?r=0&rs=1&pid=ImgDetMain') center center/cover no-repeat;
                height: 700px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                color: white;
            }
            .banner::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.4);
            }
            .banner .content {
                position: relative;
                z-index: 2;
            }
            .banner h1 {
                font-size: 6rem;
                font-weight: 800;
                text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.6);
                letter-spacing: 1px;
                margin-bottom: 10px;
            }
            .banner p.lead {
                font-size: 2.3rem;
                font-weight: 500;
                color: #f0f0f0;
                text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.5);
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
             .product-card img {
                width: 100%; /* Đảm bảo hình ảnh chiếm đầy card */
                height: 200px; /* Cố định chiều cao */
                object-fit: cover; /* Cắt ảnh cho phù hợp mà không bị biến dạng */
            }
            .product-card .add-cart:hover {
                background: #fbc02d;
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
            .benefit-banner {
                background: linear-gradient(90deg, #f1f8e9, #e0f2f1);
                border-radius: 16px;
                padding: 50px 30px;
            }
            .benefit-banner h3 {
                font-weight: 700;
                color: #2e7d32;
            }
            .benefit-banner p.lead {
                color: #444;
                font-size: 1.2rem;
                margin-bottom: 30px;
            }
            .benefit-banner i {
                font-size: 2.5rem;
                margin-bottom: 10px;
            }
            .benefit-banner h5 {
                font-weight: 600;
                margin-bottom: 8px;
                color: #2c3e50;
            }
            .benefit-banner .col-md-4 p {
                color: #555;
                font-size: 0.95rem;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
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

        <!-- Banner -->
        <div class="banner">
            <div class="content">
                <h1>Fresh From Farm to Table</h1>
                <p class="lead">Healthy. Organic. Sustainable.</p>
            </div>
        </div>





        <!-- Best Seller Products -->
        <div class="container product-section">
            <h2 class="text-center"><i class="bi bi-star-fill"></i> Best Sellers</h2>
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <!-- Card 1 -->
                <c:forEach var="p" items="${bestSellers}">
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
    </div>
</div>

<!-- Benefits Banner -->
<div class="container my-5 py-4 benefit-banner text-center">
    <h3 class="mb-3 text-success">Why Choose Fresh Vegetables & Fruits?</h3>
    <p class="lead">Eating fresh vegetables and fruits helps boost your immune system, improve digestion, and support heart health. They are packed with essential vitamins, minerals, and antioxidants that keep you energetic and feeling great every day.</p>
    <div class="row mt-4">
        <div class="col-md-4">
            <i class="bi bi-heart-pulse-fill fs-1 text-danger"></i>
            <h5 class="mt-2">Boosts Immunity</h5>
            <p>Rich in vitamins C and E, essential for a strong immune system.</p>
        </div>
        <div class="col-md-4">
            <i class="bi bi-bar-chart-fill fs-1 text-primary"></i>
            <h5 class="mt-2">High in Fiber</h5>
            <p>Supports digestion and promotes a healthy gut.</p>
        </div>
        <div class="col-md-4">
            <i class="bi bi-battery-charging fs-1 text-warning"></i>
            <h5 class="mt-2">Natural Energy</h5>
            <p>Provides sustained energy and prevents fatigue.</p>
        </div>
    </div>
</div>

<div class="container product-section">
    <h2 class="text-center"><i class="bi bi-fire"></i> Hot Products</h2>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <!-- Card 1 -->
        <c:forEach var="p" items="${hotProducts}">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hi?n th? toast n?u có attribute MESSAGE
    window.onload = function () {
        const message = '<c:out value="${MESSAGE}" />';
        if (message && message.includes('successfully')) {
            const toastElement = document.getElementById('toastSuccess');
            const toast = new bootstrap.Toast(toastElement);
            toast.show();
        }
    };
</script>

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