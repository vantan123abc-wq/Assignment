package dao;

import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDao {

        // Using mock data since we don't have the actual DB schema for products yet.
        // This will provide the AI with some context of the store's inventory.
        public List<Product> getAllProducts() {
                List<Product> products = new ArrayList<>();
                String query = "SELECT id, name, price, stock as quantity, description, image_url FROM Product";

                try (java.sql.Connection conn = DBConnection.getConnection();
                                java.sql.PreparedStatement ps = conn.prepareStatement(query);
                                java.sql.ResultSet rs = ps.executeQuery()) {

                        while (rs.next()) {
                                Product product = new Product(
                                                rs.getInt("id"),
                                                rs.getString("name"),
                                                rs.getDouble("price"),
                                                rs.getInt("quantity"),
                                                rs.getString("image_url") != null ? rs.getString("image_url")
                                                                : rs.getString("description"));
                                products.add(product);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return products;
        }

        public String getShopDataAsText() {
                List<Product> products = getAllProducts();
                StringBuilder sb = new StringBuilder();
                sb.append("Danh sách sản phẩm hiện có của cửa hàng:\n");
                for (Product p : products) {
                        sb.append("- Tên sản phẩm: ").append(p.getName())
                                        .append(" | Giá: $").append(p.getPrice())
                                        .append(" | Tồn kho: ").append(p.getQuantity())
                                        .append("\n  Mô tả: ").append(p.getDescription()).append("\n\n");
                }
                return sb.toString();
        }
}
