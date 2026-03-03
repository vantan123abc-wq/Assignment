package controller;

import dao.CartDao;
import dao.VoucherDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Voucher;

/**
 * Servlet xử lý trang chọn và áp dụng Voucher.
 * URL: /voucher
 *
 * GET /voucher → hiển thị trang kho voucher
 * POST /voucher?action=apply → áp mã voucher vào session
 * POST /voucher?action=remove → xóa voucher khỏi session
 */
@WebServlet(name = "VoucherController", urlPatterns = { "/voucher" })
public class VoucherController extends HttpServlet {

    private final VoucherDao voucherDao = new VoucherDao();
    private final CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Tính tổng giỏ hàng hiện tại để hiển thị sidebar
        Cart cart = cartDao.getCartByAccountId(account.getId());
        List<CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());
        double cartTotal = 0;
        for (CartItem item : cartItems) {
            cartTotal += item.getProduct().getPrice() * item.getQuantity();
        }

        // Lấy danh sách voucher (từ DB hoặc mẫu)
        List<Voucher> vouchers = voucherDao.findAll();

        // Voucher đang được chọn trong session
        Voucher selectedVoucher = (Voucher) session.getAttribute("selectedVoucher");

        // Tính số tiền giảm
        double discountAmount = 0;
        boolean freeShipping = false;
        if (selectedVoucher != null) {
            discountAmount = selectedVoucher.calculateDiscount(cartTotal);
            freeShipping = selectedVoucher.isFreeShipping();
        }

        // Phí ship cố định (15.000đ) - miễn nếu voucher freeship hoặc đơn >= 500k
        double shippingFee = (freeShipping || cartTotal >= 500000) ? 0 : 15000;
        double finalTotal = cartTotal - discountAmount + shippingFee;
        if (finalTotal < 0)
            finalTotal = 0;

        request.setAttribute("vouchers", vouchers);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("finalTotal", finalTotal);
        request.setAttribute("selectedVoucher", selectedVoucher);

        request.getRequestDispatcher("voucher.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("apply".equals(action)) {
            String code = request.getParameter("voucherCode");
            Voucher voucher = voucherDao.findByCode(code);

            if (voucher == null) {
                session.setAttribute("voucherError", "Mã voucher \"" + code + "\" không hợp lệ hoặc đã hết hạn!");
                session.removeAttribute("selectedVoucher");
            } else {
                // Kiểm tra điều kiện đơn tối thiểu
                Cart cart = cartDao.getCartByAccountId(account.getId());
                List<CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());
                double cartTotal = 0;
                for (CartItem item : cartItems) {
                    cartTotal += item.getProduct().getPrice() * item.getQuantity();
                }

                if (cartTotal < voucher.getMinOrderValue()) {
                    session.setAttribute("voucherError",
                            "Đơn hàng cần đạt tối thiểu " +
                                    String.format("%,.0f", voucher.getMinOrderValue()) + "đ để dùng voucher này!");
                    session.removeAttribute("selectedVoucher");
                } else {
                    session.setAttribute("selectedVoucher", voucher);
                    session.removeAttribute("voucherError");
                }
            }
        } else if ("remove".equals(action)) {
            session.removeAttribute("selectedVoucher");
            session.removeAttribute("voucherError");
        } else if ("confirm".equals(action)) {
            // Xác nhận áp dụng voucher và về checkout
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/voucher");
    }
}
