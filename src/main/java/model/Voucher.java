package model;

import java.io.Serializable;

/**
 * Model Voucher - mã giảm giá
 */
public class Voucher implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String code; // Mã voucher, VD: "CHAOHE2024"
    private String title; // Tên hiển thị, VD: "Giảm 15% tổng đơn"
    private String description; // Mô tả điều kiện
    private String type; // "PERCENT" | "FIXED" | "SHIPPING"
    private double discountValue; // % hoặc số tiền giảm (tuỳ type)
    private double maxDiscount; // Giảm tối đa (0 = không giới hạn)
    private double minOrderValue; // Đơn tối thiểu
    private String category; // "shipping" | "discount" | "cashback" | "product"
    private String expiryDate; // "31/12/2025"
    private boolean active;

    public Voucher() {
    }

    public Voucher(int id, String code, String title, String description,
            String type, double discountValue, double maxDiscount,
            double minOrderValue, String category, String expiryDate, boolean active) {
        this.id = id;
        this.code = code;
        this.title = title;
        this.description = description;
        this.type = type;
        this.discountValue = discountValue;
        this.maxDiscount = maxDiscount;
        this.minOrderValue = minOrderValue;
        this.category = category;
        this.expiryDate = expiryDate;
        this.active = active;
    }

    /**
     * Tính số tiền giảm thực tế với tổng đơn hàng cho trước.
     */
    public double calculateDiscount(double orderTotal) {
        if ("SHIPPING".equals(type)) {
            return 0; // Freeship được xử lý riêng
        }
        if (orderTotal < minOrderValue) {
            return 0;
        }
        double discount;
        if ("PERCENT".equals(type)) {
            discount = orderTotal * discountValue / 100.0;
            if (maxDiscount > 0) {
                discount = Math.min(discount, maxDiscount);
            }
        } else { // FIXED
            discount = Math.min(discountValue, orderTotal);
        }
        return discount;
    }

    public boolean isFreeShipping() {
        return "SHIPPING".equals(type);
    }

    // --- Getters & Setters ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public double getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(double maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public double getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(double minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
