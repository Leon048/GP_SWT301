<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Veggie Market - Order Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: #f4f7fa;
                font-family: 'Segoe UI', sans-serif;
            }

            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #343a40;
                color: white;
                position: fixed;
                font-family: 'Segoe UI', sans-serif;
                padding-top: 20px;
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
                padding: 30px;
                min-height: 100vh;
            }

            .order-header h4 {
                color: #4b8f3c;
                font-size: 1.75rem;

            }

            .order-header p {
                font-size: 1rem;
                color: #555;
            }

            .order-status {
                background-color: #007bff;
                color: white;
                padding: 5px 10px;
                border-radius: 5px;
                font-weight: bold;
            }

            .order-items h5 {
                font-size: 1.25rem;
                font-weight: bold;
                margin-bottom: 20px;
                color: #4b8f3c;
            }

            .table {
                width: 100%;
                margin-top: 20px;
                background-color: #fff;
                border-collapse: collapse;
            }

            .table th,
            .table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .table th {
                background-color: #4b8f3c;
                color: white;
                font-weight: bold;
            }

            .table tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .table tbody tr:hover {
                background-color: #f1f1f1;
            }

            .table img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 5px;
            }

            .order-summary {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-top: 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .order-summary h5 {
                font-size: 1.25rem;
                font-weight: bold;
                color: #4b8f3c;
                margin-bottom: 20px;
            }

            .order-summary .total {
                font-weight: bold;
                font-size: 1.25rem;
                color: #007bff;
            }

            .order-summary button {
                background-color: #f37021;
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s;
            }

            .order-summary button:hover {
                background-color: #e05d0d;
            }

            /* Pagination */
            .pagination {
                justify-content: center;
                margin-top: 30px;
            }

            .pagination .page-item.active .page-link {
                background-color: #4b8f3c;
                border-color: #4b8f3c;
            }

            .page-link {
                color: #4b8f3c;
                font-weight: bold;
                padding: 10px 15px;
                text-decoration: none;
            }

            .page-item:hover .page-link {
                background-color: #f1f1f1;
                border-color: #ddd;
            }

            .back-button {
                font-size: 0.9rem;
                background-color: #6c757d;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #5a6268;
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
            <a href="MainController?action=OrderManagement" class="back-button mb-4"><i class="bi bi-arrow-left"></i> Back to Orders</a>

            <div class="order-header mt-4">
                <div class="d-flex justify-content-between align-items-center">
                    <h4>Order #${order.orderID}</h4>
                    <span >
                        <div><p><strong>Ship Code:</strong> ${order.shipCode}</p></div>
                        <div><strong>Deliveries: </strong><span class="order-status">${order.statusOrder}</span></div>
                    </span>
                </div>
                <div>
                    <p><strong>Customer:</strong> ${order.name} (${order.email})</p>
                    <p><strong>Shipping Address:</strong> ${order.shippingAddress}</p>
                    <p><strong>Order Date:</strong> ${order.orderDate}</p>
                    <p><strong>Payment:</strong> ${order.status}</p>
                </div>
            </div>

            <div class="order-items mt-4">
                <h5>Ordered Items</h5>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Image</th>                           
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${orderItems}">
                            <tr>
                                <td>${item.productName}</td>
                                <td><img src="${item.imageUrl}" alt="${item.productName}" width="50"></td>
                                <td>${item.quantity}</td>
                                <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/></td>
                                <td><fmt:formatNumber value="${item.quantity * item.unitPrice}" type="currency" currencySymbol="₫"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="order-summary mt-4">
                <div>
                    <h5>Order Summary</h5>
                    <table class="table">
                        <tbody>                     
                            <tr>
                                <th class="total" style="color: white">Total</th>
                                <td class="total" style="color: red" ><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <c:if test="${order.statusOrder == 'Pending'}">
                    <c:if test="${order.status != 'Failed'}">
                        <form method="post" action="MainController?action=ConfirmOrder">
                            <input type="hidden" name="orderID" value="${order.orderID}" />
                            <input type="hidden" name="shipCode" value="${order.shipCode}" />
                            <button class="btn">Confirm Order</button>
                        </form>         
                    </c:if>             
                </c:if>

            </div>
            <c:if test="${not empty orderStatusMessage}">
                <div class="alert alert-info mt-3">${orderStatusMessage}</div>
            </c:if>
        </div>
    </body>
</html>
