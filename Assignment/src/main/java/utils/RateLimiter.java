package utils;

import java.util.concurrent.ConcurrentHashMap;

public class RateLimiter {
    // Stores IP addresses and the last time they made a request (in milliseconds)
    private static final ConcurrentHashMap<String, Long> requestTimes = new ConcurrentHashMap<>();

    // 5 seconds cooldown per IP
    private static final long COOLDOWN_MS = 5000;

    public static boolean isAllowed(String ip) {
        long currentTime = System.currentTimeMillis();
        Long lastRequestTime = requestTimes.get(ip);

        if (lastRequestTime != null && (currentTime - lastRequestTime) < COOLDOWN_MS) {
            return false;
        }

        requestTimes.put(ip, currentTime);
        return true;
    }
}
