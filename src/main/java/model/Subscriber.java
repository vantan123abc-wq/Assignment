package model;

import java.time.LocalDateTime;

public class Subscriber {
    private int id;
    private String email;
    private boolean isActive;
    private LocalDateTime subscribedAt;

    public Subscriber() {}

    public Subscriber(String email) {
        this.email = email;
        this.isActive = true;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public LocalDateTime getSubscribedAt() { return subscribedAt; }
    public void setSubscribedAt(LocalDateTime subscribedAt) { this.subscribedAt = subscribedAt; }

    @Override
    public String toString() {
        return "Subscriber{id=" + id + ", email='" + email + "', isActive=" + isActive + "}";
    }
}
