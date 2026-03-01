package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Product;

public class CartDao {

    // Get Cart by accountId. If not exists, create a new one.
    public Cart getCartByAccountId(int accountId) {
        String query = "SELECT id, account_id FROM Cart WHERE account_id = ?";
        Cart cart = null;

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cart = new Cart(rs.getInt("id"), rs.getInt("account_id"));
                }
            }

            // If user doesn't have a cart, create one
            if (cart == null) {
                cart = createCartForAccount(accountId, con);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    private Cart createCartForAccount(int accountId, Connection con) throws SQLException {
        String query = "INSERT INTO Cart (account_id) VALUES (?)";
        try (PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, accountId);
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return new Cart(generatedKeys.getInt(1), accountId);
                    }
                }
            }
        }
        return null;
    }

    // Get all items in a cart, including product details
    public List<CartItem> getItemsByCartId(int cartId) {
        List<CartItem> items = new ArrayList<>();
        String query = "SELECT ci.id, ci.cart_id, ci.product_id, ci.quantity, " +
                "p.name, p.price, p.image_url " +
                "FROM CartItem ci " +
                "JOIN Product p ON ci.product_id = p.id " +
                "WHERE ci.cart_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem(
                            rs.getInt("id"),
                            rs.getInt("cart_id"),
                            rs.getInt("product_id"),
                            rs.getInt("quantity"));

                    // Populate product info for UI displaying
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    // Mapping image_url to description temporarily for UI if Product.java doesn't
                    // have image_url
                    // Or ideally we should add imageUrl to Product.java
                    item.setProduct(product);

                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    // Add item to cart
    public void addItemToCart(int cartId, int productId, int quantity) {
        // Check if item already exists
        String checkQuery = "SELECT id, quantity FROM CartItem WHERE cart_id = ? AND product_id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement checkPs = con.prepareStatement(checkQuery)) {

            checkPs.setInt(1, cartId);
            checkPs.setInt(2, productId);

            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    // Item exists, update quantity
                    int existingId = rs.getInt("id");
                    int newQuantity = rs.getInt("quantity") + quantity;
                    updateItemQuantity(existingId, newQuantity);
                } else {
                    // Item doesn't exist, insert new
                    String insertQuery = "INSERT INTO CartItem (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                    try (PreparedStatement insertPs = con.prepareStatement(insertQuery)) {
                        insertPs.setInt(1, cartId);
                        insertPs.setInt(2, productId);
                        insertPs.setInt(3, quantity);
                        insertPs.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateItemQuantity(int cartItemId, int newQuantity) {
        if (newQuantity <= 0) {
            removeItem(cartItemId);
            return;
        }
        String query = "UPDATE CartItem SET quantity = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartItemId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeItem(int cartItemId) {
        String query = "DELETE FROM CartItem WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, cartItemId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get total items count for cart badge
    public int getTotalItemsCount(int cartId) {
        String query = "SELECT SUM(quantity) FROM CartItem WHERE cart_id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Clear all items from a user's cart after successful checkout
    public void clearCart(int accountId) {
        String query = "DELETE FROM CartItem WHERE cart_id = (SELECT id FROM Cart WHERE account_id = ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
