package model;

public class RevenueData {
    private String dateLabel; // Nhãn ngày (VD: "01/03/2026")
    private double totalRevenue; // Tổng doanh thu trong ngày

    public RevenueData(String dateLabel, double totalRevenue) {
        this.dateLabel = dateLabel;
        this.totalRevenue = totalRevenue;
    }

    public String getDateLabel() { return dateLabel; }
    public void setDateLabel(String dateLabel) { this.dateLabel = dateLabel; }

    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
}