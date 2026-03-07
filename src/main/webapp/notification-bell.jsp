<%@ page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="utils.NotificationHelper" %>
                <%@ page import="java.util.List" %>
                    <%@ page import="model.Account" %>
                        <% Account _bellAccount=(Account) session.getAttribute("account"); if (_bellAccount !=null
                            && "USER" .equals(_bellAccount.getRole())) {
                            utils.NotificationHelper.transferPendingToSession(_bellAccount.getId(), session); }
                            List<utils.NotificationHelper.Notification> notifications =
                            utils.NotificationHelper.getAll(session);
                            request.setAttribute("bellNotifications", notifications);
                            %>
                            <c:if test="${not empty sessionScope.account and sessionScope.account.role == 'USER'}">

                                <div id="notif-bell-wrapper" class="relative" style="z-index:1000;">

                                    <!-- Bell Button -->
                                    <button id="notifBellBtn" onclick="toggleNotifPanel()"
                                        class="relative p-2.5 rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300 transition-colors focus:outline-none"
                                        title="Thông báo">
                                        <span class="material-symbols-outlined">notifications</span>

                                        <!-- Unread badge -->
                                        <c:if test="${not empty bellNotifications}">
                                            <span id="notifBadge"
                                                class="absolute top-1.5 right-1.5 w-2.5 h-2.5 bg-red-500 rounded-full border-2 border-white animate-pulse"></span>
                                        </c:if>
                                    </button>

                                    <!-- Notification Panel -->
                                    <div id="notifPanel"
                                        class="hidden absolute right-0 top-full mt-2 w-80 bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl shadow-2xl overflow-hidden"
                                        style="z-index:9999;">

                                        <!-- Header -->
                                        <div
                                            class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-800/50">
                                            <h4 class="font-bold text-sm text-slate-800 dark:text-white">Thông báo của
                                                bạn
                                            </h4>
                                            <c:if test="${not empty bellNotifications}">
                                                <form action="${pageContext.request.contextPath}/notifications/clear"
                                                    method="post" class="m-0 p-0">
                                                    <button type="submit"
                                                        class="text-xs text-slate-400 hover:text-red-500 transition-colors font-medium">
                                                        Xóa tất cả
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>

                                        <!-- Notifications list -->
                                        <div
                                            class="max-h-80 overflow-y-auto divide-y divide-slate-50 dark:divide-slate-800">
                                            <c:choose>
                                                <c:when test="${empty bellNotifications}">
                                                    <div
                                                        class="flex flex-col items-center justify-center py-10 px-4 text-center">
                                                        <span
                                                            class="material-symbols-outlined text-4xl text-slate-300 mb-2">notifications_none</span>
                                                        <p class="text-sm text-slate-400 font-medium">Chưa có thông báo
                                                            nào
                                                        </p>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="notif" items="${bellNotifications}">
                                                        <a href="${notif.link}"
                                                            class="flex items-start gap-3 px-4 py-3.5 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors group">
                                                            <div class="shrink-0 mt-0.5">
                                                                <c:choose>
                                                                    <c:when test="${notif.type == 'success'}">
                                                                        <div
                                                                            class="size-8 rounded-full bg-green-100 text-green-600 flex items-center justify-center">
                                                                            <span
                                                                                class="material-symbols-outlined text-sm">${notif.icon}</span>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:when test="${notif.type == 'warning'}">
                                                                        <div
                                                                            class="size-8 rounded-full bg-yellow-100 text-yellow-600 flex items-center justify-center">
                                                                            <span
                                                                                class="material-symbols-outlined text-sm">${notif.icon}</span>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div
                                                                            class="size-8 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center">
                                                                            <span
                                                                                class="material-symbols-outlined text-sm">${notif.icon}</span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="flex-1 min-w-0">
                                                                <p
                                                                    class="text-sm font-medium text-slate-800 dark:text-white group-hover:text-primary transition-colors leading-snug">
                                                                    ${notif.message}</p>
                                                                <p class="text-xs text-slate-400 mt-0.5">
                                                                    <fmt:formatDate value="${notif.timestamp}"
                                                                        type="both" dateStyle="short" timeStyle="short"
                                                                        var="formattedDate" />
                                                                    Nhấn để xem đơn hàng →
                                                                </p>
                                                            </div>
                                                        </a>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Footer -->
                                        <div
                                            class="border-t border-slate-100 dark:border-slate-800 px-4 py-3 bg-slate-50/50 dark:bg-slate-800/30 text-center">
                                            <a href="${pageContext.request.contextPath}/order-history"
                                                class="text-sm font-semibold text-primary hover:underline flex items-center justify-center gap-1">
                                                <span class="material-symbols-outlined text-sm">receipt_long</span>
                                                Xem tất cả đơn hàng
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <style>
                                    #notifPanel {
                                        transform-origin: top right;
                                        transition: opacity 0.15s ease, transform 0.15s ease;
                                    }

                                    #notifPanel.hidden {
                                        display: none !important;
                                    }
                                </style>

                                <script>
                                    (function () {
                                        function toggleNotifPanel() {
                                            const panel = document.getElementById('notifPanel');
                                            const badge = document.getElementById('notifBadge');
                                            panel.classList.toggle('hidden');
                                            // Hide badge once opened
                                            if (!panel.classList.contains('hidden') && badge) {
                                                badge.style.display = 'none';
                                            }
                                        }
                                        window.toggleNotifPanel = toggleNotifPanel;

                                        // Close when clicking outside
                                        document.addEventListener('click', function (e) {
                                            const wrapper = document.getElementById('notif-bell-wrapper');
                                            const panel = document.getElementById('notifPanel');
                                            if (wrapper && !wrapper.contains(e.target) && panel && !panel.classList.contains('hidden')) {
                                                panel.classList.add('hidden');
                                            }
                                        });
                                    })();
                                </script>

                            </c:if>