<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Chi tiết - ${product.name} - Nông Sản Việt</title>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap" rel="stylesheet"/>

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
        body { font-family: 'Inter', sans-serif; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .thumb-active { border-color: #4cae4f !important; opacity: 1 !important; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 flex flex-col min-h-screen">

<!-- ==================== HEADER ==================== -->
<header class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2">
                <div class="bg-primary p-1.5 rounded-lg text-white">
                    <span class="material-symbols-outlined text-3xl">agriculture</span>
                </div>
                <h1 class="text-2xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
            </a>

            <!-- Desktop Nav -->
            <nav class="hidden md:flex items-center gap-8">
                <a class="font-medium hover:text-primary transition-colors" href="${pageContext.request.contextPath}/index">Trang chủ</a>
                <a class="font-medium text-primary border-b-2 border-primary" href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
                <a class="font-medium hover:text-primary transition-colors" href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a>
                <a class="font-medium hover:text-primary transition-colors" href="#">Về chúng tôi</a>
            </nav>

            <!-- Actions -->
            <div class="flex items-center gap-3">
                <a href="${pageContext.request.contextPath}/cart"
                   class="relative p-2.5 flex items-center justify-center rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                    <span class="material-symbols-outlined">shopping_cart</span>
                    <c:if test="${sessionScope.cartCount > 0}">
                        <span class="absolute top-1 right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">
                            ${sessionScope.cartCount}
                        </span>
                    </c:if>
                </a>

                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <a href="${pageContext.request.contextPath}/logout" title="Đăng xuất"
                           class="flex items-center gap-2 p-1 pr-3 rounded-full bg-red-50 text-red-600 font-semibold text-sm hover:bg-red-100 transition-colors">
                            <div class="size-8 rounded-full bg-red-500 text-white flex items-center justify-center">
                                <span class="material-symbols-outlined text-xl">logout</span>
                            </div>
                            <span>${sessionScope.account.username} (Thoát)</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login"
                           class="flex items-center gap-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                            <div class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                <span class="material-symbols-outlined text-xl">person</span>
                            </div>
                            <span>Đăng nhập</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<!-- ==================== MAIN ==================== -->
<main class="flex-grow max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-8">

    <!-- Breadcrumb -->
    <nav class="flex items-center gap-2 mb-8 text-sm font-medium flex-wrap">
        <a class="text-primary hover:underline" href="${pageContext.request.contextPath}/index">Trang chủ</a>
        <span class="material-symbols-outlined text-xs text-slate-400">chevron_right</span>
        <a class="text-primary hover:underline" href="${pageContext.request.contextPath}/shop">Cửa hàng</a>
        <c:if test="${not empty product.categoryName}">
            <span class="material-symbols-outlined text-xs text-slate-400">chevron_right</span>
            <a class="text-primary hover:underline"
               href="${pageContext.request.contextPath}/shop?catId=${product.categoryId}">${product.categoryName}</a>
        </c:if>
        <span class="material-symbols-outlined text-xs text-slate-400">chevron_right</span>
        <span class="text-slate-500 truncate max-w-[200px]">${product.name}</span>
    </nav>

    <!-- ====== Product Section ====== -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 mb-16">

        <!-- Left: Ảnh sản phẩm -->
        <div class="flex flex-col gap-4">
            <!-- Ảnh chính -->
            <div class="aspect-square w-full rounded-2xl overflow-hidden bg-slate-100 dark:bg-slate-800 border border-primary/10 relative">
                <c:set var="mainImg" value=""/>
                <c:choose>
                    <c:when test="${not empty product.imageUrl}">
                        <c:set var="mainImg" value="${product.imageUrl}"/>
                    </c:when>
                    <c:when test="${not empty product.description and product.description.startsWith('http')}">
                        <c:set var="mainImg" value="${product.description}"/>
                    </c:when>
                </c:choose>

                <c:choose>
                    <c:when test="${not empty mainImg}">
                        <img id="mainImage" src="${mainImg}" alt="${product.name}"
                             class="w-full h-full object-cover transition-transform duration-300 hover:scale-105"/>
                    </c:when>
                    <c:otherwise>
                        <div class="w-full h-full flex flex-col items-center justify-center gap-4 bg-slate-50 dark:bg-slate-800">
                            <span class="material-symbols-outlined text-8xl text-slate-300">inventory_2</span>
                            <p class="text-slate-400 text-sm">Chưa có hình ảnh</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Badge giảm giá -->
                <c:if test="${product.discountPercent != null && product.discountPercent > 0}">
                    <div class="absolute top-4 left-4 bg-red-600 text-white font-black text-sm px-3 py-1.5 rounded-xl shadow-md">
                        -${product.discountPercent}%
                    </div>
                </c:if>
            </div>

            <!-- Thumbnails (dùng cùng ảnh, hiệu ứng zoom khác nhau) -->
            <c:if test="${not empty mainImg}">
                <div class="grid grid-cols-4 gap-3">
                    <div class="aspect-square rounded-lg overflow-hidden border-2 border-primary cursor-pointer thumb-active"
                         onclick="setMainImage('${mainImg}', this)">
                        <img src="${mainImg}" alt="${product.name}" class="w-full h-full object-cover"/>
                    </div>
                    <!-- Thumbnails bổ sung với các góc zoom khác nhau (dùng object-position) -->
                    <div class="aspect-square rounded-lg overflow-hidden border border-primary/20 cursor-pointer opacity-70 hover:opacity-100 transition-opacity"
                         onclick="setMainImage('${mainImg}', this)">
                        <img src="${mainImg}" alt="${product.name}" class="w-full h-full object-cover" style="object-position: center top;"/>
                    </div>
                    <div class="aspect-square rounded-lg overflow-hidden border border-primary/20 cursor-pointer opacity-70 hover:opacity-100 transition-opacity"
                         onclick="setMainImage('${mainImg}', this)">
                        <img src="${mainImg}" alt="${product.name}" class="w-full h-full object-cover" style="object-position: center bottom;"/>
                    </div>
                    <div class="aspect-square rounded-lg overflow-hidden border border-primary/20 cursor-pointer opacity-70 hover:opacity-100 transition-opacity"
                         onclick="setMainImage('${mainImg}', this)">
                        <img src="${mainImg}" alt="${product.name}" class="w-full h-full object-cover" style="object-position: left center;"/>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Right: Thông tin chi tiết -->
        <div class="flex flex-col">
            <!-- Category badge -->
            <c:if test="${not empty product.categoryName}">
                <div class="mb-3">
                    <span class="inline-block px-3 py-1 bg-primary/10 text-primary text-xs font-bold rounded-full uppercase tracking-wider">
                        ${product.categoryName}
                    </span>
                </div>
            </c:if>

            <!-- Tên sản phẩm -->
            <h1 class="text-3xl lg:text-4xl font-black text-slate-900 dark:text-slate-100 mb-4 tracking-tight leading-tight">
                ${product.name}
            </h1>

            <!-- Rating & sold (tĩnh, có thể tích hợp DB sau) -->
            <div class="flex items-center gap-4 mb-6 flex-wrap">
                <div class="flex items-center gap-1">
                    <span class="material-symbols-outlined text-primary text-lg" style="font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24;">star</span>
                    <span class="material-symbols-outlined text-primary text-lg" style="font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24;">star</span>
                    <span class="material-symbols-outlined text-primary text-lg" style="font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24;">star</span>
                    <span class="material-symbols-outlined text-primary text-lg" style="font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24;">star</span>
                    <span class="material-symbols-outlined text-primary text-lg" style="font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24;">star_half</span>
                    <span class="font-bold ml-1">4.8</span>
                </div>
                <span class="text-slate-400">|</span>
                <span class="text-slate-500 text-sm">Đã đánh giá</span>
                <span class="text-slate-400">|</span>
                <span class="text-sm font-medium px-2 py-0.5 rounded-full ${product.quantity > 5 ? 'bg-green-100 text-green-700' : product.quantity > 0 ? 'bg-yellow-100 text-yellow-700' : 'bg-red-100 text-red-700'}">
                    <c:choose>
                        <c:when test="${product.quantity > 5}">Còn hàng (${product.quantity})</c:when>
                        <c:when test="${product.quantity > 0}">Sắp hết hàng (${product.quantity})</c:when>
                        <c:otherwise>Hết hàng</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <!-- Giá -->
            <div class="bg-primary/5 dark:bg-primary/10 p-6 rounded-xl mb-8 border border-primary/10">
                <c:choose>
                    <c:when test="${product.discountPercent != null && product.discountPercent > 0}">
                        <div class="flex items-end gap-3">
                            <div class="text-3xl font-black text-red-500">
                                <fmt:formatNumber value="${product.salePrice}" type="number" groupingUsed="true"/>₫
                            </div>
                            <div class="text-lg text-slate-400 line-through mb-0.5">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                            </div>
                        </div>
                        <p class="text-sm text-green-600 font-semibold mt-1">
                            Tiết kiệm <fmt:formatNumber value="${product.price - product.salePrice}" type="number" groupingUsed="true"/>₫ (${product.discountPercent}%)
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="text-3xl font-black text-primary">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                        </div>
                    </c:otherwise>
                </c:choose>
                <p class="text-xs text-slate-500 mt-2">Giá chưa bao gồm phí vận chuyển</p>
            </div>

            <!-- Mô tả ngắn -->
            <c:if test="${not empty product.description && !product.description.startsWith('http')}">
                <div class="mb-6 text-slate-600 dark:text-slate-400 text-sm leading-relaxed">
                    ${product.description}
                </div>
            </c:if>

            <!-- Số lượng -->
            <div class="mb-6">
                <p class="text-sm font-bold text-slate-900 dark:text-slate-100 mb-3">Số lượng</p>
                <div class="flex items-center gap-3">
                    <div class="flex items-center border border-slate-200 dark:border-slate-700 rounded-xl overflow-hidden">
                        <button onclick="changeQty(-1)"
                                class="px-4 py-2.5 text-slate-600 hover:bg-primary/10 hover:text-primary transition-colors font-bold text-lg">−</button>
                        <input id="qtyInput" type="number" value="1" min="1" max="${product.quantity}"
                               class="w-16 text-center border-none bg-transparent focus:ring-0 font-bold text-base"/>
                        <button onclick="changeQty(1)"
                                class="px-4 py-2.5 text-slate-600 hover:bg-primary/10 hover:text-primary transition-colors font-bold text-lg">+</button>
                    </div>
                    <span class="text-sm text-slate-500">Tối đa ${product.quantity}</span>
                </div>
            </div>

            <!-- Buttons Thêm giỏ hàng / Mua ngay -->
            <div class="flex gap-4 mb-8">
                <form action="${pageContext.request.contextPath}/cart" method="post" class="flex-1">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productId" value="${product.id}"/>
                    <input type="hidden" name="quantity" id="cartQty" value="1"/>
                    <button type="submit" onclick="syncQty()"
                            class="w-full h-14 bg-primary text-white font-bold rounded-xl flex items-center justify-center gap-2 hover:bg-primary/90 transition-all shadow-lg shadow-primary/20 active:scale-95">
                        <span class="material-symbols-outlined">shopping_cart</span>
                        Thêm vào giỏ hàng
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/cart"
                   class="flex-1 h-14 border-2 border-primary text-primary font-bold rounded-xl hover:bg-primary/5 transition-all flex items-center justify-center">
                    Mua ngay
                </a>
            </div>

            <!-- Trust badges -->
            <div class="grid grid-cols-2 gap-4 pt-6 border-t border-primary/10">
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-primary">verified</span>
                    <span class="text-xs font-medium">Cam kết chất lượng</span>
                </div>
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-primary">local_shipping</span>
                    <span class="text-xs font-medium">Giao hàng nhanh 2h</span>
                </div>
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-primary">eco</span>
                    <span class="text-xs font-medium">Sản phẩm hữu cơ</span>
                </div>
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-primary">autorenew</span>
                    <span class="text-xs font-medium">Đổi trả trong 24h</span>
                </div>
            </div>
        </div>
    </div>

    <!-- ====== Phần chi tiết ====== -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-12 border-t border-primary/10 pt-12">

        <!-- Left 2/3: Info panels -->
        <div class="lg:col-span-2 flex flex-col gap-10">

            <!-- Mô tả sản phẩm -->
            <section class="bg-white dark:bg-slate-900 rounded-2xl border border-primary/10 shadow-sm overflow-hidden">
                <div class="flex items-center gap-3 p-6 border-b border-primary/10">
                    <div class="p-2 bg-primary/20 rounded-lg">
                        <span class="material-symbols-outlined text-primary">description</span>
                    </div>
                    <h3 class="text-xl font-bold">Thông tin sản phẩm</h3>
                </div>
                <div class="p-6">
                    <table class="w-full text-sm">
                        <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                        <tr class="py-3">
                            <td class="py-3 font-semibold text-slate-600 dark:text-slate-400 w-40">Tên sản phẩm</td>
                            <td class="py-3 font-bold">${product.name}</td>
                        </tr>
                        <c:if test="${not empty product.categoryName}">
                            <tr>
                                <td class="py-3 font-semibold text-slate-600 dark:text-slate-400">Danh mục</td>
                                <td class="py-3">${product.categoryName}</td>
                            </tr>
                        </c:if>
                        <tr>
                            <td class="py-3 font-semibold text-slate-600 dark:text-slate-400">Giá bán</td>
                            <td class="py-3 text-primary font-bold">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>₫
                            </td>
                        </tr>
                        <c:if test="${product.discountPercent != null && product.discountPercent > 0}">
                            <tr>
                                <td class="py-3 font-semibold text-slate-600 dark:text-slate-400">Giảm giá</td>
                                <td class="py-3 text-red-500 font-bold">${product.discountPercent}%</td>
                            </tr>
                            <tr>
                                <td class="py-3 font-semibold text-slate-600 dark:text-slate-400">Giá sau giảm</td>
                                <td class="py-3 text-red-500 font-black text-base">
                                    <fmt:formatNumber value="${product.salePrice}" type="number" groupingUsed="true"/>₫
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td class="py-3 font-semibold text-slate-600 dark:text-slate-400">Tồn kho</td>
                            <td class="py-3">
                                <span class="font-bold ${product.quantity > 5 ? 'text-green-600' : product.quantity > 0 ? 'text-yellow-600' : 'text-red-600'}">
                                    ${product.quantity}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="py-3 font-semibold text-slate-600 dark:text-slate-400">Mô tả</td>
                            <td class="py-3 text-slate-600 dark:text-slate-400 leading-relaxed">
                                <c:choose>
                                    <c:when test="${not empty product.description && !product.description.startsWith('http')}">
                                        ${product.description}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-slate-400 italic">Chưa có mô tả.</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Tiêu chuẩn chất lượng -->
            <section class="bg-white dark:bg-slate-900 rounded-2xl border border-primary/10 shadow-sm overflow-hidden">
                <div class="flex items-center gap-3 p-6 border-b border-primary/10">
                    <div class="p-2 bg-primary/20 rounded-lg">
                        <span class="material-symbols-outlined text-primary">verified_user</span>
                    </div>
                    <h3 class="text-xl font-bold">Cam Kết Chất Lượng</h3>
                </div>
                <div class="p-6">
                    <ul class="space-y-4">
                        <li class="flex items-start gap-3">
                            <span class="material-symbols-outlined text-primary text-sm mt-1">check_circle</span>
                            <span class="text-sm text-slate-600 dark:text-slate-400">Sản phẩm đạt chuẩn VietGAP và GlobalGAP, an toàn cho sức khỏe.</span>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="material-symbols-outlined text-primary text-sm mt-1">check_circle</span>
                            <span class="text-sm text-slate-600 dark:text-slate-400">Không sử dụng phân bón hóa học và thuốc trừ sâu độc hại.</span>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="material-symbols-outlined text-primary text-sm mt-1">check_circle</span>
                            <span class="text-sm text-slate-600 dark:text-slate-400">Thu hoạch và đóng gói đảm bảo vệ sinh an toàn thực phẩm.</span>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="material-symbols-outlined text-primary text-sm mt-1">check_circle</span>
                            <span class="text-sm text-slate-600 dark:text-slate-400">Giao hàng trong ngày, đảm bảo sản phẩm tươi ngon nhất.</span>
                        </li>
                    </ul>
                </div>
            </section>

        </div>

        <!-- Right 1/3: Sidebar -->
        <div class="flex flex-col gap-6">

            <!-- Ưu đãi -->
            <div class="bg-primary/5 p-6 rounded-xl border border-primary/20 sticky top-24">
                <h4 class="font-bold mb-4 flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">local_fire_department</span>
                    Ưu đãi hôm nay
                </h4>
                <div class="space-y-4">
                    <div class="flex gap-4 items-center">
                        <div class="w-12 h-12 rounded-lg bg-white dark:bg-slate-800 flex items-center justify-center font-bold text-primary shrink-0">5%</div>
                        <div class="text-sm">Giảm thêm 5% cho đơn hàng từ 500k</div>
                    </div>
                    <div class="flex gap-4 items-center">
                        <div class="w-12 h-12 rounded-lg bg-white dark:bg-slate-800 flex items-center justify-center font-bold text-primary text-xs shrink-0">FREE</div>
                        <div class="text-sm">Freeship cho đơn từ 200k trong nội thành</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/promotions"
                   class="block w-full mt-6 py-3 bg-slate-900 dark:bg-slate-800 text-white font-bold rounded-lg text-sm hover:opacity-90 text-center transition-opacity">
                    Xem thêm ưu đãi
                </a>
            </div>

            <!-- Sản phẩm liên quan -->
            <c:if test="${not empty relatedProducts}">
                <div class="p-6 rounded-xl bg-white dark:bg-slate-900 border border-primary/10 shadow-sm">
                    <h4 class="font-bold mb-4 text-slate-900 dark:text-slate-100">Sản phẩm liên quan</h4>
                    <div class="space-y-4">
                        <c:forEach items="${relatedProducts}" var="rp">
                            <a href="${pageContext.request.contextPath}/product?id=${rp.id}"
                               class="flex gap-3 hover:bg-slate-50 dark:hover:bg-slate-800 p-2 rounded-lg transition-colors group">
                                <c:set var="rpImg" value=""/>
                                <c:choose>
                                    <c:when test="${not empty rp.imageUrl}"><c:set var="rpImg" value="${rp.imageUrl}"/></c:when>
                                    <c:when test="${not empty rp.description and rp.description.startsWith('http')}"><c:set var="rpImg" value="${rp.description}"/></c:when>
                                </c:choose>
                                <div class="w-16 h-16 rounded-lg overflow-hidden shrink-0 bg-slate-100 dark:bg-slate-800 flex items-center justify-center">
                                    <c:choose>
                                        <c:when test="${not empty rpImg}">
                                            <img src="${rpImg}" alt="${rp.name}" class="w-full h-full object-cover group-hover:scale-110 transition-transform"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="material-symbols-outlined text-slate-300 text-3xl">inventory_2</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-bold truncate group-hover:text-primary transition-colors">${rp.name}</p>
                                    <c:choose>
                                        <c:when test="${rp.discountPercent != null && rp.discountPercent > 0}">
                                            <p class="text-red-500 text-xs font-black">
                                                <fmt:formatNumber value="${rp.salePrice}" type="number" groupingUsed="true"/>₫
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-primary text-xs font-black">
                                                <fmt:formatNumber value="${rp.price}" type="number" groupingUsed="true"/>₫
                                            </p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                    <a href="${pageContext.request.contextPath}/shop?catId=${product.categoryId}"
                       class="block w-full mt-4 py-2.5 border border-primary text-primary font-bold rounded-lg text-sm hover:bg-primary/5 text-center transition-colors">
                        Xem thêm trong danh mục
                    </a>
                </div>
            </c:if>

        </div>
    </div>

</main>

<!-- ==================== FOOTER ==================== -->
<footer class="bg-white dark:bg-slate-950 border-t border-slate-100 dark:border-slate-800 pt-16 pb-10 mt-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-12">
            <div class="space-y-4">
                <div class="flex items-center gap-2">
                    <div class="bg-primary p-1.5 rounded-lg text-white">
                        <span class="material-symbols-outlined text-2xl">agriculture</span>
                    </div>
                    <h2 class="text-xl font-black tracking-tight text-primary">Nông Sản Việt</h2>
                </div>
                <p class="text-slate-500 text-sm leading-relaxed">Tự hào là đơn vị cung ứng nông sản sạch hàng đầu Việt Nam. Cam kết chất lượng trên từng sản phẩm.</p>
            </div>
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-4">Liên Kết Nhanh</h4>
                <ul class="space-y-3 text-sm text-slate-500">
                    <li><a class="hover:text-primary transition-colors" href="#">Về chúng tôi</a></li>
                    <li><a class="hover:text-primary transition-colors" href="${pageContext.request.contextPath}/shop">Sản phẩm</a></li>
                    <li><a class="hover:text-primary transition-colors" href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Liên hệ</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-4">Hỗ Trợ Khách Hàng</h4>
                <ul class="space-y-3 text-sm text-slate-500">
                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách giao hàng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách đổi trả</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Hướng dẫn mua hàng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Câu hỏi thường gặp</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-4">Thông Tin Liên Hệ</h4>
                <ul class="space-y-3 text-sm text-slate-500">
                    <li class="flex items-start gap-2">
                        <span class="material-symbols-outlined text-primary text-base">location_on</span>
                        <span>123 Đường Nông Nghiệp, Quận Cầu Giấy, Hà Nội</span>
                    </li>
                    <li class="flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary text-base">phone</span>
                        <span>1900 6789 (24/7)</span>
                    </li>
                    <li class="flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary text-base">mail</span>
                        <span>lienhe@nongsanviet.vn</span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="border-t border-slate-100 dark:border-slate-800 pt-8 text-center text-xs text-slate-400">
            © 2024 Nông Sản Việt. Tất cả quyền được bảo lưu.
        </div>
    </div>
</footer>

<!-- Chat Widget AI -->
<jsp:include page="WEB-INF/views/chat-widget.jsp"/>

<!-- ==================== SCRIPTS ==================== -->
<script>
    // Thumbnail switcher
    function setMainImage(url, thumb) {
        const img = document.getElementById('mainImage');
        if (img) img.src = url;
        // Update active thumb
        document.querySelectorAll('[onclick^="setMainImage"]').forEach(el => {
            el.classList.remove('thumb-active');
            el.style.borderWidth = '1px';
            el.style.borderColor = 'rgba(76,174,79,0.2)';
            el.style.opacity = '0.7';
        });
        thumb.classList.add('thumb-active');
        thumb.style.borderWidth = '2px';
        thumb.style.borderColor = '#4cae4f';
        thumb.style.opacity = '1';
    }

    // Qty controls
    function changeQty(delta) {
        const input = document.getElementById('qtyInput');
        const max = parseInt(input.max) || 999;
        let val = parseInt(input.value) + delta;
        if (val < 1) val = 1;
        if (val > max) val = max;
        input.value = val;
    }

    // Sync qty to cart form hidden input before submit
    function syncQty() {
        const qty = document.getElementById('qtyInput').value;
        document.getElementById('cartQty').value = qty;
    }
</script>
</body>
</html>
