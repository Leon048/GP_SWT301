<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Voucher Management</title>
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

    </style>
</head>
<body>
    <!-- SIDEBAR -->
    <div class="sidebar d-flex flex-column p-3">
        <a class="navbar-brand fw-bold" href="MainController?action=dashboard" style="font-size: 1.3rem;">
            <i class="bi bi-basket-fill me-1" style="color: #28a745;"></i> Veggie Market
        </a>
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

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Voucher Management</h2>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">+ Add Voucher</button>
            </div>

            <table class="table table-bordered bg-white shadow-sm">
                <thead class="table-dark">
                    <tr>
                        <th>Code</th>
                        <th>Discount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${voucherList}">
                        <tr>
                            <td>${v.code}</td>
                            <td>${v.discountAmount} %</td>
                            <td>
                                <span class="badge bg-${v.isActive ? 'success' : 'secondary'}">
                                    ${v.isActive ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                            <td>
                                <button type="button" class="btn btn-sm btn-primary"
                                    onclick="openEditModal('${v.code}', '${v.discountAmount}', ${v.isActive})">Edit</button>
                                <form action="MainController?action=DeleteVoucher" method="post" style="display:inline;">
                                    <input type="hidden" name="code" value="${v.code}">
                                    <button type="submit" class="btn btn-sm btn-danger">Deactivate</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ADD MODAL -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="MainController?action=AddVoucher" method="post" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Voucher</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Code</label>
                        <input type="text" name="code" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Discount Amount</label>
                        <input type="number" name="discount" step="0.01" class="form-control" required>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="active" class="form-check-input" id="activeCheck">
                        <label for="activeCheck" class="form-check-label">Active</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary">Add Voucher</button>
                </div>
            </form>
        </div>
    </div>

    <!-- EDIT MODAL -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <form action="MainController?action=EditVoucher" method="post" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Voucher</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="code" id="editCode">
                    <div class="mb-3">
                        <label class="form-label">Discount Amount</label>
                        <input type="number" name="discount" step="0.01" id="editDiscount" class="form-control" required>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" name="active" id="editActive" class="form-check-input">
                        <label for="editActive" class="form-check-label">Active</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>

    <!-- SCRIPT -->
    <script>
        function openEditModal(code, discount, isActive) {
            document.getElementById("editCode").value = code;
            document.getElementById("editDiscount").value = discount;
            document.getElementById("editActive").checked = isActive;
            new bootstrap.Modal(document.getElementById("editModal")).show();
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
