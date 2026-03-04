package model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int accountId;
    private int addressId;
    private double totalAmount;
    private String status;
    private Timestamp createdAt;

    public Order() {
    }

    public Order(int id, int accountId, int addressId, double totalAmount, String status, Timestamp createdAt) {
        this.id = id;
        this.accountId = accountId;
        this.addressId = addressId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
   
private String customerEmail;
private String customerPhone;
private java.util.Date orderDate;
private List<CartItem> items;
public List<CartItem> getItems() {
    return items;
}
public void setItems(List<CartItem> items) {
    this.items = items;
}
}
