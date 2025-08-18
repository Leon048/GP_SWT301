<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>${product.productName}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .thumb-img {
                width: 80px;
                cursor: pointer;
                border: 2px solid transparent;
            }
            .thumb-img:hover {
                border-color: orange;
            }
            .selected-thumb {
                border-color: red !important;
            }
            .discount-badge {
                position: absolute;
                top: 0;
                left: 0;
                background: red;
                color: #fff;
                padding: 2px 8px;
                font-size: 0.8rem;
                border-radius: 0 0 8px 0;
            }
            .price {
                font-size: 1.5rem;
                font-weight: bold;
                color: red;
            }
            .original-price {
                text-decoration: line-through;
                color: #888;
                margin-left: 10px;
            }
            .benefits i {
                font-size: 1.5rem;
                color: green;
            }
            .btn-orange {
                background-color: orange;
                border: none;
                color: white;
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
            .product-card img {
                width: 100%; /* Đảm bảo hình ảnh chiếm đầy card */
                height: 200px; /* Cố định chiều cao */
                object-fit: cover; /* Cắt ảnh cho phù hợp mà không bị biến dạng */
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
        <div class="container my-5">
            <div class="row">
                <!-- LEFT IMAGE PANEL -->
                <div class="col-md-6 position-relative">
                    <c:if test="${product.discountPercent != 0}">
                        <span class="discount-badge">-${product.discountPercent}%</span>
                    </c:if>

                    <img id="mainImage" src="${product.imageUrl}" class="img-fluid mb-3" alt="Main image">
                    <div class="d-flex gap-2">
                        <img src="${product.imageUrl}" class="thumb-img selected-thumb" onclick="changeImage(this)">
                        <c:forEach var="img" items="${imageProducts}">
                            <img src="${img.imageUrl}" class="thumb-img" onclick="changeImage(this)">
                        </c:forEach>
                    </div>
                </div>

                <!-- RIGHT INFO PANEL -->
                <div class="col-md-6">
                    <h4>${product.productName}</h4>                 
                    <div class="d-flex align-items-center mb-3">
                        <span class="price"><fmt:formatNumber value="${product.discountPrice}" type="currency" currencySymbol="₫"/></span>
                        <c:if test="${product.discountPercent != 0}">
                            <span class="original-price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/></span>
                        </c:if>


                    </div>


                    <div class="d-flex gap-2 mb-3">
                        <form method="post" action="MainController">
                            <input type="hidden" name="productID" value="${product.productID}"/>
                            <button type="submit" class="btn btn-outline-danger" name="action" value="AddToCart">ADD TO CART</button>
                        </form>
                        <form method="post" action="MainController">                       
                            <input type="hidden" name="productId" value="${product.productID}">
                            <input type="hidden" name="quantity" value="1">
                            <button class="btn btn-orange" name="action" value="BuyNow">BUY NOW</button>
                        </form>

                    </div>


                    <div class="benefits d-flex flex-wrap gap-4">
                        <div><i class="bi bi-truck"></i> Fast Delivery</div>
                        <div><i class="bi bi-shield-check"></i> Quality Guarantee</div>
                        <div><i class="bi bi-box-seam"></i> Check on Delivery</div>
                        <div><i class="bi bi-arrow-repeat"></i> 48h Return Policy</div>
                    </div>
                </div>
            </div>


            <div class="mt-5">
                <h5><strong>PRODUCT DESCRIPTION</strong></h5>
                <p class="mb-1">
                    <span class="text-warning">
                        <c:forEach var="i" begin="1" end="${product.rating}">
                            <i class="bi bi-star-fill text-warning"></i>
                        </c:forEach>
                        <c:forEach var="i" begin="${product.rating + 1}" end="5">
                            <i class="bi bi-star text-muted"></i>
                        </c:forEach>
                    </span>

                </p>              
                <p><strong>Origin:</strong> ${product.origin}</p>
                <p><strong>Description:</strong> ${product.description}</p>          
            </div>

            <div class="mt-5">
                <h5><strong>PRODUCT REVIEWS</strong></h5>
                <c:forEach var="review" items="${reviews}">
                    <div class="review-item mb-3">
                        <div class="d-flex align-items-center">
                            <img src="${review.imageUrl}" alt="User Image" class="rounded-circle" width="40" height="40">
                            <span class="ms-3"><strong>${review.fullName}</strong></span>
                        </div>
                        <div class="d-flex gap-1 mt-2">
                            <c:forEach var="i" begin="1" end="${review.rating}">
                                <i class="bi bi-star-fill text-warning"></i>
                            </c:forEach>
                            <c:forEach var="i" begin="${review.rating + 1}" end="5">
                                <i class="bi bi-star text-muted"></i>
                            </c:forEach>
                        </div>
                        <p class="mt-2">${review.comment}</p>
                    </div>
                </c:forEach>
            </div>

            <h5 class="mt-5 mb-3">Related Products</h5>
            <div class="row row-cols-1 row-cols-md-4 g-3">                             
                <c:forEach var="p" items="${relatedProducts}">
                    <div class="col">
                        <div class="card product-card position-relative">
                            <a href="MainController?action=ProductDetail&productID=${p.productID}" class="text-decoration-none text-dark">
                                <c:if test="${p.discountPercent != 0}">
                                    <span class="badge-discount">-${p.discountPercent}%</span>
                                </c:if>

                                <img src="${p.imageUrl}" class="card-img-top" alt="${p.productName}">
                                <div class="view-icon"><i class="bi bi-eye"></i></div>
                                <div class="card-body">
                                    <small class="text-muted">${p.origin}</small>
                                    <h6 class="mt-1">${p.productName}</h6>
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
                                <input type="hidden" name="productID" value="${p.productID}" />
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
        function changeImage(el) {
            document.getElementById("mainImage").src = el.src;
            document.querySelectorAll('.thumb-img').forEach(img => img.classList.remove('selected-thumb'));
            el.classList.add('selected-thumb');
        }
    </script>
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
        }, 500);
    });
</script>