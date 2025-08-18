<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Veggie Market - Account Management</title>
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

            .account-table {
                width: 100%;
                background-color: #fff;
                border-collapse: collapse;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .account-table th,
            .account-table td {
                padding: 15px;
                text-align: center;
            }

            .account-table th {
                background-color: #4b8f3c;
                color: white;
                font-weight: bold;
            }

            .account-table tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .account-table tbody tr:hover {
                background-color: #e1f5e6;
            }

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
            <h4 class="mb-4">Account Management</h4>
            <table class="table table-striped account-table">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Role</th>
                        <th>Loyalty Points</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userID}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.address}</td>
                            <td>${user.roleID}</td>
                            <td>${user.loyaltyPoints}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.isActive == true}">Active</c:when>
                                    <c:otherwise>Inactive</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <nav>
                <ul class="pagination">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="MainController?action=AccountManagement&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </body>
</html>
