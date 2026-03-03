package dao;

import model.RevenueData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    /**
     * Lấy doanh thu theo chế độ:
     * - daily: 7 ngày gần nhất
     * - monthly: 12 tháng gần nhất
     * - yearly: theo năm
     *
     * Chỉ tính đơn có status = 'DELIVERED'.
     * Khuyến nghị DB có cột Orders.delivered_at để thống kê theo ngày giao.
     */
    public List<RevenueData> getRevenue(String mode) {
        if (mode == null) mode = "daily";

        switch (mode) {
            case "monthly":
                return getRevenueLast12Months();
            case "yearly":
                return getRevenueByYear();
            case "daily":
            default:
                return getRevenueLast7Days();
        }
    }

    // 7 ngày gần nhất (theo ngày giao)
    private List<RevenueData> getRevenueLast7Days() {
        List<RevenueData> list = new ArrayList<>();

        String query = "SELECT " +
                "  CONVERT(date, delivered_at) AS label, " +
                "  SUM(total_amount) AS total " +
                "FROM Orders " +
                "WHERE status = 'DELIVERED' AND delivered_at IS NOT NULL " +
                "  AND delivered_at >= DATEADD(day, -6, CONVERT(date, SYSDATETIME())) " +
                "GROUP BY CONVERT(date, delivered_at) " +
                "ORDER BY label ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String label = rs.getString("label");
                double total = rs.getDouble("total");
                list.add(new RevenueData(label, total));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 12 tháng gần nhất (yyyy-MM)
    private List<RevenueData> getRevenueLast12Months() {
        List<RevenueData> list = new ArrayList<>();

        String query = "SELECT " +
                "  CONVERT(char(7), delivered_at, 120) AS label, " +
                "  SUM(total_amount) AS total " +
                "FROM Orders " +
                "WHERE status = 'DELIVERED' AND delivered_at IS NOT NULL " +
                "  AND delivered_at >= DATEADD(month, -11, DATEFROMPARTS(YEAR(SYSDATETIME()), MONTH(SYSDATETIME()), 1)) " +
                "GROUP BY CONVERT(char(7), delivered_at, 120) " +
                "ORDER BY label ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String label = rs.getString("label");
                double total = rs.getDouble("total");
                list.add(new RevenueData(label, total));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Theo năm
    private List<RevenueData> getRevenueByYear() {
        List<RevenueData> list = new ArrayList<>();

        String query = "SELECT " +
                "  CAST(YEAR(delivered_at) AS varchar(4)) AS label, " +
                "  SUM(total_amount) AS total " +
                "FROM Orders " +
                "WHERE status = 'DELIVERED' AND delivered_at IS NOT NULL " +
                "GROUP BY YEAR(delivered_at) " +
                "ORDER BY YEAR(delivered_at) ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String label = rs.getString("label");
                double total = rs.getDouble("total");
                list.add(new RevenueData(label, total));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
