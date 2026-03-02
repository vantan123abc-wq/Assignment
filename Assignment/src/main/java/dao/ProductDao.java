package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDao {

        // Using mock data since we don't have the actual DB schema for products yet.
        // This will provide the AI with some context of the store's inventory.
        public List<Product> getAllProducts() {
                List<Product> products = new ArrayList<>();
                String query = "SELECT id, category_id, name, price, stock as quantity, description, image_url, discount_percent FROM Product";

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
                                product.setCategoryId(rs.getInt("category_id"));
                                product.setDiscountPercent((Integer) rs.getObject("discount_percent"));
                                products.add(product);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return products;
        }

        public List<Product> findAvailable() {
                List<Product> products = new ArrayList<>();
                String query = "SELECT id, category_id, name, price, stock as quantity, description, image_url, discount_percent FROM Product WHERE stock > 0 ORDER BY id";
                try (java.sql.Connection conn = DBConnection.getConnection();
                                java.sql.PreparedStatement ps = conn.prepareStatement(query);
                                java.sql.ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                                Product product = new Product(
                                                rs.getInt("id"), rs.getString("name"), rs.getDouble("price"),
                                                rs.getInt("quantity"),
                                                rs.getString("image_url") != null ? rs.getString("image_url")
                                                                : rs.getString("description"));
                                product.setCategoryId(rs.getInt("category_id"));
                                product.setDiscountPercent((Integer) rs.getObject("discount_percent"));
                                products.add(product);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return products;
        }

        public List<Product> findAvailableByCategory(int categoryId) {
                List<Product> products = new ArrayList<>();
                String query = "SELECT id, category_id, name, price, stock as quantity, description, image_url, discount_percent FROM Product WHERE category_id = ? AND stock > 0 ORDER BY id";
                try (java.sql.Connection conn = DBConnection.getConnection();
                                java.sql.PreparedStatement ps = conn.prepareStatement(query)) {
                        ps.setInt(1, categoryId);
                        try (java.sql.ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                        Product product = new Product(
                                                        rs.getInt("id"), rs.getString("name"), rs.getDouble("price"),
                                                        rs.getInt("quantity"),
                                                        rs.getString("image_url") != null ? rs.getString("image_url")
                                                                        : rs.getString("description"));
                                        product.setCategoryId(rs.getInt("category_id"));
                                        product.setDiscountPercent((Integer) rs.getObject("discount_percent"));
                                        products.add(product);
                                }
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return products;
        }

        public List<Product> findFeaturedProducts(int limit) {
                List<Product> products = new ArrayList<>();
                // Fetch products with the most total quantity ordered/carted.
                // Assuming CartItem and OrderItems both represent a form of popularity.
                String query = "SELECT p.id, p.category_id, p.name, p.price, p.stock as quantity, p.description, p.image_url, p.discount_percent, "
                                +
                                "COALESCE((SELECT SUM(quantity) FROM CartItem WHERE product_id = p.id), 0) + " +
                                "COALESCE((SELECT SUM(quantity) FROM OrderItems WHERE product_id = p.id), 0) as popularity "
                                +
                                "FROM Product p " +
                                "WHERE p.stock > 0 " +
                                "ORDER BY popularity DESC, p.id " +
                                "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
                try (java.sql.Connection conn = DBConnection.getConnection();
                                java.sql.PreparedStatement ps = conn.prepareStatement(query)) {
                        ps.setInt(1, limit);
                        try (java.sql.ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                        Product product = new Product(
                                                        rs.getInt("id"), rs.getString("name"), rs.getDouble("price"),
                                                        rs.getInt("quantity"),
                                                        rs.getString("image_url") != null ? rs.getString("image_url")
                                                                        : rs.getString("description"));
                                        product.setCategoryId(rs.getInt("category_id"));
                                        product.setDiscountPercent((Integer) rs.getObject("discount_percent"));
                                        products.add(product);
                                }
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return products;
        }

        public List<model.FeaturedProduct> getTopBestSellers(int limit) {
                List<model.FeaturedProduct> products = new ArrayList<>();
                String query = "SELECT p.id, p.category_id, p.name, p.price, p.stock as quantity, p.description, p.image_url, p.discount_percent, "
                                + "ISNULL((SELECT SUM(oi.quantity) FROM OrderItems oi JOIN Payment pm ON oi.order_id = pm.order_id WHERE oi.product_id = p.id AND pm.status IN ('PAID', 'PENDING')), 0) as soldQty, "
                                + "ISNULL((SELECT SUM(ci.quantity) FROM CartItem ci WHERE ci.product_id = p.id), 0) as cartQty "
                                + "FROM Product p "
                                + "ORDER BY soldQty DESC, cartQty DESC, p.id DESC "
                                + "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";

                try (java.sql.Connection conn = DBConnection.getConnection();
                                java.sql.PreparedStatement ps = conn.prepareStatement(query)) {
                        ps.setInt(1, limit);
                        try (java.sql.ResultSet rs = ps.executeQuery()) {
                                while (rs.next()) {
                                        model.FeaturedProduct product = new model.FeaturedProduct(
                                                        rs.getInt("id"),
                                                        rs.getString("name"),
                                                        rs.getDouble("price"),
                                                        rs.getInt("quantity"),
                                                        rs.getString("image_url") != null ? rs.getString("image_url")
                                                                        : rs.getString("description"),
                                                        rs.getInt("soldQty"));
                                        product.setCategoryId(rs.getInt("category_id"));
                                        product.setDiscountPercent((Integer) rs.getObject("discount_percent"));
                                        products.add(product);
                                }
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
                return products;
        }

        public List<Product> getPromotionProducts() {
                List<Product> products = new ArrayList<>();
                String query = "SELECT id, category_id, name, price, stock as quantity, description, image_url, discount_percent "
                                +
                                "FROM Product " +
                                "WHERE discount_percent IS NOT NULL AND discount_percent > 0 " +
                                "ORDER BY discount_percent DESC";

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
                                product.setCategoryId(rs.getInt("category_id"));
                                product.setDiscountPercent((Integer) rs.getObject("discount_percent"));
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

        public List<Product> searchProducts(String keyword, int limit) {
                List<Product> products = new ArrayList<>();
                String query = "SELECT top " + limit
                                + " * FROM Product WHERE name LIKE ? AND stock > 0 ORDER BY id DESC";

                try {
                        Connection conn = DBConnection.getConnection();
                        PreparedStatement ps = conn.prepareStatement(query);
                        ps.setString(1, "%" + keyword + "%");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                                Product p = new Product();
                                p.setId(rs.getInt("id"));
                                p.setCategoryId(rs.getInt("category_id"));
                                p.setName(rs.getString("name"));
                                p.setPrice(rs.getDouble("price"));
                                p.setQuantity(rs.getInt("stock"));
                                p.setDescription(rs.getString("description"));
                                p.setDiscountPercent((Integer) rs.getObject("discount_percent"));

                                products.add(p);
                        }
                } catch (SQLException e) {
                        e.printStackTrace();
                }
                return products;
        }
}
