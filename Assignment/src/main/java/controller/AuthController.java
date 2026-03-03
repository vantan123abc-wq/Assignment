/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import org.mindrot.jbcrypt.BCrypt;
import utils.EmailService;
import utils.OtpService;

/**
 *
 * @author DELL
 */
@WebServlet(name = "AuthController", urlPatterns = { "/login", "/register", "/forget", "/verify" })
public class AuthController extends HttpServlet {
    private final AccountDao dao = new AccountDao();
    private static final OtpService otp = new OtpService();
    private static final EmailService ms = new EmailService();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/login")) {
            getLogin(request, response);
        } else if (uri.endsWith("/register")) {
            getRegister(request, response);
        } else if (uri.endsWith("/forget")) {
            getForget(request, response);
        } else if (uri.endsWith("/verify")) {
            getVerify(request, response);
        }
    }

    private void getLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    private void getRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    private void getForget(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forget.jsp").forward(request, response);
    }

    private void getVerify(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("verify.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/login")) {
            postLogin(request, response);
        } else if (uri.endsWith("/register")) {
            postregister(request, response);
        } else if (uri.endsWith("/forget")) {
            postForget(request, response);
        } else if (uri.endsWith("/verify")) {
            postVerify(request, response);
        }
    }

    protected void postLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Account acc = dao.findByUserName(username);

        boolean isPasswordMatch = false;
        if (acc != null && acc.getPasswordHash() != null) {
            try {
                isPasswordMatch = BCrypt.checkpw(password, acc.getPasswordHash());
            } catch (IllegalArgumentException e) {
                // Fallback cho trường hợp mật khẩu trong database là plain text (chưa mã hóa)
                isPasswordMatch = password.equals(acc.getPasswordHash());
            }
        }

        if (isPasswordMatch) {
            // Kiểm tra tài khoản có bị vô hiệu hóa không
            if (!acc.getStatus()) {
                request.setAttribute("error",
                        "Tài khoản của bạn đã bị vô hiệu hóa. Vui lòng liên hệ quản trị viên để được hỗ trợ.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("account", acc);

            String remember = request.getParameter("remember");
            if (remember != null) {
                Cookie c = new Cookie("USERNAME_COOKIE", username);
                c.setMaxAge(7 * 24 * 60 * 60);
                response.addCookie(c);
            } else {
                Cookie c = new Cookie("USERNAME_COOKIE", "");
                c.setMaxAge(0);
                response.addCookie(c);
            }

            String role = acc.getRole();

            System.out.println("==== KIỂM TRA ROLE TỪ DB: '" + role + "' ====");

            if (role != null && role.trim().equalsIgnoreCase("ADMIN")) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } else {
            request.setAttribute("error", "Username or password is wrong, try again!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void postregister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");

        if (dao.findByUserName(username) != null) {
            request.setAttribute("error", "User name is existed!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Account acc = new Account();
        acc.setEmail(email);
        acc.setUsername(username);
        acc.setFullName(fullname);
        acc.setStatus(true);

        // ----- ĐOẠN XỬ LÝ PHÂN QUYỀN KHI ĐĂNG KÝ -----
        // Mẹo test nhanh: Nếu username chứa chữ "admin" thì cho làm ADMIN, ngược lại
        // làm USER
        if (username != null && username.toLowerCase().contains("admin")) {
            acc.setRole("ADMIN");
        } else {
            acc.setRole("USER");
        }
        // ---------------------------------------------

        String pwdHash = BCrypt.hashpw(password, BCrypt.gensalt());
        acc.setPasswordHash(pwdHash);
        dao.create(acc);

        response.sendRedirect("login");
    }

    private void postForget(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        Account acc = dao.findByEmail(email);
        if (acc == null) {
            request.setAttribute("error", "Email chưa được đăng ký trong hệ thống!");
            request.getRequestDispatcher("forget.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("EMAIL", email);

        // Removed duplicate generateAndStored call as per original code inspection
        String sendOtpMail = otp.generateAndStored(email);

        ms.send(email, "Ma xac thuc khoi phuc mat khau", sendOtpMail);

        response.sendRedirect("verify");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void postVerify(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String verifyOtp = request.getParameter("otp");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        boolean ok = otp.verifyOtp(email, verifyOtp);
        if (ok) {
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                String pwdHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                dao.updatePasswordByEmail(email, pwdHash);
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Mật khẩu mới không hợp lệ!");
                request.getRequestDispatcher("verify.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Sai OTP!");
            request.getRequestDispatcher("verify.jsp").forward(request, response);
        }

    }

}
