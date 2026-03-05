package model;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;

@WebListener // Annotation này giúp server tự nhận diện Listener mà không cần cấu hình web.xml
public class Listener implements HttpSessionListener {

    // Sử dụng AtomicInteger để đảm bảo an toàn khi nhiều luồng (người dùng) truy cập cùng lúc
    private final AtomicInteger activeSessions = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // Tăng số lượng lên 1 khi có người truy cập mới
        int currentUsers = activeSessions.incrementAndGet();
        
        // Lưu con số này vào ServletContext (phạm vi toàn cục của ứng dụng)
        ServletContext context = se.getSession().getServletContext();
        context.setAttribute("activeUsers", currentUsers);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        // Giảm số lượng đi 1 khi người dùng đóng trình duyệt hoặc hết hạn session
        int currentUsers = activeSessions.decrementAndGet();
        
        // Cập nhật lại vào ServletContext (đảm bảo không bị âm)
        ServletContext context = se.getSession().getServletContext();
        context.setAttribute("activeUsers", Math.max(0, currentUsers)); 
    }
}