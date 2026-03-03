package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.UserStats;

public class UserStatsDao {

    public UserStats getStats(int accountId) {
        String sql = "SELECT " +
                "  (SELECT COUNT(*) FROM Orders WHERE account_id = ?) AS total_orders, " +
                "  (SELECT ISNULL(SUM(total_amount), 0) FROM Orders WHERE account_id = ?) AS total_spend, " +
                "  (SELECT COUNT(*) FROM Review WHERE account_id = ?) AS total_reviews";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setInt(2, accountId);
            ps.setInt(3, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserStats(
                            rs.getLong("total_orders"),
                            rs.getDouble("total_spend"),
                            rs.getLong("total_reviews"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new UserStats(0, 0, 0);
    }
}
