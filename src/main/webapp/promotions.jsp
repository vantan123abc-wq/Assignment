<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />

                <title>Sản Phẩm Khuyến Mãi - Nông Sản Việt</title>

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
                                fontFamily: { "display": ["Inter"] }
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

                <!-- Header -->
                <header
                    class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="flex items-center justify-between h-20">

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
                                <a class="font-medium hover:text-primary transition-colors"
                                    href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
                                <a class="font-medium text-primary border-b-2 border-primary"
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
                                    <a href="${pageContext.request.contextPath}/cart"
                                        class="relative z-50 p-2.5 flex items-center justify-center rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                                        <span class="material-symbols-outlined">shopping_cart</span>
                                        <c:if test="${sessionScope.cartCount > 0}">
                                            <span
                                                class="absolute top-1 right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full z-50 pointer-events-none">${sessionScope.cartCount}</span>
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

                    <!-- Title Section -->
                    <section>
                        <div class="flex items-center justify-between mb-8">
                            <h2 class="text-3xl font-black text-red-600 flex items-center gap-3">
                                <span class="material-symbols-outlined text-4xl">local_fire_department</span>
                                Siêu Ưu Đãi Hôm Nay
                            </h2>
                        </div>
                        <p class="text-slate-500 max-w-2xl mb-12">Khám phá ngay các nông sản sạch đang được giảm giá cực
                            sốc. Cơ hội tuyệt vời để sở hữu những sản phẩm chất lượng với mức giá tiết kiệm!</p>
                    </section>

                    <!-- Product Grid -->
                    <section>
                        <c:choose>
                            <c:when test="${empty saleProducts}">
                                <div
                                    class="text-center py-20 bg-white dark:bg-slate-900 rounded-3xl border border-slate-100 dark:border-slate-800">
                                    <span
                                        class="material-symbols-outlined text-6xl text-slate-300 mb-4">sentiment_dissatisfied</span>
                                    <h3 class="text-xl font-bold text-slate-700 dark:text-slate-300">Không có sản phẩm
                                        khuyến mãi</h3>
                                    <p class="text-slate-500 mt-2">Hiện tại không có chương trình khuyến mãi nào. Vui
                                        lòng quay lại sau!</p>
                                    <a href="shop"
                                        class="inline-block mt-6 px-6 py-3 bg-primary text-white rounded-xl font-medium hover:bg-primary/90 transition-colors">Xem
                                        toàn bộ sản phẩm</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                                    <c:forEach items="${saleProducts}" var="p">
                                        <!-- Product Card -->
                                        <div
                                            class="bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl p-4 group transition-shadow hover:shadow-xl flex flex-col justify-between relative overflow-hidden">
                                            <!-- Discount Badge -->
                                            <div
                                                class="absolute top-6 left-6 z-10 bg-red-600 text-white font-black text-sm px-3 py-1 rounded-full shadow-lg shadow-red-500/40">
                                                -${p.discountPercent}%
                                            </div>

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
                                                    <span
                                                        class="text-xs text-red-500 font-bold uppercase tracking-wider">Sale
                                                        Khủng</span>
                                                    <h4 class="font-bold text-lg leading-tight line-clamp-2"
                                                        title="${p.name}">${p.name}</h4>
                                                </div>
                                            </div>
                                            <div class="mt-4 flex items-end justify-between">
                                                <div class="flex flex-col">
                                                    <span
                                                        class="text-sm text-slate-400 line-through decoration-red-400 font-medium">
                                                        <fmt:formatNumber value="${p.price}" type="number"
                                                            groupingUsed="true" />₫
                                                    </span>
                                                    <span class="text-red-600 font-black text-2xl whitespace-nowrap">
                                                        <fmt:formatNumber value="${p.salePrice}" type="number"
                                                            groupingUsed="true" />₫
                                                    </span>
                                                </div>
                                                <form action="cart" method="post" class="m-0">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="productId" value="${p.id}">
                                                    <button type="submit"
                                                        class="bg-red-600 text-white size-12 rounded-xl flex items-center justify-center shadow-lg shadow-red-600/30 transition-transform active:scale-95 border-0 cursor-pointer hover:bg-red-700">
                                                        <span class="material-symbols-outlined">add_shopping_cart</span>
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

                <!-- Chat Widget AI -->
                <jsp:include page="WEB-INF/views/chat-widget.jsp" />
            </body>

            </html>