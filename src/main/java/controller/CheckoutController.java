package controller;

import dao.AddressDao;
import dao.CartDao;
import dao.OrderDao;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Address;
import model.CartItem;
import model.Order;
import model.Payment;
import model.Voucher;

@WebServlet(name = "CheckoutController", urlPatterns = { "/checkout" })
public class CheckoutController extends HttpServlet {

    /** Các phương thức cần QR (không thanh toán tiền mặt) */
    private static boolean isQrPayment(String method) {
        return "BANK_TRANSFER".equals(method)
                || "MOMO".equals(method)
                || "ZALOPAY".equals(method);
    }

    // ================================================================
    // GET
    // ================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        // Trang hoàn tất đơn hàng
        if ("success".equals(action)) {
            request.setAttribute("orderId", request.getParameter("orderId"));
            request.getRequestDispatcher("order-success.jsp").forward(request, response);
            return;
        }

        // Trang QR thanh toán
        if ("qr".equals(action)) {
            request.setAttribute("orderId", request.getParameter("orderId"));
            request.setAttribute("totalAmount", Double.parseDouble(request.getParameter("amount")));
            request.setAttribute("payMethod", request.getParameter("method"));
            request.getRequestDispatcher("payment-qr.jsp").forward(request, response);
            return;
        }

        // Trang checkout thông thường
        CartDao cartDao = new CartDao();
        model.Cart cart = cartDao.getCartByAccountId(account.getId());
        List<CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());

        if (cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        double subTotal = 0;
        for (CartItem item : cartItems)
            subTotal += item.getProduct().getPrice() * item.getQuantity();

        Voucher selectedVoucher = (Voucher) session.getAttribute("selectedVoucher");
        double discountAmount = 0;
        boolean freeShipping = false;
        if (selectedVoucher != null) {
            discountAmount = selectedVoucher.calculateDiscount(subTotal);
            freeShipping = selectedVoucher.isFreeShipping();
        }
        double shippingFee = (freeShipping || subTotal >= 500000) ? 0 : 15000;
        double total = Math.max(0, subTotal - discountAmount + shippingFee);

        AddressDao addressDao = new AddressDao();
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subTotal", subTotal);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("totalAmount", total);
        request.setAttribute("selectedVoucher", selectedVoucher);
        request.setAttribute("addresses", addressDao.getAddressesByAccountId(account.getId()));

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    // ================================================================
    // POST
    // ================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        // ── 1. Đặt hàng (placeOrder) ──────────────────────────────────────
        if ("placeOrder".equals(action)) {
            // Địa chỉ
            String addressChoice = request.getParameter("addressId");
            int addressId = -1;
            AddressDao addressDao = new AddressDao();
            if ("new".equals(addressChoice)) {
                String receiver = request.getParameter("receiver");
                String phone = request.getParameter("phone");
                String addressLine = request.getParameter("address_line");
                Address newAddr = new Address(0, account.getId(), receiver, phone, addressLine);
                addressId = addressDao.addAddress(newAddr);
            } else {
                try {
                    addressId = Integer.parseInt(addressChoice);
                } catch (NumberFormatException ignored) {
                }
            }

            if (addressId <= 0) {
                request.setAttribute("error", "Vui lòng cung cấp địa chỉ giao hàng!");
                doGet(request, response);
                return;
            }

            // Giỏ hàng
            CartDao cartDao = new CartDao();
            model.Cart cart = cartDao.getCartByAccountId(account.getId());
            List<CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());
            if (cartItems.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            // Tính tiền
            double subTotal = 0;
            for (CartItem item : cartItems)
                subTotal += item.getProduct().getPrice() * item.getQuantity();

            Voucher selectedVoucher = (Voucher) session.getAttribute("selectedVoucher");
            double discountAmount = 0;
            boolean freeShipping = false;
            if (selectedVoucher != null) {
                discountAmount = selectedVoucher.calculateDiscount(subTotal);
                freeShipping = selectedVoucher.isFreeShipping();
            }
            double shippingFee = (freeShipping || subTotal >= 500000) ? 0 : 15000;
            double total = Math.max(0, subTotal - discountAmount + shippingFee);

            // Phương thức thanh toán
            String paymentMethod = request.getParameter("payment_method");
            if (paymentMethod == null || paymentMethod.isEmpty())
                paymentMethod = "COD";

            // QR → PENDING_PAYMENT (chờ xác nhận), COD → PENDING
            String orderStatus = isQrPayment(paymentMethod) ? "PENDING_PAYMENT" : "PENDING";

            Order order = new Order(0, account.getId(), addressId, total,
                    orderStatus, new Timestamp(System.currentTimeMillis()));
            Payment payment = new Payment(0, 0, paymentMethod, "PENDING");

            OrderDao orderDao = new OrderDao();
            boolean success = orderDao.createOrder(order, cartItems, payment);

            if (!success) {
                request.setAttribute("error", "Đặt hàng thất bại! Vui lòng thử lại.");
                doGet(request, response);
                return;
            }

            session.removeAttribute("selectedVoucher");

            if (isQrPayment(paymentMethod)) {
                // Giữ giỏ hàng đến khi user xác nhận chuyển khoản
                String redirectUrl = request.getContextPath()
                        + "/checkout?action=qr"
                        + "&orderId=" + order.getId()
                        + "&amount=" + (long) total
                        + "&method=" + paymentMethod;
                response.sendRedirect(redirectUrl);
            } else {
                // COD: xong luôn
                cartDao.clearCart(account.getId());
                response.sendRedirect(request.getContextPath()
                        + "/checkout?action=success&orderId=" + order.getId());
            }
            return;
        }

        // ── 2. User xác nhận đã chuyển khoản ─────────────────────────────
        if ("confirmPayment".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            try {
                int orderId = Integer.parseInt(orderIdStr);
                new OrderDao().updateOrderStatus(orderId, "PENDING");
                new CartDao().clearCart(account.getId());
            } catch (Exception ignored) {
            }
            response.sendRedirect(request.getContextPath()
                    + "/checkout?action=success&orderId=" + orderIdStr);
            return;
        }

        // ── 3. Huỷ đơn ───────────────────────────────────────────────────
        if ("cancelOrder".equals(action)) {
            String orderIdStr = request.getParameter("orderId");
            try {
                new OrderDao().updateOrderStatus(Integer.parseInt(orderIdStr), "CANCELLED");
            } catch (Exception ignored) {
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
