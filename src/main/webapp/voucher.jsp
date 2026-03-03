<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Kho Voucher - Nông Sản Việt</title>
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

                    .voucher-selected {
                        border-color: #4cae4f !important;
                        border-width: 2px !important;
                    }

                    .voucher-selected .v-left {
                        background-color: #4cae4f !important;
                    }

                    .voucher-selected .v-icon {
                        color: white !important;
                    }

                    .voucher-selected .v-label {
                        color: white !important;
                    }
                </style>
            </head>

            <body
                class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 flex flex-col min-h-screen">

                <!-- HEADER -->
                <header
                    class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div class="flex items-center justify-between h-16">
                            <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2">
                                <div class="bg-primary p-1.5 rounded-lg text-white">
                                    <span class="material-symbols-outlined text-2xl">agriculture</span>
                                </div>
                                <h1 class="text-xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
                            </a>
                            <nav class="hidden md:flex items-center gap-6 text-sm font-medium">
                                <a class="hover:text-primary transition-colors"
                                    href="${pageContext.request.contextPath}/index">Trang chủ</a>
                                <a class="hover:text-primary transition-colors"
                                    href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
                                <a class="text-primary font-bold border-b-2 border-primary pb-0.5"
                                    href="${pageContext.request.contextPath}/voucher">Vouchers</a>
                                <a class="hover:text-primary transition-colors"
                                    href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
                            </nav>
                            <div class="flex items-center gap-3">
                                <a href="${pageContext.request.contextPath}/cart"
                                    class="relative p-2 rounded-xl bg-primary/10 hover:bg-primary/20 transition-colors flex items-center">
                                    <span
                                        class="material-symbols-outlined text-slate-700 dark:text-slate-200">shopping_cart</span>
                                    <c:if test="${sessionScope.cartCount > 0}">
                                        <span
                                            class="absolute -top-1 -right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">
                                            ${sessionScope.cartCount}
                                        </span>
                                    </c:if>
                                </a>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.account}">
                                        <a href="${pageContext.request.contextPath}/logout"
                                            class="flex items-center gap-1.5 p-1 pr-3 rounded-full bg-red-50 text-red-600 font-semibold text-sm hover:bg-red-100 transition-colors">
                                            <div
                                                class="size-7 rounded-full bg-red-500 text-white flex items-center justify-center">
                                                <span class="material-symbols-outlined text-sm">logout</span>
                                            </div>
                                            <span class="hidden sm:inline">${sessionScope.account.username}</span>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login"
                                            class="px-4 py-2 bg-primary text-white font-bold rounded-lg text-sm hover:bg-primary/90">Đăng
                                            nhập</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </header>

                <!-- MAIN -->
                <main class="flex-grow max-w-[1200px] mx-auto w-full px-4 sm:px-6 py-8 flex flex-col lg:flex-row gap-8">

                    <!-- LEFT: Danh sách voucher -->
                    <div class="flex-1 min-w-0">
                        <div class="mb-6">
                            <h1 class="text-2xl lg:text-3xl font-black mb-1">🎫 Kho Voucher Của Bạn</h1>
                            <p class="text-slate-500 text-sm">Chọn mã ưu đãi tốt nhất để áp dụng cho đơn hàng.</p>
                        </div>

                        <!-- Thông báo lỗi/thành công -->
                        <c:if test="${not empty sessionScope.voucherError}">
                            <div
                                class="mb-4 flex items-start gap-3 bg-red-50 border border-red-200 text-red-700 p-4 rounded-xl">
                                <span class="material-symbols-outlined text-red-500 shrink-0">error</span>
                                <span class="text-sm font-medium">${sessionScope.voucherError}</span>
                            </div>
                            <% session.removeAttribute("voucherError"); %>
                        </c:if>
                        <c:if test="${not empty selectedVoucher}">
                            <div
                                class="mb-4 flex items-center gap-3 bg-green-50 border border-green-200 text-green-700 p-4 rounded-xl">
                                <span class="material-symbols-outlined text-green-500">check_circle</span>
                                <span class="text-sm font-semibold">Đang áp dụng:
                                    <strong>${selectedVoucher.code}</strong> — ${selectedVoucher.title}</span>
                                <form action="${pageContext.request.contextPath}/voucher" method="post" class="ml-auto">
                                    <input type="hidden" name="action" value="remove" />
                                    <button type="submit" class="text-xs text-red-500 hover:underline font-bold">Bỏ
                                        chọn</button>
                                </form>
                            </div>
                        </c:if>

                        <!-- Nhập mã thủ công -->
                        <section
                            class="bg-white dark:bg-slate-800 p-5 rounded-xl border border-primary/10 mb-6 shadow-sm">
                            <h3 class="text-base font-bold mb-3">Nhập mã voucher</h3>
                            <form action="${pageContext.request.contextPath}/voucher" method="post" class="flex gap-3">
                                <input type="hidden" name="action" value="apply" />
                                <div class="flex-1 relative">
                                    <span
                                        class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary text-xl">confirmation_number</span>
                                    <input id="voucherCodeInput" name="voucherCode"
                                        class="w-full bg-primary/5 border-2 border-primary/20 rounded-xl py-2.5 pl-11 pr-4 focus:border-primary focus:ring-0 text-sm font-medium uppercase placeholder:normal-case placeholder:text-slate-400"
                                        placeholder="Nhập mã, VD: GIAM15" type="text" autocomplete="off" />
                                </div>
                                <button type="submit"
                                    class="bg-primary text-white font-bold px-6 py-2.5 rounded-xl hover:bg-primary/90 transition-opacity text-sm whitespace-nowrap">
                                    Áp dụng
                                </button>
                            </form>
                        </section>

                        <!-- Filter Tabs -->
                        <div class="mb-5 overflow-x-auto">
                            <div class="flex border-b border-slate-200 dark:border-slate-700 min-w-max gap-1"
                                id="filterTabs">
                                <button onclick="filterVouchers('all', this)"
                                    class="tab-btn active-tab px-5 py-3 text-primary font-bold border-b-2 border-primary flex items-center gap-1.5 text-sm">
                                    <span class="material-symbols-outlined text-base">apps</span> Tất cả
                                </button>
                                <button onclick="filterVouchers('shipping', this)"
                                    class="tab-btn px-5 py-3 text-slate-400 hover:text-primary font-medium flex items-center gap-1.5 text-sm border-b-2 border-transparent">
                                    <span class="material-symbols-outlined text-base">local_shipping</span> Vận chuyển
                                </button>
                                <button onclick="filterVouchers('discount', this)"
                                    class="tab-btn px-5 py-3 text-slate-400 hover:text-primary font-medium flex items-center gap-1.5 text-sm border-b-2 border-transparent">
                                    <span class="material-symbols-outlined text-base">storefront</span> Giảm giá
                                </button>
                                <button onclick="filterVouchers('cashback', this)"
                                    class="tab-btn px-5 py-3 text-slate-400 hover:text-primary font-medium flex items-center gap-1.5 text-sm border-b-2 border-transparent">
                                    <span class="material-symbols-outlined text-base">payments</span> Hoàn tiền
                                </button>
                                <button onclick="filterVouchers('product', this)"
                                    class="tab-btn px-5 py-3 text-slate-400 hover:text-primary font-medium flex items-center gap-1.5 text-sm border-b-2 border-transparent">
                                    <span class="material-symbols-outlined text-base">eco</span> Sản phẩm
                                </button>
                            </div>
                        </div>

                        <!-- Voucher Grid -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4" id="voucherGrid">
                            <c:forEach items="${vouchers}" var="v">
                                <c:set var="isSelected"
                                    value="${selectedVoucher != null && selectedVoucher.code == v.code}" />
                                <div class="voucher-card flex bg-white dark:bg-slate-800 rounded-xl overflow-hidden border ${isSelected ? 'border-primary border-2' : 'border-slate-200 dark:border-slate-700'} shadow-sm hover:shadow-md transition-all"
                                    data-category="${v.category}">

                                    <!-- Left colored strip -->
                                    <div
                                        class="v-left w-28 shrink-0 ${isSelected ? 'bg-primary' : 'bg-primary/10'} flex flex-col items-center justify-center border-r-2 border-dashed ${isSelected ? 'border-primary/30' : 'border-slate-200 dark:border-slate-600'} relative py-4 px-2">
                                        <c:choose>
                                            <c:when test="${v.category == 'shipping'}">
                                                <span
                                                    class="material-symbols-outlined v-icon text-4xl ${isSelected ? 'text-white' : 'text-primary'}">local_shipping</span>
                                            </c:when>
                                            <c:when test="${v.category == 'cashback'}">
                                                <span
                                                    class="material-symbols-outlined v-icon text-4xl ${isSelected ? 'text-white' : 'text-primary'}">payments</span>
                                            </c:when>
                                            <c:when test="${v.category == 'product'}">
                                                <span
                                                    class="material-symbols-outlined v-icon text-4xl ${isSelected ? 'text-white' : 'text-primary'}">eco</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="material-symbols-outlined v-icon text-4xl ${isSelected ? 'text-white' : 'text-primary'}">percent</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <p
                                            class="v-label text-[9px] font-black mt-1.5 uppercase ${isSelected ? 'text-white' : 'text-primary'} text-center tracking-wider">
                                            ${v.category}</p>
                                        <!-- Ticket notch -->
                                        <div
                                            class="absolute -top-2 -right-[9px] w-4 h-4 bg-background-light dark:bg-background-dark rounded-full">
                                        </div>
                                        <div
                                            class="absolute -bottom-2 -right-[9px] w-4 h-4 bg-background-light dark:bg-background-dark rounded-full">
                                        </div>
                                    </div>

                                    <!-- Content -->
                                    <div class="flex-1 p-4 flex flex-col justify-between min-w-0">
                                        <div>
                                            <div class="flex items-start justify-between gap-2">
                                                <h4
                                                    class="font-bold text-sm leading-tight text-slate-900 dark:text-slate-100">
                                                    ${v.title}</h4>
                                                <c:if test="${isSelected}">
                                                    <span
                                                        class="material-symbols-outlined text-primary text-xl shrink-0"
                                                        style="font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 0,'opsz' 24;">check_circle</span>
                                                </c:if>
                                            </div>
                                            <p class="text-xs text-slate-500 mt-1 leading-relaxed">${v.description}</p>
                                            <div class="mt-2">
                                                <code
                                                    class="text-xs font-bold bg-primary/10 text-primary px-2 py-0.5 rounded tracking-widest">${v.code}</code>
                                            </div>
                                        </div>
                                        <div class="mt-3 flex items-center justify-between gap-2">
                                            <span class="text-[10px] text-slate-400 font-medium">HSD:
                                                ${v.expiryDate}</span>
                                            <c:choose>
                                                <c:when test="${isSelected}">
                                                    <form action="${pageContext.request.contextPath}/voucher"
                                                        method="post">
                                                        <input type="hidden" name="action" value="remove" />
                                                        <button type="submit"
                                                            class="px-3 py-1.5 bg-primary text-white text-xs font-bold rounded-lg flex items-center gap-1">
                                                            <span class="material-symbols-outlined text-sm">check</span>
                                                            Đã chọn
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="${pageContext.request.contextPath}/voucher"
                                                        method="post">
                                                        <input type="hidden" name="action" value="apply" />
                                                        <input type="hidden" name="voucherCode" value="${v.code}" />
                                                        <button type="submit"
                                                            class="px-3 py-1.5 bg-primary/15 text-primary hover:bg-primary hover:text-white text-xs font-bold rounded-lg transition-all">
                                                            Sử dụng
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Empty state -->
                        <c:if test="${empty vouchers}">
                            <div
                                class="text-center py-16 bg-white dark:bg-slate-800 rounded-xl border border-slate-100">
                                <span
                                    class="material-symbols-outlined text-6xl text-slate-300 mb-3 block">confirmation_number</span>
                                <p class="text-slate-500 font-semibold">Chưa có voucher nào khả dụng.</p>
                            </div>
                        </c:if>
                    </div>

                    <!-- RIGHT: Sidebar tóm tắt đơn hàng -->
                    <aside class="w-full lg:w-80 shrink-0">
                        <div
                            class="bg-white dark:bg-slate-800 rounded-xl border border-slate-200 dark:border-slate-700 p-6 sticky top-20 shadow-lg">
                            <h3 class="text-base font-bold mb-5 flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">shopping_bag</span> Đơn hàng của
                                bạn
                            </h3>

                            <!-- Cart items mini -->
                            <div class="space-y-2 mb-5 max-h-40 overflow-y-auto pr-1">
                                <c:choose>
                                    <c:when test="${empty cartItems}">
                                        <p class="text-sm text-slate-400 text-center py-4">Giỏ hàng đang trống</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${cartItems}" var="item">
                                            <div class="flex items-center gap-2 text-xs">
                                                <c:set var="imgUrl" value="" />
                                                <c:choose>
                                                    <c:when test="${not empty item.product.imageUrl}">
                                                        <c:set var="imgUrl" value="${item.product.imageUrl}" />
                                                    </c:when>
                                                    <c:when
                                                        test="${not empty item.product.description and item.product.description.startsWith('http')}">
                                                        <c:set var="imgUrl" value="${item.product.description}" />
                                                    </c:when>
                                                </c:choose>
                                                <div class="w-9 h-9 rounded-lg bg-slate-100 bg-cover bg-center shrink-0 flex items-center justify-center"
                                                    style="${not empty imgUrl ? 'background-image:url('+imgUrl+')' : ''}">
                                                    <c:if test="${empty imgUrl}"><span
                                                            class="material-symbols-outlined text-slate-300 text-sm">inventory_2</span>
                                                    </c:if>
                                                </div>
                                                <span class="flex-1 truncate font-medium">${item.product.name}</span>
                                                <span class="text-slate-500 shrink-0">x${item.quantity}</span>
                                                <span class="font-bold text-primary shrink-0">
                                                    <fmt:formatNumber value="${item.product.price * item.quantity}"
                                                        type="number" groupingUsed="true" />đ
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Tóm tắt giá -->
                            <div class="space-y-3 border-t border-slate-100 dark:border-slate-700 pt-4 mb-5 text-sm">
                                <div class="flex justify-between text-slate-500">
                                    <span>Tổng đơn:</span>
                                    <span class="font-bold text-slate-800 dark:text-slate-200">
                                        <fmt:formatNumber value="${cartTotal}" type="number" groupingUsed="true" />đ
                                    </span>
                                </div>

                                <c:if test="${discountAmount > 0}">
                                    <div class="flex justify-between text-green-600 font-medium">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">check_circle</span> Voucher
                                            giảm:
                                        </span>
                                        <span class="font-bold">-
                                            <fmt:formatNumber value="${discountAmount}" type="number"
                                                groupingUsed="true" />đ
                                        </span>
                                    </div>
                                </c:if>

                                <c:if test="${selectedVoucher != null && selectedVoucher.type == 'SHIPPING'}">
                                    <div class="flex justify-between text-green-600 font-medium">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">local_shipping</span> Vận
                                            chuyển:
                                        </span>
                                        <span class="font-bold">Miễn phí</span>
                                    </div>
                                </c:if>
                                <c:if test="${selectedVoucher == null || selectedVoucher.type != 'SHIPPING'}">
                                    <div class="flex justify-between text-slate-500">
                                        <span>Phí vận chuyển:</span>
                                        <span class="font-bold text-slate-800 dark:text-slate-200">
                                            <fmt:formatNumber value="${shippingFee}" type="number"
                                                groupingUsed="true" />đ
                                        </span>
                                    </div>
                                </c:if>

                                <div class="border-t border-slate-100 dark:border-slate-700 pt-3">
                                    <div class="flex justify-between items-end">
                                        <span class="font-bold text-slate-900 dark:text-slate-100">Thành tiền:</span>
                                        <div class="text-right">
                                            <c:if test="${discountAmount > 0 || shippingFee == 0}">
                                                <p class="text-xs text-slate-400 line-through">
                                                    <fmt:formatNumber value="${cartTotal + 15000}" type="number"
                                                        groupingUsed="true" />đ
                                                </p>
                                            </c:if>
                                            <p class="text-2xl font-black text-primary">
                                                <fmt:formatNumber value="${finalTotal}" type="number"
                                                    groupingUsed="true" />đ
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tiết kiệm -->
                            <c:if test="${discountAmount > 0}">
                                <div class="bg-primary/5 rounded-xl p-3 mb-5 border border-primary/10">
                                    <p class="text-[10px] text-slate-400 uppercase tracking-wider font-bold mb-0.5">Bạn
                                        tiết kiệm được:</p>
                                    <p class="text-xl font-black text-primary">
                                        <fmt:formatNumber value="${discountAmount}" type="number" groupingUsed="true" />
                                        đ
                                    </p>
                                </div>
                            </c:if>

                            <!-- Nút xác nhận -->
                            <c:choose>
                                <c:when test="${empty cartItems}">
                                    <a href="${pageContext.request.contextPath}/shop"
                                        class="w-full bg-primary text-white font-bold py-3 rounded-xl flex items-center justify-center gap-2 hover:bg-primary/90 transition-all text-sm">
                                        <span class="material-symbols-outlined">shopping_bag</span> Đi mua sắm
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/voucher" method="post">
                                        <input type="hidden" name="action" value="confirm" />
                                        <button type="submit"
                                            class="w-full bg-primary text-white font-bold py-3.5 rounded-xl flex items-center justify-center gap-2 hover:shadow-lg hover:shadow-primary/20 transition-all text-base">
                                            Xác nhận & Thanh toán
                                            <span class="material-symbols-outlined">arrow_forward</span>
                                        </button>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/cart"
                                        class="block w-full mt-3 border border-slate-200 dark:border-slate-600 text-slate-600 dark:text-slate-400 font-semibold py-2.5 rounded-xl text-center hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors text-sm">
                                        ← Quay lại giỏ hàng
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <p class="text-center text-slate-400 text-xs mt-3">Voucher sẽ được áp dụng ở bước thanh
                                toán.</p>
                        </div>
                    </aside>
                </main>

                <!-- FOOTER -->
                <footer
                    class="mt-auto py-8 border-t border-slate-200 dark:border-slate-800 text-center text-slate-400 text-xs">
                    <div class="flex justify-center gap-6 mb-3 text-sm">
                        <a class="hover:text-primary transition-colors" href="#">Chính sách bảo mật</a>
                        <a class="hover:text-primary transition-colors" href="#">Điều khoản sử dụng</a>
                        <a class="hover:text-primary transition-colors" href="#">Trung tâm hỗ trợ</a>
                    </div>
                    <p>© 2024 Nông Sản Việt - Tươi ngon mỗi ngày từ nông trại.</p>
                </footer>

                <jsp:include page="WEB-INF/views/chat-widget.jsp" />

                <script>
                    // Filter vouchers by category tab
                    function filterVouchers(cat, btn) {
                        // Update tabs styling
                        document.querySelectorAll('.tab-btn').forEach(t => {
                            t.classList.remove('text-primary', 'font-bold', 'border-primary', 'border-b-2');
                            t.classList.add('text-slate-400', 'font-medium', 'border-transparent', 'border-b-2');
                        });
                        btn.classList.remove('text-slate-400', 'font-medium', 'border-transparent');
                        btn.classList.add('text-primary', 'font-bold', 'border-primary');

                        // Filter cards
                        document.querySelectorAll('.voucher-card').forEach(card => {
                            if (cat === 'all' || card.dataset.category === cat) {
                                card.style.display = 'flex';
                            } else {
                                card.style.display = 'none';
                            }
                        });
                    }

                    // Auto-uppercase voucher code input
                    const codeInput = document.getElementById('voucherCodeInput');
                    if (codeInput) {
                        codeInput.addEventListener('input', function () {
                            const pos = this.selectionStart;
                            this.value = this.value.toUpperCase();
                            this.setSelectionRange(pos, pos);
                        });
                    }
                </script>
            </body>

            </html>