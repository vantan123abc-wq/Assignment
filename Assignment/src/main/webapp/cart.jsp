<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Giỏ hàng - Nông Sản Việt</title>
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
            </head>

            <body
                class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 antialiased font-display">
                <div
                    class="relative flex h-auto min-h-screen w-full max-w-md mx-auto flex-col bg-white dark:bg-background-dark shadow-xl overflow-x-hidden">

                    <!-- Header / TopAppBar -->
                    <div
                        class="sticky top-0 z-10 flex items-center bg-white dark:bg-background-dark p-4 border-b border-primary/10 justify-between">
                        <a href="index.jsp"
                            class="text-slate-900 dark:text-slate-100 flex size-10 shrink-0 items-center justify-center cursor-pointer hover:bg-primary/10 rounded-full transition-colors text-decoration-none">
                            <span class="material-symbols-outlined">arrow_back</span>
                        </a>
                        <h2
                            class="text-slate-900 dark:text-slate-100 text-lg font-bold leading-tight tracking-tight flex-1 ml-4">
                            Giỏ hàng</h2>
                        <div
                            class="text-slate-900 dark:text-slate-100 flex size-10 shrink-0 items-center justify-center cursor-pointer hover:bg-primary/10 rounded-full transition-colors">
                            <span class="material-symbols-outlined">more_vert</span>
                        </div>
                    </div>

                    <!-- Cart Items List -->
                    <div class="flex flex-col flex-1">
                        <c:if test="${empty cartItems}">
                            <div class="p-8 text-center text-slate-500">
                                <span
                                    class="material-symbols-outlined text-6xl mb-4 text-slate-300">shopping_cart</span>
                                <p class="text-lg">Giỏ hàng của bạn đang trống</p>
                                <a href="index.jsp" class="inline-block mt-4 text-primary hover:underline">Tiếp tục mua
                                    sắm</a>
                            </div>
                        </c:if>

                        <c:set var="totalPrice" value="0" />
                        <c:forEach items="${cartItems}" var="item">
                            <c:set var="itemTotal" value="${item.product.price * item.quantity}" />
                            <c:set var="totalPrice" value="${totalPrice + itemTotal}" />

                            <div
                                class="flex gap-4 bg-white dark:bg-background-dark px-4 py-5 border-b border-primary/5 justify-between">
                                <div class="flex items-start gap-4">
                                    <!-- Product Image (Fallback if not provided) -->
                                    <c:set var="bgUrl"
                                        value="https://lh3.googleusercontent.com/aida-public/AB6AXuAYgMI6058HEQ8ei2U8k85Tcd5_FbMxhRLChVKrL_bk8JVIVrEvhCoQmn5CO93GRDDZ0GcpHwAVvGT57JIfbdBRFQ4pFS6AXSGHtNnjxBOlTdo_Nt0ttrICWS765yYVLS-o1ZO6gi-1eJlX5F3gM57QMSyH8EFWsNaa5P8Mwzn3bkzd9mQvB6IXs1Ph75TfN50JEzktPMt89cyY-TVdZzo6ZSOWTjXiQ1y6ZlwTt3l4V-L8HjEIotIgfpDR_IdmjT0BXTX2SShmXj_1" />
                                    <c:if
                                        test="${item.product.description != null && item.product.description.startsWith('http')}">
                                        <c:set var="bgUrl" value="${item.product.description}" />
                                    </c:if>
                                    <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-xl size-20 border border-primary/10 flex items-center justify-center bg-slate-100"
                                        style="background-image: url('${bgUrl}');">
                                        <c:if
                                            test="${item.product.description == null || !item.product.description.startsWith('http')}">
                                            <span
                                                class="material-symbols-outlined text-slate-400 opacity-0 relative z-[-1]">category</span>
                                        </c:if>
                                    </div>

                                    <div class="flex flex-1 flex-col justify-between py-0.5">
                                        <div>
                                            <p
                                                class="text-slate-900 dark:text-slate-100 text-base font-semibold leading-tight">
                                                ${item.product.name}</p>
                                            <p class="text-primary text-sm font-medium mt-1">
                                                <fmt:formatNumber value="${item.product.price}" type="number"
                                                    groupingUsed="true" />đ
                                            </p>
                                        </div>
                                        <form action="cart" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="itemId" value="${item.id}">
                                            <button type="submit"
                                                class="text-red-500 dark:text-red-400 text-xs font-medium flex items-center gap-1 mt-2 hover:opacity-80 bg-transparent border-0 cursor-pointer">
                                                <span class="material-symbols-outlined text-sm">delete</span> Xóa
                                            </button>
                                        </form>
                                    </div>
                                </div>
                                <div class="flex flex-col items-end justify-between py-0.5">
                                    <form action="cart" method="post"
                                        class="flex items-center gap-3 bg-primary/10 dark:bg-primary/20 p-1 rounded-full">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="itemId" value="${item.id}">
                                        <button type="submit" name="quantity" value="${item.quantity - 1}"
                                            class="flex h-7 w-7 items-center justify-center rounded-full bg-white dark:bg-background-dark text-primary shadow-sm border-0 cursor-pointer">-</button>
                                        <span
                                            class="text-slate-900 dark:text-slate-100 font-bold text-sm min-w-[1rem] text-center">${item.quantity}</span>
                                        <button type="submit" name="quantity" value="${item.quantity + 1}"
                                            class="flex h-7 w-7 items-center justify-center rounded-full bg-primary text-white shadow-sm border-0 cursor-pointer">+</button>
                                    </form>
                                    <p class="text-slate-900 dark:text-slate-100 font-bold">
                                        <fmt:formatNumber value="${itemTotal}" type="number" groupingUsed="true" />đ
                                    </p>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Promotional Code Section -->
                        <div class="p-4 mt-2">
                            <p class="text-slate-900 dark:text-slate-100 text-sm font-semibold mb-3">Mã khuyến mãi</p>
                            <div class="flex items-center gap-2">
                                <div class="relative flex-1">
                                    <span
                                        class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/60">sell</span>
                                    <input
                                        class="w-full pl-10 pr-4 py-3 bg-primary/5 border border-primary/10 rounded-lg focus:ring-primary focus:border-primary text-slate-900 dark:text-slate-100 placeholder:text-slate-400"
                                        placeholder="Nhập mã giảm giá" type="text" />
                                </div>
                                <button
                                    class="bg-primary text-white font-bold px-6 py-3 rounded-lg hover:bg-primary/90 transition-all">Áp
                                    dụng</button>
                            </div>
                        </div>

                        <!-- Summary Section -->
                        <c:if test="${not empty cartItems}">
                            <div
                                class="mt-4 p-4 bg-primary/5 dark:bg-primary/10 rounded-t-3xl border-t border-primary/10">
                                <div class="space-y-3 mb-6">
                                    <div class="flex justify-between items-center">
                                        <p class="text-slate-600 dark:text-slate-400 text-sm">Tạm tính</p>
                                        <p class="text-slate-900 dark:text-slate-100 text-base font-medium">
                                            <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" />
                                            đ
                                        </p>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <p class="text-slate-600 dark:text-slate-400 text-sm">Phí vận chuyển</p>
                                        <p class="text-slate-900 dark:text-slate-100 text-base font-medium">30,000đ</p>
                                    </div>
                                    <div class="flex justify-between items-center pt-3 border-t border-primary/10">
                                        <p class="text-slate-900 dark:text-slate-100 text-lg font-bold">Tổng cộng</p>
                                        <p class="text-primary text-xl font-bold">
                                            <fmt:formatNumber value="${totalPrice + 30000}" type="number"
                                                groupingUsed="true" />đ
                                        </p>
                                    </div>
                                </div>

                                <!-- Checkout Button -->
                                <button
                                    class="w-full bg-primary text-white text-lg font-bold py-4 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center gap-2 hover:scale-[1.02] active:scale-[0.98] transition-all">
                                    Thanh toán ngay
                                    <span class="material-symbols-outlined">arrow_forward</span>
                                </button>
                            </div>
                        </c:if>
                    </div>
                    <!-- Spacer for extra scrolling comfort -->
                    <div class="h-8 bg-white dark:bg-background-dark"></div>
                </div>
            </body>

            </html>