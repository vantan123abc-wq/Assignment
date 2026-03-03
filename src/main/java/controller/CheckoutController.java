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

@WebServlet(name = "CheckoutController", urlPatterns = { "/checkout" })
public class CheckoutController extends HttpServlet {

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
if ("success".equals(action)) {
    String orderId = request.getParameter("orderId");
    request.setAttribute("orderId", orderId);

    request.getRequestDispatcher("order-success.jsp").forward(request, response);
    return;
}

        CartDao cartDao = new CartDao();
        model.Cart cart = cartDao.getCartByAccountId(account.getId());
        List<CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());

        if (cartItems.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        double total = 0;
        for (CartItem item : cartItems) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }

        AddressDao addressDao = new AddressDao();
        List<Address> addresses = addressDao.getAddressesByAccountId(account.getId());

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", total);
        request.setAttribute("addresses", addresses);

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

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
        if ("placeOrder".equals(action)) {
            String addressChoice = request.getParameter("addressId");
            int addressId = -1;

            AddressDao addressDao = new AddressDao();
            if ("new".equals(addressChoice)) {
                String receiver = request.getParameter("receiver");
                String phone = request.getParameter("phone");
                String addressLine = request.getParameter("address_line");

                Address newAddress = new Address(0, account.getId(), receiver, phone, addressLine);
                addressId = addressDao.addAddress(newAddress);
            } else {
                try {
                    addressId = Integer.parseInt(addressChoice);
                } catch (NumberFormatException e) {
                    // fallback
                }
            }

            if (addressId <= 0) {
                request.setAttribute("error", "Vui lòng cung cấp địa chỉ để giao hàng!");
                doGet(request, response);
                return;
            }

            CartDao cartDao = new CartDao();
            model.Cart cart = cartDao.getCartByAccountId(account.getId());
            List<CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());
            if (cartItems.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            double total = 0;
            for (CartItem item : cartItems) {
                total += item.getProduct().getPrice() * item.getQuantity();
            }

            String paymentMethod = request.getParameter("payment_method");
            if (paymentMethod == null)
                paymentMethod = "COD";

            Order order = new Order(0, account.getId(), addressId, total, "PENDING",
                    new Timestamp(System.currentTimeMillis()));
            Payment payment = new Payment(0, 0, paymentMethod, "PENDING");

            OrderDao orderDao = new OrderDao();
            boolean success = orderDao.createOrder(order, cartItems, payment);

            if (success) {
    cartDao.clearCart(account.getId());

    // ĐỔI redirect về servlet (không redirect .jsp nữa)
    response.sendRedirect(request.getContextPath() + "/checkout?action=success&orderId=" + order.getId());
    return;
} else {
    request.setAttribute("error", "Đặt hàng thất bại! Vui lòng thử lại.");
    doGet(request, response);
    return;
}
        }
    }
}
