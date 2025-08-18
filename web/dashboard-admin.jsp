<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html> <html lang="en"> <head> <meta charset="UTF-8">
        <title>Admin Dashboard - Veggie Market</title> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: #f4f7fa;
            }
            .sidebar {
                width: 240px;
                height: 100vh;
                background-color: #343a40; /* xanh lá đậm */
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
            .card {
                border: none;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }
            .card-header {
                background-color: transparent;
                font-weight: bold;
            }
            .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }
            .status-dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                display: inline-block;
                margin-right: 6px;
            }
            .navbar-brand {
                font-size: 1.5rem;
                font-weight: bold;

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
            .card i {
                background-color: rgba(0,0,0,0.05);
                padding: 10px;
                border-radius: 50%;
            }
            canvas#revenueChart {
                width: 100% !important;
                min-width: 600px;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head> 
    <body> 

        <div class="sidebar d-flex flex-column p-3">       
            <div class="text-center mb-2">
                <a class="navbar-brand fw-bold" href="MainController?action=dashboard" style=" font-size: 1.3rem;">
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
        </div> <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4"> 
                <h3>Dashboard</h3>
                <div class="d-flex gap-3"> 
                    <i class="bi bi-gear fs-4"></i> 
                    <i class="bi bi-bell fs-4"></i> 
                    <i class="bi bi-person fs-4"></i>
                </div>
            </div>
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card p-3 d-flex flex-column align-items-start gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-cash-stack fs-3 text-success"></i>
                            <div>
                                <h6 class="mb-0">Total Revenue</h6>
                                <h4>${totalRevenue} đ</h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3 d-flex flex-column align-items-start gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-box-seam fs-3 text-primary"></i>
                            <div>
                                <h6 class="mb-0">Total Products</h6>
                                <h4>${totalProducts}</h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3 d-flex flex-column align-items-start gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-people-fill fs-3 text-warning"></i>
                            <div>
                                <h6 class="mb-0">Total Users</h6>
                                <h4>${totalUsers}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card p-3 d-flex flex-column align-items-start gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-bag-check fs-3 text-info"></i>
                            <div>
                                <h6 class="mb-0">Today’s Orders</h6>
                                <h4>${todaysOrders}</h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3 d-flex flex-column align-items-start gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-exclamation-triangle fs-3 text-danger"></i>
                            <div>
                                <h6 class="mb-0">Low Stock Products</h6>
                                <h4 class="text-danger mb-0">${lowStock}</h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3 d-flex flex-column align-items-start gap-2">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-hourglass-split fs-3 text-secondary"></i>
                            <div>
                                <h6 class="mb-0">Pending Orders</h6>
                                <h4 class="text-secondary mb-0">${pendingOrders}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-6">

                    <div class="card p-3">
                        <h6 class="mb-3">Monthly Revenue</h6>
                        <canvas id="revenueChart" height="400" style="width: 100%; min-width: 500px;"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card p-3">
                        <h6 class="mb-3">New Orders</h6>
                        <ul class="list-group list-group-flush">
                            <c:forEach var="order" items="${newOrders}">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><span class="status-dot bg-info"></span> Order #${order.orderID}</span>
                                    <span>${order.orderDate}</span>
                                    <a href="MainController?action=OrderDetailManagement&orderID=${order.orderID}">
                                        <button class="btn btn-sm btn-info"> <i class="bi bi-eye"></i></button>
                                    </a>

                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> </body> </html>
<script>
    const ctx = document.getElementById('revenueChart').getContext('2d');
    const revenueChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                    label: 'Revenue (đ)',
                    data: ${monthlyRevenue}, // dữ liệu từ server
                    backgroundColor: '#4CAF50',
                    borderRadius: 5,
                    barThickness: 35
                }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: value => value + 'đ'
                    }
                }
            }
        }
    });
</script>