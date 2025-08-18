<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category Management</title>
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
        </style>
    </head>
    <body>
        <!-- SIDEBAR -->
        <div class="sidebar d-flex flex-column p-3">
            <a class="navbar-brand fw-bold" href="#" style="font-size: 1.3rem;">
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

        <!-- MAIN -->
        <div class="main-content">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>Category Management</h3>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">
                        <i class="bi bi-plus-circle"></i> Add Category
                    </button>
                </div>

                <!-- CATEGORY TABLE -->
                <table class="table table-bordered bg-white shadow-sm">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th style="width: 150px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categoryList}">
                            <tr>
                                <td>${cat.categoryId}</td>
                                <td>${cat.categoryName}</td>
                                <td>
                                    <button class="btn btn-sm btn-primary"
                                            onclick="openEditModal('${cat.categoryId}', '${cat.categoryName}')">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <form action="MainController?action=DeleteCategory" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="DeleteCategory">
                                        <input type="hidden" name="id" value="${cat.categoryId}">
                                        <button class="btn btn-sm btn-danger" type="submit"><i class="bi bi-trash"></i></button>
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
                <form action="MainController?action=AddCategory" method="post" class="modal-content">
                    <input type="hidden" name="action" value="AddCategory">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Category</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <label class="form-label">Category Name</label>
                        <input type="text" name="categoryName" class="form-control" required>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btn-primary">Add</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- EDIT MODAL -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog">
                <form action="MainController?action=EditCategory" method="post" class="modal-content">
                    <input type="hidden" name="action" value="UpdateCategory">
                    <input type="hidden" name="id" id="editCategoryId">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Category</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <label class="form-label">Category Name</label>
                        <input type="text" name="categoryName" id="editCategoryName" class="form-control" required>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button class="btn btn-primary">Update</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openEditModal(id, name) {
                document.getElementById("editCategoryId").value = id;
                document.getElementById("editCategoryName").value = name;
                new bootstrap.Modal(document.getElementById("editModal")).show();
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
