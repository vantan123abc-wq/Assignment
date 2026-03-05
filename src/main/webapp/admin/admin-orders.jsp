<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Quản lý Đơn hàng - Admin Nông Sản Việt</title>

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
                                    "background-dark": "#151d15"
                                },
                                fontFamily: { "display": ["Inter"] }
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

            <body
                class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 flex h-screen overflow-hidden">

                <aside
                    class="w-64 bg-white dark:bg-slate-900 border-r border-slate-100 dark:border-slate-800 flex flex-col h-full shrink-0">
                    <div class="h-20 flex items-center gap-2 px-6 border-b border-primary/10">
                        <div class="bg-primary p-1.5 rounded-lg text-white">
                            <span class="material-symbols-outlined text-2xl">agriculture</span>
                        </div>
                        <h1 class="text-xl font-black tracking-tight text-primary">Admin Panel</h1>
                    </div>

                    <nav class="flex-1 overflow-y-auto py-6 px-4 space-y-2">
                        <a href="${pageContext.request.contextPath}/admin"
                            class="flex items-center gap-3 px-4 py-3 text-slate-500 hover:bg-slate-50 hover:text-primary rounded-xl font-medium transition-colors">
                            <span class="material-symbols-outlined">dashboard</span> Tổng quan
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users"
                            class="flex items-center gap-3 px-4 py-3 text-slate-500 hover:bg-slate-50 hover:text-primary rounded-xl font-medium transition-colors">
                            <span class="material-symbols-outlined">group</span> Người dùng
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/inventory"
                            class="flex items-center gap-3 px-4 py-3 text-slate-500 hover:bg-slate-50 hover:text-primary rounded-xl font-medium transition-colors">
                            <span class="material-symbols-outlined">inventory_2</span> Kho hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/orders"
                            class="flex items-center gap-3 px-4 py-3 bg-primary/10 text-primary rounded-xl font-semibold transition-colors">
                            <span class="material-symbols-outlined">receipt_long</span> Đơn hàng
                        </a>
                    </nav>

                    <div class="p-4 border-t border-slate-100">
                        <a href="${pageContext.request.contextPath}/logout"
                            class="flex items-center justify-center gap-2 w-full p-3 rounded-xl bg-red-50 text-red-600 font-semibold hover:bg-red-100 transition-colors">
                            <span class="material-symbols-outlined">logout</span> Đăng xuất
                        </a>
                    </div>
                </aside>

                <main class="flex-1 h-full overflow-y-auto bg-background-light p-8">
                    <div class="flex items-center justify-between mb-8">
                        <div>
                            <h2 class="text-3xl font-black text-slate-800">Quản lý Đơn hàng</h2>
                            <p class="text-slate-500 mt-1">Xem, cập nhật trạng thái và xử lý yêu cầu trả hàng.</p>
                        </div>

                        <div class="flex flex-row items-center gap-4">
                            <div
                                class="flex items-center gap-3 bg-white px-4 py-2 rounded-full shadow-sm border border-slate-100">
                                <div
                                    class="size-10 rounded-full bg-primary text-white flex items-center justify-center">
                                    <span class="material-symbols-outlined">shield_person</span>
                                </div>
                                <span class="font-bold">Admin
                                    <c:out value="${sessionScope.account.username}" />
                                </span>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty sessionScope.message}">
                        <div
                            class="mb-6 p-4 rounded-xl ${sessionScope.messageType == 'success' ? 'bg-green-50 text-green-700 border-green-200' : 'bg-red-50 text-red-700 border-red-200'} border flex items-center gap-3">
                            <span class="material-symbols-outlined">${sessionScope.messageType == 'success' ?
                                'check_circle' : 'error'}</span>
                            <span class="font-medium">${sessionScope.message}</span>
                        </div>
                        <c:remove var="message" scope="session" />
                        <c:remove var="messageType" scope="session" />
                    </c:if>

                    <section class="bg-white border border-slate-100 rounded-2xl p-6 shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full text-sm text-left">
                                <thead class="text-xs text-slate-500 uppercase bg-slate-50 border-b border-slate-100">
                                    <tr>
                                        <th class="px-4 py-3 rounded-tl-xl">Mã ĐH</th>
                                        <th class="px-4 py-3">Mã Khách</th>
                                        <th class="px-4 py-3">Ngày đặt</th>
                                        <th class="px-4 py-3 text-right">Tổng tiền</th>
                                        <th class="px-4 py-3 text-center">Trạng thái</th>
                                        <th class="px-4 py-3 text-center">Lý do trả hàng</th>
                                        <th class="px-4 py-3 rounded-tr-xl text-center">Thao tác / Cập nhật</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100">
                                    <c:forEach var="order" items="${orders}">
                                        <tr class="hover:bg-slate-50 transition-colors">
                                            <td class="px-4 py-4 font-bold text-slate-900 border-r border-slate-100">
                                                #${order.id}</td>
                                            <td class="px-4 py-4 font-medium">Khách #${order.accountId}</td>
                                            <td class="px-4 py-4 text-slate-500">
                                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td class="px-4 py-4 text-right font-bold text-primary">
                                                <fmt:formatNumber pattern="#,###" value="${order.totalAmount}" /> ₫
                                            </td>
                                            <td class="px-4 py-4 text-center">
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span
                                                            class="bg-orange-100 text-orange-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center text-nowrap truncate">Chờ
                                                            xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CONFIRMED'}">
                                                        <span
                                                            class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center text-nowrap truncate">Đã
                                                            xác nhận (Đã TT)</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <span
                                                            class="bg-teal-100 text-teal-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center text-nowrap truncate">Đã
                                                            giao hàng</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'COMPLETED'}">
                                                        <span
                                                            class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center text-nowrap truncate">Hoàn
                                                            thành</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'RETURN_REQUESTED'}">
                                                        <span
                                                            class="bg-yellow-100 text-yellow-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center truncate border border-yellow-300 animate-pulse"
                                                            title="Yêu cầu Trả hàng / Hoàn tiền">Yêu cầu Trả hàng</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'RETURN_ACCEPTED'}">
                                                        <span
                                                            class="bg-purple-100 text-purple-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center text-nowrap truncate"
                                                            title="Đã chấp nhận trả hàng">Đã Trả Hàng</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="bg-slate-100 text-slate-700 px-3 py-1 rounded-full text-xs font-bold inline-block w-28 text-center text-nowrap truncate">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-4 py-4 text-center max-w-[160px]">
                                                <c:choose>
                                                    <c:when
                                                        test="${not empty order.returnReason and (order.status == 'RETURN_REQUESTED' or order.status == 'RETURN_ACCEPTED')}">
                                                        <span
                                                            class="inline-block bg-yellow-50 text-yellow-800 border border-yellow-200 rounded-lg px-2 py-1 text-xs font-semibold leading-snug"
                                                            title="${order.returnReason}">
                                                            ${order.returnReason}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-slate-300 text-xs">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-4 py-4 text-center">
                                                <form
                                                    action="${pageContext.request.contextPath}/admin/orders/update-status"
                                                    method="post" class="flex items-center justify-center gap-2">
                                                    <input type="hidden" name="orderId" value="${order.id}">

                                                    <c:if test="${order.status == 'RETURN_REQUESTED'}">
                                                        <select name="status"
                                                            class="text-sm font-medium rounded-lg border-slate-200 focus:ring-primary focus:border-primary py-1.5 px-3 bg-red-50 text-red-700">
                                                            <option value="RETURN_ACCEPTED">Chấp nhận Trả / Hoàn tiền
                                                            </option>
                                                            <option value="DELIVERED">Từ chối Trả (Giữ nguyên)</option>
                                                        </select>
                                                        <button type="submit"
                                                            class="bg-primary hover:bg-primary/90 text-white p-1.5 rounded-lg transition-colors flex items-center justify-center"
                                                            title="Lưu trạng thái">
                                                            <span class="material-symbols-outlined text-sm">save</span>
                                                        </button>
                                                    </c:if>

                                                    <c:if test="${order.status != 'RETURN_REQUESTED'}">
                                                        <select name="status"
                                                            class="text-sm rounded-lg border-slate-200 focus:ring-primary focus:border-primary py-1.5 px-3">
                                                            <option value="PENDING" ${order.status=='PENDING'
                                                                ? 'selected' : '' }>Chờ xử lý</option>
                                                            <option value="CONFIRMED" ${order.status=='CONFIRMED'
                                                                ? 'selected' : '' }>Đã xác nhận</option>
                                                            <option value="DELIVERED" ${order.status=='DELIVERED'
                                                                ? 'selected' : '' }>Đã giao hàng</option>
                                                            <option value="COMPLETED" ${order.status=='COMPLETED'
                                                                ? 'selected' : '' }>Hoàn thành</option>
                                                            <option value="CANCELLED" ${order.status=='CANCELLED'
                                                                ? 'selected' : '' }>Đã Hủy</option>
                                                        </select>
                                                        <button type="submit"
                                                            class="bg-blue-500 hover:bg-blue-600 text-white p-1.5 rounded-lg transition-colors flex items-center justify-center"
                                                            title="Cập nhật">
                                                            <span
                                                                class="material-symbols-outlined text-sm">update</span>
                                                        </button>
                                                    </c:if>

                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="7" class="px-4 py-8 text-center text-slate-500 font-medium">
                                                Chưa có đơn hàng nào trong hệ thống.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </section>
                </main>

            </body>

            </html>