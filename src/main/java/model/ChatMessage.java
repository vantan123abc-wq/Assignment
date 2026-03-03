package model;

public class ChatMessage {
    private String role; // "user" or "model"
    private String content;
    private long createdAt;

    public ChatMessage() {
        this.createdAt = System.currentTimeMillis();
    }

    public ChatMessage(String role, String content) {
        this.role = role;
        this.content = content;
        this.createdAt = System.currentTimeMillis();
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(long createdAt) {
        this.createdAt = createdAt;
    }
}
