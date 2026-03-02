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

@WebServlet(name = "InventoryController", urlPatterns = { "/admin/inventory", "/admin/inventory/update-stock" })
public class InventoryController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/admin/inventory")) {
            showInventory(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/admin/inventory/update-stock")) {
            updateStock(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showInventory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("categoryId");
        String filter = request.getParameter("filter"); // outOfStock or null

        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException ignored) {
            }
        }

        List<Product> products = productDao.findAllWithCategory(keyword, categoryId, filter);
        List<Category> categories = categoryDao.findAll();

        // Calculate total alerts for the notification bell
        List<Product> allProducts = productDao.findAllWithCategory(null, null, null);
        boolean hasStockAlert = false;
        long lowStockCount = 0;
        long outOfStockCount = 0;
        for (Product p : allProducts) {
            if (p.getQuantity() == 0) {
                hasStockAlert = true;
                outOfStockCount++;
            } else if (p.getQuantity() > 0 && p.getQuantity() <= 5) {
                hasStockAlert = true;
                lowStockCount++;
            }
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("hasStockAlert", hasStockAlert);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("outOfStockCount", outOfStockCount);

        request.getRequestDispatcher("/admin/inventory.jsp").forward(request, response);
    }

    private void updateStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            productDao.updateStock(id, stock);
        } catch (NumberFormatException ignored) {
        }

        // Redirect back to inventory page with the exact query string
        String queryStr = request.getQueryString();
        String redirectUrl = request.getContextPath() + "/admin/inventory";
        if (queryStr != null && !queryStr.isEmpty()) {
            redirectUrl += "?" + queryStr;
        }
        response.sendRedirect(redirectUrl);
    }
}
