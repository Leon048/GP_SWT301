<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="dto.ChatProductDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<ChatProductDTO> productList = (List<ChatProductDTO>) request.getAttribute("products");
    String productJson = new Gson().toJson(productList).replace("\"", "\\\"");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chat with AI</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            #chat-box {
                border: 1px solid #ccc;
                height: 400px;
                overflow-y: auto;
                padding: 10px;
                margin-bottom: 10px;
            }
            #chatForm {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-top: 15px;
            }
            #message {
                flex: 1;
                padding: 10px 14px;
                font-size: 1rem;
                border: 1px solid #ced4da;
                border-radius: 6px;
                outline: none;
                transition: border-color 0.3s;
            }

            #message:focus {
                border-color: #198754;
                box-shadow: 0 0 0 2px rgba(25, 135, 84, 0.2);
            }

            #chatForm button {
                padding: 10px 18px;
                font-size: 1rem;
                font-weight: 500;
                background-color: #198754;
                color: white;
                border: none;
                border-radius: 6px;
                transition: background-color 0.3s ease;
                cursor: pointer;
            }

            #chatForm button:hover {
                background-color: #146c43;
            }
            .user {
                color: blue;
            }
            .ai {
                color: green;
            }
            ul {
                margin: 0;
                padding-left: 20px;
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
        <div class="container my-4 px-4">
            <h2>Chat with AI</h2>

            <div id="chat-box"></div>

            <form id="chatForm">
                <input type="text" id="message" required placeholder="Type your message..." />
                <button type="submit">Send</button>
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

        <script>
            const productData = JSON.parse("<%= productJson %>");
            const chatBox = document.getElementById("chat-box");
            const form = document.getElementById("chatForm");
            const input = document.getElementById("message");

            form.addEventListener("submit", async (e) => {
                e.preventDefault();
                const userMessage = input.value.trim();
                if (!userMessage)
                    return;

                chatBox.insertAdjacentHTML("beforeend", "<p class='user'><strong>You:</strong> " + userMessage + "</p>");
                input.value = "";
                chatBox.scrollTop = chatBox.scrollHeight;

                const prompt =
                        "Dưới đây là danh sách sản phẩm:\n" + JSON.stringify(productData) + "\n\n" +
                        "Người dùng hỏi: \"" + userMessage + "\"\n\n" +
                        "Hãy trả lời như sau:\n" +
                        "1. Một câu lý do ngắn tại sao nên chọn sản phẩm phù hợp.\n" +
                        "2. Một danh sách JSON sản phẩm phù hợp dạng:\n" +
                        "[\n  { \"productId\": 1, \"productName\": \"Tên sản phẩm\" }\n]";

                const API_KEY = "AIzaSyAK91SBVutqeyc4WLX33Lxm5HqF443yL5k";

                try {
                    const response = await fetch("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY, {
                        method: "POST",
                        headers: {"Content-Type": "application/json"},
                        body: JSON.stringify({
                            contents: [{parts: [{text: prompt}]}]
                        })
                    });

                    const data = await response.json();
                    let html = `<p class="ai"><strong>AI:</strong><br/>`;

                    if (data.candidates && data.candidates.length > 0) {
                        const aiRaw = data.candidates[0].content.parts[0].text.trim();
                        console.log(aiRaw);

                        let reasonText = "";
                        let productJson = "";

                        const jsonStart = aiRaw.indexOf("```json");
                        const jsonEnd = aiRaw.lastIndexOf("```");

                        if (jsonStart !== -1 && jsonEnd !== -1 && jsonEnd > jsonStart) {
                            reasonText = aiRaw.substring(0, jsonStart).trim();
                            productJson = aiRaw.substring(jsonStart + 7, jsonEnd).trim();
                        } else {

                            const lines = aiRaw.split("\n");
                            reasonText = lines[0];
                            productJson = lines.slice(1).join("\n").trim();
                        }


                        if (reasonText && reasonText.length > 0) {
                            html += "<div style='margin-bottom: 8px; font-style: italic;'>" + reasonText + "</div>";
                        }
                        console.log(reasonText)
                        try {
                            const products = JSON.parse(productJson);
                            if (Array.isArray(products) && products.length > 0) {

                                html += "<ul>";
                                for (let p of products) {
                                    html += "<li><a href='MainController?action=ProductDetail&productID=" + p.productId + "'>" + p.productName + "</a></li>";
                                }
                                html += "</ul>";
                            } else {
                                html += "Không tìm thấy sản phẩm phù hợp.";
                            }
                        } catch (e) {
                            html += "<br/>⚠️ Không thể phân tích danh sách sản phẩm từ phản hồi.";
                        }
                    } else {
                        html += "Không có phản hồi từ AI.";
                    }

                    html += "</p>";
                    chatBox.insertAdjacentHTML("beforeend", html);
                    chatBox.scrollTop = chatBox.scrollHeight;
                } catch (err) {
                    console.error(err);
                    chatBox.insertAdjacentHTML("beforeend", `<p class="ai"><strong>AI:</strong> Lỗi khi gọi API.</p>`);
                }
            });
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
        }, 500); // 2 giây
    });
</script>
