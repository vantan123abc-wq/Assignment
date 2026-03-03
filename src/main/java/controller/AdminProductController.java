package controller;

import dao.CategoryDao;
import dao.EmailLogDAO;
import dao.ProductDao;
import dao.SubscriberDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.EmailLog;
import model.Product;
import utils.DiscountEmailBuilder;
import utils.EmailService;

@WebServlet(name = "AdminProductController", urlPatterns = { "/admin/product/create", "/admin/product/edit",
        "/admin/product/delete" })
public class AdminProductController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final CategoryDao categoryDao = new CategoryDao();
    private final SubscriberDAO subscriberDAO = new SubscriberDAO();
    private final EmailLogDAO emailLogDAO = new EmailLogDAO();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/admin/product/create")) {
            showCreateForm(request, response);
        } else if (uri.endsWith("/admin/product/edit")) {
            showEditForm(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/admin/product/create")) {
            createProduct(request, response);
        } else if (uri.endsWith("/admin/product/edit")) {
            editProduct(request, response);
        } else if (uri.endsWith("/admin/product/delete")) {
            deleteProduct(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDao.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDao.findById(id);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/inventory");
                return;
            }
            List<Category> categories = categoryDao.findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/inventory");
        }
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Product p = new Product();
            p.setName(request.getParameter("name"));
            p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            p.setQuantity(Integer.parseInt(request.getParameter("stock")));
            p.setDescription(request.getParameter("description"));
            p.setImageUrl(request.getParameter("imageUrl"));
            p.setNotified(false);

            String discountStr = request.getParameter("discountPercent");
            if (discountStr != null && !discountStr.trim().isEmpty()) {
                p.setDiscountPercent(Integer.parseInt(discountStr));
            }

            productDao.insert(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/inventory");
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Lấy trạng thái cũ để so sánh discount & isNotified
            Product oldProduct = productDao.findById(id);

            Product p = new Product();
            p.setId(id);
            p.setName(request.getParameter("name"));
            p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            p.setQuantity(Integer.parseInt(request.getParameter("stock")));
            p.setDescription(request.getParameter("description"));
            p.setImageUrl(request.getParameter("imageUrl"));

            Integer newDiscount = null;
            String discountStr = request.getParameter("discountPercent");
            if (discountStr != null && !discountStr.trim().isEmpty()) {
                newDiscount = Integer.parseInt(discountStr);
            }
            p.setDiscountPercent(newDiscount);

            // --- Logic chống gửi trùng ---
            // Nếu discount thay đổi → reset isNotified về false
            Integer oldDiscount = (oldProduct != null) ? oldProduct.getDiscountPercent() : null;
            boolean discountChanged = !java.util.Objects.equals(oldDiscount, newDiscount);
            if (discountChanged) {
                p.setNotified(false); // discount mới → cho phép gửi lại
            } else {
                p.setNotified(oldProduct != null && oldProduct.isNotified()); // giữ nguyên
            }

            productDao.update(p);

            // --- Gửi email nếu discount > 0 và chưa gửi ---
            if (newDiscount != null && newDiscount > 0 && !p.isNotified()) {
                String baseUrl = request.getScheme() + "://" + request.getServerName()
                        + ":" + request.getServerPort() + request.getContextPath();
                sendDiscountNotifications(p, baseUrl);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/inventory");
    }

    /**
     * Gửi email thông báo giảm giá tới tất cả subscriber đang active.
     * Sau khi gửi xong: set is_notified = true và ghi EmailLog.
     */
    private void sendDiscountNotifications(Product p, String baseUrl) {
        try {
            List<String> emails = subscriberDAO.getAllActiveEmails();
            if (emails.isEmpty()) return;

            String subject = "🎉 Sản phẩm đang giảm giá!";
            String productLink = baseUrl + "/shop?id=" + p.getId();
            String htmlContent = DiscountEmailBuilder.buildHtml(p, productLink);

            int successCount = 0;
            for (String email : emails) {
                try {
                    emailService.sendMail(email, subject, htmlContent);
                    successCount++;
                } catch (Exception ex) {
                    ex.printStackTrace(); // Log lỗi từng mail, không dừng vòng lặp
                }
            }

            if (successCount > 0) {
                // Đánh dấu đã gửi thông báo
                productDao.updateNotified(p.getId(), true);

                // Ghi log
                EmailLog log = new EmailLog(subject, htmlContent, p.getId());
                emailLogDAO.insert(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            productDao.delete(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/inventory");
    }
}
