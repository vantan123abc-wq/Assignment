<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8" />
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

                    <title>Nông Sản Việt - Fresh from Farm to Table</title>

                    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
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
                                        "background-dark": "#151d15"
                                    },
                                    fontFamily: { "display": ["Inter"] },
                                    borderRadius: {
                                        "DEFAULT": "0.25rem",
                                        "lg": "0.5rem",
                                        "xl": "0.75rem",
                                        "full": "9999px"
                                    }
                                }
                            }
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

                <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">

                    <!-- Top Navigation Bar -->
                    <header
                        class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="flex items-center justify-between h-20">

                                <!-- Logo -->
                                <div class="flex items-center gap-2">
                                    <div class="bg-primary p-1.5 rounded-lg text-white">
                                        <span class="material-symbols-outlined text-3xl">agriculture</span>
                                    </div>
                                    <h1 class="text-2xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
                                </div>

                                <!-- Desktop Nav Links -->
                                <nav class="hidden md:flex items-center gap-8">
                                    <a class="font-medium text-primary border-b-2 border-primary" href="#">Trang chủ</a>
                                    <a class="font-medium hover:text-primary transition-colors"
                                        href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
                                    <a class="font-medium hover:text-primary transition-colors"
                                        href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a>
                                    <a class="font-medium hover:text-primary transition-colors"
                                        href="${pageContext.request.contextPath}/about">Về chúng tôi</a>
                                </nav>

                                <!-- Search & Actions -->
                                <div class="flex items-center gap-4 flex-1 max-w-md ml-8">
                                    <form action="${pageContext.request.contextPath}/shop" method="GET"
                                        class="relative w-full group">
                                        <span
                                            class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                                        <input id="searchInput" name="keyword"
                                            class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-full py-2.5 pl-10 pr-4 focus:ring-2 focus:ring-primary/50 text-sm"
                                            placeholder="Tìm kiếm nông sản..." type="text" autocomplete="off" />
                                        <!-- Search Suggestions Dropdown -->
                                        <div id="searchResults"
                                            class="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl shadow-2xl overflow-hidden z-[100] hidden flex-col max-h-96 overflow-y-auto">
                                            <!-- results injected via js -->
                                        </div>
                                    </form>

                                    <div class="flex items-center gap-2">
                                        <button
                                            class="p-2.5 rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                                            <span class="material-symbols-outlined">favorite</span>
                                        </button>

                                        <%-- Notification Bell Widget (User only) --%>
                                            <jsp:include page="WEB-INF/views/notification-bell.jsp" />


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
                                                    <div class="relative group ml-2">
                                                        <a href="#"
                                                            class="flex items-center gap-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                                                            <div
                                                                class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                                                <span
                                                                    class="material-symbols-outlined text-xl">person</span>
                                                            </div>
                                                            <span>${sessionScope.account.username}</span>
                                                        </a>

                                                        <!-- Dropdown User Menu -->
                                                        <div
                                                            class="absolute right-0 top-full mt-2 w-48 bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl shadow-xl overflow-hidden z-[100] opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                                                            <a href="${pageContext.request.contextPath}/order-history"
                                                                class="block px-4 py-3 text-sm text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 font-medium transition-colors border-b border-slate-50 dark:border-slate-800 flex items-center gap-2">
                                                                <span
                                                                    class="material-symbols-outlined text-[18px]">receipt_long</span>
                                                                Lịch sử đơn hàng
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/logout"
                                                                class="block px-4 py-3 text-sm text-red-600 hover:bg-red-50 dark:hover:bg-red-900/10 font-medium transition-colors flex items-center gap-2">
                                                                <span
                                                                    class="material-symbols-outlined text-[18px]">logout</span>
                                                                Đăng xuất
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="login"
                                                        class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                                                        <div
                                                            class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                                            <span
                                                                class="material-symbols-outlined text-xl">person</span>
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

                    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-12">

                        <!-- Hero Section -->
                        <section
                            class="relative min-h-[500px] rounded-3xl overflow-hidden shadow-2xl flex flex-col justify-center py-16">
                            <div class="absolute inset-0 bg-cover bg-center"
                                data-alt="Fresh vegetable market landscape background"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCVj1hLs9-DlBz3V8-O9Eo6EBRa0EUN9pebGEBBHNKWSReYxVLOFXd6o2lDm-YqsehrI4U_Lr-q8yjSKmERLPUxgXPUVu8zRLg9xho7x2Ijq2T1TCIb4jLhLeBDAE8JCd9y-KBzC4ngFIWvFSaB5csLafcNLvHNTxSRXezigBlkzhitblKHwLn0qW1vlS8TBsfihxMshKwvxA3eo0Wc65HGOlNGUp1wWO72eLIW8YnHCpoeVGMQKPuoft0RkPDW63QVvgl3gW_kkXaU');">
                            </div>

                            <div class="absolute inset-0 bg-gradient-to-r from-black/70 via-black/40 to-transparent">
                            </div>

                            <div class="relative flex flex-col justify-center items-start px-12 lg:px-20 max-w-2xl">
                                <span
                                    class="bg-primary/20 text-primary border border-primary/30 px-4 py-1.5 rounded-full text-sm font-bold mb-6 backdrop-blur-sm">
                                    Sạch từ Nông Trại - Tươi tới Bàn Ăn
                                </span>

                                <h2 class="text-5xl lg:text-7xl font-black text-white leading-[1.1] mb-6">
                                    Nông Sản Tươi Sạch Cho Gia Đình Việt
                                </h2>

                                <p class="text-lg text-slate-200 mb-10 leading-relaxed">
                                    Chúng tôi kết nối trực tiếp với những người nông dân tâm huyết nhất để mang đến
                                    những
                                    sản
                                    phẩm
                                    nông nghiệp đạt chuẩn VietGAP và GlobalGAP.
                                </p>

                                <div class="flex gap-4">
                                    <button
                                        class="bg-primary hover:bg-primary/90 text-white font-bold py-4 px-10 rounded-xl text-lg transition-transform active:scale-95">
                                        Mua sắm ngay
                                    </button>
                                    <button
                                        class="bg-white/10 hover:bg-white/20 text-white font-bold py-4 px-8 rounded-xl text-lg backdrop-blur-md transition-colors">
                                        Khám phá thêm
                                    </button>
                                </div>
                            </div>
                        </section>

                        <!-- Category Grid -->
                        <section>
                            <div class="flex items-center justify-between mb-8">
                                <h3 class="text-2xl font-bold">Danh mục sản phẩm</h3>
                                <a class="text-primary font-semibold flex items-center gap-1 hover:underline"
                                    href="shop">
                                    Xem tất cả <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </a>
                            </div>

                            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">

                                <!-- Cat 1 -->
                                <a href="shop?catId=1" class="group cursor-pointer block">
                                    <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                                        <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                            data-alt="Fresh organic green vegetables"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBpS_FD-G6bHlv68CLd4E0K-kqziiMSG4pWFfDHdXqFa4ZAf3rxo2hwdWnss_BEpsKXeNskc7Hse68aR8wDaJ3qV5etVi-Qeh8732vti2tnUg_wCCF5nhRlfG8lZ2M9yjMPUSMog_wWE2eRV7cT-tuSivDfVeK0BdrGCeMvVHrxfytl5UYtDIjd0gHuAgJ61sYLGoe4IQnx_rcKZBpmNmWg7xIxpFlrNDErr9uUIHjJn-NPmPqn_PvLw5E4972k39bxDT6wGJlZHAW9" />
                                        <div
                                            class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                                            <span class="text-white font-bold text-lg">Rau Xanh Tươi</span>
                                        </div>
                                    </div>
                                </a>

                                <!-- Cat 2 -->
                                <a href="shop?catId=2" class="group cursor-pointer block">
                                    <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                                        <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                            data-alt="Selection of tropical and seasonal fruits"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuA3ViUs5dwuRUlP5n8dI8PXyW7ymK709v5CxN4EwqjqhIguZCdtTKJt4IiwFIWuHecaUNsaBrf_Er8cC7nxsPUnc4XDVYpMRA5F9b6lnSn4coe5LBa-678dA8DR7Eym75Qoc8U4W7V1KytzdD9Cl_Uxhn0mbkUxPvdlYpYWMUmdyS400iLSl7OFmmb4pfaYDD4KKlN61K24xJTpPxyzXPP6m_9QYPI4iR42kwLfQ_AVvySXfI0itt2qIYFOK_fI63S_tCD_PyZejxTk" />
                                        <div
                                            class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                                            <span class="text-white font-bold text-lg">Trái Cây Mùa Vụ</span>
                                        </div>
                                    </div>
                                </a>

                                <!-- Cat 3 -->
                                <a href="shop?catId=3" class="group cursor-pointer block">
                                    <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                                        <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                            data-alt="Fresh cuts of raw meat"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBnbDygKW4NS1acCH_yFkMK9Nsl_uhNDefI55C68p2ekkRsx7io5_1Ct4_PhVMmdZ8_H7Eux4LRBnWFko-3kBEgjP7n1vST3YwwG2OxhMZQXVkxYnEahJQQar0TSf858tJILQTdWsFiA-S_xBsxgc9kRqHXxmoofyM3FajOxpufgbtHDC9FPNxQTCHB4Dl9AkhcFl1aaMvGuwrJv6u3GPHQBW1JXBHXMOIDO2OAqRKuglO2OUPJnH-xIkLnD6r79PjxKiuiyh8A--VP" />
                                        <div
                                            class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                                            <span class="text-white font-bold text-lg">Thịt &amp; Hải Sản</span>
                                        </div>
                                    </div>
                                </a>

                                <!-- Cat 4 -->
                                <a href="shop?catId=4" class="group cursor-pointer block">
                                    <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                                        <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                            data-alt="Assorted dry goods and grains"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuAgoKvtfUywgTquPI5XBApK7jH_dSTMWjdUFolwOGL6aho7R05NueYWmbTGr5RDelfug_j0dF3ix82y0X5eoNBxz-95Pg82c_E4iSYTWsmbAhLf5-rQNG3GcLng7eoY5RthGdmKOouqeZUhG6qvgQZ-fu1rC8LJFlY8rup7wTJ6gw3kgapUiPNpLRo4j2apxqfEXK9S0RV0KCWvZ1I3nG2oprxWkmKggs82oypp_NuEcIDH2omjiig9OWzhUKDBwdmC6dNoaBT_F2pC" />
                                        <div
                                            class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                                            <span class="text-white font-bold text-lg">Đồ Khô &amp; Gia Vị</span>
                                        </div>
                                    </div>
                                </a>

                            </div>
                        </section>

                        <!-- Featured Products -->
                        <section>
                            <div class="flex items-center justify-between mb-8">
                                <div class="space-y-1">
                                    <h3 class="text-2xl font-bold">Sản phẩm nổi bật</h3>
                                    <p class="text-slate-500 text-sm">Sản phẩm được lựa chọn nhiều nhất hôm nay</p>
                                </div>

                                <div class="flex gap-2">
                                    <button
                                        class="p-2 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-white dark:hover:bg-slate-800 transition-colors">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </button>
                                    <button
                                        class="p-2 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-white dark:hover:bg-slate-800 transition-colors">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                </div>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

                                <c:forEach items="${bestSellers}" var="p">
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
                                                    style="background-image: url('${bgUrl}');">
                                                </div>
                                                <c:if
                                                    test="${p.description == null || !p.description.startsWith('http')}">
                                                    <span
                                                        class="material-symbols-outlined absolute text-slate-300 opacity-50 text-5xl">inventory_2</span>
                                                </c:if>
                                            </div>

                                            <div class="space-y-1">
                                                <span class="text-xs text-primary font-bold uppercase">Sản phẩm bán
                                                    chạy</span>
                                                <h4 class="font-bold text-lg leading-tight line-clamp-2"
                                                    title="${p.name}">
                                                    ${p.name}</h4>
                                                <p class="text-xs text-slate-500">Đã bán: ${p.soldQty}</p>
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
                                                                <fmt:formatNumber value="${p.salePrice}" type="number"
                                                                    groupingUsed="true" />₫
                                                            </span>
                                                            <span class="text-xs text-slate-400 line-through mb-1">
                                                                <fmt:formatNumber value="${p.price}" type="number"
                                                                    groupingUsed="true" />₫
                                                            </span>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-primary font-black text-xl whitespace-nowrap">
                                                            <fmt:formatNumber value="${p.price}" type="number"
                                                                groupingUsed="true" />₫
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <form action="cart" method="post" class="m-0">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productId" value="${p.id}">
                                                <button type="submit"
                                                    class="bg-primary text-white px-3 py-2 rounded-xl flex items-center justify-center shadow-lg shadow-primary/30 transition-transform active:scale-90 border-0 cursor-pointer hover:bg-primary/90">
                                                    <span class="text-sm font-bold">Thêm vào giỏ</span>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                        </section>

                        <!-- Newsletter Section -->
                        <section
                            class="bg-primary rounded-3xl p-8 lg:p-16 flex flex-col lg:flex-row items-center justify-between gap-8 text-white">
                            <div class="max-w-xl text-center lg:text-left">
                                <h3 class="text-3xl font-black mb-4">Đăng ký nhận tin từ Nông Sản Việt</h3>
                                <p class="text-white/80">
                                    Nhận thông báo về các đợt thu hoạch mới nhất và mã giảm giá đặc biệt cho thành viên.
                                </p>

                                <%-- Toast thông báo kết quả --%>
                                    <c:choose>
                                        <c:when test="${param.subscribeStatus == 'success'}">
                                            <div
                                                class="mt-4 bg-white/20 border border-white/30 text-white text-sm font-semibold px-4 py-2 rounded-xl inline-block">
                                                ✅ Đăng ký thành công! Bạn sẽ nhận được thông báo giảm giá sớm nhất.
                                            </div>
                                        </c:when>
                                        <c:when test="${param.subscribeStatus == 'exists'}">
                                            <div
                                                class="mt-4 bg-white/20 border border-white/30 text-white text-sm font-semibold px-4 py-2 rounded-xl inline-block">
                                                ⚠️ Email này đã được đăng ký trước đó.
                                            </div>
                                        </c:when>
                                        <c:when test="${param.subscribeStatus == 'invalid'}">
                                            <div
                                                class="mt-4 bg-white/20 border border-white/30 text-white text-sm font-semibold px-4 py-2 rounded-xl inline-block">
                                                ❌ Email không hợp lệ. Vui lòng thử lại.
                                            </div>
                                        </c:when>
                                        <c:when test="${param.subscribeStatus == 'error'}">
                                            <div
                                                class="mt-4 bg-white/20 border border-white/30 text-white text-sm font-semibold px-4 py-2 rounded-xl inline-block">
                                                ❌ Đã có lỗi xảy ra. Vui lòng thử lại sau.
                                            </div>
                                        </c:when>
                                    </c:choose>
                            </div>

                            <form action="${pageContext.request.contextPath}/subscribe" method="post"
                                class="flex w-full max-w-md bg-white p-2 rounded-2xl shadow-xl">
                                <input name="email"
                                    class="flex-1 border-none focus:ring-0 text-slate-900 font-medium px-4 bg-transparent"
                                    placeholder="Địa chỉ email của bạn" type="email" required />
                                <button type="submit"
                                    class="bg-primary hover:bg-primary/90 text-white font-bold px-8 py-3 rounded-xl transition-colors">
                                    Đăng ký
                                </button>
                            </form>
                            <c:if test="${not empty param.subscribeStatus}">
                                <div style="margin-top:10px;">
                                    <c:choose>
                                        <c:when test="${param.subscribeStatus == 'success'}">
                                            <p style="color:lightgreen;">✅ Đăng ký thành công!</p>
                                        </c:when>

                                        <c:when test="${param.subscribeStatus == 'exists'}">
                                            <p style="color:orange;">⚠ Email đã tồn tại!</p>
                                        </c:when>

                                        <c:when test="${param.subscribeStatus == 'invalid'}">
                                            <p style="color:red;">❌ Email không hợp lệ!</p>
                                        </c:when>

                                        <c:otherwise>
                                            <p style="color:red;">❌ Có lỗi xảy ra!</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                        </section>

                    </main>

                    <!-- Footer -->
                    <footer
                        class="bg-white dark:bg-slate-950 border-t border-slate-100 dark:border-slate-800 pt-20 pb-10">
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
                                        Tự hào là đơn vị cung ứng nông sản sạch hàng đầu Việt Nam. Chúng tôi cam kết
                                        chất
                                        lượng
                                        trên
                                        từng sản phẩm.
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
                                        <li><a class="hover:text-primary transition-colors" href="${pageContext.request.contextPath}/about">Về chúng tôi</a>
                                        </li>
                                        <li><a class="hover:text-primary transition-colors" href="#">Hệ thống cửa
                                                hàng</a>
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
                                                hàng</a>
                                        </li>
                                        <li><a class="hover:text-primary transition-colors" href="#">Chính sách đổi
                                                trả</a>
                                        </li>
                                        <li><a class="hover:text-primary transition-colors" href="#">Hướng dẫn mua
                                                hàng</a>
                                        </li>
                                        <li><a class="hover:text-primary transition-colors" href="#">Câu hỏi thường
                                                gặp</a>
                                        </li>
                                    </ul>
                                </div>

                                <!-- Contact Info -->
                                <div>
                                    <h4 class="font-bold text-slate-900 dark:text-white mb-6">Thông Tin Liên Hệ</h4>
                                    <ul class="space-y-4 text-sm text-slate-500">
                                        <li class="flex items-start gap-3">
                                            <span
                                                class="material-symbols-outlined text-primary text-xl">location_on</span>
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
                                    © 2024 Nông Sản Việt. Tất cả quyền được bảo lưu. MSDN: 0123456789 được cấp bởi Sở
                                    KH&ĐT
                                    Hà
                                    Nội.
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

                    <!-- Search Autocomplete Script -->
                    <script>
                        const searchInput = document.getElementById('searchInput');
                        const searchResults = document.getElementById('searchResults');
                        let debounceTimer;

                        searchInput.addEventListener('input', function () {
                            clearTimeout(debounceTimer);
                            const keyword = this.value.trim();

                            if (keyword.length === 0) {
                                searchResults.classList.add('hidden');
                                searchResults.innerHTML = '';
                                return;
                            }

                            debounceTimer = setTimeout(() => {
                                fetch(`${pageContext.request.contextPath}/api/search?q=` + encodeURIComponent(keyword))
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.length === 0) {
                                            searchResults.innerHTML = '<div class="p-4 text-center text-sm text-slate-500">Không tìm thấy sản phẩm nào.</div>';
                                        } else {
                                            searchResults.innerHTML = data.map(item => `
                                            <a href="${pageContext.request.contextPath}/shop?keyword=` + encodeURIComponent(item.name) + `" class="flex items-center gap-3 p-3 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors border-b border-slate-50 last:border-0 dark:border-slate-800">
                                                <div class="size-12 rounded-lg bg-cover bg-center shrink-0" style="background-image: url('\${item.imageUrl || item.description.startsWith('http') ? item.description : ''}')">
                                                    \${(!item.imageUrl && !item.description.startsWith('http')) ? '<span class="material-symbols-outlined text-slate-300 w-full h-full flex items-center justify-center">inventory_2</span>' : ''}
                                                </div>
                                                <div class="flex-1 min-w-0">
                                                    <h4 class="text-sm font-bold text-slate-900 dark:text-white truncate">\${item.name}</h4>
                                                    <p class="text-xs font-semibold text-primary">\${new Intl.NumberFormat('vi-VN').format(item.price)}₫</p>
                                                </div>
                                            </a>
                                        `).join('');
                                        }
                                        searchResults.classList.remove('hidden');
                                        searchResults.classList.add('flex');
                                    })
                                    .catch(err => console.error('Search error:', err));
                            }, 300); // 300ms debounce
                        });

                        // Hide dropdown when clicking outside
                        document.addEventListener('click', (e) => {
                            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                                searchResults.classList.add('hidden');
                            }
                        });

                        // Show dropdown when focusing back on input if there is text
                        searchInput.addEventListener('focus', () => {
                            if (searchInput.value.trim().length > 0 && searchResults.innerHTML !== '') {
                                searchResults.classList.remove('hidden');
                            }
                        });
                    </script>
                </body>

                </html>
