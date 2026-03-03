<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Quên mật khẩu - Nông Sản Việt</title>
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

            input[type=email] {
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
        <div class="container">
            <h2 style="text-align: center; color: #4cae4f;">Quên mật khẩu</h2>
            <form action="forget" method="post">
                <label>Email của bạn:</label><br>
                <input type="email" name="email" required><br>

                <input type="submit" value="Lấy mã OTP">
            </form>
            <div style="margin-top: 20px; font-size: 14px; text-align: center;">
                <a href="login" style="text-decoration: none; color: #4cae4f; font-weight: bold;">Quay lại đăng nhập</a>
            </div>
            <p style="color:red; text-align: center; margin-top: 15px;">
                ${requestScope.error}
            </p>
        </div>
    </body>

    </html>