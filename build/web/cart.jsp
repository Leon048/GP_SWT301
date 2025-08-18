<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .cart-summary {
                background: #fff;
                border: 1px solid #ddd;
                padding: 20px;
                border-radius: 8px;
            }
            .cart-item {
                border: 1px solid #eee;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 15px;
            }
            .cart-item img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }
            .price {
                color: red;
                font-weight: bold;
            }
            .note-section textarea {
                width: 100%;
                height: 100px;
            }
            .policy-box {
                background: #e3f2fd;
                padding: 15px;
                border-radius: 6px;
            }
            .total-box {
                font-size: 20px;
                font-weight: bold;
                color: red;
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
                            <a href="#" class="text-dark position-relative" id="cartIcon">
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
                    <div class="user-dropdown dropdown">
                        <a href="#" class="text-dark d-flex align-items-center gap-1" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle fs-5"></i> <span class="fw-medium">Thanh Lee</span>
                        </a>
                        <ul class="dropdown-menu">
                          <li><a class="dropdown-item" href="MainController?action=OrderHistory">Order History</a></li>    
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        <div class="container my-5">
            <h3>Your Shopping Cart</h3>
            <p>You have <strong>${cartItems.size()}</strong> item(s) in your cart</p>
            <div class="row">
                <!-- Left: Items -->
                <div class="col-md-8">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item d-flex justify-content-between align-items-center position-relative">
                            <!-- Nút Xóa -->
                            <form action="MainController" method="post" class="position-absolute" style="top: 5px; left: 5px;">
                                <input type="hidden" name="productID" value="${item.productID}" />
                                <button type="submit"
                                        class="btn btn-sm btn-danger rounded-circle fw-bold px-2 py-0"
                                        title="Remove item"
                                        name="action"
                                        value="DeleteItemCart"
                                        style="line-height: 1;">
                                    &times;
                                </button>
                            </form>

                            <div class="d-flex gap-3 align-items-center">
                                <img src="${item.imageUrl}" alt="${item.productName}" />
                                <div>
                                    <p class="mb-1 fw-bold">${item.productName}</p>
                                    <p class="price mb-0"><fmt:formatNumber value="${item.discountPrice}" type="currency" currencySymbol="₫"/></p>
                                </div>
                            </div>


                            <div class="d-flex align-items-center gap-2">
                               <form method="post" action="MainController">
                                    <input type="hidden" name="userID" value="${sessionScope.loginUser.userID}" />
                                    <input type="hidden" name="productID" value="${item.productID}" />
                                    <button class="btn btn-outline-secondary btn-sm" name="action" value="DecreaseFromCart">-</button>
                                </form>
                                <input type="text" value="${item.quantity}" class="form-control text-center" style="width: 50px;">
                                <form method="post" action="MainController">
                                    <input type="hidden" name="userID" value="${sessionScope.loginUser.userID}" />
                                    <input type="hidden" name="productID" value="${item.productID}" />
                                    <button class="btn btn-outline-secondary btn-sm" name="action" value="AddToCart">+</button>
                                </form>

                            </div>
                        </div>

                    </c:forEach>

                    <!-- Note -->
                    <div class="note-section bg-white p-3 mt-4">
                        <label for="orderNote" class="form-label fw-semibold">Order Note</label>
                        <textarea id="orderNote" class="form-control"></textarea>
                        <div class="form-check mt-2">
                            <input class="form-check-input" type="checkbox" id="exportInvoice">
                            <label class="form-check-label" for="exportInvoice">
                                Request invoice for this order
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Right: Summary -->
                <div class="col-md-4">
                    <div class="cart-summary">
                        <h5>Order Summary</h5>
                        <hr>
                        <p class="d-flex justify-content-between">
                            <span>Total:</span>
                            <span class="total-box">${totalAmount}&#273;</span>
                        </p>
                        <small class="text-muted">
                            * VEGGIE MARKET only accepts VAT invoice requests within 120 minutes after payment.
                        </small>
                        <a class="btn btn-danger w-100 mt-3" href="MainController?action=CheckOut">CHECKOUT</a>
                    </div>
                    <div class="policy-box mt-3">
                        <strong>Purchase Policy:</strong>
                        <p>We only support checkout for orders with a minimum value of <strong>50,000&#273;</strong>.</p>
                    </div>
                    <div class="mt-3">
                        <h6>Exclusive Promotions for You</h6>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left"></i></button>
                            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-right"></i></button>
                        </div>
                    </div>
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
