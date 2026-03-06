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

    public List<Order> getOrdersByAccountId(int accountId) {
        List<Order> orders = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE account_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order(
                            rs.getInt("id"),
                            rs.getInt("account_id"),
                            rs.getInt("address_id"),
                            rs.getDouble("total_amount"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"));
                    o.setReturnReason(rs.getString("return_reason"));
                    orders.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order(
                        rs.getInt("id"),
                        rs.getInt("account_id"),
                        rs.getInt("address_id"),
                        rs.getDouble("total_amount"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"));
                o.setReturnReason(rs.getString("return_reason"));
                orders.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = new Order(
                            rs.getInt("id"),
                            rs.getInt("account_id"),
                            rs.getInt("address_id"),
                            rs.getDouble("total_amount"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"));
                    o.setReturnReason(rs.getString("return_reason"));
                    return o;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<model.OrderItem> getOrderItems(int orderId) {
        List<model.OrderItem> items = new java.util.ArrayList<>();
        String sql = "SELECT * FROM OrderItems WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new model.OrderItem(
                            rs.getInt("id"),
                            rs.getInt("order_id"),
                            rs.getInt("product_id"),
                            rs.getDouble("price"),
                            rs.getInt("quantity")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateOrderStatusWithReason(int orderId, String newStatus, String reason) {
        String sql = "UPDATE Orders SET status = ?, return_reason = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, reason);
            ps.setInt(3, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
