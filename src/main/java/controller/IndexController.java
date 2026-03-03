package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "IndexController", urlPatterns = { "/index" })
public class IndexController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        try (java.sql.Connection con = dao.DBConnection.getConnection();
                java.sql.Statement stmt = con.createStatement()) {
            try {
                stmt.executeUpdate("ALTER TABLE Product ADD discount_percent INT DEFAULT 0");
            } catch (Exception e) {
                // Ignore if column already exists
            }
            try {
                stmt.executeUpdate("UPDATE Product SET discount_percent = 15 WHERE id IN (1, 3, 5, 7)");
                stmt.executeUpdate("UPDATE Product SET discount_percent = 25 WHERE id IN (2, 4, 6, 8)");
            } catch (Exception e) {
                // Ignore
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dao.ProductDao productDao = new dao.ProductDao();
        java.util.List<model.FeaturedProduct> bestSellers = productDao.getTopBestSellers(4);
        request.setAttribute("bestSellers", bestSellers);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
