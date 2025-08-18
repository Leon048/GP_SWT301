<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Login - Vegetable Market</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
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

            .login-card {
                background: #f9fff4;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
                padding: 40px;
                width: 100%;
                max-width: 450px;
                text-align: center;
            }

            .login-card h2 {
                margin-bottom: 30px;
                font-weight: 700;
                color: #4b8f3c;
                letter-spacing: 1.2px;
            }

            .form-label {
                text-align: left;
                font-weight: 600;
                color: #3e3e3e;
            }

            .form-control:focus {
                border-color: #77c85c;
                box-shadow: 0 0 8px rgba(119, 200, 92, 0.5);
            }

            .btn-primary {
                background-color: #77c85c;
                border: none;
                padding: 12px;
                font-weight: 600;
                width: 100%;
                margin-top: 15px;
            }

            .btn-primary:hover {
                background-color: #5da244;
            }

            .error-message {
                margin-bottom: 15px;
                padding: 12px;
                background-color: #f8d7da;
                color: #842029;
                border-radius: 8px;
                font-weight: 600;
            }

            .register-link {
                margin-top: 20px;
                font-size: 14px;
                color: #555;
            }

            .register-link a {
                color: #4b8f3c;
                font-weight: 600;
            }

            .register-link a:hover {
                text-decoration: underline;
            }

            .google-btn {
                background: white;
                color: #555;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                width: 100%;
                margin-top: 20px;
            }

            .google-btn:hover {
                background-color: #f1f1f1;
            }

            .or-text {
                margin: 15px 0 10px;
                font-weight: 600;
                color: #444;
            }
        </style>
    </head>
    <body>
        <div class="login-card">
            <h2><i class="bi bi-basket-fill"></i> Veggie Market</h2>

            <form action="MainController" method="POST" autocomplete="off">
                <c:if test="${not empty ERROR}">
                    <div class="error-message">
                        <i class="bi bi-exclamation-circle-fill"></i> ${ERROR}
                    </div>
                </c:if>

                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                    <input type="text" id="usernameInput" name="email" class="form-control" placeholder="Enter your email" required />
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                    <input type="password" id="passwordInput" name="password" class="form-control" placeholder="Enter your password" required />
                </div>

                <button type="submit" name="action" value="Login" class="btn btn-primary">
                    <i class="bi bi-box-arrow-in-right"></i> Login
                </button>
            </form>

            <div class="register-link">
                Don't have an account? <a href="register.jsp">Register now</a>
            </div>

            <div class="or-text">Or</div>

            <a href="" class="google-btn">
                <i class="bi bi-google"></i> Sign in with Google
            </a>
        </div>
    </body>
</html>
