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

@WebServlet(name = "AdminProductController", urlPatterns = { "/admin/product/create", "/admin/product/edit",
        "/admin/product/delete" })
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
            p.setImageUrl(request.getParameter("imageUrl"));

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
            p.setImageUrl(request.getParameter("imageUrl"));

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
