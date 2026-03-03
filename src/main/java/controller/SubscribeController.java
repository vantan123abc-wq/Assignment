package controller;

import dao.SubscriberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "SubscribeController", urlPatterns = {"/subscribe"})
public class SubscribeController extends HttpServlet {

    private final SubscriberDAO subscriberDAO = new SubscriberDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=error&email=");
            return;
        }

        email = email.trim().toLowerCase();

        if (subscriberDAO.exists(email)) {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=exists&email=" + java.net.URLEncoder.encode(email, "UTF-8"));
            return;
        }

        boolean success = subscriberDAO.insert(email);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=success&email=" + java.net.URLEncoder.encode(email, "UTF-8"));
        } else {
            response.sendRedirect(request.getContextPath() + "/subscribe-result.jsp?status=error&email=" + java.net.URLEncoder.encode(email, "UTF-8"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }
}
