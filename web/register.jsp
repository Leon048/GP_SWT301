<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register - Veggie Market</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(to right, #c9f299, #6cc070);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
            }

            .register-card {
                background: #f9fff4;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
                padding: 40px;
                width: 100%;
                max-width: 500px;
            }

            .register-card h2 {
                text-align: center;
                margin-bottom: 30px;
                font-weight: 700;
                color: #4b8f3c;
            }

            .input-group-text {
                background-color: #e3f4dc;
            }

            .form-control:focus {
                border-color: #77c85c;
                box-shadow: 0 0 8px rgba(119, 200, 92, 0.5);
            }

            .btn-success {
                background-color: #5da244;
                border: none;
                font-weight: 600;
                width: 100%;
                padding: 12px;
            }

            .btn-success:hover {
                background-color: #4b8f3c;
            }

            .register-link {
                margin-top: 20px;
                text-align: center;
                font-size: 14px;
                color: #555;
            }

            .register-link a {
                color: #4b8f3c;
                font-weight: 600;
                text-decoration: none;
            }

            .register-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="register-card">
            <h2><i class="bi bi-person-plus-fill"></i> Create Account</h2>

            <form action="MainController" method="POST">

                <c:if test="${not empty ERROR}">
                    <div class="alert alert-danger text-center mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i> ${ERROR}
                    </div>
                </c:if>
                <!-- Full Name -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                    <input type="text" name="fullName" class="form-control" placeholder="Full name" required>
                </div>

                <!-- Email -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>

                <!-- Phone -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                    <input type="text" name="phone" class="form-control" placeholder="Phone number">
                </div>

                <!-- Password -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <!-- Confirm Password -->
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                </div>

                <!-- Address -->
                <div class="input-group mb-4">
                    <span class="input-group-text"><i class="bi bi-house-door-fill"></i></span>
                    <input type="text" name="address" class="form-control" placeholder="Address">
                </div>

                <!-- Submit button -->
                <button type="submit" name="action" value="Register" class="btn btn-success">
                    <i class="bi bi-check-circle-fill"></i> Register
                </button>
            </form>

            <div class="register-link">
                <i class="bi bi-person-check-fill"></i>
                Already have an account?
                <a href="login.jsp">Login here</a>
            </div>
        </div>
    </body>
</html>
