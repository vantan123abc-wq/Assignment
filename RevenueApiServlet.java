package controller;

import com.google.gson.Gson;
import dao.AdminDAO;
import model.RevenueData;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

// Khi frontend gọi URL /api/revenue, Servlet này sẽ chạy
@WebServlet(name = "RevenueApiServlet", urlPatterns = {"/api/revenue"})
public class RevenueApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Trả về định dạng JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        AdminDAO dao = new AdminDAO();
        List<RevenueData> revenueList = dao.getRevenueLast7Days();

        // Chuyển List Java thành chuỗi JSON
        Gson gson = new Gson();
        String jsonOutput = gson.toJson(revenueList);

        // In ra response
        PrintWriter out = response.getWriter();
        out.print(jsonOutput);
        out.flush();
    }
}