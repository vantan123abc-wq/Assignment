package utils;

import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingDeque;

/**
 * Utility class for managing in-session notifications for users.
 * Notifications are stored in the session as a LinkedList (max 10 items).
 *
 * For cross-session delivery (e.g., admin triggering notification for a
 * customer),
 * we use a static server-side map keyed by accountId.
 */
public class NotificationHelper {

    private static final String SESSION_KEY = "userNotifications";
    private static final int MAX_NOTIFICATIONS = 10;

    public static final String TYPE_SUCCESS = "success";
    public static final String TYPE_INFO = "info";
    public static final String TYPE_WARNING = "warning";

    // -------------------------------------------------------------------
    // Server-side pending notifications (for cross-session delivery)
    // Key: accountId, Value: queue of pending notifications not yet in a session
    // -------------------------------------------------------------------
    private static final ConcurrentHashMap<Integer, LinkedBlockingDeque<Notification>> PENDING = new ConcurrentHashMap<>();

    // -------------------------------------------------------------------
    // Notification data class
    // -------------------------------------------------------------------
    public static class Notification {
        private final String type; // success | info | warning
        private final String icon; // Material Symbol name
        private final String message; // Displayed text
        private final String link; // URL to navigate when clicked
        private final java.util.Date timestamp; // for fmt:formatDate in JSP

        public Notification(String type, String icon, String message, String link) {
            this.type = type;
            this.icon = icon;
            this.message = message;
            this.link = link;
            this.timestamp = new java.util.Date();
        }

        public String getType() {
            return type;
        }

        public String getIcon() {
            return icon;
        }

        public String getMessage() {
            return message;
        }

        public String getLink() {
            return link;
        }

        public java.util.Date getTimestamp() {
            return timestamp;
        }
    }

    // -------------------------------------------------------------------
    // Session-based helpers
    // -------------------------------------------------------------------

    /** Add a notification directly to the user's current session. */
    @SuppressWarnings("unchecked")
    public static void add(HttpSession session, String type, String icon, String message, String link) {
        LinkedList<Notification> list = (LinkedList<Notification>) session.getAttribute(SESSION_KEY);
        if (list == null)
            list = new LinkedList<>();
        list.addFirst(new Notification(type, icon, message, link));
        while (list.size() > MAX_NOTIFICATIONS)
            list.removeLast();
        session.setAttribute(SESSION_KEY, list);
    }

    /** Get all notifications from user's session. */
    @SuppressWarnings("unchecked")
    public static List<Notification> getAll(HttpSession session) {
        List<Notification> list = (List<Notification>) session.getAttribute(SESSION_KEY);
        return list != null ? list : new ArrayList<>();
    }

    /** Clear all notifications from user's session. */
    public static void clear(HttpSession session) {
        session.removeAttribute(SESSION_KEY);
    }

    // -------------------------------------------------------------------
    // Cross-session helpers (admin → customer)
    // -------------------------------------------------------------------

    /**
     * Queue a notification for a specific accountId.
     * Will be transferred to their session on their next page load via
     * {@link #transferPendingToSession(int, HttpSession)}.
     */
    public static void addForUser(int accountId, String type, String icon, String message, String link) {
        PENDING.computeIfAbsent(accountId, k -> new LinkedBlockingDeque<>(MAX_NOTIFICATIONS))
                .offerFirst(new Notification(type, icon, message, link));
    }

    /**
     * Call this on every user page load.
     * Moves any server-side pending notifications into the user's session.
     */
    @SuppressWarnings("unchecked")
    public static void transferPendingToSession(int accountId, HttpSession session) {
        LinkedBlockingDeque<Notification> pending = PENDING.remove(accountId);
        if (pending == null || pending.isEmpty())
            return;

        LinkedList<Notification> list = (LinkedList<Notification>) session.getAttribute(SESSION_KEY);
        if (list == null)
            list = new LinkedList<>();
        for (Notification n : pending) {
            list.addFirst(n);
        }
        while (list.size() > MAX_NOTIFICATIONS)
            list.removeLast();
        session.setAttribute(SESSION_KEY, list);
    }

    // -------------------------------------------------------------------
    // Shorthand event methods
    // -------------------------------------------------------------------

    public static void orderPlaced(HttpSession session, int orderId, String contextPath) {
        add(session, TYPE_SUCCESS, "check_circle",
                "Đặt hàng thành công! Mã ĐH #" + orderId,
                contextPath + "/order-history");
    }

    public static void returnRequested(HttpSession session, int orderId, String contextPath) {
        add(session, TYPE_INFO, "assignment_return",
                "Đã gửi yêu cầu trả hàng cho đơn #" + orderId,
                contextPath + "/order-history");
    }

    /**
     * Called by admin controller — queued server-side, delivered on user's next
     * load.
     */
    public static void returnAccepted(int accountId, int orderId, String contextPath) {
        addForUser(accountId, TYPE_SUCCESS, "verified",
                "✅ Yêu cầu trả hàng đơn #" + orderId + " đã được chấp nhận!",
                contextPath + "/order-history");
    }
}
