<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Payment Success</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
         <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
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
    <body class="bg-light">
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
        <div class="container mt-5 text-center">
            <div class="alert alert-success p-5">
                <h2 class="mb-3">🎉 Order Placed Successfully!</h2>
                <p class="lead">Thank you for your purchase. Your order has been placed successfully.</p>
                <a href="MainController?action=Home" class="btn btn-success mt-3">Back to Home</a>
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