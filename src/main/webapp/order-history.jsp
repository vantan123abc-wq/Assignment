<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Lịch sử Đơn hàng - Nông Sản Việt</title>

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
                                colors: { "primary": "#4cae4f", "background-light": "#f6f7f6" },
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

                    /* Radio card styling */
                    .reason-card input[type="radio"] {
                        display: none;
                    }

                    .reason-card label {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        border: 2px solid #e2e8f0;
                        border-radius: 12px;
                        padding: 12px 16px;
                        cursor: pointer;
                        font-size: 14px;
                        font-weight: 500;
                        color: #475569;
                        transition: all 0.18s ease;
                    }

                    .reason-card label:hover {
                        border-color: #4cae4f;
                        background: #f0faf0;
                        color: #1a2e1a;
                    }

                    .reason-card input[type="radio"]:checked+label {
                        border-color: #4cae4f;
                        background: #f0faf0;
                        color: #16a34a;
                        font-weight: 700;
                    }

                    .reason-card input[type="radio"]:checked+label .radio-dot {
                        background: #4cae4f;
                        border-color: #4cae4f;
                    }

                    .radio-dot {
                        width: 18px;
                        height: 18px;
                        border-radius: 50%;
                        border: 2px solid #cbd5e1;
                        background: white;
                        flex-shrink: 0;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: all 0.18s;
                    }

                    .radio-dot::after {
                        content: '';
                        width: 8px;
                        height: 8px;
                        border-radius: 50%;
                        background: white;
                    }

                    .reason-card input[type="radio"]:checked+label .radio-dot::after {
                        background: white;
                    }

                    /* Modal animation */
                    #returnModal {
                        transition: opacity 0.2s ease;
                    }

                    #returnModal.active {
                        opacity: 1;
                        pointer-events: auto;
                    }

                    #returnModal-box {
                        transition: transform 0.2s ease, opacity 0.2s ease;
                    }

                    #returnModal.active #returnModal-box {
                        transform: scale(1);
                        opacity: 1;
                    }
                </style>
            </head>

            <body class="bg-background-light text-slate-900 flex flex-col min-h-screen">

                <header class="bg-white border-b border-slate-100 sticky top-0 z-50 shadow-sm">
                    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="flex items-center justify-between h-20">
                            <a href="${pageContext.request.contextPath}/index.jsp"
                                class="flex items-center gap-2 text-primary hover:opacity-80 transition-opacity">
                                <span class="material-symbols-outlined text-3xl">arrow_back</span>
                                <span class="font-bold text-lg hidden sm:block">Trở về Trang Chủ</span>
                            </a>
                            <h1 class="text-2xl font-black text-slate-800">Lịch sử Đơn hàng</h1>
                            <div class="w-36"></div>
                        </div>
                    </div>
                </header>

                <main class="flex-grow max-w-6xl w-full mx-auto px-4 py-8">

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

                    <section class="bg-white border border-slate-100 rounded-3xl p-6 sm:p-10 shadow-sm">

                        <c:if test="${empty orders}">
                            <div class="text-center py-16">
                                <div
                                    class="bg-slate-50 size-24 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <span class="material-symbols-outlined text-5xl text-slate-300">receipt_long</span>
                                </div>
                                <h3 class="text-xl font-bold text-slate-800 mb-2">Bạn chưa có đơn hàng nào</h3>
                                <p class="text-slate-500 mb-8">Hãy khám phá các sản phẩm tươi sạch của chúng tôi nhé!
                                </p>
                                <a href="${pageContext.request.contextPath}/shop"
                                    class="bg-primary hover:bg-primary/90 text-white font-bold py-3 px-8 rounded-full transition-colors inline-block">
                                    Mua sắm ngay
                                </a>
                            </div>
                        </c:if>

                        <c:if test="${not empty orders}">
                            <div class="space-y-6">
                                <c:forEach var="order" items="${orders}">
                                    <div
                                        class="border border-slate-100 rounded-2xl p-6 hover:shadow-md transition-shadow bg-slate-50/50">
                                        <div
                                            class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 border-b border-slate-200 pb-4 mb-4">
                                            <div>
                                                <div class="flex items-center gap-3 mb-1">
                                                    <h4 class="font-black text-lg">Đơn hàng #${order.id}</h4>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'PENDING'}">
                                                            <span
                                                                class="bg-orange-100 text-orange-700 px-3 py-1 rounded-full text-xs font-bold">Chờ
                                                                xử lý</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'CONFIRMED'}">
                                                            <span
                                                                class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-xs font-bold">Đã
                                                                xác nhận (Đã TT)</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'DELIVERED'}">
                                                            <span
                                                                class="bg-teal-100 text-teal-700 px-3 py-1 rounded-full text-xs font-bold">Đã
                                                                giao hàng</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'COMPLETED'}">
                                                            <span
                                                                class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-xs font-bold">Hoàn
                                                                thành</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'RETURN_REQUESTED'}">
                                                            <span
                                                                class="bg-yellow-100 text-yellow-700 px-3 py-1 rounded-full text-xs font-bold border border-yellow-300">Đang
                                                                chờ xử lý Trả hàng</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'RETURN_ACCEPTED'}">
                                                            <span
                                                                class="bg-purple-100 text-purple-700 px-3 py-1 rounded-full text-xs font-bold">Đã
                                                                Trả hàng & Hoàn tiền</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="bg-slate-200 text-slate-700 px-3 py-1 rounded-full text-xs font-bold">${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <p class="text-sm text-slate-500 flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-sm">schedule</span>
                                                    Đặt ngày:
                                                    <fmt:formatDate value="${order.createdAt}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </p>
                                                <%-- Show return reason if set --%>
                                                    <c:if
                                                        test="${not empty order.returnReason and (order.status == 'RETURN_REQUESTED' or order.status == 'RETURN_ACCEPTED')}">
                                                        <p class="text-sm text-yellow-700 mt-1 flex items-center gap-1">
                                                            <span class="material-symbols-outlined text-sm">info</span>
                                                            Lý do: <span
                                                                class="font-semibold">${order.returnReason}</span>
                                                        </p>
                                                    </c:if>
                                            </div>
                                            <div class="text-right w-full sm:w-auto">
                                                <p class="text-sm text-slate-500 mb-1">Tổng thanh toán</p>
                                                <p class="font-black text-xl text-primary">
                                                    <fmt:formatNumber pattern="#,###" value="${order.totalAmount}" /> ₫
                                                </p>
                                            </div>
                                        </div>

                                        <div class="flex flex-col sm:flex-row items-center justify-between gap-4 mt-4">
                                            <span class="text-sm text-slate-500">Địa chỉ giao hàng
                                                #${order.addressId}</span>

                                            <div class="flex gap-3 w-full sm:w-auto">
                                                <%-- Return Request Button — opens modal --%>
                                                    <c:if test="${order.status == 'DELIVERED'}">
                                                        <button onclick="openReturnModal(${order.id})"
                                                            class="flex-1 sm:flex-none bg-yellow-500 hover:bg-yellow-600 text-white font-bold py-2 px-6 rounded-xl shadow-sm transition-transform active:scale-95 flex items-center justify-center gap-2">
                                                            <span
                                                                class="material-symbols-outlined text-sm">assignment_return</span>
                                                            Yêu cầu Trả hàng
                                                        </button>
                                                    </c:if>
                                            </div>
                                        </div>

                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>

                    </section>
                </main>

                <!-- ===== RETURN REASON MODAL ===== -->
                <div id="returnModal"
                    class="fixed inset-0 z-[9999] bg-black/50 flex items-center justify-center p-4 opacity-0 pointer-events-none"
                    onclick="handleModalBackdropClick(event)">

                    <div id="returnModal-box"
                        class="bg-white rounded-3xl shadow-2xl w-full max-w-lg transform scale-95 opacity-0"
                        onclick="event.stopPropagation()">

                        <!-- Modal Header -->
                        <div class="flex items-center justify-between px-6 py-5 border-b border-slate-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="size-10 rounded-xl bg-yellow-100 text-yellow-600 flex items-center justify-center">
                                    <span class="material-symbols-outlined">assignment_return</span>
                                </div>
                                <div>
                                    <h3 class="font-black text-lg text-slate-800">Yêu cầu Trả hàng</h3>
                                    <p class="text-sm text-slate-500">Đơn hàng <span id="modal-order-id"
                                            class="font-bold text-primary"></span></p>
                                </div>
                            </div>
                            <button onclick="closeReturnModal()"
                                class="p-2 rounded-xl hover:bg-slate-100 text-slate-400 hover:text-slate-600 transition-colors">
                                <span class="material-symbols-outlined">close</span>
                            </button>
                        </div>

                        <!-- Modal Body -->
                        <form id="returnForm" action="${pageContext.request.contextPath}/return-request" method="post">
                            <input type="hidden" name="orderId" id="modal-order-id-input" value="">

                            <div class="px-6 py-5">
                                <p class="text-sm font-semibold text-slate-700 mb-4">Vui lòng chọn lý do trả hàng: <span
                                        class="text-red-500">*</span></p>

                                <div class="grid grid-cols-1 gap-2.5">
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r1"
                                            value="Sản phẩm bị lỗi / hư hỏng" required>
                                        <label for="r1"><span class="radio-dot"></span> Sản phẩm bị lỗi / hư
                                            hỏng</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r2"
                                            value="Sản phẩm bị bể vỡ khi giao">
                                        <label for="r2"><span class="radio-dot"></span> Sản phẩm bị bể vỡ khi
                                            giao</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r3" value="Giao sai sản phẩm">
                                        <label for="r3"><span class="radio-dot"></span> Giao sai sản phẩm</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r4"
                                            value="Thiếu sản phẩm trong đơn hàng">
                                        <label for="r4"><span class="radio-dot"></span> Thiếu sản phẩm trong đơn
                                            hàng</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r5"
                                            value="Sản phẩm không đúng mô tả">
                                        <label for="r5"><span class="radio-dot"></span> Sản phẩm không đúng mô
                                            tả</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r6"
                                            value="Sản phẩm hết hạn sử dụng">
                                        <label for="r6"><span class="radio-dot"></span> Sản phẩm hết hạn sử dụng</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r7" value="Chất lượng sản phẩm kém">
                                        <label for="r7"><span class="radio-dot"></span> Chất lượng sản phẩm kém</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r8"
                                            value="Không còn nhu cầu sử dụng">
                                        <label for="r8"><span class="radio-dot"></span> Không còn nhu cầu sử
                                            dụng</label>
                                    </div>
                                    <div class="reason-card">
                                        <input type="radio" name="returnReason" id="r9" value="Khác">
                                        <label for="r9"><span class="radio-dot"></span> Khác</label>
                                    </div>
                                </div>

                                <!-- Note field -->
                                <div class="mt-4">
                                    <label class="block text-sm font-semibold text-slate-700 mb-2">Ghi chú thêm (tuỳ
                                        chọn)</label>
                                    <textarea name="returnNote" rows="2" placeholder="Mô tả thêm về vấn đề..."
                                        class="w-full border border-slate-200 rounded-xl text-sm px-4 py-3 focus:ring-primary focus:border-primary resize-none text-slate-700 placeholder:text-slate-400"></textarea>
                                </div>
                            </div>

                            <!-- Modal Footer -->
                            <div
                                class="flex items-center justify-between gap-3 px-6 py-4 border-t border-slate-100 bg-slate-50 rounded-b-3xl">
                                <button type="button" onclick="closeReturnModal()"
                                    class="flex-1 py-3 px-4 rounded-xl bg-white border border-slate-200 text-slate-600 font-semibold hover:bg-slate-100 transition-colors">
                                    Hủy bỏ
                                </button>
                                <button type="submit"
                                    class="flex-1 py-3 px-4 rounded-xl bg-yellow-500 hover:bg-yellow-600 text-white font-bold transition-colors flex items-center justify-center gap-2 shadow-sm shadow-yellow-200">
                                    <span class="material-symbols-outlined text-sm">send</span>
                                    Gửi yêu cầu
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function openReturnModal(orderId) {
                        document.getElementById('modal-order-id').textContent = '#' + orderId;
                        document.getElementById('modal-order-id-input').value = orderId;
                        // Reset radio selection
                        document.querySelectorAll('#returnForm input[type="radio"]').forEach(r => r.checked = false);
                        document.querySelector('#returnForm textarea').value = '';

                        const modal = document.getElementById('returnModal');
                        modal.classList.add('active');
                        document.body.style.overflow = 'hidden';
                    }

                    function closeReturnModal() {
                        const modal = document.getElementById('returnModal');
                        modal.classList.remove('active');
                        document.body.style.overflow = '';
                    }

                    function handleModalBackdropClick(e) {
                        if (e.target === document.getElementById('returnModal')) {
                            closeReturnModal();
                        }
                    }

                    // Validate one reason selected before submit
                    document.getElementById('returnForm').addEventListener('submit', function (e) {
                        const selected = document.querySelector('#returnForm input[name="returnReason"]:checked');
                        if (!selected) {
                            e.preventDefault();
                            alert('Vui lòng chọn ít nhất một lý do trả hàng!');
                        }
                    });
                </script>

            </body>

            </html>