package controller;

import dao.CartDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;

@WebServlet(name = "CartController", urlPatterns = { "/cart" })
public class CartController extends HttpServlet {

    private CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view"; // Default action
        }

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        Cart cart = cartDao.getCartByAccountId(account.getId());

        switch (action) {
            case "add":
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = 1; // Default adding one
                cartDao.addItemToCart(cart.getId(), productId, quantity);
                updateCartCount(request, cart.getId());
                response.sendRedirect(request.getHeader("Referer")); // Stay on current page
                break;

            case "update":
                int cartItemId = Integer.parseInt(request.getParameter("itemId"));
                int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                cartDao.updateItemQuantity(cartItemId, newQuantity);
                updateCartCount(request, cart.getId());
                response.sendRedirect("cart.jsp");
                break;

            case "remove":
                int removeId = Integer.parseInt(request.getParameter("itemId"));
                cartDao.removeItem(removeId);
                updateCartCount(request, cart.getId());
                response.sendRedirect("cart.jsp");
                break;

            case "view":
            default:
                updateCartCount(request, cart.getId());
                java.util.List<model.CartItem> cartItems = cartDao.getItemsByCartId(cart.getId());
                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                break;
        }
    }

    private void updateCartCount(HttpServletRequest request, int cartId) {
        int totalItems = cartDao.getTotalItemsCount(cartId);
        request.getSession().setAttribute("cartCount", totalItems);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
