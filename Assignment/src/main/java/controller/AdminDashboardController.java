package controller;

import dao.ProductDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "AdminDashboardController", urlPatterns = { "/admin" })
public class AdminDashboardController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Calculate stock alerts for the notification bell
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

        request.setAttribute("hasStockAlert", hasStockAlert);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("outOfStockCount", outOfStockCount);

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}
