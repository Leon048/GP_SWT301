/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author xuant
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String REGISTER = "Register";
    private static final String REGISTER_CONTROLLER = "RegisterController";
    private static final String HOME = "Home";
    private static final String HOME_CONTROLLER = "HomeController";
    private static final String CART = "AddToCart";
    private static final String CART_CONTROLLER = "CartController";
    private static final String PRODUCT = "Product";
    private static final String PRODUCT_CONTROLLER = "ProductController";
    private static final String PRODUCTDETAIL = "ProductDetail";
    private static final String PRODUCTDETAIL_CONTROLLER = "ProductDetailController";
    private static final String VIEWCART = "ViewCart";
    private static final String VIEWCART_CONTROLLER = "ViewCartController";
    private static final String DELETEITEMCART = "DeleteItemCart";
    private static final String DELETEITEMCART_CONTROLLER = "CartDeleteController";
    private static final String DECREASEFROMCART = "DecreaseFromCart";
    private static final String DECREASEFROMCART_CONTROLLER = "CartUpdateController";
    private static final String CHECKOUT = "CheckOut";
    private static final String CHECKOUT_CONTROLLER = "CheckoutController";
    private static final String ORDER = "Order";
    private static final String ORDER_CONTROLLER = "CheckoutByVnPayController";
    private static final String VNPAYRETURN = "VnpayReturn";
    private static final String VNPAYRETURN_CONTROLLER = "VnpayReturnController";
    private static final String BUYNOW = "BuyNow";
    private static final String BUYNOW_CONTROLLER = "CheckoutController";
    private static final String APPLYVOUCHER = "ApplyVoucher";
    private static final String APPLYVOUCHER_CONTROLLER = "CheckoutController";
    private static final String ORDERHISTORY = "OrderHistory";
    private static final String ORDERHISTORY_CONTROLLER = "OrderHistoryController";
    private static final String DELIVERED = "Delivered";
    private static final String DELIVERED_CONTROLLER = "ReceivedOrderController";
    private static final String SUBMIT_REVIEW = "SubmitReview";
    private static final String SUBMIT_REVIEW_CONTROLLER = "SubmitReviewController";
    private static final String CHAT = "Chat";
    private static final String CHAT_CONTROLLER = "ChatBoxController";

    //ADMIN    
    private static final String PRODUCTMANAGEMENT = "ProductManagement";
    private static final String PRODUCTMANAGEMENT_CONTROLLER = "ProductMangementController";
    private static final String ADDPRODUCT = "AddProduct";
    private static final String ADDPRODUCT_CONTROLLER = "AddProductController";
    private static final String CATEGORYPRODUCT = "CategoryProduct";
    private static final String CATEGORYPRODUCT_CONTROLLER = "CategoryProductController";
    private static final String PRODUCTINFO = "ProductInfo";
    private static final String PRODUCTINFO_CONTROLLER = "ProductInfoController";
    private static final String EDITPRODUCT = "EditProduct";
    private static final String EDITPRODUCT_CONTROLLER = "EditProductController";
    private static final String DELETEPRODUCT = "DeleteProduct";
    private static final String DELETEPRODUCT_CONTROLLER = "DeleteProductController";
    private static final String ORDERMANAGEMENT = "OrderManagement";
    private static final String ORDERMANAGEMENT_CONTROLLER = "OrderManageController";
    private static final String ORDERDETAILMANAGEMENT = "OrderDetailManagement";
    private static final String ORDERDETAILMANAGEMENT_CONTROLLER = "OrderDetailManagementController";
    private static final String ACCOUNT = "GetAccount";
    private static final String ACCOUNT_CONTROLLER = "AccountController";
    private static final String ADMIN = "dashboard";
    private static final String ADMIN_CONTROLLER = "AdminController";
    private static final String CONFIRM_ORDER = "ConfirmOrder";
    private static final String CONFIRM_ORDER_CONTROLLER = "ConfirmOrderController";
    private static final String CATEGORY = "Category";
    private static final String CATEGORY_CONTROLLER = "CategoryController";
    private static final String VOUCHER_MANAGER = "VoucherManager";
    private static final String VOUCHER_MANAGER_CONTROLLER = "VoucherManageController";
    private static final String ADD_VOUCHER = "AddVoucher";
    private static final String ADD_VOUCHER_CONTROLLER = "AddVoucherController";
    private static final String EDIT_VOUCHER = "EditVoucher";
    private static final String EDIT_VOUCHER_CONTROLLER = "EditVoucherController";
    private static final String DELETE_VOUCHER = "DeleteVoucher";
    private static final String DELETE_VOUCHER_CONTROLLER = "DeleteVoucherController";
    private static final String ADD_CATEGORY = "AddCategory";
    private static final String ADD_CATEGORY_CONTROLLER = "AddCategoryController";
    private static final String EDIT_CATEGORY = "EditCategory";
    private static final String EDIT_CATEGORY_CONTROLLER = "EditCategoryController";
    private static final String DELETE_CATEGORY = "DeleteCategory";
    private static final String DELETE_CATEGORY_CONTROLLER = "DeleteCategoryController";

    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (LOGIN.equals(action)) {
                url = LOGIN_CONTROLLER;
            } else if (REGISTER.equals(action)) {
                url = REGISTER_CONTROLLER;
            } else if (HOME.equals(action)) {
                url = HOME_CONTROLLER;
            } else if (CART.equals(action)) {
                url = CART_CONTROLLER;
            } else if (PRODUCT.equals(action)) {
                url = PRODUCT_CONTROLLER;
            } else if (PRODUCTDETAIL.equals(action)) {
                url = PRODUCTDETAIL_CONTROLLER;
            } else if (VIEWCART.equals(action)) {
                url = VIEWCART_CONTROLLER;
            } else if (DELETEITEMCART.equals(action)) {
                url = DELETEITEMCART_CONTROLLER;
            } else if (DECREASEFROMCART.equals(action)) {
                url = DECREASEFROMCART_CONTROLLER;
            } else if (CHECKOUT.equals(action)) {
                url = CHECKOUT_CONTROLLER;
            } else if (ORDER.equals(action)) {
                url = ORDER_CONTROLLER;
            } else if (VNPAYRETURN.equals(action)) {
                url = VNPAYRETURN_CONTROLLER;
            } else if (BUYNOW.equals(action)) {
                url = BUYNOW_CONTROLLER;
            } else if (APPLYVOUCHER.equals(action)) {
                url = APPLYVOUCHER_CONTROLLER;
            } else if (PRODUCTMANAGEMENT.equals(action)) {
                url = PRODUCTMANAGEMENT_CONTROLLER;
            } else if (ADDPRODUCT.equals(action)) {
                url = ADDPRODUCT_CONTROLLER;
            } else if (CATEGORYPRODUCT.equals(action)) {
                url = CATEGORYPRODUCT_CONTROLLER;
            } else if (PRODUCTINFO.equals(action)) {
                url = PRODUCTINFO_CONTROLLER;
            } else if (EDITPRODUCT.equals(action)) {
                url = EDITPRODUCT_CONTROLLER;
            } else if (DELETEPRODUCT.equals(action)) {
                url = DELETEPRODUCT_CONTROLLER;
            } else if (ORDERMANAGEMENT.equals(action)) {
                url = ORDERMANAGEMENT_CONTROLLER;
            } else if (ORDERDETAILMANAGEMENT.equals(action)) {
                url = ORDERDETAILMANAGEMENT_CONTROLLER;
            } else if (ACCOUNT.equals(action)) {
                url = ACCOUNT_CONTROLLER;
            } else if (ADMIN.equals(action)) {
                url = ADMIN_CONTROLLER;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_CONTROLLER;
            } else if (ORDERHISTORY.equals(action)) {
                url = ORDERHISTORY_CONTROLLER;
            } else if (CONFIRM_ORDER.equals(action)) {
                url = CONFIRM_ORDER_CONTROLLER;
            } else if (DELIVERED.equals(action)) {
                url = DELIVERED_CONTROLLER;
            } else if (SUBMIT_REVIEW.equals(action)) {
                url = SUBMIT_REVIEW_CONTROLLER;
            } else if (CHAT.equals(action)) {
                url = CHAT_CONTROLLER;
            } else if (CATEGORY.equals(action)) {
                url = CATEGORY_CONTROLLER;
            } else if (VOUCHER_MANAGER.equals(action)) {
                url = VOUCHER_MANAGER_CONTROLLER;
            } else if (ADD_VOUCHER.equals(action)) {
                url = ADD_VOUCHER_CONTROLLER;
            } else if (EDIT_VOUCHER.equals(action)) {
                url = EDIT_VOUCHER_CONTROLLER;
            } else if (DELETE_VOUCHER.equals(action)) {
                url = DELETE_VOUCHER_CONTROLLER;
            }else if (ADD_CATEGORY.equals(action)) {
                url = ADD_CATEGORY_CONTROLLER;
            }else if (EDIT_CATEGORY.equals(action)) {
                url = EDIT_CATEGORY_CONTROLLER;
            } else if (DELETE_CATEGORY.equals(action)) {
                url = DELETE_CATEGORY_CONTROLLER;
            }else {
                url = HOME_CONTROLLER;

            }

        } catch (Exception e) {
            log("Error at MainController" + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
