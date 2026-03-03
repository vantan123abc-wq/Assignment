package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Review;

public class ReviewDao {

    public List<Review> findReviewsByAccount(int accountId, int page, int size) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.id, r.account_id, r.product_id, r.rating, r.comment, r.created_at, p.name AS product_name "
                +
                "FROM Review r JOIN Product p ON r.product_id = p.id " +
                "WHERE r.account_id = ? ORDER BY r.created_at DESC " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (page - 1) * size;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setInt(2, offset);
            ps.setInt(3, size);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(new Review(
                            rs.getInt("id"),
                            rs.getInt("account_id"),
                            rs.getInt("product_id"),
                            rs.getInt("rating"),
                            rs.getString("comment"),
                            rs.getTimestamp("created_at"),
                            rs.getString("product_name")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public int countReviewsByAccount(int accountId) {
        String sql = "SELECT COUNT(*) FROM Review WHERE account_id = ?";
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
}
