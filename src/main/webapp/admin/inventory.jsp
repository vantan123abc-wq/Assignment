<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Quản lý kho hàng - Nông Sản Việt</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
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
                                fontFamily: {
                                    "display": ["Inter"]
                                },
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

                    .active-nav {
                        background-color: #f1f3f1;
                        border-left: 4px solid #4cae4f;
                    }

                    ::-webkit-scrollbar {
                        width: 8px;
                        height: 8px;
                    }

                    ::-webkit-scrollbar-track {
                        background: transparent;
                    }

                    ::-webkit-scrollbar-thumb {
                        background: #cbd5e1;
                        border-radius: 10px;
                    }

                    ::-webkit-scrollbar-thumb:hover {
                        background: #94a3b8;
                    }
                </style>
            </head>

            <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
                <div class="flex h-screen overflow-hidden">
                    <!-- Sidebar -->
                    <aside
                        class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-800 flex flex-col shrink-0">
                        <div class="p-6 flex items-center gap-3">
                            <div class="size-10 rounded-full bg-primary flex items-center justify-center text-white">
                                <span class="material-symbols-outlined text-2xl">eco</span>
                            </div>
                            <div class="flex flex-col">
                                <h1 class="text-primary text-base font-bold leading-tight">Nông Sản Việt</h1>
                                <p class="text-slate-500 text-xs font-medium">Admin Panel</p>
                            </div>
                        </div>
                        <nav class="flex-1 px-4 space-y-1 mt-4">
                            <a class="flex items-center gap-3 px-3 py-3 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="${pageContext.request.contextPath}/admin">
                                <span class="material-symbols-outlined">dashboard</span>
                                <span class="text-sm font-medium">Tổng quan</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-3 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="${pageContext.request.contextPath}/admin/users">
                                <span class="material-symbols-outlined">group</span>
                                <span class="text-sm font-medium">Người dùng</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-3 rounded-lg active-nav text-primary"
                                href="${pageContext.request.contextPath}/admin/inventory">
                                <span class="material-symbols-outlined"
                                    style="font-variation-settings: 'FILL' 1">inventory_2</span>
                                <span class="text-sm font-bold">Kho hàng</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-3 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="#">
                                <span class="material-symbols-outlined">shopping_cart</span>
                                <span class="text-sm font-medium">Đơn hàng</span>
                            </a>
                        </nav>
                        <div class="p-4 border-t border-slate-100 dark:border-slate-800">
                            <a href="${pageContext.request.contextPath}/logout"
                                class="flex items-center gap-3 w-full px-3 py-3 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors">
                                <span class="material-symbols-outlined">logout</span>
                                <span class="text-sm font-medium">Đăng xuất</span>
                            </a>
                        </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="flex-1 flex flex-col overflow-y-auto bg-background-light dark:bg-background-dark">
                        <!-- Header -->
                        <header
                            class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between px-8 sticky top-0 z-10 w-full relative">
                            <h2 class="text-xl font-bold text-slate-800 dark:text-slate-100">Quản lý kho hàng</h2>
                            <div class="flex items-center gap-4">
                                <div class="relative">
                                    <form action="${pageContext.request.contextPath}/admin/inventory" method="GET"
                                        class="flex items-center gap-2 px-3 py-1.5 bg-slate-100 dark:bg-slate-800 rounded-full">
                                        <span class="material-symbols-outlined text-slate-500 text-sm">search</span>
                                        <input id="searchInput" autocomplete="off" name="keyword"
                                            value="${param.keyword}"
                                            class="bg-transparent border-none text-xs focus:ring-0 w-48 text-slate-600 dark:text-slate-300"
                                            placeholder="Tìm kiếm nhanh sản phẩm..." type="text" />
                                    </form>
                                    <!-- Dropdown suggestions -->
                                    <div id="searchDropdown"
                                        class="absolute top-full left-0 right-0 mt-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl shadow-lg z-50 overflow-hidden hidden">
                                        <ul id="suggestionList"
                                            class="max-h-64 overflow-y-auto divide-y divide-slate-100 dark:divide-slate-700">
                                            <!-- Items will be appended here by JS -->
                                        </ul>
                                    </div>
                                </div>
                                <button
                                    class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative group"
                                    <c:if test="${hasStockAlert}">title="Cảnh báo: Có ${outOfStockCount} sản phẩm hết
                                    hàng và ${lowStockCount} sản phẩm sắp hết hàng"</c:if>>
                                    <span class="material-symbols-outlined">notifications</span>
                                    <c:if test="${hasStockAlert}">
                                        <span
                                            class="absolute top-2 right-2 w-2 h-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900 animate-pulse"></span>
                                    </c:if>

                                    <!-- Tooltip Dropdown Menu (Optional, can be expanded later) -->
                                    <c:if test="${hasStockAlert}">
                                        <div
                                            class="absolute right-0 top-full mt-2 w-72 bg-white dark:bg-slate-800 rounded-xl shadow-lg border border-slate-200 dark:border-slate-700 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50 text-left">
                                            <div class="p-4 border-b border-slate-100 dark:border-slate-700">
                                                <h3 class="font-bold text-slate-800 dark:text-slate-100">Thông báo kho
                                                    hàng</h3>
                                            </div>
                                            <div class="p-2">
                                                <c:if test="${outOfStockCount > 0}">
                                                    <a href="${pageContext.request.contextPath}/admin/inventory?filter=outOfStock"
                                                        class="flex items-start gap-3 p-3 hover:bg-red-50 dark:hover:bg-red-900/10 rounded-lg transition-colors">
                                                        <div
                                                            class="bg-red-100 dark:bg-red-900/30 text-red-600 p-2 rounded-full shrink-0">
                                                            <span class="material-symbols-outlined text-sm">error</span>
                                                        </div>
                                                        <div>
                                                            <p
                                                                class="text-sm font-medium text-slate-800 dark:text-slate-200">
                                                                Hết hàng</p>
                                                            <p class="text-xs text-slate-500 mt-0.5">Có
                                                                ${outOfStockCount} sản phẩm đã hết hàng trong kho.</p>
                                                        </div>
                                                    </a>
                                                </c:if>
                                                <c:if test="${lowStockCount > 0}">
                                                    <a href="${pageContext.request.contextPath}/admin/inventory?filter=lowStock"
                                                        class="flex items-start gap-3 p-3 hover:bg-orange-50 dark:hover:bg-orange-900/10 rounded-lg transition-colors">
                                                        <div
                                                            class="bg-orange-100 dark:bg-orange-900/30 text-orange-600 p-2 rounded-full shrink-0">
                                                            <span
                                                                class="material-symbols-outlined text-sm">warning</span>
                                                        </div>
                                                        <div>
                                                            <p
                                                                class="text-sm font-medium text-slate-800 dark:text-slate-200">
                                                                Sắp hết hàng</p>
                                                            <p class="text-xs text-slate-500 mt-0.5">Có ${lowStockCount}
                                                                sản phẩm sắp hết hàng (kho <= 5).</p>
                                                        </div>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:if>
                                </button>
                                <div class="h-8 w-px bg-slate-200 dark:bg-slate-700 mx-2"></div>
                                <div class="flex items-center gap-3">
                                    <div class="text-right hidden sm:block">
                                        <p class="text-sm font-bold leading-none">Admin
                                            <c:out value="${sessionScope.account.username}" />
                                        </p>
                                        <p class="text-xs text-slate-500 mt-1">Quản trị viên</p>
                                    </div>
                                    <div
                                        class="size-10 rounded-xl bg-primary/20 border-2 border-primary/30 flex justify-center items-center text-primary font-bold">
                                        <span class="material-symbols-outlined">shield_person</span>
                                    </div>
                                </div>
                            </div>
                        </header>

                        <div class="p-8">
                            <!-- Stats Grid (Tính toán sơ bộ) -->
                            <c:set var="totalProducts" value="${products.size()}" />
                            <c:set var="inStock" value="0" />
                            <c:set var="lowStock" value="0" />
                            <c:set var="outOfStock" value="0" />
                            <c:forEach items="${products}" var="p">
                                <c:choose>
                                    <c:when test="${p.quantity == 0}">
                                        <c:set var="outOfStock" value="${outOfStock + 1}" />
                                    </c:when>
                                    <c:when test="${p.quantity > 0 && p.quantity <= 5}">
                                        <c:set var="lowStock" value="${lowStock + 1}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="inStock" value="${inStock + 1}" />
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4">
                                    <div class="p-3 bg-blue-50 dark:bg-blue-900/20 rounded-lg text-blue-600">
                                        <span class="material-symbols-outlined">inventory</span>
                                    </div>
                                    <div>
                                        <p class="text-sm text-slate-500 font-medium">Tổng sản phẩm</p>
                                        <p class="text-2xl font-bold">${totalProducts}</p>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4">
                                    <div class="p-3 bg-primary/10 rounded-lg text-primary">
                                        <span class="material-symbols-outlined">check_circle</span>
                                    </div>
                                    <div>
                                        <p class="text-sm text-slate-500 font-medium">Trong kho / Tốt</p>
                                        <p class="text-2xl font-bold">${inStock}</p>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4 border-l-4 border-l-orange-500">
                                    <div class="p-3 bg-orange-50 dark:bg-orange-900/20 rounded-lg text-orange-600">
                                        <span class="material-symbols-outlined">warning</span>
                                    </div>
                                    <div>
                                        <p class="text-sm text-slate-500 font-medium">Sắp hết hàng</p>
                                        <p class="text-2xl font-bold text-orange-600">${lowStock}</p>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4 border-l-4 border-l-red-500">
                                    <div class="p-3 bg-red-50 dark:bg-red-900/20 rounded-lg text-red-600">
                                        <span class="material-symbols-outlined">error</span>
                                    </div>
                                    <div>
                                        <p class="text-sm text-slate-500 font-medium">Hết hàng</p>
                                        <p class="text-2xl font-bold text-red-600">${outOfStock}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Table Container -->
                            <div
                                class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                                <div
                                    class="p-6 border-b border-slate-200 dark:border-slate-800 flex flex-col xl:flex-row md:items-center justify-between gap-4">
                                    <!-- Tabs for Categories -->
                                    <div
                                        class="flex border-b border-slate-100 dark:border-slate-800 overflow-x-auto no-scrollbar gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/inventory"
                                            class="px-4 py-2 text-sm ${(empty param.categoryId && empty param.filter) ? 'font-bold border-b-2 border-primary text-primary' : 'font-medium text-slate-500 hover:text-slate-700'} whitespace-nowrap">Tất
                                            cả</a>
                                        <a href="${pageContext.request.contextPath}/admin/inventory?filter=outOfStock"
                                            class="px-4 py-2 text-sm ${param.filter == 'outOfStock' ? 'font-bold border-b-2 border-red-500 text-red-500' : 'font-medium text-slate-500 hover:text-red-500'} whitespace-nowrap">Hết
                                            hàng</a>
                                        <a href="${pageContext.request.contextPath}/admin/inventory?filter=lowStock"
                                            class="px-4 py-2 text-sm ${param.filter == 'lowStock' ? 'font-bold border-b-2 border-orange-500 text-orange-500' : 'font-medium text-slate-500 hover:text-orange-500'} whitespace-nowrap">Sắp
                                            hết hàng</a>
                                        <!-- Danh mục cụ thể -->
                                        <c:forEach items="${categories}" var="cat">
                                            <a href="${pageContext.request.contextPath}/admin/inventory?categoryId=${cat.id}"
                                                class="px-4 py-2 text-sm ${param.categoryId == cat.id ? 'font-bold border-b-2 border-primary text-primary' : 'font-medium text-slate-500 hover:text-slate-700'} whitespace-nowrap">${cat.name}</a>
                                        </c:forEach>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="flex items-center gap-3">
                                        <a href="${pageContext.request.contextPath}/admin/product/create"
                                            class="bg-primary hover:bg-primary/90 text-white flex items-center gap-2 px-4 py-2 text-sm font-bold rounded-lg transition-colors shadow-sm">
                                            <span class="material-symbols-outlined text-[18px]">add</span>
                                            Thêm sản phẩm
                                        </a>
                                    </div>
                                </div>

                                <div class="overflow-x-auto">
                                    <table class="w-full text-left border-collapse min-w-[800px]">
                                        <thead>
                                            <tr class="bg-slate-50 dark:bg-slate-800/50">
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider w-12">
                                                    ID</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Sản phẩm</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Danh mục</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Đơn giá</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Tồn kho / Cập nhật</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                    Trạng thái</th>
                                                <th
                                                    class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">
                                                    Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                            <c:forEach items="${products}" var="p">
                                                <tr
                                                    class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                                    <td class="px-6 py-4 text-sm text-slate-400 font-bold">#${p.id}</td>
                                                    <td class="px-6 py-4">
                                                        <div class="flex items-center gap-3">
                                                            <div
                                                                class="size-10 rounded-lg bg-slate-100 overflow-hidden flex-shrink-0">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty p.imageUrl && p.imageUrl.startsWith('http')}">
                                                                        <img class="w-full h-full object-cover"
                                                                            src="${p.imageUrl}" alt="img" />
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${not empty p.description && p.description.startsWith('http')}">
                                                                        <img class="w-full h-full object-cover"
                                                                            src="${p.description}" alt="img" />
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div
                                                                            class="w-full h-full flex items-center justify-center text-slate-400">
                                                                            <span
                                                                                class="material-symbols-outlined text-xl">image</span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div>
                                                                <p class="text-sm font-bold text-slate-800">
                                                                    <c:out value="${p.name}" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <span
                                                            class="px-2 py-1 text-[10px] font-bold bg-green-50 dark:bg-green-900/20 text-green-600 rounded-full uppercase">
                                                            <c:out
                                                                value="${p.categoryName != null ? p.categoryName : 'K.Rõ'}" />
                                                        </span>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm font-medium">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,###" />đ
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <form
                                                            action="${pageContext.request.contextPath}/admin/inventory/update-stock"
                                                            method="POST" class="flex items-center gap-2">
                                                            <input type="hidden" name="id" value="${p.id}" />
                                                            <input type="number" name="stock" value="${p.quantity}"
                                                                min="0"
                                                                class="w-20 text-sm font-bold border-slate-200 rounded-md focus:ring-primary focus:border-primary px-2 py-1 <c:if test="
                                                                ${p.quantity==0}">text-red-600</c:if>
                                                            <c:if test="${p.quantity > 0 && p.quantity <= 5}">
                                                                text-orange-600</c:if>">
                                                            <button type="submit"
                                                                class="p-1 text-slate-400 hover:text-primary transition-colors flex items-center justify-center bg-slate-100 hover:bg-green-50 rounded-md"
                                                                title="Cập nhật nhanh">
                                                                <span
                                                                    class="material-symbols-outlined text-sm font-bold">save</span>
                                                            </button>
                                                        </form>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <c:choose>
                                                            <c:when test="${p.quantity == 0}">
                                                                <div class="flex items-center gap-1.5 text-red-500">
                                                                    <span class="size-2 bg-red-500 rounded-full"></span>
                                                                    <span class="text-xs font-bold">Hết hàng</span>
                                                                </div>
                                                            </c:when>
                                                            <c:when test="${p.quantity > 0 && p.quantity <= 5}">
                                                                <div class="flex items-center gap-1.5 text-orange-500">
                                                                    <span
                                                                        class="size-2 bg-orange-500 rounded-full"></span>
                                                                    <span class="text-xs font-bold">Sắp hết</span>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="flex items-center gap-1.5 text-primary">
                                                                    <span class="size-2 bg-primary rounded-full"></span>
                                                                    <span class="text-xs font-bold">Sẵn hàng</span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="px-6 py-4 text-right">
                                                        <div class="flex justify-end gap-3 hover:opacity-100">
                                                            <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}"
                                                                class="p-1.5 text-slate-400 hover:text-primary transition-colors inline-block"
                                                                title="Sửa">
                                                                <span
                                                                    class="material-symbols-outlined text-[20px]">edit</span>
                                                            </a>
                                                            <form
                                                                action="${pageContext.request.contextPath}/admin/product/delete"
                                                                method="POST" class="inline"
                                                                onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
                                                                <input type="hidden" name="id" value="${p.id}" />
                                                                <button type="submit"
                                                                    class="p-1.5 text-slate-400 hover:text-red-500 transition-colors inline-block"
                                                                    title="Xóa">
                                                                    <span
                                                                        class="material-symbols-outlined text-[20px]">delete</span>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty products}">
                                                <tr>
                                                    <td colspan="7" class="px-6 py-12 text-center text-slate-400">
                                                        <span
                                                            class="material-symbols-outlined text-4xl mb-2 block mx-auto text-slate-300">inventory_2</span>
                                                        Không tìm thấy sản phẩm nào.
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                                <div
                                    class="p-6 border-t border-slate-200 dark:border-slate-800 flex items-center justify-between">
                                    <p class="text-sm text-slate-500">Hiển thị tất cả <strong>${totalProducts}</strong>
                                        sản phẩm</p>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
                <!-- Search Autocomplete Script -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const searchInput = document.getElementById('searchInput');
                        const searchDropdown = document.getElementById('searchDropdown');
                        const suggestionList = document.getElementById('suggestionList');
                        let searchTimeout = null;

                        if (!searchInput) return;

                        searchInput.addEventListener('input', function () {
                            const keyword = this.value.trim();

                            clearTimeout(searchTimeout);

                            if (keyword.length > 0) {
                                // Fetch debounce
                                searchTimeout = setTimeout(() => {
                                    fetchSuggestions(keyword);
                                }, 300);
                            } else {
                                searchDropdown.classList.add('hidden');
                            }
                        });

                        // Hide dropdown when clicking outside
                        document.addEventListener('click', function (e) {
                            if (!searchInput.contains(e.target) && !searchDropdown.contains(e.target)) {
                                searchDropdown.classList.add('hidden');
                            }
                        });

                        // Show dropdown again if input is focused and has items
                        searchInput.addEventListener('focus', function () {
                            if (this.value.trim().length > 0 && suggestionList.children.length > 0) {
                                searchDropdown.classList.remove('hidden');
                            }
                        });

                        function fetchSuggestions(keyword) {
                            fetch('${pageContext.request.contextPath}/api/search?q=' + encodeURIComponent(keyword))
                                .then(response => response.json())
                                .then(data => {
                                    suggestionList.innerHTML = '';

                                    if (data && data.length > 0) {
                                        data.forEach(product => {
                                            const li = document.createElement('li');

                                            // Handle image
                                            let imgSrc = '';
                                            if (product.imageUrl && product.imageUrl.startsWith('http')) {
                                                imgSrc = product.imageUrl;
                                            } else if (product.description && product.description.startsWith('http')) {
                                                imgSrc = product.description;
                                            }

                                            const imgHtml = imgSrc ? `<img src="\${imgSrc}" class="w-8 h-8 rounded-md object-cover flex-shrink-0" alt="\${product.name}">`
                                                : `<div class="w-8 h-8 rounded-md bg-slate-100 flex items-center justify-center text-slate-400 flex-shrink-0"><span class="material-symbols-outlined text-sm">image</span></div>`;

                                            li.innerHTML = `
                                <a href="${pageContext.request.contextPath}/admin/inventory?keyword=\${encodeURIComponent(product.name)}" class="flex items-center gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">
                                    \${imgHtml}
                                    <div class="flex-1 min-w-0 flex justify-between items-center">
                                        <p class="text-sm font-bold text-slate-800 dark:text-slate-200 truncate">\${product.name}</p>
                                        <p class="text-xs text-slate-500 font-medium">Tồn: <span class="\${product.quantity == 0 ? 'text-red-500' : (product.quantity <= 5 ? 'text-orange-500' : 'text-primary')}">\${product.quantity}</span></p>
                                    </div>
                                </a>
                            `;
                                            suggestionList.appendChild(li);
                                        });
                                        searchDropdown.classList.remove('hidden');
                                    } else {
                                        const li = document.createElement('li');
                                        li.innerHTML = `<div class="px-4 py-3 text-sm text-slate-500 text-center flex items-center justify-center gap-2"><span class="material-symbols-outlined text-lg">search_off</span> Không có gợi ý</div>`;
                                        suggestionList.appendChild(li);
                                        searchDropdown.classList.remove('hidden');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error fetching search suggestions:', error);
                                });
                        }
                    });
                </script>
            </body>

            </html>