package controller;

import dao.CategoryDao;
import dao.ProductDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import model.Category;
import model.Product;
import config.CloudinaryConfig;

@WebServlet(name = "AdminProductController", urlPatterns = { "/admin/product/create", "/admin/product/edit",
        "/admin/product/delete" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class AdminProductController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final CategoryDao categoryDao = new CategoryDao();

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

            // Handle Image Upload with Cloudinary
            String textUrl = request.getParameter("imageUrl");
            Part filePart = request.getPart("imageFile");
            String finalImageUrl = null;

            if (filePart != null && filePart.getSize() > 0) {
                // Upload to Cloudinary
                CloudinaryConfig cloudConfig = new CloudinaryConfig(request.getServletContext());
                try (java.io.InputStream inputStream = filePart.getInputStream()) {
                    byte[] fileBytes = inputStream.readAllBytes();
                    @SuppressWarnings("unchecked")
                    java.util.Map<String, Object> uploadResult = cloudConfig.getClient().uploader().upload(fileBytes,
                            com.cloudinary.utils.ObjectUtils.emptyMap());
                    finalImageUrl = (String) uploadResult.get("secure_url");
                } catch (Exception ex) {
                    ex.printStackTrace();
                    System.out.println("Cloudinary Upload Error: " + ex.getMessage());
                }
            } else if (textUrl != null && !textUrl.trim().isEmpty()) {
                finalImageUrl = textUrl.trim();
            }
            p.setImageUrl(finalImageUrl);

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
            Product p = new Product();
            p.setId(Integer.parseInt(request.getParameter("id")));
            p.setName(request.getParameter("name"));
            p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            p.setQuantity(Integer.parseInt(request.getParameter("stock")));
            p.setDescription(request.getParameter("description"));

            // Handle Image Upload with Cloudinary
            String textUrl = request.getParameter("imageUrl");
            Part filePart = request.getPart("imageFile");
            String finalImageUrl = null;

            if (filePart != null && filePart.getSize() > 0) {
                // Upload to Cloudinary
                CloudinaryConfig cloudConfig = new CloudinaryConfig(request.getServletContext());
                try (java.io.InputStream inputStream = filePart.getInputStream()) {
                    byte[] fileBytes = inputStream.readAllBytes();
                    @SuppressWarnings("unchecked")
                    java.util.Map<String, Object> uploadResult = cloudConfig.getClient().uploader().upload(fileBytes,
                            com.cloudinary.utils.ObjectUtils.emptyMap());
                    finalImageUrl = (String) uploadResult.get("secure_url");
                } catch (Exception ex) {
                    ex.printStackTrace();
                    System.out.println("Cloudinary Edit Upload Error: " + ex.getMessage());
                }
            } else if (textUrl != null && !textUrl.trim().isEmpty()) {
                finalImageUrl = textUrl.trim();
            }

            // For editing, if both are empty, we might want to keep the old image.
            // But based on the UI flow, if they clear both, they might intend to delete it.
            // If we want to strictly keep the old one, we need to fetch it first.
            // For now, if no file and no URL and user submitted, it updates to null.
            p.setImageUrl(finalImageUrl);

            String discountStr = request.getParameter("discountPercent");
            if (discountStr != null && !discountStr.trim().isEmpty()) {
                p.setDiscountPercent(Integer.parseInt(discountStr));
            }

            productDao.update(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/inventory");
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
