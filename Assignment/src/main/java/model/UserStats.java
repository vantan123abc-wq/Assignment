package model;

public class UserStats {
    private long totalOrders;
    private double totalSpend;
    private long totalReviews;

    public UserStats() {
    }

    public UserStats(long totalOrders, double totalSpend, long totalReviews) {
        this.totalOrders = totalOrders;
        this.totalSpend = totalSpend;
        this.totalReviews = totalReviews;
    }

    public long getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(long totalOrders) {
        this.totalOrders = totalOrders;
    }

    public double getTotalSpend() {
        return totalSpend;
    }

    public void setTotalSpend(double totalSpend) {
        this.totalSpend = totalSpend;
    }

    public long getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(long totalReviews) {
        this.totalReviews = totalReviews;
    }
}
