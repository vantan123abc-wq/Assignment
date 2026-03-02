<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Thanh toán - Nông Sản Việt</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap"
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
                        min-height: max(884px, 100dvh);
                    }

                    .material-symbols-outlined {
                        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    }
                </style>
                <script>
                    function toggleNewAddress() {
                        const select = document.getElementById('addressId');
                        const newAddressGroup = document.getElementById('newAddressGroup');
                        if (select.value === 'new') {
                            newAddressGroup.classList.remove('hidden');
                        } else {
                            newAddressGroup.classList.add('hidden');
                        }
                    }
                    window.onload = toggleNewAddress;
                </script>
            </head>

            <body
                class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 antialiased font-display">
                <div
                    class="relative flex h-auto min-h-screen w-full max-w-md mx-auto flex-col bg-white dark:bg-background-dark shadow-xl overflow-x-hidden">

                    <!-- Header -->
                    <div
                        class="sticky top-0 z-10 flex items-center bg-white dark:bg-background-dark p-4 border-b border-primary/10">
                        <a href="cart"
                            class="text-slate-900 dark:text-slate-100 flex size-10 shrink-0 items-center justify-center cursor-pointer hover:bg-primary/10 rounded-full transition-colors text-decoration-none">
                            <span class="material-symbols-outlined">arrow_back</span>
                        </a>
                        <h2
                            class="text-slate-900 dark:text-slate-100 text-lg font-bold leading-tight tracking-tight flex-1 ml-4">
                            Giao hàng và Thanh toán</h2>
                    </div>

                    <div class="flex flex-col flex-1 p-4 overflow-y-auto">
                        <c:if test="${not empty error}">
                            <div
                                class="bg-red-50 dark:bg-red-900/10 text-red-600 border border-red-200 dark:border-red-800 rounded-lg p-3 text-sm flex items-center gap-2 mb-4">
                                <span class="material-symbols-outlined text-xl">error</span>
                                <span>${error}</span>
                            </div>
                        </c:if>

                        <form action="checkout" method="post" id="checkoutForm" class="flex flex-col space-y-6">
                            <input type="hidden" name="action" value="placeOrder">

                            <!-- Address Selection -->
                            <section class="space-y-3">
                                <div class="flex items-center gap-2 pb-2 border-b border-primary/10">
                                    <span class="material-symbols-outlined text-primary">location_on</span>
                                    <h3 class="font-bold text-lg">Địa chỉ giao hàng</h3>
                                </div>
                                <div class="space-y-4">
                                    <div class="space-y-1">
                                        <select name="addressId" id="addressId" onchange="toggleNewAddress()"
                                            class="w-full bg-slate-50 border border-slate-200 dark:border-slate-700 text-slate-900 dark:bg-slate-800 dark:text-white text-sm rounded-lg focus:ring-primary focus:border-primary block p-2.5 outline-none transition-colors">
                                            <c:if test="${not empty addresses}">
                                                <c:forEach items="${addresses}" var="addr">
                                                    <option value="${addr.id}">${addr.receiver} - ${addr.phone} -
                                                        ${addr.addressLine}</option>
                                                </c:forEach>
                                            </c:if>
                                            <option value="new" ${empty addresses ? 'selected' : '' }>+ Thêm địa chỉ mới
                                            </option>
                                        </select>
                                    </div>

                                    <!-- New Address Entry -->
                                    <div id="newAddressGroup"
                                        class="space-y-3 p-4 bg-slate-50 dark:bg-slate-800/50 rounded-xl border border-slate-200 dark:border-slate-800 ${empty addresses ? '' : 'hidden'}">
                                        <div class="space-y-1">
                                            <label
                                                class="text-sm font-semibold text-slate-600 dark:text-slate-400">Người
                                                nhận</label>
                                            <input type="text" name="receiver" placeholder="Tên người nhận"
                                                class="w-full bg-white dark:bg-slate-800 border ${empty addresses ? 'required' : ''} border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all placeholder:text-slate-400">
                                        </div>
                                        <div class="space-y-1">
                                            <label class="text-sm font-semibold text-slate-600 dark:text-slate-400">Số
                                                điện thoại</label>
                                            <input type="tel" name="phone" placeholder="Số điện thoại"
                                                class="w-full bg-white dark:bg-slate-800 border ${empty addresses ? 'required' : ''} border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all placeholder:text-slate-400">
                                        </div>
                                        <div class="space-y-1">
                                            <label class="text-sm font-semibold text-slate-600 dark:text-slate-400">Địa
                                                chỉ cụ thể</label>
                                            <textarea name="address_line" rows="2"
                                                placeholder="Số nhà, tên đường, phường/xã, quận/huyện..."
                                                class="w-full bg-white dark:bg-slate-800 border ${empty addresses ? 'required' : ''} border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all placeholder:text-slate-400"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- Payment Method Segment -->
                            <section class="space-y-3">
                                <div class="flex items-center gap-2 pb-2 border-b border-primary/10">
                                    <span class="material-symbols-outlined text-primary">payments</span>
                                    <h3 class="font-bold text-lg">Phương thức thanh toán</h3>
                                </div>

                                <label
                                    class="flex items-center justify-between p-4 border border-primary bg-primary/5 rounded-xl cursor-pointer">
                                    <div class="flex items-center gap-3">
                                        <span
                                            class="material-symbols-outlined text-primary text-2xl">local_shipping</span>
                                        <div>
                                            <p class="font-bold text-sm text-slate-900 dark:text-white">Thanh toán khi
                                                nhận hàng</p>
                                            <p class="text-xs text-slate-500">Thanh toán tiền mặt cho shipper (COD)</p>
                                        </div>
                                    </div>
                                    <input type="radio" name="payment_method" value="COD" checked
                                        class="w-5 h-5 text-primary border-slate-300 focus:ring-primary rounded-full cursor-pointer">
                                </label>
                            </section>

                            <!-- Order Summary -->
                            <section class="space-y-3">
                                <div class="flex items-center gap-2 pb-2 border-b border-primary/10">
                                    <span class="material-symbols-outlined text-primary">receipt_long</span>
                                    <h3 class="font-bold text-lg">Tóm tắt đơn hàng</h3>
                                </div>
                                <div
                                    class="bg-slate-50 dark:bg-slate-900/50 rounded-xl p-4 border border-slate-100 dark:border-slate-800 space-y-3">
                                    <c:set var="shippingFee" value="15000" />
                                    <c:set var="vatAmount" value="${totalAmount * 0.08}" />
                                    <c:set var="finalTotal" value="${totalAmount + shippingFee + vatAmount}" />

                                    <c:forEach items="${cartItems}" var="item">
                                        <div class="flex justify-between items-center text-sm">
                                            <span
                                                class="text-slate-600 dark:text-slate-400 flex-1 truncate pr-4 text-xs">${item.product.name}
                                                (x${item.quantity})</span>
                                            <span class="font-semibold whitespace-nowrap">
                                                <fmt:formatNumber value="${item.product.price * item.quantity}"
                                                    type="number" groupingUsed="true" />₫
                                            </span>
                                        </div>
                                    </c:forEach>
                                    <div class="w-full h-px bg-slate-200 dark:bg-slate-700 my-2"></div>
                                    <div class="flex justify-between items-center text-sm">
                                        <span class="text-slate-500">Tạm tính</span>
                                        <span class="font-semibold">
                                            <fmt:formatNumber value="${totalAmount}" type="number"
                                                groupingUsed="true" />₫
                                        </span>
                                    </div>
                                    <div class="flex justify-between items-center text-sm">
                                        <span class="text-slate-500">Phí vận chuyển</span>
                                        <span class="font-semibold">
                                            <fmt:formatNumber value="${shippingFee}" type="number"
                                                groupingUsed="true" />₫
                                        </span>
                                    </div>
                                    <div class="flex justify-between items-center text-sm">
                                        <span class="text-slate-500">Thuế (VAT 8%)</span>
                                        <span class="font-semibold">
                                            <fmt:formatNumber value="${vatAmount}" type="number" groupingUsed="true" />₫
                                        </span>
                                    </div>
                                </div>
                            </section>

                            <!-- Spacer to ensure content doesn't get hidden behind bottom bar -->
                            <div class="h-16"></div>
                        </form>
                    </div>

                    <!-- Bottom Bar (Sticky Footer) for CTA -->
                    <div
                        class="sticky bottom-0 bg-white dark:bg-background-dark border-t border-primary/10 p-4 shadow-[0_-4px_6px_-1px_rgb(0,0,0,0.05)] z-20">
                        <div class="flex items-center justify-between mb-3 px-1">
                            <span class="text-sm font-medium text-slate-500">Tổng thanh toán</span>
                            <span class="text-2xl font-black text-primary">
                                <fmt:formatNumber value="${finalTotal}" type="number" groupingUsed="true" />₫
                            </span>
                        </div>
                        <button type="submit" form="checkoutForm"
                            class="w-full bg-primary hover:bg-[#3d8c40] text-white font-bold py-3.5 px-6 rounded-xl transition-all shadow-lg hover:shadow-xl active:scale-[0.98] flex items-center justify-center gap-2 text-lg">
                            <span>Đặt hàng ngay</span>
                            <span class="material-symbols-outlined text-base">check_circle</span>
                        </button>
                    </div>

                </div>
            </body>

            </html>