package dao;

import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDao {

    // Using mock data since we don't have the actual DB schema for products yet.
    // This will provide the AI with some context of the store's inventory.
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        products.add(new Product(1, "MacBook Pro 16 inch M3 Max", 3499.00, 10,
                "Laptop cao cấp của Apple, phù hợp làm đồ hoạ và lập trình."));
        products.add(new Product(2, "iPhone 15 Pro Max 256GB", 1199.00, 50,
                "Điện thoại flagship mới nhất của Apple với khung Titanium."));
        products.add(new Product(3, "Chuột Logitech MX Master 3S", 99.00, 100,
                "Chuột không dây công thái học, chống ồn tốt nhất cho công việc."));
        products.add(new Product(4, "Bàn phím cơ Keychron Q1 Pro", 199.00, 20,
                "Bàn phím cơ không dây layout 75%, vỏ nhôm nguyên khối."));
        products.add(new Product(5, "Màn hình LG UltraFine 4K 27 inch", 450.00, 15,
                "Màn hình độ phân giải cực cao, sắc nét, màu chuẩn cho creator."));
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
