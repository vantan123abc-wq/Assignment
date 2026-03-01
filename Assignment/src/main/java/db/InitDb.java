package db;

import dao.DBConnection;
import java.sql.Connection;
import java.sql.Statement;

public class InitDb {
    public static void main(String[] args) {
        try (Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement()) {

            String sql = "ALTER TABLE Product ADD add_to_cart_count INT DEFAULT 0";
            stmt.executeUpdate(sql);
            System.out.println("ALTER TABLE column added successfully.");
        } catch (Exception e) {
            System.err.println("Error or column already exists: " + e.getMessage());
        }
    }
}
