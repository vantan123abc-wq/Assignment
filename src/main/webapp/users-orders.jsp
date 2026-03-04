<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - Nông Sản Việt</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap" rel="stylesheet" />
    <style> 
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; } 
    </style>
</head>
<body class="flex flex-col min-h-screen">

    <header class="bg-white border-b border-slate-100 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between gap-8">
            <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2 text-[#4cae4f] font-black text-2xl tracking-tight shrink-0">
                <div class="bg-[#4cae4f] text-white p-1.5 rounded-lg">
                    <span class="material-symbols-outlined text-3xl">agriculture</span>
                </div>
                Nông Sản Việt
            </a>

            <div class="flex-1 max-w-xl relative hidden md:block">
                <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                <input type="text" placeholder="Tìm kiếm sản phẩm..." class="w-full bg-slate-50 border border-slate-200 text-slate-800 rounded-full py-2.5 pl-12 pr-4 focus:outline-none focus:border-[#4cae4f] focus:ring-2 focus:ring-[#4cae4f]/20 transition-all">
            </div>

            <nav class="hidden lg:flex items-center gap-6 font-semibold text-slate-700">
                <a href="${pageContext.request.contextPath}/index" class="hover:text-[#4cae4f] transition-colors">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/shop" class="hover:text-[#4cae4f] transition-colors">Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/promotions" class="hover:text-[#4cae4f] transition-colors">Khuyến mãi</a>
                <a href="${pageContext.request.contextPath}/contact" class="hover:text-[#4cae4f] transition-colors">Liên hệ</a>
            </nav>

            <div class="flex items-center gap-3 shrink-0">
                <a href="${pageContext.request.contextPath}/cart" class="w-10 h-10 flex items-center justify-center bg-[#4cae4f]/10 text-[#4cae4f] rounded-lg hover:bg-[#4cae4f]/20 transition-colors">
                    <span class="material-symbols-outlined">shopping_cart</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="w-10 h-10 flex items-center justify-center border border-slate-200 text-slate-600 rounded-lg hover:bg-slate-50 transition-colors" title="Đăng xuất">
                    <span class="material-symbols-outlined">logout</span>
                </a>
            </div>
        </div>
    </header>

    <main class="flex-grow max-w-5xl mx-auto w-full px-4 py-8">
        
        <div class="text-sm text-slate-500 mb-6 flex items-center gap-2 font-medium">
            <a href="${pageContext.request.contextPath}/index" class="hover:text-[#4cae4f] transition-colors">Trang chủ</a> 
            <span class="text-slate-300">/</span>
            <span class="text-[#4cae4f]">Đơn hàng của tôi</span>
        </div>

        <h1 class="text-3xl font-black text-slate-900 mb-8">Lịch sử đơn hàng</h1>

        <c:if test="${empty myOrders}">
            <div class="bg-white py-16 px-4 rounded-2xl text-center shadow-sm border border-slate-100 flex flex-col items-center justify-center">
                <span class="material-symbols-outlined text-7xl text-slate-300 mb-4">receipt_long</span>
                <p class="text-slate-500 text-lg font-medium">Bạn chưa có đơn hàng nào.</p>
                <a href="${pageContext.request.contextPath}/shop" class="mt-6 px-8 py-3 bg-[#4cae4f] text-white rounded-lg font-bold hover:bg-green-600 transition-colors shadow-sm shadow-green-200">
                    Tiếp tục mua sắm
                </a>
            </div>
        </c:if>

        <div class="space-y-6">
            <c:forEach var="order" items="${myOrders}">
                <div class="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 transition-shadow hover:shadow-md">
                    
                    <div class="flex flex-col sm:flex-row justify-between sm:items-center pb-4 border-b border-slate-100 gap-2">
                        <div>
                            <p class="font-bold text-lg text-slate-900">Đơn hàng #${order.id}</p>
                            <p class="text-sm text-slate-500 mt-0.5">Đặt lúc: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></p>
                        </div>
                        <div class="text-left sm:text-right">
                            <p class="font-black text-[#4cae4f] text-xl">
                                <fmt:formatNumber value="${order.totalAmount}" type="number" maxFractionDigits="0"/>₫
                            </p>
                        </div>
                    </div>

                    <div class="py-4 space-y-4">
                        <c:forEach var="item" items="${order.items}">
                            <div class="flex items-center gap-4 group cursor-pointer">
                                <div class="w-16 h-16 shrink-0 bg-slate-50 rounded-lg overflow-hidden border border-slate-100">
                                    <img src="${item.product.imageUrl}" alt="product" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300">
                                </div>
                                
                                <div class="flex-1">
                                    <h4 class="font-bold text-slate-800 text-sm md:text-base group-hover:text-[#4cae4f] transition-colors line-clamp-2">${item.product.name}</h4>
                                    <p class="text-sm text-slate-500 font-medium mt-1">Số lượng: x${item.quantity}</p>
                                </div>
                                
                                <div class="font-bold text-slate-700 text-sm md:text-base">
                                    <fmt:formatNumber value="${item.product.price}" type="number" maxFractionDigits="0"/>₫
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="pt-4 border-t border-slate-100">
                        <c:choose>
                            <c:when test="${order.status == 'Pending' || order.status == 'Chờ xác nhận'}">
                                <div class="inline-flex items-center gap-2 bg-orange-50 text-orange-600 px-4 py-2 rounded-lg text-sm font-bold">
                                    <span class="material-symbols-outlined text-base">hourglass_empty</span> Đang chờ xác nhận
                                </div>
                            </c:when>
                            <c:when test="${order.status == 'Shipping' || order.status == 'Đang giao'}">
                                <div class="inline-flex items-center gap-2 bg-blue-50 text-blue-600 px-4 py-2 rounded-lg text-sm font-bold border border-blue-100">
                                    <span class="material-symbols-outlined text-base animate-bounce">local_shipping</span> Đang giao hàng
                                </div>
                            </c:when>
                            <c:when test="${order.status == 'Completed' || order.status == 'Đã giao'}">
                                <div class="inline-flex items-center gap-2 bg-green-50 text-green-600 px-4 py-2 rounded-lg text-sm font-bold">
                                    <span class="material-symbols-outlined text-base">check_circle</span> Đã giao thành công
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="inline-flex items-center gap-2 bg-red-50 text-red-600 px-4 py-2 rounded-lg text-sm font-bold">
                                    <span class="material-symbols-outlined text-base">cancel</span> Đã hủy
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <footer class="bg-white border-t border-slate-100 pt-16 pb-8 mt-auto relative">
        <div class="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8 mb-12">
            <div>
                <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2 text-[#4cae4f] font-black text-2xl tracking-tight mb-4">
                    <div class="bg-[#4cae4f] text-white p-1.5 rounded-lg">
                        <span class="material-symbols-outlined text-3xl">agriculture</span>
                    </div>
                    Nông Sản Việt
                </a>
                <p class="text-slate-500 text-sm leading-relaxed">Kết nối trực tiếp nông sản sạch từ nông trại đến tận bàn ăn gia đình bạn.</p>
            </div>

            <div>
                <h3 class="font-bold text-slate-900 mb-4 uppercase text-sm tracking-wider">Sản phẩm</h3>
                <ul class="space-y-3 text-slate-500 text-sm">
                    <li><a href="#" class="hover:text-[#4cae4f]">Rau củ hữu cơ</a></li>
                    <li><a href="#" class="hover:text-[#4cae4f]">Trái cây tươi</a></li>
                    <li><a href="#" class="hover:text-[#4cae4f]">Thịt cá sạch</a></li>
                </ul>
            </div>

            <div>
                <h3 class="font-bold text-slate-900 mb-4 uppercase text-sm tracking-wider">Chính sách</h3>
                <ul class="space-y-3 text-slate-500 text-sm">
                    <li><a href="#" class="hover:text-[#4cae4f]">Giao hàng & Nhận hàng</a></li>
                    <li><a href="#" class="hover:text-[#4cae4f]">Đổi trả & Hoàn tiền</a></li>
                    <li><a href="#" class="hover:text-[#4cae4f]">Bảo mật thông tin</a></li>
                </ul>
            </div>

            <div>
                <h3 class="font-bold text-slate-900 mb-4 uppercase text-sm tracking-wider">Liên hệ</h3>
                <ul class="space-y-3 text-slate-500 text-sm">
                    <li class="flex items-center gap-2"><span class="material-symbols-outlined text-sm">call</span> 1900 1234</li>
                    <li class="flex items-center gap-2"><span class="material-symbols-outlined text-sm">mail</span> hotro@nongsanviet.vn</li>
                    <li class="flex items-center gap-2"><span class="material-symbols-outlined text-sm">location_on</span> Đà Nẵng, Việt Nam</li>
                </ul>
            </div>
        </div>
        
        <button class="fixed bottom-6 right-6 bg-[#4cae4f] hover:bg-green-600 text-white px-6 py-3 rounded-full font-bold shadow-lg shadow-green-200 flex items-center gap-2 transition-transform hover:-translate-y-1">
            <span class="material-symbols-outlined">forum</span> Hỗ trợ trực tuyến AI
        </button>
    </footer>

</body>
</html>