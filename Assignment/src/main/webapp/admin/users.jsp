<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Quản lý người dùng - Nông Sản Việt</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap"
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
                                <h1 class="text-base font-bold text-slate-900 dark:text-white leading-tight">Nông Sản
                                    Việt</h1>
                                <p class="text-xs text-slate-500 dark:text-slate-400">Admin Panel</p>
                            </div>
                        </div>
                        <nav class="flex-1 px-4 py-4 space-y-1">
                            <a class="flex items-center gap-3 px-3 py-2 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="${pageContext.request.contextPath}/admin">
                                <span class="material-symbols-outlined">dashboard</span>
                                <span class="text-sm font-medium">Tổng quan</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-2 bg-primary/10 text-primary rounded-lg transition-colors font-bold"
                                href="${pageContext.request.contextPath}/admin/users">
                                <span class="material-symbols-outlined"
                                    style="font-variation-settings: 'FILL' 1">group</span>
                                <span class="text-sm font-medium">Người dùng</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-2 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="${pageContext.request.contextPath}/admin/inventory">
                                <span class="material-symbols-outlined">inventory_2</span>
                                <span class="text-sm font-medium">Kho hàng</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-2 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="#">
                                <span class="material-symbols-outlined">shopping_cart</span>
                                <span class="text-sm font-medium">Đơn hàng</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-2 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors"
                                href="#">
                                <span class="material-symbols-outlined">description</span>
                                <span class="text-sm font-medium">Báo cáo</span>
                            </a>
                        </nav>
                        <div class="p-4 border-t border-slate-200 dark:border-slate-800">
                            <div class="flex items-center gap-3 p-2">
                                <div
                                    class="size-10 rounded-xl bg-primary/20 border-2 border-primary/30 flex justify-center items-center text-primary font-bold">
                                    <span class="material-symbols-outlined">shield_person</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-sm font-semibold truncate">Admin
                                        <c:out value="${sessionScope.account.username}" />
                                    </p>
                                    <p class="text-xs text-slate-500 dark:text-slate-400 truncate">Quản trị viên</p>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="flex items-center justify-center gap-2 w-full mt-2 py-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors text-sm font-medium">
                                <span class="material-symbols-outlined text-[18px]">logout</span>
                                Đăng xuất
                            </a>
                        </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="flex-1 ml-64 min-h-screen">
                        <!-- Header -->
                        <header
                            class="bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 h-16 flex items-center justify-between px-8 sticky top-0 z-10">
                            <h2 class="text-xl font-bold">Quản lý người dùng</h2>
                            <div class="flex items-center gap-6">
                                <div class="relative w-72">
                                    <span
                                        class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                                    <input id="searchInput" name="keyword" value="${paramKeyword}"
                                        class="w-full pl-10 pr-4 py-2 bg-slate-100 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                        placeholder="Tìm kiếm tài khoản..." type="text" />
                                </div>
                                <button
                                    class="relative p-2 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full">
                                    <span class="material-symbols-outlined">notifications</span>
                                    <span
                                        class="absolute top-2 right-2 w-2 h-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                                </button>
                            </div>
                        </header>

                        <div class="p-8 space-y-8">
                            <!-- Statistics Grid -->
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 flex flex-col gap-2">
                                    <div class="flex items-center justify-between">
                                        <span class="text-slate-500 dark:text-slate-400 text-sm font-medium">Tổng người
                                            dùng</span>
                                        <span
                                            class="p-2 bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400 rounded-lg material-symbols-outlined">groups</span>
                                    </div>
                                    <p class="text-3xl font-bold">
                                        <fmt:formatNumber value="${totalUsers}" pattern="#,###" />
                                    </p>
                                    <div class="flex items-center gap-1 text-primary text-sm font-medium">
                                        <span class="material-symbols-outlined text-sm">trending_up</span>
                                        <span>Cập nhật liên tục</span>
                                    </div>
                                </div>

                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 flex flex-col gap-2">
                                    <div class="flex items-center justify-between">
                                        <span class="text-slate-500 dark:text-slate-400 text-sm font-medium">Đang hoạt
                                            động</span>
                                        <span
                                            class="p-2 bg-emerald-100 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400 rounded-lg material-symbols-outlined">online_prediction</span>
                                    </div>
                                    <p class="text-3xl font-bold">
                                        <fmt:formatNumber value="${activeUsers}" pattern="#,###" />
                                    </p>
                                    <div class="flex items-center gap-1 text-primary text-sm font-medium">
                                        <span class="material-symbols-outlined text-sm">trending_up</span>
                                        <span>Trạng thái Active</span>
                                    </div>
                                </div>

                                <div
                                    class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 flex flex-col gap-2">
                                    <div class="flex items-center justify-between">
                                        <span class="text-slate-500 dark:text-slate-400 text-sm font-medium">Người dùng
                                            mới</span>
                                        <span
                                            class="p-2 bg-amber-100 text-amber-600 dark:bg-amber-900/30 dark:text-amber-400 rounded-lg material-symbols-outlined">person_add</span>
                                    </div>
                                    <p class="text-3xl font-bold">
                                        <fmt:formatNumber value="${newUsers}" pattern="#,###" />
                                    </p>
                                    <div class="flex items-center gap-1 text-primary text-sm font-medium">
                                        <span class="material-symbols-outlined text-sm">trending_up</span>
                                        <span>Trong 30 ngày qua</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Advanced Filters (Added matching exact HTML from user) -->
                            <div
                                class="grid grid-cols-1 md:grid-cols-4 gap-4 bg-white dark:bg-slate-900 p-4 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
                                <div class="space-y-1">
                                    <label class="text-xs font-bold text-slate-500 uppercase">Trạng thái</label>
                                    <select
                                        class="w-full text-sm border-slate-200 dark:border-slate-800 dark:bg-slate-800 rounded-lg focus:ring-primary transition-colors">
                                        <option>Tất cả trạng thái</option>
                                        <option>Đang hoạt động</option>
                                        <option>Bị khóa</option>
                                    </select>
                                </div>
                                <div class="space-y-1">
                                    <label class="text-xs font-bold text-slate-500 uppercase">Từ ngày</label>
                                    <input
                                        class="w-full text-sm border-slate-200 dark:border-slate-800 dark:bg-slate-800 rounded-lg focus:ring-primary transition-colors hover:border-slate-300 dark:hover:border-slate-700"
                                        type="date" />
                                </div>
                                <div class="space-y-1">
                                    <label class="text-xs font-bold text-slate-500 uppercase">Đến ngày</label>
                                    <input
                                        class="w-full text-sm border-slate-200 dark:border-slate-800 dark:bg-slate-800 rounded-lg focus:ring-primary transition-colors hover:border-slate-300 dark:hover:border-slate-700"
                                        type="date" />
                                </div>
                                <div class="flex items-end">
                                    <button onclick="applyFilters()"
                                        class="w-full bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 py-2 rounded-lg text-sm font-semibold transition-colors flex justify-center items-center h-[38px] text-slate-700 dark:text-slate-300">
                                        Áp dụng bộ lọc
                                    </button>
                                </div>
                            </div>

                            <!-- Table Controls & Tabs -->
                            <div class="flex items-center justify-between mt-6">
                                <div class="flex bg-slate-200/50 dark:bg-slate-800 p-1 rounded-lg">
                                    <a href="${pageContext.request.contextPath}/admin/users?role=&keyword=${paramKeyword}"
                                        class="px-6 py-2 rounded-md text-sm font-semibold ${(empty paramRole or paramRole == 'All' or paramRole == '') ? 'bg-white dark:bg-slate-700 shadow-sm text-slate-900' : 'text-slate-500 hover:text-slate-700'}">Tất
                                        cả</a>
                                    <a href="${pageContext.request.contextPath}/admin/users?role=ADMIN&keyword=${paramKeyword}"
                                        class="px-6 py-2 rounded-md text-sm font-medium ${paramRole == 'ADMIN' ? 'bg-white dark:bg-slate-700 shadow-sm font-bold text-slate-900' : 'text-slate-500 hover:text-slate-700'}">Admin</a>
                                    <a href="${pageContext.request.contextPath}/admin/users?role=USER&keyword=${paramKeyword}"
                                        class="px-6 py-2 rounded-md text-sm font-medium ${paramRole == 'USER' ? 'bg-white dark:bg-slate-700 shadow-sm font-bold text-slate-900' : 'text-slate-500 hover:text-slate-700'}">User</a>
                                </div>
                                <button onclick="document.getElementById('addUserModal').classList.remove('hidden')"
                                    class="flex items-center gap-2 bg-primary hover:bg-primary/90 text-white px-6 py-2.5 rounded-lg font-bold transition-all">
                                    <span class="material-symbols-outlined">add</span>
                                    Thêm người dùng mới
                                </button>
                            </div>

                            <!-- User Table -->
                            <div
                                class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 overflow-hidden shadow-sm">
                                <table class="w-full text-left border-collapse">
                                    <thead>
                                        <tr
                                            class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                                Người dùng</th>
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                                Số điện thoại</th>
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                                Vai trò</th>
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                                Trạng thái</th>
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider text-center">
                                                Ngày tham gia</th>
                                            <th
                                                class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider text-right">
                                                Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-200 dark:divide-slate-800">
                                        <c:forEach items="${usersList}" var="u">
                                            <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                                <td class="px-6 py-4">
                                                    <a href="${pageContext.request.contextPath}/admin/users/detail?id=${u.id}"
                                                        class="flex items-center gap-3 group">
                                                        <div
                                                            class="w-10 h-10 rounded-full bg-slate-200 flex items-center justify-center font-bold text-slate-600 text-lg group-hover:bg-primary/10 group-hover:text-primary transition-colors">
                                                            ${empty u.fullName ? 'U' :
                                                            u.fullName.substring(0,1).toUpperCase()}
                                                        </div>
                                                        <div>
                                                            <p
                                                                class="text-sm font-semibold group-hover:text-primary transition-colors">
                                                                ${u.fullName}</p>
                                                            <p class="text-xs text-slate-500 dark:text-slate-400">
                                                                ${u.email}</p>
                                                        </div>
                                                    </a>
                                                </td>

                                                <td
                                                    class="px-6 py-4 text-sm font-medium text-slate-700 dark:text-slate-200">
                                                    ${u.phone ne null ? u.phone : u.username}</td>

                                                <td class="px-6 py-4">
                                                    <c:choose>
                                                        <c:when test="${u.role == 'ADMIN'}">
                                                            <span
                                                                class="px-2.5 py-1 bg-primary/10 text-primary text-xs font-bold rounded-full">ADMIN</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="px-2.5 py-1 bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 text-xs font-bold rounded-full">USER</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td class="px-6 py-4">
                                                    <div class="flex items-center gap-2">
                                                        <c:choose>
                                                            <c:when test="${u.status}">
                                                                <span class="w-2 h-2 rounded-full bg-primary"></span>
                                                                <span class="text-sm text-slate-700 font-medium">Đang
                                                                    hoạt động</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="w-2 h-2 rounded-full bg-slate-300"></span>
                                                                <span class="text-sm text-slate-500 font-medium">Bị
                                                                    khóa</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>

                                                <td
                                                    class="px-6 py-4 text-sm text-slate-500 dark:text-slate-400 text-center font-medium">
                                                    <fmt:formatDate value="${u.createdAt}" pattern="dd/MM/yyyy" />
                                                </td>

                                                <td class="px-6 py-4 text-right">
                                                    <div class="flex justify-end gap-2">
                                                        <button
                                                            onclick="openEditModal('${u.id}','${u.fullName}','${u.email}','${u.phone}','${u.role}')"
                                                            class="p-2 text-slate-400 hover:text-primary transition-colors hover:bg-slate-100 rounded-lg"
                                                            title="Chỉnh sửa">
                                                            <span class="material-symbols-outlined text-lg">edit</span>
                                                        </button>
                                                        <form action="${pageContext.request.contextPath}/admin/users"
                                                            method="POST" class="inline"
                                                            onsubmit="return confirm('Xác nhận đổi trạng thái của người dùng này?');">
                                                            <input type="hidden" name="action" value="toggleStatus" />
                                                            <input type="hidden" name="id" value="${u.id}" />
                                                            <input type="hidden" name="keyword"
                                                                value="${paramKeyword}" />
                                                            <input type="hidden" name="role" value="${paramRole}" />
                                                            <input type="hidden" name="page" value="${currentPage}" />
                                                            <button type="submit"
                                                                class="p-2 text-slate-400 transition-colors rounded-lg flex items-center justify-center ${u.status ? 'hover:text-amber-500 hover:bg-amber-50' : 'hover:text-primary hover:bg-primary/10'}">
                                                                <c:choose>
                                                                    <c:when test="${u.status}">
                                                                        <span class="material-symbols-outlined text-lg"
                                                                            title="Khóa">block</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="material-symbols-outlined text-lg"
                                                                            title="Mở khóa">check_circle</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty usersList}">
                                            <tr>
                                                <td colspan="6"
                                                    class="py-12 text-center text-slate-400 bg-slate-50 dark:bg-slate-800/50">
                                                    <span
                                                        class="material-symbols-outlined text-4xl mb-2 block mx-auto text-slate-300">group_off</span>
                                                    <p class="font-medium">Không tìm thấy dữ liệu phù hợp.</p>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>

                                <!-- Pagination -->
                                <div
                                    class="px-6 py-4 bg-slate-50 dark:bg-slate-800/50 flex items-center justify-between">
                                    <p class="text-sm text-slate-500 dark:text-slate-400">Hiển thị kết quả cho <span
                                            class="font-bold text-slate-900 dark:text-white ml-1">
                                            <fmt:formatNumber value="${totalFilteredUsers}" pattern="#,###" />
                                        </span> người dùng</p>

                                    <div class="flex items-center gap-1">
                                        <a href="?page=${currentPage - 1}&role=${paramRole}&keyword=${paramKeyword}"
                                            class="p-2 text-slate-400 hover:text-primary ${currentPage <= 1 ? 'pointer-events-none opacity-50' : ''}">
                                            <span class="material-symbols-outlined">chevron_left</span>
                                        </a>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <a href="?page=${i}&role=${paramRole}&keyword=${paramKeyword}"
                                                class="w-8 h-8 rounded flex items-center justify-center text-sm font-medium ${currentPage == i ? 'bg-primary text-white font-bold' : 'hover:bg-slate-200 dark:hover:bg-slate-700 font-medium text-slate-600'}">${i}</a>
                                        </c:forEach>
                                        <a href="?page=${currentPage + 1}&role=${paramRole}&keyword=${paramKeyword}"
                                            class="p-2 text-slate-400 hover:text-primary ${currentPage >= totalPages ? 'pointer-events-none opacity-50' : ''}">
                                            <span class="material-symbols-outlined">chevron_right</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>

                <!-- Edit User Modal -->
                <div id="editUserModal"
                    class="fixed inset-0 z-50 hidden bg-black/50 flex items-center justify-center p-4">
                    <div class="bg-white dark:bg-slate-900 rounded-xl shadow-lg w-full max-w-md overflow-hidden">
                        <div
                            class="flex items-center justify-between p-6 border-b border-slate-200 dark:border-slate-800">
                            <h3 class="text-xl font-bold">Chỉnh sửa thông tin người dùng</h3>
                            <button onclick="document.getElementById('editUserModal').classList.add('hidden')"
                                class="text-slate-400 hover:text-slate-600">
                                <span class="material-symbols-outlined">close</span>
                            </button>
                        </div>
                        <form id="editUserForm" action="${pageContext.request.contextPath}/admin/users" method="POST"
                            class="p-6 space-y-4">
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" id="editUserId" name="id" />
                            <input type="hidden" name="keyword" value="${paramKeyword}" />
                            <input type="hidden" name="role" value="${paramRole}" />
                            <input type="hidden" name="page" value="${currentPage}" />

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 mb-1">Họ và tên</label>
                                <input id="editFullName" name="fullName" type="text" required
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập họ và tên..." />
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 mb-1">Email</label>
                                <input id="editEmail" name="email" type="email" required
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập địa chỉ email..." />
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 mb-1">Số điện thoại</label>
                                <input id="editPhone" name="phone" type="text"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập số điện thoại..." />
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 mb-1">Vai trò</label>
                                <select id="editRole" name="newRole"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none cursor-pointer">
                                    <option value="USER">User (Người dùng thường)</option>
                                    <option value="ADMIN">Admin (Quản trị viên)</option>
                                </select>
                            </div>

                            <div class="pt-4 flex items-center justify-end gap-3">
                                <button type="button"
                                    onclick="document.getElementById('editUserModal').classList.add('hidden')"
                                    class="px-5 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-100 rounded-lg">
                                    Hủy bỏ
                                </button>
                                <button type="submit"
                                    class="px-5 py-2 text-sm font-bold text-white bg-primary hover:bg-primary/90 rounded-lg">
                                    Lưu thay đổi
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Add User Modal -->
                <div id="addUserModal"
                    class="fixed inset-0 z-50 hidden bg-black/50 flex items-center justify-center p-4">
                    <div class="bg-white dark:bg-slate-900 rounded-xl shadow-lg w-full max-w-md overflow-hidden">
                        <div
                            class="flex items-center justify-between p-6 border-b border-slate-200 dark:border-slate-800">
                            <h3 class="text-xl font-bold text-slate-900 dark:text-white">Thêm người dùng mới</h3>
                            <button onclick="document.getElementById('addUserModal').classList.add('hidden')"
                                class="text-slate-400 hover:text-slate-600 transition-colors">
                                <span class="material-symbols-outlined">close</span>
                            </button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/users" method="POST"
                            class="p-6 space-y-4">
                            <input type="hidden" name="action" value="create" />

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Tên
                                    đăng nhập *</label>
                                <input name="username" required type="text"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập tên đăng nhập...">
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Mật
                                    khẩu *</label>
                                <input name="password" required type="password"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập mật khẩu...">
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Họ và
                                    tên</label>
                                <input name="fullName" type="text"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập họ tên đầy đủ...">
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Email
                                    *</label>
                                <input name="email" required type="email"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập địa chỉ email...">
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Số
                                    điện thoại</label>
                                <input name="phone" type="text"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Nhập số điện thoại...">
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Vai
                                    trò</label>
                                <select name="newRole"
                                    class="w-full px-4 py-2 bg-slate-50 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none cursor-pointer">
                                    <option value="USER">User (Người dùng thường)</option>
                                    <option value="ADMIN">Admin (Quản trị viên)</option>
                                </select>
                            </div>

                            <div class="pt-4 flex items-center justify-end gap-3">
                                <button type="button"
                                    onclick="document.getElementById('addUserModal').classList.add('hidden')"
                                    class="px-5 py-2 text-sm font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
                                    Hủy bỏ
                                </button>
                                <button type="submit"
                                    class="px-5 py-2 text-sm font-bold text-white bg-primary hover:bg-primary/90 rounded-lg transition-colors">
                                    Tạo tài khoản
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Filter & Search JS Logic -->
                <script>
                    // 1. Live Search with Debounce
                    const searchInput = document.getElementById('searchInput');
                    let debounceTimer;

                    if (searchInput) {
                        searchInput.addEventListener('input', function () {
                            clearTimeout(debounceTimer);
                            debounceTimer = setTimeout(() => {
                                applyFilters();
                            }, 500); // 500ms delay
                        });

                        // Allow Enter key to submit immediately
                        searchInput.addEventListener('keypress', function (e) {
                            if (e.key === 'Enter') {
                                clearTimeout(debounceTimer);
                                applyFilters();
                            }
                        });
                    }

                    // 2. Apply all filters
                    function applyFilters() {
                        const urlParams = new URLSearchParams(window.location.search);

                        // Keyword
                        const keyword = document.getElementById('searchInput')?.value.trim();
                        if (keyword) {
                            urlParams.set('keyword', keyword);
                        } else {
                            urlParams.delete('keyword');
                        }

                        // Reset pagination when searching
                        urlParams.set('page', '1');

                        // Redirect
                        window.location.href = window.location.pathname + '?' + urlParams.toString();
                    }
                    // 3. Edit User Modal
                    function openEditModal(id, fullName, email, phone, role) {
                        document.getElementById('editUserId').value = id;
                        document.getElementById('editFullName').value = fullName || '';
                        document.getElementById('editEmail').value = email || '';
                        document.getElementById('editPhone').value = (phone && phone !== 'null') ? phone : '';
                        const roleSelect = document.getElementById('editRole');
                        roleSelect.value = (role === 'ADMIN') ? 'ADMIN' : 'USER';
                        document.getElementById('editUserModal').classList.remove('hidden');
                    }

                    // Close modals when clicking backdrop
                    document.getElementById('editUserModal').addEventListener('click', function (e) {
                        if (e.target === this) this.classList.add('hidden');
                    });
                    document.getElementById('addUserModal').addEventListener('click', function (e) {
                        if (e.target === this) this.classList.add('hidden');
                    });
                </script>
            </body>

            </html>