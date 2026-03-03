package model;

public class Payment {
    private int id;
    private int orderId;
    private String method;
    private String status;

    public Payment() {
    }

    public Payment(int id, int orderId, String method, String status) {
        this.id = id;
        this.orderId = orderId;
        this.method = method;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
