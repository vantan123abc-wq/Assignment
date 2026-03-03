<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@page import="jakarta.servlet.http.Cookie" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Login - Nông Sản Việt</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f6f7f6;
                    margin: 0;
                    padding: 20px;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                }

                .container {
                    background: white;
                    padding: 30px;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    width: 100%;
                    max-width: 400px;
                    margin-top: 50px;
                }

                input[type=text],
                input[type=password] {
                    width: 100%;
                    padding: 10px;
                    margin: 8px 0 20px 0;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                    box-sizing: border-box;
                }

                input[type=submit] {
                    width: 100%;
                    padding: 10px;
                    background-color: #4cae4f;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    font-weight: bold;
                    cursor: pointer;
                }

                input[type=submit]:hover {
                    background-color: #45a049;
                }
            </style>
        </head>

        <body>
            <% String username_value="" ; Cookie[] cookies=request.getCookies(); if (cookies !=null) { for (Cookie
                cookie : cookies) { if ("USERNAME_COOKIE".equals(cookie.getName())) { username_value=cookie.getValue();
                break; } } } %>

                <div class="container">
                    <h2 style="text-align: center; color: #4cae4f;">Đăng nhập</h2>
                    <form action="login" method="post">
                        <label>Tên đăng nhập (Username):</label><br>
                        <input type="text" name="username" value="<%= username_value %>" required><br>

                        <label>Mật khẩu (Password):</label><br>
                        <input type="password" name="password" required><br>

                        <div style="display: flex; align-items: center; margin-bottom: 20px;">
                            <input type="checkbox" name="remember" value="1" style="margin-right: 8px;">
                            <label> Nhớ tài khoản </label>
                        </div>

                        <input type="submit" value="Đăng nhập">
                    </form>
                    <div style="margin-top: 20px; font-size: 14px; text-align: center;">
                        <a href="forget" style="text-decoration: none; color: #007bff;">Quên mật khẩu?</a><br><br>
                        <span style="color: #555;">Chưa có tài khoản?</span>
                        <a href="register" style="text-decoration: none; color: #007bff; font-weight: bold;">Đăng ký
                            ngay</a>
                    </div>
                    <p style="color:red; text-align: center; margin-top: 15px;">
                        ${requestScope.error}
                    </p>
                </div>
        </body>

        </html>