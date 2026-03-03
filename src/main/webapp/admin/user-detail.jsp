<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Chi tiết người dùng - Admin Panel</title>
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
                                colors: { "primary": "#4cae4f", "background-light": "#f6f7f6", "background-dark": "#151d15" },
                                fontFamily: { "display": ["Inter"] },
                                borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
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

            <body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100">
                <div class="flex min-h-screen">
                    <!-- Sidebar -->
                    <aside
                        class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-800 flex flex-col fixed h-full z-10">
                        <div class="p-6 flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white">
                                <span class="material-symbols-outlined">eco</span>
                            </div>
                            <div>
                                <h1 class="text-base font-bold leading-tight">Nông Sản Việt</h1>
                                <p class="text-xs text-slate-500">Admin Panel</p>
                            </div>
                        </div>
                        <nav class="flex-1 px-4 py-4 space-y-1">
                            <a href="${pageContext.request.contextPath}/admin"
                                class="flex items-center gap-3 px-3 py-2 text-slate-600 hover:bg-slate-100 rounded-lg transition-colors">
                                <span class="material-symbols-outlined">dashboard</span>
                                <span class="text-sm font-medium">Bảng điều khiển</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/inventory"
                                class="flex items-center gap-3 px-3 py-2 text-slate-600 hover:bg-slate-100 rounded-lg transition-colors">
                                <span class="material-symbols-outlined">inventory_2</span>
                                <span class="text-sm font-medium">Sản phẩm</span>
                            </a>
                            <a href="#"
                                class="flex items-center gap-3 px-3 py-2 text-slate-600 hover:bg-slate-100 rounded-lg transition-colors">
                                <span class="material-symbols-outlined">shopping_cart</span>
                                <span class="text-sm font-medium">Đơn hàng</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users"
                                class="flex items-center gap-3 px-3 py-2 bg-primary/10 text-primary rounded-lg font-bold">
                                <span class="material-symbols-outlined"
                                    style="font-variation-settings:'FILL' 1">group</span>
                                <span class="text-sm font-medium">Người dùng</span>
                            </a>
                        </nav>
                        <div class="p-4 border-t border-slate-200">
                            <div class="flex items-center gap-3 p-2">
                                <div
                                    class="size-10 rounded-xl bg-primary/20 border-2 border-primary/30 flex items-center justify-center text-primary font-bold">
                                    <span class="material-symbols-outlined">shield_person</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-bold truncate">Admin
                                        <c:out value="${sessionScope.account.username}" />
                                    </p>
                                    <p class="text-xs text-slate-500 truncate">Quản trị viên</p>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="flex items-center gap-2 w-full px-3 py-2 text-red-500 hover:bg-red-50 rounded-lg mt-2 text-sm font-medium">
                                <span class="material-symbols-outlined text-lg">logout</span> Đăng xuất
                            </a>
                        </div>
                    </aside>

                    <!-- Main -->
                    <main class="flex-1 ml-64 min-h-screen">
                        <!-- Header -->
                        <header
                            class="bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 h-16 flex items-center justify-between px-8 sticky top-0 z-10">
                            <div class="flex items-center gap-2 text-sm text-slate-500">
                                <a href="${pageContext.request.contextPath}/admin" class="hover:text-primary">Admin</a>
                                <span class="material-symbols-outlined text-sm">chevron_right</span>
                                <a href="${pageContext.request.contextPath}/admin/users"
                                    class="hover:text-primary">Người dùng</a>
                                <span class="material-symbols-outlined text-sm">chevron_right</span>
                                <span class="text-slate-900 font-semibold">${detailUser.fullName}</span>
                            </div>
                            <div class="flex items-center gap-4">
                                <button class="relative p-2 text-slate-600 hover:bg-slate-100 rounded-full">
                                    <span class="material-symbols-outlined">notifications</span>
                                    <span
                                        class="absolute top-2 right-2 w-2 h-2 bg-red-500 rounded-full border-2 border-white"></span>
                                </button>
                            </div>
                        </header>

                        <div class="p-6 flex flex-col gap-6">
                            <!-- User Info Header Card -->
                            <div
                                class="bg-white dark:bg-slate-900 rounded-xl p-6 shadow-sm border border-slate-200 dark:border-slate-800">
                                <div class="flex flex-col md:flex-row md:items-start justify-between gap-6">
                                    <div class="flex items-center gap-6">
                                        <!-- Avatar -->
                                        <div class="relative">
                                            <div
                                                class="w-24 h-24 rounded-full bg-primary/10 flex items-center justify-center text-4xl font-bold text-primary ring-4 ring-primary/20">
                                                ${empty detailUser.fullName ? 'U' :
                                                detailUser.fullName.substring(0,1).toUpperCase()}
                                            </div>
                                            <c:if test="${detailUser.status}">
                                                <span
                                                    class="absolute bottom-1 right-1 size-5 bg-primary border-4 border-white rounded-full"></span>
                                            </c:if>
                                        </div>
                                        <!-- Info -->
                                        <div>
                                            <div class="flex items-center gap-3 flex-wrap">
                                                <h1 class="text-2xl font-bold">${detailUser.fullName}</h1>
                                                <c:choose>
                                                    <c:when test="${detailUser.status}">
                                                        <span
                                                            class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-primary/10 text-primary">HOẠT
                                                            ĐỘNG</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-slate-200 text-slate-500">BỊ
                                                            KHÓA</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${detailUser.role == 'ADMIN'}">
                                                        <span
                                                            class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-blue-100 text-blue-700">ADMIN</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-slate-100 text-slate-600">USER</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <p
                                                class="text-slate-500 mt-2 flex flex-wrap items-center gap-x-4 gap-y-1 text-sm">
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">mail</span>${detailUser.email}</span>
                                                <c:if test="${not empty detailUser.phone}">
                                                    <span class="flex items-center gap-1"><span
                                                            class="material-symbols-outlined text-sm">call</span>${detailUser.phone}</span>
                                                </c:if>
                                            </p>
                                            <p class="text-slate-400 text-sm mt-1">
                                                Ngày tham gia:
                                                <fmt:formatDate value="${detailUser.createdAt}" pattern="dd/MM/yyyy" />
                                            </p>
                                        </div>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="flex flex-col gap-2 shrink-0">
                                        <!-- Change Role -->
                                        <form action="${pageContext.request.contextPath}/admin/users/detail"
                                            method="POST">
                                            <input type="hidden" name="action" value="changeRole" />
                                            <input type="hidden" name="id" value="${detailUser.id}" />
                                            <input type="hidden" name="tab" value="${activeTab}" />
                                            <input type="hidden" name="newRole"
                                                value="${detailUser.role == 'ADMIN' ? 'USER' : 'ADMIN'}" />
                                            <button type="submit"
                                                class="w-full flex items-center justify-center gap-2 bg-primary text-white px-5 py-2 rounded-lg font-bold text-sm hover:bg-primary/90 transition-colors">
                                                <span
                                                    class="material-symbols-outlined text-lg">admin_panel_settings</span>
                                                ${detailUser.role == 'ADMIN' ? 'Hạ xuống USER' : 'Thăng lên ADMIN'}
                                            </button>
                                            <p class="text-[10px] text-slate-400 text-center mt-0.5">* Admin không thể
                                                tự hạ chức vụ</p>
                                        </form>

                                        <!-- Toggle Status -->
                                        <form action="${pageContext.request.contextPath}/admin/users/detail"
                                            method="POST"
                                            onsubmit="return confirm('Xác nhận thay đổi trạng thái tài khoản này?');">
                                            <input type="hidden" name="action" value="toggleStatus" />
                                            <input type="hidden" name="id" value="${detailUser.id}" />
                                            <input type="hidden" name="tab" value="${activeTab}" />
                                            <c:choose>
                                                <c:when test="${detailUser.status}">
                                                    <button type="submit"
                                                        class="w-full flex items-center justify-center gap-2 bg-red-50 text-red-600 px-5 py-2 rounded-lg font-bold text-sm hover:bg-red-100 transition-colors">
                                                        <span class="material-symbols-outlined text-lg">block</span> Vô
                                                        hiệu hóa
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit"
                                                        class="w-full flex items-center justify-center gap-2 bg-primary/10 text-primary px-5 py-2 rounded-lg font-bold text-sm hover:bg-primary/20 transition-colors">
                                                        <span
                                                            class="material-symbols-outlined text-lg">check_circle</span>
                                                        Kích hoạt lại
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Stats Cards -->
                            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                                <div
                                    class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4">
                                    <div
                                        class="size-12 rounded-full bg-blue-50 flex items-center justify-center text-blue-600">
                                        <span class="material-symbols-outlined">shopping_bag</span>
                                    </div>
                                    <div>
                                        <p class="text-xs font-bold text-slate-500 uppercase tracking-wider">Tổng đơn
                                            hàng</p>
                                        <p class="text-2xl font-bold">${stats.totalOrders}</p>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4">
                                    <div
                                        class="size-12 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                                        <span class="material-symbols-outlined">payments</span>
                                    </div>
                                    <div>
                                        <p class="text-xs font-bold text-slate-500 uppercase tracking-wider">Tổng chi
                                            tiêu</p>
                                        <p class="text-2xl font-bold">
                                            <fmt:formatNumber value="${stats.totalSpend}" pattern="#,###" />đ
                                        </p>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm flex items-center gap-4">
                                    <div
                                        class="size-12 rounded-full bg-amber-50 flex items-center justify-center text-amber-600">
                                        <span class="material-symbols-outlined">star</span>
                                    </div>
                                    <div>
                                        <p class="text-xs font-bold text-slate-500 uppercase tracking-wider">Số đánh giá
                                        </p>
                                        <p class="text-2xl font-bold">${stats.totalReviews}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Tabs Panel -->
                            <div
                                class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
                                <!-- Tab Headers -->
                                <div class="flex border-b border-slate-200 dark:border-slate-800 overflow-x-auto">
                                    <a href="?id=${detailUser.id}&tab=orders"
                                        class="px-6 py-4 text-sm whitespace-nowrap border-b-2 ${activeTab == 'orders' ? 'border-primary text-primary font-bold' : 'border-transparent text-slate-500 hover:text-slate-800 font-medium'}">Lịch
                                        sử đơn hàng</a>
                                    <a href="?id=${detailUser.id}&tab=addresses"
                                        class="px-6 py-4 text-sm whitespace-nowrap border-b-2 ${activeTab == 'addresses' ? 'border-primary text-primary font-bold' : 'border-transparent text-slate-500 hover:text-slate-800 font-medium'}">Địa
                                        chỉ giao hàng</a>
                                    <a href="?id=${detailUser.id}&tab=reviews"
                                        class="px-6 py-4 text-sm whitespace-nowrap border-b-2 ${activeTab == 'reviews' ? 'border-primary text-primary font-bold' : 'border-transparent text-slate-500 hover:text-slate-800 font-medium'}">Đánh
                                        giá sản phẩm</a>
                                </div>

                                <!-- TAB: ORDERS -->
                                <c:if test="${activeTab == 'orders'}">
                                    <div class="overflow-x-auto">
                                        <table class="w-full text-left border-collapse">
                                            <thead>
                                                <tr class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200">
                                                    <th
                                                        class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                        Mã đơn hàng</th>
                                                    <th
                                                        class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                        Ngày đặt</th>
                                                    <th
                                                        class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                        Tổng tiền</th>
                                                    <th
                                                        class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">
                                                        Trạng thái</th>
                                                    <th
                                                        class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">
                                                        Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                                <c:forEach items="${orders}" var="o">
                                                    <tr
                                                        class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                                        <td class="px-6 py-4 font-bold text-primary">#NSV-${o.id}</td>
                                                        <td class="px-6 py-4 text-sm">
                                                            <fmt:formatDate value="${o.createdAt}"
                                                                pattern="dd/MM/yyyy" />
                                                        </td>
                                                        <td class="px-6 py-4 text-sm font-medium">
                                                            <fmt:formatNumber value="${o.totalAmount}"
                                                                pattern="#,###" />đ
                                                        </td>
                                                        <td class="px-6 py-4">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${o.status == 'DELIVERED' or o.status == 'CONFIRMED'}">
                                                                    <span
                                                                        class="px-2 py-1 rounded text-[10px] font-bold bg-green-100 text-green-700 uppercase">Đã
                                                                        giao</span>
                                                                </c:when>
                                                                <c:when test="${o.status == 'PENDING'}">
                                                                    <span
                                                                        class="px-2 py-1 rounded text-[10px] font-bold bg-amber-100 text-amber-700 uppercase">Đang
                                                                        xử lý</span>
                                                                </c:when>
                                                                <c:when test="${o.status == 'CANCELLED'}">
                                                                    <span
                                                                        class="px-2 py-1 rounded text-[10px] font-bold bg-red-100 text-red-700 uppercase">Đã
                                                                        hủy</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="px-2 py-1 rounded text-[10px] font-bold bg-slate-100 text-slate-600 uppercase">${o.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="px-6 py-4 text-right">
                                                            <button
                                                                class="text-slate-400 hover:text-primary transition-colors p-1">
                                                                <span
                                                                    class="material-symbols-outlined">visibility</span>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty orders}">
                                                    <tr>
                                                        <td colspan="5" class="py-10 text-center text-slate-400">
                                                            <span
                                                                class="material-symbols-outlined text-3xl block mb-2">receipt_long</span>
                                                            Chưa có đơn hàng nào.
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- Pagination -->
                                    <div
                                        class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 flex items-center justify-between">
                                        <p class="text-sm text-slate-500">Hiển thị ${orders.size()} trong tổng số
                                            ${totalItems} đơn hàng</p>
                                        <div class="flex items-center gap-1">
                                            <a href="?id=${detailUser.id}&tab=orders&page=${currentPage - 1}"
                                                class="px-3 py-1 text-sm rounded bg-slate-100 hover:bg-slate-200 ${currentPage <= 1 ? 'pointer-events-none opacity-50' : ''}">Trước</a>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?id=${detailUser.id}&tab=orders&page=${i}"
                                                    class="px-3 py-1 text-sm rounded ${currentPage == i ? 'bg-primary text-white font-bold' : 'bg-slate-100 hover:bg-slate-200'}">${i}</a>
                                            </c:forEach>
                                            <a href="?id=${detailUser.id}&tab=orders&page=${currentPage + 1}"
                                                class="px-3 py-1 text-sm rounded bg-slate-100 hover:bg-slate-200 ${currentPage >= totalPages ? 'pointer-events-none opacity-50' : ''}">Tiếp</a>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- TAB: ADDRESSES -->
                                <c:if test="${activeTab == 'addresses'}">
                                    <div class="p-6 grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <c:forEach items="${addresses}" var="addr" varStatus="st">
                                            <div
                                                class="p-4 border border-slate-200 dark:border-slate-700 rounded-xl relative hover:shadow-sm transition-shadow">
                                                <c:if test="${st.first}">
                                                    <span
                                                        class="absolute top-4 right-4 text-primary font-bold text-[10px] bg-primary/10 px-2 py-0.5 rounded uppercase">Mặc
                                                        định</span>
                                                </c:if>
                                                <h4 class="font-bold mb-2 text-slate-800">Địa chỉ ${st.index + 1}</h4>
                                                <p class="text-sm text-slate-600 dark:text-slate-400">
                                                    ${addr.addressLine}</p>
                                                <p class="text-sm text-slate-500 mt-2 flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-sm">person</span>
                                                    ${addr.receiver}
                                                    &nbsp;|&nbsp; <span
                                                        class="material-symbols-outlined text-sm">call</span>
                                                    ${addr.phone}
                                                </p>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty addresses}">
                                            <div class="col-span-2 py-10 text-center text-slate-400">
                                                <span
                                                    class="material-symbols-outlined text-3xl block mb-2">location_off</span>
                                                Chưa có địa chỉ giao hàng nào.
                                            </div>
                                        </c:if>
                                    </div>
                                </c:if>

                                <!-- TAB: REVIEWS -->
                                <c:if test="${activeTab == 'reviews'}">
                                    <div class="divide-y divide-slate-100 dark:divide-slate-800">
                                        <c:forEach items="${reviews}" var="rv">
                                            <div class="p-6">
                                                <div class="flex items-start justify-between mb-2">
                                                    <div>
                                                        <p class="font-bold text-sm text-slate-800">${rv.productName}
                                                        </p>
                                                        <div class="flex items-center gap-0.5 text-amber-400 mt-1">
                                                            <c:forEach begin="1" end="${rv.rating}">
                                                                <span class="material-symbols-outlined text-sm"
                                                                    style="font-variation-settings:'FILL' 1">star</span>
                                                            </c:forEach>
                                                            <c:forEach begin="${rv.rating + 1}" end="5">
                                                                <span
                                                                    class="material-symbols-outlined text-sm text-slate-300">star</span>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <span class="text-xs text-slate-400">
                                                        <fmt:formatDate value="${rv.createdAt}" pattern="dd/MM/yyyy" />
                                                    </span>
                                                </div>
                                                <p class="text-sm text-slate-600 dark:text-slate-400 italic">
                                                    "${rv.comment}"</p>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty reviews}">
                                            <div class="py-10 text-center text-slate-400">
                                                <span
                                                    class="material-symbols-outlined text-3xl block mb-2">rate_review</span>
                                                Chưa có đánh giá sản phẩm nào.
                                            </div>
                                        </c:if>
                                    </div>
                                    <!-- Pagination for Reviews -->
                                    <c:if test="${totalPages > 1}">
                                        <div
                                            class="px-6 py-4 border-t border-slate-100 flex items-center justify-end gap-1">
                                            <a href="?id=${detailUser.id}&tab=reviews&page=${currentPage - 1}"
                                                class="px-3 py-1 text-sm rounded bg-slate-100 hover:bg-slate-200 ${currentPage <= 1 ? 'pointer-events-none opacity-50' : ''}">Trước</a>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?id=${detailUser.id}&tab=reviews&page=${i}"
                                                    class="px-3 py-1 text-sm rounded ${currentPage == i ? 'bg-primary text-white font-bold' : 'bg-slate-100 hover:bg-slate-200'}">${i}</a>
                                            </c:forEach>
                                            <a href="?id=${detailUser.id}&tab=reviews&page=${currentPage + 1}"
                                                class="px-3 py-1 text-sm rounded bg-slate-100 hover:bg-slate-200 ${currentPage >= totalPages ? 'pointer-events-none opacity-50' : ''}">Tiếp</a>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </div>
                    </main>
                </div>
            </body>

            </html>