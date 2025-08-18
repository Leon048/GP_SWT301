<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order History - Veggie Market</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
            }

            .order-item {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                padding: 20px;
                transition: transform 0.2s;
            }


            .order-item img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 5px;
            }

            .order-item .product-info {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .order-item .product-info .product-name {
                font-weight: bold;
                font-size: 1rem;
                color: #333;
            }

            .order-item .product-info .product-price {
                font-weight: bold;
                color: #e74c3c;
            }

            .order-item .order-status {
                padding: 6px 12px;
                border-radius: 5px;
                color: white;
                font-weight: bold;
            }

            /* Styles for different order statuses */
            .order-status.Pending {
                background-color: #f39c12;
            }

            .order-status.Completed {
                background-color: #2ecc71;
            }

            .order-status.Fail {
                background-color: #e74c3c;
            }

            .order-item .shipment-info {
                color: #888;
                font-size: 0.9rem;
            }

            .order-item .action-btns {
                display: flex;
                gap: 10px;
            }

            .order-item .action-btns .btn {
                font-size: 0.8rem;
                padding: 8px 20px;
                border-radius: 25px;
            }

            .btn-contact-seller {
                background-color: #3498db;
                color: white;
            }

            .btn-cancel-order {
                background-color: #e74c3c;
                color: white;
            }

            .order-history {
                padding: 30px;
            }

            .order-history h2 {
                font-size: 1.8rem;
                color: #4b8f3c;
                margin-bottom: 30px;
                font-weight: 700;
            }

            .pagination {
                justify-content: center;
                margin-top: 30px;
            }

            .pagination .page-item.active .page-link {
                background-color: #4b8f3c;
                border-color: #4b8f3c;
            }

            .pagination .page-link {
                color: #4b8f3c;
                font-weight: bold;
            }

            .product-card {
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                transition: box-shadow 0.2s ease;
                display: block;
                width: 100%; /* Make sure it takes the full width */
                margin-bottom: 20px;
            }

            .product-card:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .product-card .d-flex {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .product-card img {
                width: 100%;
                max-width: 80px;
                margin-right: 15px;
            }

            .product-card .product-name {
                font-weight: bold;
                font-size: 1rem;
                color: #333;
            }

            .product-card .product-price {
                font-weight: bold;
                color: #e74c3c;
            }

            .product-card .shipment-info {
                color: #888;
                font-size: 0.9rem;
                margin-top: 10px;
            }

            .product-card .btn-review {
                background-color: #f1c40f;
                color: white;
                padding: 8px 15px;
                border-radius: 30px;
                font-weight: bold;
                text-align: center;
            }

            .product-card .btn-review:hover {
                background-color: #f39c12;
            }


            .review-form {
                display: none;
                margin-top: 20px;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .review-form textarea {
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 1rem;
                margin-top: 10px;
                height: 100px;
                resize: none;
            }

            .rating-stars {
                display: flex;
                gap: 5px;
            }

            .rating-stars i {
                font-size: 1.5rem;
                color: #f1c40f;
                cursor: pointer;
            }

            .rating-stars i.inactive {
                color: #ccc;
            }

            .btn-submit-review {
                margin-top: 10px;
                background-color: #2ecc71;
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: bold;
                width: 100%;
            }

            .btn-submit-review:hover {
                background-color: #27ae60;
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

        <div class="container order-history">
            <h2>Your Order History</h2>


            <c:forEach var="order" items="${orderHistory}">
                <div class="order-item">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p><strong>Order ID:</strong># ${order.orderID}</p>
                            <p><strong>Full Name:</strong> ${order.fullName}</p>
                            <p><strong>Phone:</strong> ${order.phone}</p>
                            <p><strong>Total Amount:</strong><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></p>
                        </div>
                        <div>
                            <p><strong>Address:</strong> ${order.address}</p>
                            <p><strong>Order Date:</strong> ${order.orderDate}</p>
                            <p><strong>Payment: </strong>
                                ${order.status}                        
                            </p>
                            <p><strong>Delivery: </strong>
                                ${order.statusOrder} (${order.shipCode})                        
                            </p>
                        </div>
                    </div>


                    <div class="product-info mt-3">
                        <c:forEach var="p" items="${order.product}">
                            <div class="product-card">
                                <div class="d-flex gap-3">

                                    <div class="d-flex gap-3">
                                        <img src="${p.imageUrl}" alt="Product">
                                        <div>

                                            <p class="product-name">${p.productName}</p>
                                            <p class="product-price"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></p>
                                            <p class="shipment-info">Quantity: ${p.quantity}</p>
                                        </div>
                                    </div>
                                    <c:if test="${order.statusOrder == 'Delivered'}">
                                        <button class="btn btn-review" onclick="toggleReviewForm('${order.orderID}', '${p.productID}')">
                                            <i class="bi bi-chat-left-text"></i> FeedBack
                                        </button>
                                    </c:if>

                                </div>

                                <form method="post" action="MainController">
                                    <div id="review-form-${order.orderID}-${p.productID}" class="review-form">
                                        <h4>Rate this Product</h4>
                                        <div class="rating-stars" id="stars-${order.orderID}-${p.productID}">
                                            <i class="bi bi-star" onclick="setRating('${order.orderID}', '${p.productID}', 1)"></i>
                                            <i class="bi bi-star" onclick="setRating('${order.orderID}', '${p.productID}', 2)"></i>
                                            <i class="bi bi-star" onclick="setRating('${order.orderID}', '${p.productID}', 3)"></i>
                                            <i class="bi bi-star" onclick="setRating('${order.orderID}', '${p.productID}', 4)"></i>
                                            <i class="bi bi-star" onclick="setRating('${order.orderID}', '${p.productID}', 5)"></i>
                                        </div>
                                            <textarea placeholder="Write your review..." name="reviewText" id="review-text-${order.orderID}-${p.productID}" required></textarea>                                                                           
                                        <input type="hidden" name="productID" value="${p.productID}" />
                                        <input type="hidden" name="rating" id="rating-review" value="5" />
                                        <button type="submit" class="btn-submit-review" name="action" value="SubmitReview">Submit Review</button>
                                    </div>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                    <c:if test="${order.statusOrder == 'Delivering'}">
                        <form method="post" action="MainController">
                            <input type="hidden" name="orderID" value="${order.orderID}" />
                            <input type="hidden" name="shipCode" value="${order.shipCode}" />
                            <button type="submit" class="btn btn-success mt-3" name="action" value="Delivered">
                                <i class="bi bi-box-check"></i> The goods have been received
                            </button>
                        </form>
                    </c:if> 
                    <c:if test="${not empty orderStatusMessage}">
                        <div class="alert alert-info mt-3">${orderStatusMessage}</div>
                    </c:if>
                </div>
            </c:forEach>


            <!-- Pagination -->
            <nav>
                <ul class="pagination">
                    <!-- Previous Page -->
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="MainController?action=OrderHistory&page=${currentPage - 1}">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                    </c:if>

                    <!-- Page Numbers (Show 3 pages at a time) -->
                    <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}" step="1">
                        <c:if test="${i > 0 && i <= totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="MainController?action=OrderHistory&page=${i}">${i}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <!-- Next Page -->
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="MainController?action=OrderHistory&page=${currentPage + 1}">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
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

    <script>

        function toggleReviewForm(orderID, productID) {
            var reviewForm = document.getElementById('review-form-' + orderID + '-' + productID);
            reviewForm.style.display = reviewForm.style.display === 'none' ? 'block' : 'none';
        }



        function setRating(orderID, productID, rating) {
            var stars = document.querySelectorAll('#stars-' + orderID + '-' + productID + ' i');
            for (let i = 0; i < stars.length; i++) {
                stars[i].classList.toggle('inactive', i >= rating);
            }
            console.log(rating);
            document.getElementById('rating-review').value = rating;
        }


    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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
