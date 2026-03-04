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
    // 1. Lấy danh sách đơn hàng cho Admin (Có JOIN để lấy thêm Email và SĐT)
    public List<Order> getAllOrdersForAdmin() {
        List<Order> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) return list;

            // LƯU Ý: Chỗ này mình đang JOIN bảng Orders với Account và Address. 
            // Nếu tên bảng hoặc tên cột trong Database của bạn khác, hãy điều chỉnh lại câu SQL này.
            String sql = "SELECT o.id, o.total_amount, o.status, o.created_at, " +
                         "a.email AS customer_email, ad.phone AS customer_phone " +
                         "FROM Orders o " +
                         "LEFT JOIN Account a ON o.account_id = a.id " +
                         "LEFT JOIN Address ad ON o.address_id = ad.id " +
                         "ORDER BY o.id DESC";

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id")); // Trong model của bạn là id thay vì orderId
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setCustomerEmail(rs.getString("customer_email"));
                    order.setCustomerPhone(rs.getString("customer_phone"));
                    order.setOrderDate(rs.getTimestamp("created_at"));
                    
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
        return list;
    }

    // 2. Cập nhật trạng thái đơn hàng từ Admin Panel
    public boolean updateOrderStatusAdmin(int orderId, String newStatus) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) return false;

            String sql = "UPDATE Orders SET status = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, newStatus);
                ps.setInt(2, orderId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
    // 1. Lấy thông tin chi tiết của 1 Đơn hàng (Thông tin khách, địa chỉ, thanh toán)
public Order getOrderDetail(int orderId) {
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT o.*, a.email, ad.phone, ad.address_line, p.method AS payment_method, p.status AS payment_status " +
                     "FROM Orders o " +
                     "JOIN Account a ON o.account_id = a.id " +
                     "JOIN Address ad ON o.address_id = ad.id " +
                     "JOIN Payment p ON o.id = p.order_id " +
                     "WHERE o.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setOrderDate(rs.getTimestamp("created_at"));
                    order.setCustomerEmail(rs.getString("email"));
                    order.setCustomerPhone(rs.getString("phone"));
                    // Tạm thời bạn có thể set thêm các trường này vào Order model hoặc dùng Map/DTO
                    // Ví dụ: order.setPaymentMethod(rs.getString("payment_method"));
                    return order;
                }
            }
        }
    } catch (Exception e) { e.printStackTrace(); }
    finally { try { if(conn != null) conn.close(); } catch(Exception e){} }
    return null;
}

// 2. Lấy danh sách sản phẩm của đơn hàng đó
public List<CartItem> getItemsByOrderId(int orderId) {
    List<CartItem> list = new ArrayList<>();
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT oi.*, p.name, p.image_url FROM OrderItems oi " +
                     "JOIN Product p ON oi.product_id = p.id WHERE oi.order_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tái sử dụng model CartItem hoặc tạo OrderItem model
                    model.Product p = new model.Product();
                    p.setName(rs.getString("name"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setPrice(rs.getDouble("price"));

                    CartItem item = new CartItem();
                    item.setProduct(p);
                    item.setQuantity(rs.getInt("quantity"));
                    list.add(item);
                }
            }
        }
    } catch (Exception e) { e.printStackTrace(); }
    finally { try { if(conn != null) conn.close(); } catch(Exception e){} }
    return list;
}
// Lấy danh sách đơn hàng của một khách hàng cụ thể (Phía User)
public List<Order> getOrdersByAccountId(int accountId) {
    List<Order> list = new ArrayList<>();
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        if (conn == null) return list;

        String sql = "SELECT * FROM Orders WHERE account_id = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status")); // Trạng thái DB: Pending, Shipping, Completed, Cancelled
                    order.setOrderDate(rs.getTimestamp("created_at"));
                    list.add(order);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if(conn != null) conn.close(); } catch(Exception e){}
    }
    return list;
}
}
