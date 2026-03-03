<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Giỏ hàng của bạn - Nông Sản Việt</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap"
                    rel="stylesheet" />
                <script id="tailwind-config">
                    tailwind.config = {
                        darkMode: "class",
                        theme: {
                            extend: {
                                colors: {
                                    "primary": "#4cae4f",
                                    "background-light": "#f9faf9",
                                    "background-dark": "#151d15",
                                },
                                fontFamily: { "display": ["Inter"] },
                            },
                        },
                    }
                </script>
                <style>
                    body {
                        font-family: 'Inter', sans-serif;
                        background-color: #f9faf9;
                    }

                    .material-symbols-outlined {
                        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    }
                </style>
            </head>

            <body class="text-slate-800 antialiased flex flex-col min-h-screen">

                <!-- Header -->
                <header class="bg-white sticky top-0 z-50 border-b border-primary/10">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex items-center justify-between">
                        <a href="${pageContext.request.contextPath}/"
                            class="flex items-center gap-2 text-decoration-none">
                            <div class="bg-primary p-1.5 rounded-lg text-white">
                                <span class="material-symbols-outlined text-3xl">agriculture</span>
                            </div>
                            <h1 class="text-2xl font-black tracking-tight text-slate-900 m-0">Nông Sản Việt</h1>
                        </a>

                        <div class="hidden md:flex flex-1 max-w-md mx-8">
                            <div class="relative w-full">
                                <span
                                    class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                                <input
                                    class="w-full bg-slate-100 border-none rounded-lg py-2.5 pl-10 pr-4 focus:ring-2 focus:ring-primary/50 text-sm"
                                    placeholder="Tìm kiếm sản phẩm..." type="text" />
                            </div>
                        </div>

                        <nav class="hidden lg:flex items-center gap-8 font-semibold text-sm text-slate-600 mr-8">
                            <a href="${pageContext.request.contextPath}/" class="text-slate-900">Trang chủ</a>
                            <a href="#" class="hover:text-primary">Sản phẩm</a>
                            <a href="#" class="hover:text-primary">Khuyến mãi</a>
                            <a href="#" class="hover:text-primary">Liên hệ</a>
                        </nav>

                        <div class="flex items-center gap-3">
                            <a href="${pageContext.request.contextPath}/cart"
                                class="relative p-2 bg-primary/10 text-primary rounded-lg hover:bg-primary/20 transition-colors flex items-center justify-center">
                                <span class="material-symbols-outlined">shopping_cart</span>
                                <c:if test="${sessionScope.cartCount > 0}">
                                    <span
                                        class="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full z-50">
                                        ${sessionScope.cartCount}
                                    </span>
                                </c:if>
                            </a>
                            <c:choose>
                                <c:when test="${not empty sessionScope.account}">
                                    <a href="logout"
                                        class="p-2 bg-slate-100 text-slate-600 rounded-lg hover:bg-slate-200"
                                        title="Đăng xuất">
                                        <span class="material-symbols-outlined">logout</span>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="login"
                                        class="p-2 bg-slate-100 text-slate-600 rounded-lg hover:bg-slate-200">
                                        <span class="material-symbols-outlined">person</span>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </header>

                <main class="flex-grow max-w-[1200px] mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 tracking-tight">
                    <!-- Breadcrumb -->
                    <div class="text-sm font-medium text-slate-500 mb-6 flex gap-2 items-center tracking-normal">
                        <a href="${pageContext.request.contextPath}/" class="hover:text-primary">Trang chủ</a>
                        <span class="text-slate-400">/</span>
                        <span class="text-primary font-bold">Giỏ hàng</span>
                    </div>

                    <h1 class="text-3xl lg:text-4xl font-black text-slate-900 mb-10 tracking-tight">Giỏ hàng của bạn
                    </h1>

                    <c:if test="${empty cartItems}">
                        <div class="bg-white p-12 rounded-2xl shadow-sm border border-slate-100/50 text-center">
                            <span
                                class="material-symbols-outlined text-6xl text-slate-300 mb-4 block">remove_shopping_cart</span>
                            <p class="text-xl font-bold text-slate-500 mb-6">Chưa có sản phẩm nào trong giỏ hàng</p>
                            <a href="${pageContext.request.contextPath}/"
                                class="inline-block bg-primary text-white font-bold py-3 px-8 rounded-lg hover:bg-primary/90 transition-colors shadow-md shadow-primary/20">Tiếp
                                tục mua sắm</a>
                        </div>
                    </c:if>

                    <c:if test="${not empty cartItems}">
                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">

                            <!-- Left Column: Cart Items -->
                            <div
                                class="lg:col-span-2 bg-white rounded-2xl shadow-[0_2px_15px_-3px_rgba(0,0,0,0.07),0_10px_20px_-2px_rgba(0,0,0,0.04)] overflow-hidden border border-slate-100/50">
                                <!-- Table Header -->
                                <div
                                    class="hidden md:grid grid-cols-12 gap-4 px-8 py-5 bg-[#fafff9]/40 border-b border-primary/10 text-[13px] font-bold text-slate-700 uppercase tracking-widest">
                                    <div class="col-span-5">Sản phẩm</div>
                                    <div class="col-span-2 text-center">Đơn giá</div>
                                    <div class="col-span-2 text-center">Số lượng</div>
                                    <div class="col-span-2 text-center">Thành tiền</div>
                                    <div class="col-span-1 text-center">Xóa</div>
                                </div>

                                <!-- Items List -->
                                <div class="divide-y divide-slate-100 px-8">
                                    <c:set var="totalPrice" value="0" />
                                    <c:forEach items="${cartItems}" var="item">
                                        <c:set var="itemTotal" value="${item.product.price * item.quantity}" />
                                        <c:set var="totalPrice" value="${totalPrice + itemTotal}" />

                                        <div class="grid grid-cols-1 md:grid-cols-12 gap-6 py-6 items-center">
                                            <!-- Product Info -->
                                            <div class="col-span-1 md:col-span-5 flex gap-4 items-center">
                                                <c:set var="bgUrl"
                                                    value="https://lh3.googleusercontent.com/aida-public/AB6AXuAYgMI6058HEQ8ei2U8k85Tcd5_FbMxhRLChVKrL_bk8JVIVrEvhCoQmn5CO93GRDDZ0GcpHwAVvGT57JIfbdBRFQ4pFS6AXSGHtNnjxBOlTdo_Nt0ttrICWS765yYVLS-o1ZO6gi-1eJlX5F3gM57QMSyH8EFWsNaa5P8Mwzn3bkzd9mQvB6IXs1Ph75TfN50JEzktPMt89cyY-TVdZzo6ZSOWTjXiQ1y6ZlwTt3l4V-L8HjEIotIgfpDR_IdmjT0BXTX2SShmXj_1" />
                                                <c:if
                                                    test="${item.product.description != null && item.product.description.startsWith('http')}">
                                                    <c:set var="bgUrl" value="${item.product.description}" />
                                                </c:if>
                                                <div class="w-20 h-20 rounded-xl bg-slate-100 bg-cover bg-center flex-shrink-0 shadow-sm border border-slate-100"
                                                    style="background-image: url('${bgUrl}')"></div>
                                                <div>
                                                    <h3
                                                        class="font-bold text-slate-800 text-[15px] leading-tight mb-1.5">
                                                        ${item.product.name}</h3>
                                                    <p
                                                        class="text-[11px] text-slate-400 uppercase tracking-widest font-semibold">
                                                        <c:choose>
                                                            <c:when test="${item.product.quantity > 0}">Có sẵn - Đạt
                                                                chuẩn</c:when>
                                                            <c:otherwise>Hết hàng</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>

                                            <!-- Unit Price -->
                                            <div class="col-span-1 md:col-span-2 text-center">
                                                <span class="md:hidden text-slate-500 text-sm font-semibold">Đơn giá:
                                                </span>
                                                <span class="font-semibold text-slate-700 text-[15px]">
                                                    <fmt:formatNumber value="${item.product.price}" type="number"
                                                        groupingUsed="true" />đ
                                                </span>
                                            </div>

                                            <!-- Quantity -->
                                            <div class="col-span-1 md:col-span-2 flex justify-center">
                                                <form action="cart" method="post"
                                                    class="flex items-center gap-1 bg-white border shadow-sm border-slate-200 rounded-full px-1 py-1">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="itemId" value="${item.id}">
                                                    <button type="submit" name="quantity" value="${item.quantity - 1}"
                                                        class="w-7 h-7 flex items-center justify-center rounded-full text-slate-500 hover:bg-slate-100 hover:text-slate-900 transition-colors">
                                                        <span
                                                            class="material-symbols-outlined text-[15px]">remove</span>
                                                    </button>
                                                    <span
                                                        class="font-bold text-sm w-6 text-center text-slate-900">${item.quantity}</span>
                                                    <button type="submit" name="quantity" value="${item.quantity + 1}"
                                                        class="w-7 h-7 flex items-center justify-center rounded-full text-slate-500 hover:bg-slate-100 hover:text-slate-900 transition-colors">
                                                        <span class="material-symbols-outlined text-[15px]">add</span>
                                                    </button>
                                                </form>
                                            </div>

                                            <!-- Total Price -->
                                            <div class="col-span-1 md:col-span-2 text-center md:text-center">
                                                <span class="md:hidden text-slate-500 text-sm font-semibold">Thành tiền:
                                                </span>
                                                <span class="font-bold text-primary text-base">
                                                    <fmt:formatNumber value="${itemTotal}" type="number"
                                                        groupingUsed="true" />đ
                                                </span>
                                            </div>

                                            <!-- Delete -->
                                            <div class="col-span-1 md:col-span-1 text-center flex justify-center">
                                                <form action="cart" method="post">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="itemId" value="${item.id}">
                                                    <button type="submit"
                                                        class="text-slate-400 hover:text-slate-700 hover:bg-slate-100 rounded-lg transition-colors p-2 flex items-center justify-center">
                                                        <span
                                                            class="material-symbols-outlined text-[22px]">delete</span>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Left Column Footer -->
                                <div
                                    class="bg-slate-50/70 py-4 px-8 flex flex-col sm:flex-row justify-between items-center gap-4 text-[14px] font-bold border-t border-slate-100">
                                    <a href="${pageContext.request.contextPath}/"
                                        class="text-primary hover:text-primary/80 flex items-center gap-2 transition-colors py-2">
                                        <span class="material-symbols-outlined text-[18px]">arrow_back</span>
                                        Tiếp tục mua sắm
                                    </a>
                                    <span
                                        class="text-slate-500 flex items-center gap-2 cursor-pointer hover:text-slate-800 transition-colors py-2"
                                        onclick="location.reload()">
                                        <span class="material-symbols-outlined text-[18px]">refresh</span> Cập nhật giỏ
                                        hàng
                                    </span>
                                </div>
                            </div>

                            <!-- Right Column: Summary -->
                            <div class="lg:col-span-1">
                                <div
                                    class="bg-white rounded-2xl shadow-[0_2px_15px_-3px_rgba(0,0,0,0.07),0_10px_20px_-2px_rgba(0,0,0,0.04)] p-8 sticky top-28 border border-slate-100/50">
                                    <h2 class="text-lg font-black text-slate-900 mb-6">Tóm tắt đơn hàng</h2>

                                    <c:set var="shippingFee" value="15000" />
                                    <c:set var="vatAmount" value="${totalPrice * 0.08}" />
                                    <c:set var="finalTotal" value="${totalPrice + shippingFee + vatAmount}" />

                                    <div class="space-y-4 text-sm mb-6 pb-6 border-b border-primary/10">
                                        <div class="flex justify-between items-center text-slate-500 font-medium">
                                            <span>Tạm tính (
                                                <c:out value="${cartItems.size()}" /> sản phẩm)
                                            </span>
                                            <span class="font-bold text-slate-800 text-[15px]">
                                                <fmt:formatNumber value="${totalPrice}" type="number"
                                                    groupingUsed="true" />đ
                                            </span>
                                        </div>
                                        <div class="flex justify-between items-center text-slate-500 font-medium">
                                            <span>Phí vận chuyển</span>
                                            <span class="font-bold text-slate-800 text-[15px]">
                                                <fmt:formatNumber value="${shippingFee}" type="number"
                                                    groupingUsed="true" />đ
                                            </span>
                                        </div>
                                        <div class="flex justify-between items-center text-slate-500 font-medium">
                                            <span>Thuế (VAT 8%)</span>
                                            <span class="font-bold text-slate-800 text-[15px]">
                                                <fmt:formatNumber value="${vatAmount}" type="number"
                                                    groupingUsed="true" />đ
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Discount Code -->
                                    <div class="mb-6 relative">
                                        <div
                                            class="flex bg-[#fafff9] rounded-xl border border-primary/20 p-1.5 items-center border-dashed">
                                            <span class="material-symbols-outlined text-primary ml-2 mr-1">sell</span>
                                            <input type="text" placeholder="Mã giảm giá"
                                                class="flex-1 bg-transparent border-none text-sm font-medium focus:ring-0 placeholder-slate-400 py-2">
                                            <button class="text-primary font-bold text-[13px] px-3 hover:underline">Áp
                                                dụng</button>
                                        </div>
                                    </div>

                                    <div class="flex justify-between items-end mb-6">
                                        <span class="text-lg font-black text-slate-900">Tổng cộng</span>
                                        <span class="text-[26px] leading-none font-black text-primary">
                                            <fmt:formatNumber value="${finalTotal}" type="number" groupingUsed="true" />
                                            đ
                                        </span>
                                    </div>

                                    <a href="checkout"
                                        class="w-full bg-[#4cae4f] hover:bg-[#439e46] text-white font-bold py-4 rounded-xl flex items-center justify-center gap-2 transition-transform active:scale-95 text-base no-underline">
                                        Thanh toán ngay
                                        <span class="material-symbols-outlined text-xl">arrow_forward</span>
                                    </a>

                                    <!-- Trust Badges -->
                                    <div class="mt-8 space-y-4">
                                        <div class="flex items-start gap-3 text-[13px] text-slate-500 font-medium">
                                            <span
                                                class="material-symbols-outlined text-slate-700 text-[18px]">verified_user</span>
                                            <span>Giao hàng nhanh trong 2h tại TP.HCM & Hà Nội</span>
                                        </div>
                                        <div class="flex items-start gap-3 text-[13px] text-slate-500 font-medium">
                                            <span
                                                class="material-symbols-outlined text-slate-700 text-[18px]">verified</span>
                                            <span>Sản phẩm đạt chuẩn hữu cơ quốc tế</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </main>

                <!-- Footer -->
                <footer class="bg-white border-t border-slate-100 mt-12 py-16">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-12 lg:gap-8">
                            <div class="col-span-1">
                                <div class="flex items-center gap-2 mb-6">
                                    <div class="bg-primary p-2 rounded-xl text-white">
                                        <span class="material-symbols-outlined text-2xl">agriculture</span>
                                    </div>
                                    <h2 class="text-xl font-black text-slate-900">Nông Sản Việt</h2>
                                </div>
                                <p class="text-[14px] text-slate-500 leading-relaxed font-medium">Kết nối người nông dân
                                    Việt với người tiêu dùng qua những sản phẩm nông nghiệp sạch, chất lượng và an toàn.
                                </p>
                            </div>

                            <div class="col-span-1">
                                <h3 class="font-bold text-slate-900 mb-6 text-[15px]">Sản phẩm</h3>
                                <ul class="text-[14px] text-slate-500 space-y-3 font-medium">
                                    <li><a href="#" class="hover:text-primary transition-colors">Rau củ hữu cơ</a></li>
                                    <li><a href="#" class="hover:text-primary transition-colors">Trái cây đặc sản</a>
                                    </li>
                                    <li><a href="#" class="hover:text-primary transition-colors">Gia vị thực phẩm</a>
                                    </li>
                                    <li><a href="#" class="hover:text-primary transition-colors">Hạt dinh dưỡng</a></li>
                                </ul>
                            </div>
                            <div class="col-span-1">
                                <h3 class="font-bold text-slate-900 mb-6 text-[15px]">Chính sách</h3>
                                <ul class="text-[14px] text-slate-500 space-y-3 font-medium">
                                    <li><a href="#" class="hover:text-primary transition-colors">Giao hàng & Nhận
                                            hàng</a></li>
                                    <li><a href="#" class="hover:text-primary transition-colors">Chính sách đổi trả</a>
                                    </li>
                                    <li><a href="#" class="hover:text-primary transition-colors">Bảo mật thông tin</a>
                                    </li>
                                    <li><a href="#" class="hover:text-primary transition-colors">Điều khoản dịch vụ</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-span-1">
                                <h3 class="font-bold text-slate-900 mb-6 text-[15px]">Liên hệ</h3>
                                <ul class="text-[14px] text-slate-500 space-y-3 font-medium">
                                    <li class="flex items-center gap-3"><span
                                            class="material-symbols-outlined text-slate-400 text-[18px]">call</span>
                                        1900 1234</li>
                                    <li class="flex items-center gap-3"><span
                                            class="material-symbols-outlined text-slate-400 text-[18px]">mail</span>
                                        contact@nongsanviet.vn</li>
                                    <li class="flex items-center gap-3"><span
                                            class="material-symbols-outlined text-slate-400 text-[18px]">location_on</span>
                                        Quận 1, TP. Hồ Chí Minh</li>
                                </ul>
                            </div>
                        </div>
                        <div
                            class="border-t border-slate-100 mt-12 pt-8 text-center text-[13px] font-medium text-slate-400">
                            © 2024 Nông Sản Việt. Tất cả quyền được bảo lưu.
                        </div>
                    </div>
                </footer>

                <jsp:include page="WEB-INF/views/chat-widget.jsp" />
            </body>

            </html>