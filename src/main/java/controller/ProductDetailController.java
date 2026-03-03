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
import model.Category;
import model.Product;

/**
 * Servlet hiển thị trang chi tiết sản phẩm.
 * URL: /product?id={productId}
 */
@WebServlet(name = "ProductDetailController", urlPatterns = { "/product" })
public class ProductDetailController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        // Kiểm tra tham số id hợp lệ
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        // Lấy thông tin sản phẩm theo id
        Product product = productDao.findById(productId);

        if (product == null) {
            // Sản phẩm không tồn tại -> về trang shop
            request.setAttribute("error", "Sản phẩm không tồn tại!");
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        // Lấy danh sách sản phẩm liên quan (cùng danh mục, loại trừ sp hiện tại)
        List<Product> relatedProducts = productDao.findAvailableByCategory(product.getCategoryId());
        relatedProducts.removeIf(p -> p.getId() == productId);
        // Giới hạn 4 sản phẩm liên quan
        if (relatedProducts.size() > 4) {
            relatedProducts = relatedProducts.subList(0, 4);
        }

        // Lấy tên danh mục nếu chưa có
        if (product.getCategoryName() == null || product.getCategoryName().isEmpty()) {
            List<Category> categories = categoryDao.findAll();
            for (Category c : categories) {
                if (c.getId() == product.getCategoryId()) {
                    product.setCategoryName(c.getName());
                    break;
                }
            }
        }

        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);
        request.getRequestDispatcher("product-detail.jsp").forward(request, response);
    }
}
