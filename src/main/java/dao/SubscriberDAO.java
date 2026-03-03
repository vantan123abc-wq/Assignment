package dao;

import model.Subscriber;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SubscriberDAO {

    public boolean insert(String email) {
        String sql = "INSERT INTO Subscribers (email, isActive) VALUES (?, 1)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(SubscriberDAO.class.getName()).log(Level.SEVERE, "insert subscriber error", e);
        }
        return false;
    }

    public List<String> getAllActiveEmails() {
        List<String> emails = new ArrayList<>();
        String sql = "SELECT email FROM Subscribers WHERE isActive = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                emails.add(rs.getString("email"));
            }
        } catch (Exception e) {
            Logger.getLogger(SubscriberDAO.class.getName()).log(Level.SEVERE, "getAllActiveEmails error", e);
        }
        return emails;
    }

    public boolean exists(String email) {
        String sql = "SELECT COUNT(*) FROM Subscribers WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            Logger.getLogger(SubscriberDAO.class.getName()).log(Level.SEVERE, "exists subscriber error", e);
        }
        return false;
    }
}
