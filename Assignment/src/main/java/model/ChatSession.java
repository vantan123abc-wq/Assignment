package model;

import java.util.ArrayList;
import java.util.List;

public class ChatSession {
    private String sessionId;
    private long createdAt;
    private String ip;
    private String userAgent;
    private List<ChatMessage> history;

    public ChatSession(String sessionId, String ip, String userAgent) {
        this.sessionId = sessionId;
        this.ip = ip;
        this.userAgent = userAgent;
        this.createdAt = System.currentTimeMillis();
        this.history = new ArrayList<>();
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public long getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(long createdAt) {
        this.createdAt = createdAt;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public List<ChatMessage> getHistory() {
        return history;
    }

    public void setHistory(List<ChatMessage> history) {
        this.history = history;
    }

    public void addMessage(ChatMessage message) {
        this.history.add(message);
    }
}
