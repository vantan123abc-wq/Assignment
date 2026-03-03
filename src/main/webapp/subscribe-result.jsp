<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Kết quả đăng ký - Nông Sản Việt</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap"
                rel="stylesheet" />
            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
            <script>tailwind.config = { theme: { extend: { colors: { primary: "#4cae4f" }, fontFamily: { display: ["Inter"] } } } }</script>
            <style>
                body {
                    font-family: 'Inter', sans-serif;
                }
            </style>
        </head>

        <body class="bg-gradient-to-br from-green-50 to-emerald-100 min-h-screen flex items-center justify-center px-4">

            <div class="bg-white rounded-3xl shadow-2xl max-w-md w-full p-10 text-center">

                <c:choose>
                    <%--=====THÀNH CÔNG=====--%>
                        <c:when test="${param.status == 'success'}">
                            <div
                                class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                <span class="material-symbols-outlined text-primary"
                                    style="font-size:56px;">check_circle</span>
                            </div>
                            <h1 class="text-3xl font-black text-slate-800 mb-3">Đăng ký thành công!</h1>
                            <p class="text-slate-500 mb-2">Email <span
                                    class="font-semibold text-primary">${param.email}</span></p>
                            <p class="text-slate-500 mb-8">đã được đăng ký. Bạn sẽ nhận thông báo khi có sản phẩm giảm
                                giá mới nhất. 🎉</p>
                            <a href="${pageContext.request.contextPath}/"
                                class="inline-block bg-primary hover:bg-green-600 text-white font-bold px-8 py-3 rounded-xl transition-colors">
                                ← Về trang chủ
                            </a>
                        </c:when>

                        <%--=====EMAIL ĐÃ TỒN TẠI=====--%>
                            <c:when test="${param.status == 'exists'}">
                                <div
                                    class="w-24 h-24 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <span class="material-symbols-outlined text-orange-400"
                                        style="font-size:56px;">warning</span>
                                </div>
                                <h1 class="text-3xl font-black text-slate-800 mb-3">Email đã tồn tại!</h1>
                                <p class="text-slate-500 mb-2">Email <span
                                        class="font-semibold text-orange-500">${param.email}</span></p>
                                <p class="text-slate-500 mb-8">đã được đăng ký trước đó. Bạn đã có trong danh sách nhận
                                    thông báo rồi! 😊</p>
                                <a href="${pageContext.request.contextPath}/"
                                    class="inline-block bg-primary hover:bg-green-600 text-white font-bold px-8 py-3 rounded-xl transition-colors">
                                    ← Về trang chủ
                                </a>
                            </c:when>

                            <%--=====LỖI KHÁC=====--%>
                                <c:otherwise>
                                    <div
                                        class="w-24 h-24 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                        <span class="material-symbols-outlined text-red-400"
                                            style="font-size:56px;">error</span>
                                    </div>
                                    <h1 class="text-3xl font-black text-slate-800 mb-3">Có lỗi xảy ra!</h1>
                                    <p class="text-slate-500 mb-8">Vui lòng thử lại hoặc liên hệ hỗ trợ.</p>
                                    <a href="${pageContext.request.contextPath}/"
                                        class="inline-block bg-primary hover:bg-green-600 text-white font-bold px-8 py-3 rounded-xl transition-colors">
                                        ← Thử lại
                                    </a>
                                </c:otherwise>
                </c:choose>

            </div>
        </body>

        </html>