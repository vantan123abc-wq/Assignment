<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />

                <title>Cửa Hàng - Nông Sản Việt</title>

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
                                    "background-light": "#f6f7f6",
                                    "background-dark": "#151d15",
                                },
                                fontFamily: { "display": ["Inter"] },
                                borderRadius: {
                                    "DEFAULT": "0.25rem",
                                    "lg": "0.5rem",
                                    "xl": "0.75rem",
                                    "full": "9999px"
                                },
                            },
                        },
                    }
                </script>

                <style>
                    body {
                        font-family: 'Inter', sans-serif;
                    }

                    .material-symbols-outlined {
                        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    }
                </style>
            </head>

            <body
                class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 flex flex-col min-h-screen">

                <!-- Top Navigation Bar -->
                <header
                    class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="flex items-center justify-between h-20">

                            <!-- Logo -->
                            <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2 block">
                                <div class="bg-primary p-1.5 rounded-lg text-white">
                                    <span class="material-symbols-outlined text-3xl">agriculture</span>
                                </div>
                                <h1 class="text-2xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
                            </a>

                            <!-- Desktop Nav Links -->
                            <nav class="hidden md:flex items-center gap-8">
                                <a class="font-medium hover:text-primary transition-colors"
                                    href="${pageContext.request.contextPath}/index">Trang chủ</a>
                                <a class="font-medium text-primary border-b-2 border-primary"
                                    href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
                                <a class="font-medium hover:text-primary transition-colors"
                                    href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a>
                                <a class="font-medium hover:text-primary transition-colors" href="#">Về chúng tôi</a>
                            </nav>

                            <!-- Search & Actions -->
                            <div class="flex items-center gap-4 flex-1 max-w-md ml-8">
                                <div class="relative w-full">
                                    <span
                                        class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                                    <input
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-full py-2.5 pl-10 pr-4 focus:ring-2 focus:ring-primary/50 text-sm"
                                        placeholder="Tìm kiếm nông sản..." type="text" />
                                </div>

                                <div class="flex items-center gap-2">
                                    <button
                                        class="p-2.5 rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                                        <span class="material-symbols-outlined">favorite</span>
                                    </button>

                                    <a href="${pageContext.request.contextPath}/cart"
                                        class="relative z-50 p-2.5 flex items-center justify-center rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                                        <span class="material-symbols-outlined">shopping_cart</span>
                                        <c:if test="${sessionScope.cartCount > 0}">
                                            <span
                                                class="absolute top-1 right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full z-50 pointer-events-none">
                                                ${sessionScope.cartCount}
                                            </span>
                                        </c:if>
                                    </a>

                                    <c:choose>
                                        <c:when test="${not empty sessionScope.account}">
                                            <a href="logout" title="Đăng xuất"
                                                class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-red-50 text-red-600 font-semibold text-sm hover:bg-red-100 transition-colors">
                                                <div
                                                    class="size-8 rounded-full bg-red-500 text-white flex items-center justify-center">
                                                    <span class="material-symbols-outlined text-xl">logout</span>
                                                </div>
                                                <span>${sessionScope.account.username} (Thoát)</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="login"
                                                class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                                                <div
                                                    class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                                    <span class="material-symbols-outlined text-xl">person</span>
                                                </div>
                                                <span>Đăng nhập</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>

                <main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-12">

                    <!-- Category Filter Bar -->
                    <section>
                        <div class="flex items-center justify-between mb-8">
                            <h2 class="text-3xl font-black">Cửa Hàng Nông Sản</h2>
                        </div>

                        <div class="flex gap-4 overflow-x-auto pb-4 mb-4">
                            <a href="shop"
                                class="whitespace-nowrap px-6 py-2.5 rounded-full font-medium transition-colors border ${empty selectedCatId ? 'bg-primary text-white border-primary' : 'bg-white text-slate-700 border-slate-200 hover:border-primary/50'}">
                                Tất cả sản phẩm
                            </a>
                            <c:forEach items="${categories}" var="c">
                                <a href="shop?catId=${c.id}"
                                    class="whitespace-nowrap px-6 py-2.5 rounded-full font-medium transition-colors border ${selectedCatId == c.id ? 'bg-primary text-white border-primary' : 'bg-white text-slate-700 border-slate-200 hover:border-primary/50'}">
                                    ${c.name}
                                </a>
                            </c:forEach>
                        </div>
                    </section>

                    <!-- Product Grid -->
                    <section>
                        <c:choose>
                            <c:when test="${empty products}">
                                <div
                                    class="text-center py-20 bg-white dark:bg-slate-900 rounded-3xl border border-slate-100 dark:border-slate-800">
                                    <span
                                        class="material-symbols-outlined text-6xl text-slate-300 mb-4">sentiment_dissatisfied</span>
                                    <h3 class="text-xl font-bold text-slate-700 dark:text-slate-300">Không có sản phẩm
                                        nào</h3>
                                    <p class="text-slate-500 mt-2">Hiện tại danh mục này đang trống hoặc đã hết hàng.
                                    </p>
                                    <a href="shop"
                                        class="inline-block mt-6 px-6 py-3 bg-primary text-white rounded-xl font-medium hover:bg-primary/90 transition-colors">Xem
                                        tất cả sản phẩm</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                                    <c:forEach items="${products}" var="p">
                                        <!-- Product Card -->
                                        <div
                                            class="bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl p-4 group transition-shadow hover:shadow-xl flex flex-col justify-between relative overflow-hidden">

                                            <c:if test="${p.discountPercent != null && p.discountPercent > 0}">
                                                <div
                                                    class="absolute top-6 left-6 z-10 bg-red-600 text-white font-black text-xs px-2 py-1 rounded-md shadow-sm">
                                                    -${p.discountPercent}%
                                                </div>
                                            </c:if>

                                            <div>
                                                <div
                                                    class="relative aspect-square rounded-xl overflow-hidden mb-4 bg-slate-50 dark:bg-slate-800 flex items-center justify-center">
                                                    <c:set var="bgUrl"
                                                        value="https://lh3.googleusercontent.com/aida-public/AB6AXuCWMTUSM5YLbmU3839QK5MPC4diZv1ZkSTdVRtphTM3BFW6sNhuJl9N1zIhhXQW4c9zjx3FhXTXyoaN57eMPMkm27xx9RZ6m1VwpExhjlNfrWuFq684btGItwspjzKBGUdKcEpVVDwFtjcd4XmVLoeTGv0E7_sKm2vfCzLltuMTeo8RGiUMSGx_NqVw15v5njILT1lG2n7UGMglN1jV4xO9Agy8vG02k5eNTaFX3-HvwJ6V64F71R24Kb0mjAXGhhcn2wKli20G19sP" />
                                                    <c:if
                                                        test="${p.description != null && p.description.startsWith('http')}">
                                                        <c:set var="bgUrl" value="${p.description}" />
                                                    </c:if>
                                                    <div class="w-full h-full bg-center bg-cover bg-no-repeat transition-transform group-hover:scale-105"
                                                        style="background-image: url('${bgUrl}');"></div>
                                                    <c:if
                                                        test="${p.description == null || !p.description.startsWith('http')}">
                                                        <span
                                                            class="material-symbols-outlined absolute text-slate-300 opacity-50 text-5xl">inventory_2</span>
                                                    </c:if>
                                                </div>
                                                <div class="space-y-1">
                                                    <span class="text-xs text-primary font-bold uppercase">Sản
                                                        phẩm</span>
                                                    <h4 class="font-bold text-lg leading-tight line-clamp-2"
                                                        title="${p.name}">${p.name}</h4>
                                                    <p class="text-xs text-slate-500 line-clamp-2"
                                                        title="${p.description}">${p.description}</p>
                                                </div>
                                            </div>
                                            <div class="mt-4 flex items-center justify-between">
                                                <div class="flex flex-col">
                                                    <c:choose>
                                                        <c:when
                                                            test="${p.discountPercent != null && p.discountPercent > 0}">
                                                            <div class="flex items-end gap-2">
                                                                <span
                                                                    class="text-red-500 font-black text-xl whitespace-nowrap">
                                                                    <fmt:formatNumber value="${p.salePrice}"
                                                                        type="number" groupingUsed="true" />₫
                                                                </span>
                                                                <span class="text-xs text-slate-400 line-through mb-1">
                                                                    <fmt:formatNumber value="${p.price}" type="number"
                                                                        groupingUsed="true" />₫
                                                                </span>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="text-primary font-black text-xl whitespace-nowrap">
                                                                <fmt:formatNumber value="${p.price}" type="number"
                                                                    groupingUsed="true" />₫
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="text-xs text-slate-400">Tồn kho: ${p.quantity}</span>
                                                </div>
                                                <form action="cart" method="post" class="m-0">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="productId" value="${p.id}">
                                                    <button type="submit"
                                                        class="bg-primary text-white size-10 rounded-xl flex items-center justify-center shadow-lg shadow-primary/30 transition-transform active:scale-90 border-0 cursor-pointer hover:bg-primary/90">
                                                        <span class="material-symbols-outlined">add</span>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </section>

                </main>

                <!-- Footer -->
                <footer
                    class="bg-white dark:bg-slate-950 border-t border-slate-100 dark:border-slate-800 pt-20 pb-10 mt-auto">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-16">
                            <!-- Branding -->
                            <div class="space-y-6">
                                <div class="flex items-center gap-2">
                                    <div class="bg-primary p-1.5 rounded-lg text-white">
                                        <span class="material-symbols-outlined text-2xl">agriculture</span>
                                    </div>
                                    <h1 class="text-xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
                                </div>
                                <p class="text-slate-500 text-sm leading-relaxed">
                                    Tự hào là đơn vị cung ứng nông sản sạch hàng đầu Việt Nam. Chúng tôi cam kết chất
                                    lượng trên từng sản phẩm.
                                </p>
                                <div class="flex gap-4">
                                    <a class="size-10 rounded-full bg-primary/10 text-primary flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                                        href="#"><span class="material-symbols-outlined text-xl">share</span></a>
                                    <a class="size-10 rounded-full bg-primary/10 text-primary flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                                        href="#"><span class="material-symbols-outlined text-xl">groups</span></a>
                                    <a class="size-10 rounded-full bg-primary/10 text-primary flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                                        href="#"><span class="material-symbols-outlined text-xl">public</span></a>
                                </div>
                            </div>

                            <!-- Quick Links -->
                            <div>
                                <h4 class="font-bold text-slate-900 dark:text-white mb-6">Liên Kết Nhanh</h4>
                                <ul class="space-y-4 text-sm text-slate-500">
                                    <li><a class="hover:text-primary transition-colors" href="#">Về chúng tôi</a></li>
                                    <li><a class="hover:text-primary transition-colors" href="#">Hệ thống cửa hàng</a>
                                    </li>
                                    <li><a class="hover:text-primary transition-colors" href="#">Tuyển dụng</a></li>
                                    <li><a class="hover:text-primary transition-colors" href="#">Liên hệ</a></li>
                                </ul>
                            </div>

                            <!-- Customer Support -->
                            <div>
                                <h4 class="font-bold text-slate-900 dark:text-white mb-6">Hỗ Trợ Khách Hàng</h4>
                                <ul class="space-y-4 text-sm text-slate-500">
                                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách giao
                                            hàng</a></li>
                                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách đổi trả</a>
                                    </li>
                                    <li><a class="hover:text-primary transition-colors" href="#">Hướng dẫn mua hàng</a>
                                    </li>
                                    <li><a class="hover:text-primary transition-colors" href="#">Câu hỏi thường gặp</a>
                                    </li>
                                </ul>
                            </div>

                            <!-- Contact Info -->
                            <div>
                                <h4 class="font-bold text-slate-900 dark:text-white mb-6">Thông Tin Liên Hệ</h4>
                                <ul class="space-y-4 text-sm text-slate-500">
                                    <li class="flex items-start gap-3">
                                        <span class="material-symbols-outlined text-primary text-xl">location_on</span>
                                        <span>123 Đường Nông Nghiệp, Quận Cầu Giấy, Hà Nội</span>
                                    </li>
                                    <li class="flex items-center gap-3">
                                        <span class="material-symbols-outlined text-primary text-xl">phone</span>
                                        <span>1900 6789 (Hỗ trợ 24/7)</span>
                                    </li>
                                    <li class="flex items-center gap-3">
                                        <span class="material-symbols-outlined text-primary text-xl">mail</span>
                                        <span>lienhe@nongsanviet.vn</span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div
                            class="border-t border-slate-100 dark:border-slate-800 pt-8 flex flex-col md:flex-row items-center justify-between gap-4">
                            <p class="text-slate-400 text-xs text-center md:text-left">
                                © 2024 Nông Sản Việt. Tất cả quyền được bảo lưu. MSDN: 0123456789 được cấp bởi Sở KH&ĐT
                                Hà Nội.
                            </p>
                            <div class="flex items-center gap-6">
                                <img alt="Visa"
                                    class="h-6 opacity-50 grayscale hover:grayscale-0 transition-all cursor-pointer"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBLt976I4iDYE0wo91SHnXKSzUaqT_iJ3eQ0RU_dS5pZsE8Quiiy6yyUT2lafuBMgt74A3OZTCwZ1lf7V1tqJ3I_-ozarDzOevbbmoLu-awf_duyjHv94__dNsBKuIHM6lSAzUhJQr58ApQA_fryFYbskYtVzCZ0m_AWHOgZnFHXEW7XdxFliQwAk3j17p_c7_9dSJuK1X8-fWn28evWRgIh2YQiyrsqUuwve7GynUNbzEqgYLeNqNNkQ8BGJNLRr874MjUY2yeNW_P" />
                                <img alt="Mastercard"
                                    class="h-6 opacity-50 grayscale hover:grayscale-0 transition-all cursor-pointer"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAjGLXz8ChF_tOz8zZfnlrz9UnfB8Yty926eFm_M2HfL0Rx0tLZCVvY5vnvYZVk4YF0IwOCG--70oGw7ImhUYR5ZaVOfl9FwoU5KNQx3so5qn05YIfY6JQFOVWto3QTthM9UzFb23cTe6DL4CRy9IYxCBl0djLGlHT2GtBRFQbrFBKjQoIYdnoe1ICsGakMRar1k9Z30c58Xs2qiZ3Cmqn2FYWKrKkpLEV8oEtc_Gxvkuwvy6sy04Q2xzNVcewjvA9TVR0dza6NIAZL" />
                                <img alt="Paypal"
                                    class="h-6 opacity-50 grayscale hover:grayscale-0 transition-all cursor-pointer"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBlDlMwCJS798KjMoN2S7ziuGmRPKVCSwM-BmV7GxKq1sVhBag_MoTY4WC6XNgDOKXKdN2ZjwOW7OQ0axedajkDaaO92vUm-3uIkV3-S4K5tfzHCCLG3cduK4rMiHAqBCxX2DwhEnLVQrUs_uG1XAXPZdOTLr-tQKVrVph3KJlOCnULsac6HhMQUtJ3KSBZDnB1e-PHR6JSjW-qhD6PeE5ZuLLXAC4BP1IoQnj3pENXeKmUteX1m_YVtSEnKjG8c4_jyF5Cay_o0qU9" />
                            </div>
                        </div>
                    </div>
                </footer>

                <!-- Chat Widget AI -->
                <jsp:include page="WEB-INF/views/chat-widget.jsp" />
            </body>

            </html>