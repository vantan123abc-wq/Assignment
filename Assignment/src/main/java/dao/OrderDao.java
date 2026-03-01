package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import model.CartItem;
import model.Order;
import model.Payment;

public class OrderDao {

    public boolean createOrder(Order order, List<CartItem> cartItems, Payment payment) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null)
                return false;

            conn.setAutoCommit(false); // Start transaction

            // 1. Insert into Orders
            String sqlOrder = "INSERT INTO Orders (account_id, address_id, total_amount, status) VALUES (?, ?, ?, ?)";
            int orderId = -1;
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getAccountId());
                psOrder.setInt(2, order.getAddressId());
                psOrder.setDouble(3, order.getTotalAmount());
                psOrder.setString(4, order.getStatus());

                int affectedRows = psOrder.executeUpdate();
                if (affectedRows == 0)
                    throw new Exception("Creating order failed, no rows affected.");

                try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                        order.setId(orderId);
                    } else {
                        throw new Exception("Creating order failed, no ID obtained.");
                    }
                }
            }

            // 2. Insert into OrderItems and 3. Update Product stock
            String sqlOrderItem = "INSERT INTO OrderItems (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
            String sqlUpdateStock = "UPDATE Product SET stock = stock - ? WHERE id = ?";

            try (PreparedStatement psOrderItem = conn.prepareStatement(sqlOrderItem);
                    PreparedStatement psUpdateStock = conn.prepareStatement(sqlUpdateStock)) {

                for (CartItem item : cartItems) {
                    // Insert order item
                    psOrderItem.setInt(1, orderId);
                    psOrderItem.setInt(2, item.getProduct().getId());
                    psOrderItem.setDouble(3, item.getProduct().getPrice());
                    psOrderItem.setInt(4, item.getQuantity());
                    psOrderItem.addBatch();

                    // Update stock
                    psUpdateStock.setInt(1, item.getQuantity()); // reduce by quantity
                    psUpdateStock.setInt(2, item.getProduct().getId());
                    psUpdateStock.addBatch();
                }
                psOrderItem.executeBatch();
                psUpdateStock.executeBatch();
            }

            // 4. Insert into Payment
            String sqlPayment = "INSERT INTO Payment (order_id, method, status) VALUES (?, ?, ?)";
            try (PreparedStatement psPayment = conn.prepareStatement(sqlPayment)) {
                psPayment.setInt(1, orderId);
                psPayment.setString(2, payment.getMethod());
                psPayment.setString(3, payment.getStatus());
                psPayment.executeUpdate();
            }

            // Commit transaction
            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
