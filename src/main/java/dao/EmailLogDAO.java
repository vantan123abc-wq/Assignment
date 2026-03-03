package dao;

import model.EmailLog;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailLogDAO {

    public boolean insert(EmailLog log) {
        String sql = "INSERT INTO EmailLogs (subject, content, productId) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, log.getSubject());
            ps.setString(2, log.getContent());
            if (log.getProductId() != null) {
                ps.setInt(3, log.getProductId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(EmailLogDAO.class.getName()).log(Level.SEVERE, "insert email log error", e);
        }
        return false;
    }
}
