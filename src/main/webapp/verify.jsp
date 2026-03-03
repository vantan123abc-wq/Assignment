<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Xác thực mã OTP - Nông Sản Việt</title>
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
                max-width: 450px;
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
        <script>
            function validatePassword() {
                var newPassword = document.getElementById("newPassword").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                if (newPassword !== confirmPassword) {
                    alert("Mật khẩu xác nhận không khớp!");
                    return false;
                }
                return true;
            }
        </script>
    </head>

    <body>
        <div class="container">
            <h2 style="text-align: center; color: #4cae4f;">Xác nhận OTP & Đổi mật khẩu</h2>
            <form action="verify" method="post" onsubmit="return validatePassword()">
                <input type="hidden" name="email" value="${sessionScope.EMAIL}">
                <!-- Thêm trường ẩn này để trình duyệt nhận diện Username (email) thay vì lấy nhầm mã OTP -->
                <input type="text" name="browser_username" value="${sessionScope.EMAIL}" autocomplete="username"
                    style="display:none;" aria-hidden="true">

                <label>Nhập mã OTP (đã gửi qua email):</label><br>
                <input type="text" name="otp" autocomplete="one-time-code" required><br>

                <label>Mật khẩu mới:</label><br>
                <input type="password" name="newPassword" id="newPassword" autocomplete="new-password" required><br>

                <label>Xác nhận mật khẩu mới:</label><br>
                <input type="password" name="confirmPassword" id="confirmPassword" autocomplete="new-password"
                    required><br>

                <input type="submit" value="Xác nhận & Cập nhật">
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