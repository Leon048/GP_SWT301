<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Checkout - Veggie Market</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .payment-container {
                max-width: 1200px;
                margin: auto;
                padding: 40px 20px;
                background: #fff;
            }
            .payment-title {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 30px;
            }
            .order-summary {
                background-color: #f5f5f5;
                padding: 20px;
                border-radius: 8px;
            }
            .order-summary img {
                width: 60px;
                height: 60px;
                object-fit: cover;
            }
            .form-check-label i {
                margin-right: 8px;
                color: #007baf;
            }
            .order-total {
                font-size: 1.3rem;
                font-weight: bold;
            }
            .complete-btn {
                background-color: #f37021;
                color: white;
            }
            .complete-btn:hover {
                background-color: #e05d0d;
            }
            .btn-outline-secondary {
                border-color: #ccc;
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
        <div class="container payment-container">
            <form method="post" action="MainController">
                <div class="row">
                    <!-- Left -->
                    <div class="col-md-7">
                        <h4 class="payment-title">Shipping Information</h4>

                        <form method="post" action="MainController">
                            <div class="mb-3">
                                <input type="text" class="form-control" name="fullName"  placeholder="Full Name" value="${param.fullName}" required>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <input type="email" class="form-control" name="email" placeholder="Email" value="${param.email}" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" class="form-control" name="phone" placeholder="Phone Number" value="${param.phone}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <input type="text" class="form-control" name="address" placeholder="Address" value="${param.address}" required>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <select class="form-control" id="province" name="province" required>
                                        <option value="">Select Province</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <select class="form-control" id="district" name="district" required>
                                        <option value="">Select District</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <select class="form-control" id="ward" name="ward" required>
                                        <option value="">Select Ward</option>
                                    </select>
                                </div>
                            </div>
                            <div id="addressError" class="alert alert-danger" style="display: none;">
                                <strong>Error:</strong> The selected location is not valid. Please choose a valid address.
                            </div>

                            <h5>Payment Method</h5>

                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="payment" id="cod" value="1" checked>
                                <label class="form-check-label" for="cod">
                                    <i class="bi bi-truck"></i> Cash on Delivery (COD)
                                </label>
                            </div>
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="radio" name="payment" id="vnpay" value="2">
                                <label class="form-check-label" for="vnpay">
                                    <i class="bi bi-credit-card"></i> VNPAY
                                </label>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="cart.jsp" class="btn btn-outline-secondary">Back to Cart</a>
                                <c:forEach var="item" items="${cartItems}">
                                    <input type="hidden" name="productID" value="${item.productID}" />
                                    <input type="hidden" name="productName" value="${item.productName}" />
                                    <input type="hidden" name="imageUrl" value="${item.imageUrl}" />
                                    <input type="hidden" name="discountPrice" value="${item.discountPrice}" />
                                    <input type="hidden" name="quantity" value="${item.quantity}" />
                                </c:forEach>
                                <input type="hidden" name="provinceSelected" id="provinceSelected" value="" />
                                <input type="hidden" name="districtSelected" id="districtSelected" value="" />
                                <input type="hidden" name="wardSelected" id="wardSelected" value="" />
                                <input type="hidden" name="totalAmount" id="totalAmount" value="${empty total ? (empty totalAmount ? 0 : totalAmount) : total}" />
                                <button type="submit" class="btn complete-btn" name="action" value="Order">Check Out</button>
                            </div>
                        </form>
                    </div>

                    <!-- Right -->
                    <div class="col-md-5">
                        <div class="order-summary">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="d-flex justify-content-between align-items-center">
                                    <img src="${item.imageUrl}" class="me-3" alt="${item.productName}" />                              
                                    <div>
                                        <div>${item.productName} - ${item.quantity}</div>                                 
                                    </div>
                                    <div class="fw-bold"><fmt:formatNumber value="${item.discountPrice}" type="currency" currencySymbol="₫"/></div>
                                </div>
                                <hr>
                            </c:forEach>


                            <input type="text" class="form-control mb-3" name="voucherCode" placeholder="Discount Code" value="${param.voucherCode}">
                            <button class="btn btn-outline-danger w-100 mb-3" type="submit" name="action" value="ApplyVoucher">Apply</button>


                            <c:if test="${not empty voucherError}">
                                <div class="alert alert-info">${voucherError}</div>
                            </c:if>


                            <div class="d-flex justify-content-between">
                                <span>Subtotal</span>
                                <span>
                                    <span id="subtotal"><fmt:formatNumber value="${empty totalAmount ? 0 : totalAmount}" type="currency" currencySymbol="₫"/></span>
                                </span>

                            </div>

                            <div class="d-flex justify-content-between">
                                <span>Discount</span>
                                <span>
                                    <span id="discount"><fmt:formatNumber value="${empty discount ? 0 : discount}" type="currency" currencySymbol="₫"/></span>
                                </span>

                            </div>

                            <div class="d-flex justify-content-between">
                                <span>Shipping Fee</span>
                                <span>
                                    <span id="shipping-fee">0</span><span>&#273;</span>
                                </span>
                            </div>
                            <hr>

                            <div class="d-flex justify-content-between order-total">
                                <span>Total</span><span>
                                    <span id="total"><fmt:formatNumber  value="${empty total ? (empty totalAmount ? 0 : totalAmount) : total}" type="currency" currencySymbol="₫"/></span>
                                </span>

                            </div>
                        </div>
                    </div>
                </div>
            </form>
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
<script>
    const token = 'a4cf5c26-7379-11ef-8e53-0a00184fe694'; 
    const shopId = '194471';


    function loadProvinces() {
        fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Token': token
            }
        })
                .then(response => response.json())
                .then(data => {
                    const provinces = data.data;
                    const provinceSelect = document.getElementById("province");
                    provinceSelect.innerHTML = "<option value=''>Select Province</option>";
                    provinces.forEach(province => {
                        const option = document.createElement("option");
                        option.value = province.ProvinceID;
                        option.textContent = province.ProvinceName;
                        provinceSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching provinces:', error));
    }

    function loadDistricts(provinceId) {
        const url = 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=' + provinceId;
        fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Token': token
            }
        })
                .then(response => response.json())
                .then(data => {
                    const districts = data.data;
                    const districtSelect = document.getElementById("district");
                    districtSelect.innerHTML = "<option value=''>Select District</option>"; // Clear previous options
                    districts.forEach(district => {
                        const option = document.createElement("option");
                        option.value = district.DistrictID;
                        option.textContent = district.DistrictName;
                        districtSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching districts:', error));
    }

    function loadWards(districtId) {
        const url = 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtId;
        fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Token': token
            }
        })
                .then(response => response.json())
                .then(data => {
                    const wards = data.data;
                    const wardSelect = document.getElementById("ward");
                    wardSelect.innerHTML = "<option value=''>Select Ward</option>"; // Clear previous options
                    wards.forEach(ward => {
                        const option = document.createElement("option");
                        option.value = ward.WardCode;
                        option.textContent = ward.WardName;
                        wardSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching wards:', error));
    }

    function calculateShippingFee(fromDistrictId, fromWardCode, toDistrictId, toWardCode, weight, length, width, height) {
        const url = 'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee';

        const payload = {
            service_type_id: 2,
            from_district_id: parseInt(fromDistrictId),
            from_ward_code: fromWardCode,
            to_district_id: parseInt(toDistrictId),
            to_ward_code: toWardCode,
            length: length,
            width: width,
            height: height,
            weight: weight,
            insurance_value: 0,
            coupon: null,
            items: [
                {
                    name: "Product",
                    quantity: 1,
                    length: length,
                    width: width,
                    height: height,
                    weight: weight
                }
            ]
        };
        console.log(payload);

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Token': token,
                'ShopId': shopId
            },
            body: JSON.stringify(payload)
        })
                .then(response => response.json())
                .then(data => {
                    console.log(data.data);
                    if (data.code === 200 && data.data) {
                        const shippingFee = data.data.total;

                        document.getElementById("shipping-fee").innerText = `₫`+formatToVND(shippingFee) ;

                        let subtotal = parseVietnameseCurrency(document.getElementById("subtotal").innerText);
                        const discount = parseVietnameseCurrency(document.getElementById("discount").innerText);
                        subtotal = Math.floor(subtotal / 100);
                        console.log(subtotal);
                        const total = subtotal - discount + shippingFee;
                        console.log(total);
                        document.getElementById("total").innerText = `₫`+formatToVND(total);
                        document.getElementById("totalAmount").value = total;
                        ;
                    } else {
                        console.error('Error calculating shipping fee:', data);
                        document.getElementById("addressError").style.display = "block";
                    }
                })
                .catch(error => {
                    console.error('Error fetching shipping fee:', error);
                });
    }

    function parseVietnameseCurrency(text) {
        return parseFloat(text.replace(/[₫,.]/g, '').trim());
    }
    function formatToVND(amount) {
        return amount.toLocaleString('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }

    document.getElementById("province").addEventListener("change", function () {
        const provinceId = this.value;
        const provinceName = this.options[this.selectedIndex].text;
        console.log(provinceName);
        document.getElementById("provinceSelected").value = provinceName;
        if (provinceId) {
            loadDistricts(provinceId);
        } else {
            document.getElementById("district").innerHTML = "<option value=''>Select District</option>";
            document.getElementById("ward").innerHTML = "<option value=''>Select Ward</option>";
        }
    });

    document.getElementById("district").addEventListener("change", function () {
        const districtId = this.value;
        const districtName = this.options[this.selectedIndex].text;
        document.getElementById("districtSelected").value = districtName;
        if (districtId) {
            loadWards(districtId);
        } else {
            document.getElementById("ward").innerHTML = "<option value=''>Select Ward</option>";
        }
    });

    document.getElementById("ward").addEventListener("change", function () {
        const fromDistrictId = 1442;
        const fromWardCode = "21211";
        const toDistrictId = document.getElementById("district").value;
        const wardName = this.options[this.selectedIndex].text;
        document.getElementById("wardSelected").value = wardName;
        const toWardCode = this.value;
        const weight = 100;
        const length = 30;
        const width = 20;
        const height = 20;

        if (toDistrictId && toWardCode) {
            calculateShippingFee(fromDistrictId, fromWardCode, toDistrictId, toWardCode, weight, length, width, height);
        }
    });


    window.onload = function () {
        loadProvinces();
    };
</script>