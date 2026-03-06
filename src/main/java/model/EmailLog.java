package model;

import java.time.LocalDateTime;

public class EmailLog {
    private int id;
    private String subject;
    private String content;
    private LocalDateTime sentAt;
    private Integer productId;

    public EmailLog() {}

    public EmailLog(String subject, String content, Integer productId) {
        this.subject = subject;
        this.content = content;
        this.productId = productId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public LocalDateTime getSentAt() { return sentAt; }
    public void setSentAt(LocalDateTime sentAt) { this.sentAt = sentAt; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    @Override
    public String toString() {
        return "EmailLog{id=" + id + ", subject='" + subject + "', productId=" + productId + "}";
    }
}
