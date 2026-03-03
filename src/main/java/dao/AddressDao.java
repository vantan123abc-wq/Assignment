package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Address;

public class AddressDao {

    public List<Address> getAddressesByAccountId(int accountId) {
        List<Address> addresses = new ArrayList<>();
        String query = "SELECT id, account_id, receiver, phone, address_line FROM Address WHERE account_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    addresses.add(new Address(
                            rs.getInt("id"),
                            rs.getInt("account_id"),
                            rs.getString("receiver"),
                            rs.getString("phone"),
                            rs.getString("address_line")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addresses;
    }

    public int addAddress(Address address) {
        String query = "INSERT INTO Address (account_id, receiver, phone, address_line) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, address.getAccountId());
            ps.setString(2, address.getReceiver());
            ps.setString(3, address.getPhone());
            ps.setString(4, address.getAddressLine());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
