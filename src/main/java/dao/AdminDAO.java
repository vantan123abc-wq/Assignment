package dao;

import model.RevenueData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    
    
    // Hàm lấy doanh thu 7 ngày gần nhất
    public List<RevenueData> getRevenueLast7Days() {
        List<RevenueData> list = new ArrayList<>();
        // Query gom nhóm theo ngày, tính tổng doanh thu
        String query = "SELECT DATE(order_date) as orderDate, SUM(total_price) as total " +
                       "FROM Orders " +
                       "WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
                       "GROUP BY DATE(order_date) " +
                       "ORDER BY DATE(order_date) ASC";
        try {
            Connection conn = DBConnection.getConnection(); // Tùy class kết nối của bạn
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String date = rs.getString("orderDate");
                double total = rs.getDouble("total");
                list.add(new RevenueData(date, total));
            }
        } catch (SQLException e) {
             e.printStackTrace();
        }
        return list;
    }
}