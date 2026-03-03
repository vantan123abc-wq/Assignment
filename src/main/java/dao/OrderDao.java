package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
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
            String sqlUpdateStock = "UPDATE Product SET stock = stock - ? WHERE id = ? AND stock >= ?";

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
                    psUpdateStock.setInt(3, item.getQuantity()); // stock >= quantity (THÊM DÒNG NÀY)
                    psUpdateStock.addBatch();
                }
                psOrderItem.executeBatch();

                int[] stockResults = psUpdateStock.executeBatch();
                for (int r : stockResults) {
                    if (r == 0) {
                        throw new Exception("Không đủ tồn kho cho một sản phẩm trong giỏ.");
                    }
                }
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

    public List<Order> findOrdersByAccount(int accountId, int page, int size) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, account_id, address_id, total_amount, status, created_at FROM Orders " +
                "WHERE account_id = ? ORDER BY created_at DESC " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (page - 1) * size;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setInt(2, offset);
            ps.setInt(3, size);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getInt("id"));
                    o.setAccountId(rs.getInt("account_id"));
                    o.setAddressId(rs.getInt("address_id"));
                    o.setTotalAmount(rs.getDouble("total_amount"));
                    o.setStatus(rs.getString("status"));
                    o.setCreatedAt(rs.getTimestamp("created_at"));
                    orders.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int countOrdersByAccount(int accountId) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE account_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean markPaid(int orderId, String method) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null)
                return false;

            conn.setAutoCommit(false); // Start transaction

            // 1. Update Payment status
            String updatePayment = "UPDATE Payment SET status = 'PAID', method = ? WHERE order_id = ?";
            try (PreparedStatement psPayment = conn.prepareStatement(updatePayment)) {
                psPayment.setString(1, method);
                psPayment.setInt(2, orderId);
                int rowsPayment = psPayment.executeUpdate();
                if (rowsPayment == 0)
                    throw new Exception("Updating payment failed, no rows affected.");
            }

            // 2. Update Orders status
            String updateOrder = "UPDATE Orders SET status = 'CONFIRMED' WHERE id = ?";
            try (PreparedStatement psOrder = conn.prepareStatement(updateOrder)) {
                psOrder.setInt(1, orderId);
                int rowsOrder = psOrder.executeUpdate();
                if (rowsOrder == 0)
                    throw new Exception("Updating order failed, no rows affected.");
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
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

    /**
     * Dùng cho admin cập nhật trạng thái đơn.
     * Nếu status = 'DELIVERED' thì set delivered_at = SYSDATETIME().
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status = ?, delivered_at = " +
                "CASE WHEN ? = 'DELIVERED' THEN SYSDATETIME() ELSE delivered_at END " +
                "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, status);
            ps.setInt(3, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
