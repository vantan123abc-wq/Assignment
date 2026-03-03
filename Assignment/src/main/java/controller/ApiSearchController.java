package controller;

import com.google.gson.Gson;
import dao.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "ApiSearchController", urlPatterns = { "/api/search" })
public class ApiSearchController extends HttpServlet {

    private ProductDao productDao = new ProductDao();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("q");
        PrintWriter out = response.getWriter();

        if (keyword == null || keyword.trim().isEmpty()) {
            out.print("[]");
            out.flush();
            return;
        }

        List<Product> products = productDao.searchProducts(keyword, 5); // Limit to top 5 suggestions

        String json = gson.toJson(products);
        out.print(json);
        out.flush();
    }
}
