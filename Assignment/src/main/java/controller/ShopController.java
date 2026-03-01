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

@WebServlet(name = "ShopController", urlPatterns = { "/shop" })
public class ShopController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String catIdParam = request.getParameter("catId");

        CategoryDao catDao = new CategoryDao();
        ProductDao prodDao = new ProductDao();

        List<Category> categories = catDao.findAll();
        List<Product> products;

        if (catIdParam != null && !catIdParam.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(catIdParam);
                products = prodDao.findAvailableByCategory(catId);
                request.setAttribute("selectedCatId", catId);
            } catch (NumberFormatException e) {
                products = prodDao.findAvailable();
            }
        } else {
            products = prodDao.findAvailable();
        }

        request.setAttribute("categories", categories);
        request.setAttribute("products", products);

        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
