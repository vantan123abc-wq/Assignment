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
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
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

                    /* Tùy chỉnh thanh cuộn */
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

            <body
                class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen flex overflow-hidden">

                <!-- Sidebar -->
                <aside
                    class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-800 flex flex-col shrink-0">
                    <div class="p-6 flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white">
                            <span class="material-symbols-outlined">eco</span>
                        </div>
                        <div>
                            <h1 class="text-base font-bold text-slate-900 dark:text-white leading-tight">Nông Sản Việt
                            </h1>
                            <p class="text-xs text-slate-500 dark:text-slate-400">Admin Panel</p>
                        </div>
                    </div>
                    <nav class="flex-1 px-4 py-4 space-y-1">
                        <a class="flex items-center gap-3 px-3 py-3 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors"
                            href="${pageContext.request.contextPath}/admin">
                            <span class="material-symbols-outlined">dashboard</span>
                            <span class="text-sm font-medium">Tổng quan</span>
                        </a>
                        <a class="flex items-center gap-3 px-3 py-3 bg-primary/10 text-primary rounded-lg transition-colors font-bold"
                            href="${pageContext.request.contextPath}/admin/users">
                            <span class="material-symbols-outlined"
                                style="font-variation-settings: 'FILL' 1">group</span>
                            <span class="text-sm">Người dùng</span>
                        </a>
                        <a class="flex items-center gap-3 px-3 py-3 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors"
                            href="${pageContext.request.contextPath}/admin/inventory">
                            <span class="material-symbols-outlined">inventory_2</span>
                            <span class="text-sm font-medium">Kho hàng</span>
                        </a>
                        <a class="flex items-center gap-3 px-3 py-3 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg transition-colors"
                            href="#">
                            <span class="material-symbols-outlined">shopping_cart</span>
                            <span class="text-sm font-medium">Đơn hàng</span>
                        </a>
                    </nav>
                    <div class="p-4 border-t border-slate-200 dark:border-slate-800">
                        <a href="${pageContext.request.contextPath}/logout"
                            class="flex items-center gap-3 w-full px-3 py-3 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors">
                            <span class="material-symbols-outlined">logout</span>
                            <span class="text-sm font-medium">Đăng xuất</span>
                        </a>
                    </div>
                </aside>

                <!-- Main Content -->
                <main class="flex-1 flex flex-col h-screen overflow-y-auto">
                    <!-- Header -->
                    <header
                        class="bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 h-16 flex items-center justify-between px-8 sticky top-0 z-10 shrink-0">
                        <h2 class="text-xl font-bold">Quản lý người dùng</h2>
                        <div class="flex items-center gap-6">
                            <form action="${pageContext.request.contextPath}/admin/users" method="GET"
                                class="relative w-72">
                                <span
                                    class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                                <input name="keyword" value="${paramKeyword}"
                                    class="w-full pl-10 pr-4 py-2 bg-slate-100 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/50 outline-none"
                                    placeholder="Tìm kiếm nhanh..." type="text" />
                                <input type="hidden" name="role" value="${paramRole}" />
                            </form>

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
                    <div class="p-8 space-y-8">
                        <!-- Statistics Grid -->
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div
                                class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 flex flex-col gap-2 shadow-sm">
                                <div class="flex items-center justify-between">
                                    <span class="text-slate-500 dark:text-slate-400 text-sm font-medium">Tổng người
                                        dùng</span>
                                    <span
                                        class="p-2 bg-blue-50 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400 rounded-lg material-symbols-outlined">groups</span>
                                </div>
                                <p class="text-3xl font-bold">
                                    <fmt:formatNumber value="${totalUsers}" pattern="#,###" />
                                </p>
                            </div>
                            <div
                                class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 flex flex-col gap-2 shadow-sm">
                                <div class="flex items-center justify-between">
                                    <span class="text-slate-500 dark:text-slate-400 text-sm font-medium">Đang hoạt
                                        động</span>
                                    <span
                                        class="p-2 bg-emerald-50 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400 rounded-lg material-symbols-outlined">online_prediction</span>
                                </div>
                                <p class="text-3xl font-bold">
                                    <fmt:formatNumber value="${activeUsers}" pattern="#,###" />
                                </p>
                            </div>
                            <div
                                class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 flex flex-col gap-2 shadow-sm">
                                <div class="flex items-center justify-between">
                                    <span class="text-slate-500 dark:text-slate-400 text-sm font-medium">Tài khoản mới
                                        (30 ngày)</span>
                                    <span
                                        class="p-2 bg-amber-50 text-amber-600 dark:bg-amber-900/30 dark:text-amber-400 rounded-lg material-symbols-outlined">person_add</span>
                                </div>
                                <p class="text-3xl font-bold">
                                    <fmt:formatNumber value="${newUsers}" pattern="#,###" />
                                </p>
                            </div>
                        </div>
                        <!-- Table Controls -->
                        <div class="flex items-center justify-between flex-wrap gap-4">
                            <div class="flex bg-slate-100 dark:bg-slate-800 p-1 rounded-lg">
                                <a href="${pageContext.request.contextPath}/admin/users?role=&keyword=${paramKeyword}"
                                    class="px-6 py-2 rounded-md text-sm cursor-pointer ${(empty paramRole or paramRole == 'All' or paramRole == '') ? 'bg-white dark:bg-slate-700 shadow-sm font-bold text-slate-900' : 'text-slate-500 font-medium hover:text-slate-700'}">Tất
                                    cả</a>
                                <a href="${pageContext.request.contextPath}/admin/users?role=ADMIN&keyword=${paramKeyword}"
                                    class="px-6 py-2 rounded-md text-sm cursor-pointer ${paramRole == 'ADMIN' ? 'bg-white dark:bg-slate-700 shadow-sm font-bold text-slate-900' : 'text-slate-500 font-medium hover:text-slate-700'}">Admin</a>
                                <a href="${pageContext.request.contextPath}/admin/users?role=USER&keyword=${paramKeyword}"
                                    class="px-6 py-2 rounded-md text-sm cursor-pointer ${paramRole == 'USER' ? 'bg-white dark:bg-slate-700 shadow-sm font-bold text-slate-900' : 'text-slate-500 font-medium hover:text-slate-700'}">User</a>
                            </div>
                            <button
                                class="flex items-center gap-2 bg-primary hover:bg-primary/90 text-white px-6 py-2.5 rounded-lg font-bold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-[18px]">add</span>
                                Thêm người dùng mới
                            </button>
                        </div>
                        <!-- User Table -->
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 overflow-x-auto shadow-sm">
                            <table class="w-full text-left border-collapse min-w-[800px]">
                                <thead>
                                    <tr
                                        class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                            Người dùng</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                            Vai trò</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                            Trạng thái</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                            Ngày tham gia</th>
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider text-right">
                                            Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                    <c:forEach items="${usersList}" var="u">
                                        <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div
                                                        class="w-10 h-10 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold text-lg shrink-0">
                                                        ${empty u.fullName ? 'U' :
                                                        u.fullName.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <div class="min-w-0">
                                                        <p
                                                            class="text-sm font-bold truncate text-slate-800 dark:text-slate-100">
                                                            ${u.fullName}</p>
                                                        <p class="text-xs text-slate-500 dark:text-slate-400 truncate">
                                                            ${u.email}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>
                                                    <c:when test="${u.role == 'ADMIN'}">
                                                        <span
                                                            class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] font-bold rounded-full uppercase">Admin</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2.5 py-1 bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 text-[10px] font-bold rounded-full uppercase">User</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-2">
                                                    <c:choose>
                                                        <c:when test="${u.status}">
                                                            <span class="w-2 h-2 rounded-full bg-primary"></span>
                                                            <span
                                                                class="text-sm font-medium text-slate-700 dark:text-slate-200">Online/Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="w-2 h-2 rounded-full bg-slate-300"></span>
                                                            <span class="text-sm font-medium text-slate-500">Bị
                                                                khóa</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td
                                                class="px-6 py-4 text-sm font-medium text-slate-600 dark:text-slate-400">
                                                <fmt:formatDate value="${u.createdAt}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td class="px-6 py-4 text-right">
                                                <div class="flex justify-end gap-2">
                                                    <button
                                                        class="p-2 text-slate-400 hover:text-primary transition-colors hover:bg-primary/10 rounded-lg">
                                                        <span class="material-symbols-outlined text-[20px]">edit</span>
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/admin/users"
                                                        method="POST" class="inline"
                                                        onsubmit="return confirm('Xác nhận đổi trạng thái của người dùng này?');">
                                                        <input type="hidden" name="action" value="toggleStatus" />
                                                        <input type="hidden" name="id" value="${u.id}" />
                                                        <input type="hidden" name="keyword" value="${paramKeyword}" />
                                                        <input type="hidden" name="role" value="${paramRole}" />
                                                        <input type="hidden" name="page" value="${currentPage}" />
                                                        <button type="submit"
                                                            class="p-2 text-slate-400 transition-colors rounded-lg flex items-center justify-center ${u.status ? 'hover:text-red-500 hover:bg-red-50' : 'hover:text-emerald-500 hover:bg-emerald-50'}">
                                                            <c:choose>
                                                                <c:when test="${u.status}"><span
                                                                        class="material-symbols-outlined text-[20px]"
                                                                        title="Khóa">lock</span></c:when>
                                                                <c:otherwise><span
                                                                        class="material-symbols-outlined text-[20px]"
                                                                        title="Mở khóa">lock_open</span></c:otherwise>
                                                            </c:choose>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty usersList}">
                                        <tr>
                                            <td colspan="5" class="py-12 text-center text-slate-400">
                                                <span
                                                    class="material-symbols-outlined text-4xl mb-2 block mx-auto text-slate-300">group_off</span>
                                                Không tìm thấy dữ liệu phù hợp.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            <!-- Pagination -->
                            <div
                                class="px-6 py-4 bg-white dark:bg-slate-800/50 flex items-center justify-between border-t border-slate-100">
                                <p class="text-sm text-slate-500 dark:text-slate-400">Kết quả lọc có: <span
                                        class="font-bold text-slate-900 dark:text-white">
                                        <fmt:formatNumber value="${totalFilteredUsers}" pattern="#,###" />
                                    </span> người dùng</p>
                                <div class="flex items-center gap-1">
                                    <a href="?page=${currentPage - 1}&role=${paramRole}&keyword=${paramKeyword}"
                                        class="p-2 text-slate-400 hover:text-primary ${currentPage <= 1 ? 'pointer-events-none opacity-50' : ''}">
                                        <span class="material-symbols-outlined">chevron_left</span>
                                    </a>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="?page=${i}&role=${paramRole}&keyword=${paramKeyword}"
                                            class="w-8 h-8 rounded flex items-center justify-center text-sm ${currentPage == i ? 'bg-primary text-white font-bold' : 'hover:bg-slate-100 dark:hover:bg-slate-700 font-medium text-slate-600'}">${i}</a>
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
            </body>

            </html>