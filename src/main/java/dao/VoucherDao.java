package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Voucher;

/**
 * DAO cho Voucher - đọc từ DB nếu có bảng Voucher,
 * fallback về dữ liệu mẫu nếu bảng chưa tồn tại.
 */
public class VoucherDao {

    /**
     * Lấy tất cả voucher còn hiệu lực.
     * Nếu bảng Voucher chưa có trong DB → trả về dữ liệu mẫu.
     */
    public List<Voucher> findAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT id, code, title, description, voucher_type, discount_value, " +
                "max_discount, min_order_value, category, expiry_date, active " +
                "FROM Voucher WHERE active = 1";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            // Nếu DB trống, dùng mẫu
            if (list.isEmpty()) {
                list = getSampleVouchers();
            }
        } catch (Exception e) {
            // Bảng chưa tồn tại → trả về mẫu
            list = getSampleVouchers();
        }
        return list;
    }

    /**
     * Tìm voucher theo mã code (không phân biệt hoa thường).
     */
    public Voucher findByCode(String code) {
        if (code == null || code.trim().isEmpty())
            return null;

        // Thử DB trước
        String sql = "SELECT id, code, title, description, voucher_type, discount_value, " +
                "max_discount, min_order_value, category, expiry_date, active " +
                "FROM Voucher WHERE UPPER(code) = UPPER(?) AND active = 1";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (Exception e) {
            // ignore, fallback to sample
        }

        // Fallback: tìm trong dữ liệu mẫu
        for (Voucher v : getSampleVouchers()) {
            if (v.getCode().equalsIgnoreCase(code.trim())) {
                return v;
            }
        }
        return null;
    }

    private Voucher mapRow(ResultSet rs) throws Exception {
        Voucher v = new Voucher();
        v.setId(rs.getInt("id"));
        v.setCode(rs.getString("code"));
        v.setTitle(rs.getString("title"));
        v.setDescription(rs.getString("description"));
        v.setType(rs.getString("voucher_type"));
        v.setDiscountValue(rs.getDouble("discount_value"));
        v.setMaxDiscount(rs.getDouble("max_discount"));
        v.setMinOrderValue(rs.getDouble("min_order_value"));
        v.setCategory(rs.getString("category"));
        v.setExpiryDate(rs.getString("expiry_date"));
        v.setActive(rs.getBoolean("active"));
        return v;
    }

    /**
     * Dữ liệu mẫu để demo (dùng khi bảng Voucher chưa có trong DB).
     */
    public static List<Voucher> getSampleVouchers() {
        List<Voucher> list = new ArrayList<>();
        list.add(new Voucher(1, "FREESHIP2025", "Miễn phí vận chuyển",
                "Đơn tối thiểu 0đ cho nông sản hữu cơ",
                "SHIPPING", 0, 0, 0, "shipping", "31/12/2025", true));
        list.add(new Voucher(2, "GIAM15", "Giảm 15% tổng đơn",
                "Tối đa 100.000đ cho đơn hàng từ 500.000đ",
                "PERCENT", 15, 100000, 500000, "discount", "31/12/2025", true));
        list.add(new Voucher(3, "HOANU10", "Hoàn xu 10% đơn hàng",
                "Áp dụng thanh toán qua ví điện tử",
                "PERCENT", 10, 50000, 200000, "cashback", "31/12/2025", true));
        list.add(new Voucher(4, "RAUSACH50", "Giảm 50.000đ cho rau củ",
                "Dành riêng cho danh mục Rau Củ Sạch",
                "FIXED", 50000, 0, 100000, "product", "31/12/2025", true));
        list.add(new Voucher(5, "CHAOHE2025", "Chào hè - Giảm 20%",
                "Ưu đãi đặc biệt mùa hè, tối đa 200.000đ",
                "PERCENT", 20, 200000, 300000, "discount", "31/12/2025", true));
        return list;
    }
}
