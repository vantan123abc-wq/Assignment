<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Thanh toán – Nông Sản Việt</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800;900&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap"
                    rel="stylesheet" />
                <script>
                    tailwind.config = {
                        theme: {
                            extend: {
                                colors: { primary: '#2e9e53', 'primary-light': '#e8f7ee', 'primary-dark': '#1e6e39' },
                                fontFamily: { sans: ['"Be Vietnam Pro"', 'sans-serif'] },
                            }
                        }
                    }
                </script>
                <style>
                    * {
                        font-family: 'Be Vietnam Pro', sans-serif;
                    }

                    .msym {
                        font-family: 'Material Symbols Outlined';
                        font-weight: 400;
                        font-style: normal;
                        font-size: 20px;
                        line-height: 1;
                        letter-spacing: normal;
                        text-transform: none;
                        display: inline-block;
                        white-space: nowrap;
                        word-wrap: normal;
                        direction: ltr;
                    }

                    .pay-btn {
                        transition: all .2s ease;
                    }

                    .pay-btn.on {
                        box-shadow: 0 0 0 2px #2e9e53;
                        background: #e8f7ee;
                    }

                    .ibank-btn {
                        transition: all .15s ease;
                        cursor: pointer;
                    }

                    .ibank-btn.on {
                        box-shadow: 0 0 0 2px #2e9e53;
                        background: #e8f7ee;
                    }

                    .step-dot {
                        transition: all .3s ease;
                    }

                    @keyframes spin {
                        to {
                            transform: rotate(360deg);
                        }
                    }

                    .spin {
                        animation: spin .8s linear infinite;
                    }

                    input:focus,
                    select:focus,
                    textarea:focus {
                        outline: 2px solid #2e9e53;
                        outline-offset: 1px;
                    }

                    .scrollbar::-webkit-scrollbar {
                        width: 3px;
                    }

                    .scrollbar::-webkit-scrollbar-thumb {
                        background: #2e9e5344;
                        border-radius: 99px;
                    }
                </style>
            </head>

            <body class="min-h-screen bg-[#f4f7f5] text-slate-800">

                <!-- ─── TOPBAR ─────────────────────────────────────────────────────── -->
                <header class="sticky top-0 z-50 h-14 bg-white border-b border-slate-100 shadow-sm">
                    <div class="max-w-6xl mx-auto h-full px-5 flex items-center justify-between">
                        <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2 group">
                            <span
                                class="msym text-2xl text-primary group-hover:scale-110 transition-transform">agriculture</span>
                            <span class="font-extrabold text-slate-800 tracking-tight">Nông Sản Việt</span>
                        </a>
                        <!-- Step indicators -->
                        <div class="hidden sm:flex items-center gap-1 text-xs font-semibold">
                            <div class="flex items-center gap-1.5 text-slate-400">
                                <span
                                    class="step-dot w-5 h-5 rounded-full bg-slate-200 text-slate-500 flex items-center justify-center text-[10px]">1</span>Giỏ
                                hàng
                            </div>
                            <span class="msym text-slate-300 text-sm">chevron_right</span>
                            <div class="flex items-center gap-1.5 text-primary">
                                <span
                                    class="step-dot w-5 h-5 rounded-full bg-primary text-white flex items-center justify-center text-[10px]">2</span>Thanh
                                toán
                            </div>
                            <span class="msym text-slate-300 text-sm">chevron_right</span>
                            <div class="flex items-center gap-1.5 text-slate-400">
                                <span
                                    class="step-dot w-5 h-5 rounded-full bg-slate-200 text-slate-500 flex items-center justify-center text-[10px]">3</span>Xác
                                nhận
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/cart"
                            class="flex items-center gap-1 text-sm text-slate-500 hover:text-primary transition-colors">
                            <span class="msym">arrow_back</span> Giỏ hàng
                        </a>
                    </div>
                </header>

                <!-- ─── MAIN ───────────────────────────────────────────────────────── -->
                <main class="max-w-6xl mx-auto px-4 py-8 grid grid-cols-1 lg:grid-cols-3 gap-6">

                    <!-- ──── FORM (2/3) ──────────────────────────────── -->
                    <div class="lg:col-span-2">
                        <c:if test="${not empty error}">
                            <div
                                class="mb-5 flex gap-2 items-start bg-red-50 border border-red-200 text-red-700 rounded-xl p-4 text-sm">
                                <span class="msym shrink-0">error</span><span>${error}</span>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                            <input type="hidden" name="action" value="placeOrder" />
                            <input type="hidden" name="payment_method" id="selPay" value="BANK_TRANSFER" />

                            <div class="space-y-5">

                                <!-- ══ BƯỚC 1: ĐỊA CHỈ ══════════════════════════════════ -->
                                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                    <!-- header -->
                                    <div class="flex items-center gap-3 px-6 py-4 border-b border-slate-50">
                                        <span
                                            class="w-7 h-7 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">1</span>
                                        <h2 class="font-bold text-base">Địa chỉ giao hàng</h2>
                                    </div>
                                    <div class="px-6 py-5 space-y-4">
                                        <select name="addressId" id="addressId" onchange="toggleAddr()"
                                            class="w-full border border-slate-200 rounded-xl px-4 py-3 text-sm bg-[#f8faf9]">
                                            <c:forEach items="${addresses}" var="a">
                                                <option value="${a.id}">${a.receiver} · ${a.phone} · ${a.addressLine}
                                                </option>
                                            </c:forEach>
                                            <option value="new" ${empty addresses ? 'selected' :''}> + Thêm địa chỉ mới
                                            </option>
                                        </select>
                                        <div id="newAddr"
                                            class="grid grid-cols-1 sm:grid-cols-2 gap-3 ${empty addresses ? '' : 'hidden'}">
                                            <div class="sm:col-span-1">
                                                <label class="block text-xs font-semibold text-slate-500 mb-1">Họ và
                                                    tên</label>
                                                <input name="receiver" type="text" placeholder="Nguyễn Văn A"
                                                    class="w-full border border-slate-200 rounded-xl px-4 py-3 text-sm bg-[#f8faf9]" />
                                            </div>
                                            <div>
                                                <label class="block text-xs font-semibold text-slate-500 mb-1">Số điện
                                                    thoại</label>
                                                <input name="phone" type="tel" placeholder="0912 345 678"
                                                    class="w-full border border-slate-200 rounded-xl px-4 py-3 text-sm bg-[#f8faf9]" />
                                            </div>
                                            <div class="sm:col-span-2">
                                                <label class="block text-xs font-semibold text-slate-500 mb-1">Địa chỉ
                                                    cụ thể</label>
                                                <textarea name="address_line" rows="2"
                                                    placeholder="Số nhà, đường, phường/xã, quận/huyện..."
                                                    class="w-full border border-slate-200 rounded-xl px-4 py-3 text-sm bg-[#f8faf9] resize-none"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- ══ BƯỚC 2: VẬN CHUYỂN ════════════════════════════════ -->
                                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                    <div class="flex items-center gap-3 px-6 py-4 border-b border-slate-50">
                                        <span
                                            class="w-7 h-7 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">2</span>
                                        <h2 class="font-bold text-base">Phương thức vận chuyển</h2>
                                    </div>
                                    <div class="px-6 py-5 grid grid-cols-1 sm:grid-cols-2 gap-3">
                                        <label
                                            class="flex items-center gap-4 p-4 rounded-xl border-2 border-primary bg-primary-light cursor-pointer">
                                            <input type="radio" name="shipping_method" value="FAST" checked
                                                class="accent-primary w-4 h-4" />
                                            <div class="flex-1">
                                                <p class="font-semibold text-sm">⚡ Giao nhanh</p>
                                                <p class="text-xs text-slate-500">Nhận trong 2–4h</p>
                                            </div>
                                            <span class="font-bold text-sm text-primary">35.000đ</span>
                                        </label>
                                        <label
                                            class="flex items-center gap-4 p-4 rounded-xl border-2 border-slate-100 cursor-pointer hover:border-primary/30 transition-all">
                                            <input type="radio" name="shipping_method" value="STANDARD"
                                                class="accent-primary w-4 h-4" />
                                            <div class="flex-1">
                                                <p class="font-semibold text-sm">🚚 Tiêu chuẩn</p>
                                                <p class="text-xs text-slate-500">Nhận trong ngày</p>
                                            </div>
                                            <span class="font-bold text-sm text-primary">15.000đ</span>
                                        </label>
                                    </div>
                                </div>

                                <!-- ══ BƯỚC 3: THANH TOÁN ════════════════════════════════ -->
                                <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
                                    <div class="flex items-center gap-3 px-6 py-4 border-b border-slate-50">
                                        <span
                                            class="w-7 h-7 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">3</span>
                                        <h2 class="font-bold text-base">Phương thức thanh toán</h2>
                                    </div>
                                    <div class="px-6 pt-5 pb-2">
                                        <!-- Lựa chọn -->
                                        <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-5">

                                            <button type="button" onclick="selMethod('BANK_TRANSFER',this)"
                                                class="pay-btn on flex flex-col items-center gap-2 py-4 px-2 rounded-2xl border-2 border-primary bg-primary-light text-center">
                                                <span class="msym text-2xl text-primary">account_balance</span>
                                                <span class="text-xs font-bold leading-tight">Ngân hàng QR</span>
                                            </button>

                                            <button type="button" onclick="selMethod('MOMO',this)"
                                                class="pay-btn flex flex-col items-center gap-2 py-4 px-2 rounded-2xl border-2 border-slate-100 text-center hover:border-primary/40">
                                                <span class="text-2xl">💜</span>
                                                <span class="text-xs font-bold leading-tight">MoMo</span>
                                            </button>

                                            <button type="button" onclick="selMethod('ZALOPAY',this)"
                                                class="pay-btn flex flex-col items-center gap-2 py-4 px-2 rounded-2xl border-2 border-slate-100 text-center hover:border-primary/40">
                                                <span class="text-2xl">💙</span>
                                                <span class="text-xs font-bold leading-tight">ZaloPay</span>
                                            </button>

                                            <button type="button" onclick="selMethod('COD',this)"
                                                class="pay-btn flex flex-col items-center gap-2 py-4 px-2 rounded-2xl border-2 border-slate-100 text-center hover:border-primary/40">
                                                <span class="msym text-2xl text-slate-500">payments</span>
                                                <span class="text-xs font-bold leading-tight">Tiền mặt (COD)</span>
                                            </button>
                                        </div>

                                        <!-- ── QR PANEL ──────────────────────────── -->
                                        <div id="qrPanel"
                                            class="mb-5 rounded-2xl border border-primary/30 bg-[#f4fbf6] overflow-hidden">
                                            <div class="flex items-center justify-between bg-primary/10 px-5 py-3">
                                                <div class="flex items-center gap-2">
                                                    <span class="msym text-primary">qr_code_scanner</span>
                                                    <p class="font-bold text-sm text-primary">Quét QR chuyển khoản ngay
                                                    </p>
                                                </div>
                                                <p class="text-xs text-slate-500">Mở app ngân hàng · Quét QR</p>
                                            </div>

                                            <div class="p-5 flex flex-col md:flex-row gap-6">

                                                <!-- Ngân hàng grid -->
                                                <div>
                                                    <p
                                                        class="text-[11px] font-bold text-slate-400 uppercase tracking-widest mb-3">
                                                        Chọn ngân hàng</p>
                                                    <div id="bankGrid"
                                                        class="grid grid-cols-4 md:grid-cols-2 gap-2 w-full md:w-44">
                                                        <button type="button"
                                                            onclick="pickBank('970436','1234567890','VCB','Vietcombank',this)"
                                                            class="ibank-btn on flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-primary bg-primary-light">
                                                            <img src="https://api.vietqr.io/img/VCB.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span
                                                                class="text-[11px] font-bold truncate">Vietcombank</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970407','9876543210','TCB','Techcombank',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/TCB.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span
                                                                class="text-[11px] font-bold truncate">Techcombank</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970422','1122334455','MB','MB Bank',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/MB.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span class="text-[11px] font-bold truncate">MB Bank</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970418','5566778899','BIDV','BIDV',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/BIDV.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span class="text-[11px] font-bold truncate">BIDV</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970405','3344556677','AGRIBANK','Agribank',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/AGRIBANK.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span class="text-[11px] font-bold truncate">Agribank</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970423','7788990011','TPB','TPBank',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/TPB.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span class="text-[11px] font-bold truncate">TPBank</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970432','2233445566','VPB','VPBank',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/VPB.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span class="text-[11px] font-bold truncate">VPBank</span>
                                                        </button>
                                                        <button type="button"
                                                            onclick="pickBank('970416','9900112233','ACB','ACB',this)"
                                                            class="ibank-btn flex items-center gap-2 py-2 px-2.5 rounded-xl border-2 border-slate-100 hover:border-primary/40">
                                                            <img src="https://api.vietqr.io/img/ACB.png"
                                                                class="w-7 h-7 object-contain shrink-0" alt="" />
                                                            <span class="text-[11px] font-bold truncate">ACB</span>
                                                        </button>
                                                    </div>
                                                </div>

                                                <!-- QR + thông tin -->
                                                <div class="flex-1 flex flex-col items-center gap-4">
                                                    <!-- QR image -->
                                                    <div
                                                        class="relative p-3 bg-white rounded-2xl shadow-md border-4 border-primary/20">
                                                        <img id="qrImg" src="" alt="QR Code"
                                                            class="w-48 h-48 object-contain rounded-xl block" />
                                                        <div id="qrSpin"
                                                            class="absolute inset-0 bg-white/90 grid place-items-center rounded-xl">
                                                            <div
                                                                class="w-8 h-8 rounded-full border-2 border-primary border-t-transparent spin">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Bank name + account -->
                                                    <div class="text-center">
                                                        <div class="flex items-center justify-center gap-2 mb-0.5">
                                                            <img id="qrBankLogo" src="https://api.vietqr.io/img/VCB.png"
                                                                class="w-5 h-5 object-contain" alt="" />
                                                            <span id="qrBankName"
                                                                class="font-bold text-sm">Vietcombank</span>
                                                        </div>
                                                        <p id="qrBankAcc" class="text-xs text-slate-500 font-mono">STK:
                                                            1234567890</p>
                                                        <p class="text-xs text-slate-400">Chủ TK: NONG SAN VIET</p>
                                                    </div>

                                                    <!-- Amount + note -->
                                                    <div
                                                        class="w-full rounded-xl border border-slate-200 bg-white p-3 text-sm space-y-2">
                                                        <div class="flex justify-between items-center">
                                                            <span class="text-slate-500 text-xs">Số tiền</span>
                                                            <span class="font-extrabold text-primary text-base"
                                                                id="qrAmt">--</span>
                                                        </div>
                                                        <div class="flex justify-between items-center">
                                                            <span class="text-slate-500 text-xs">Nội dung CK</span>
                                                            <div class="flex items-center gap-2">
                                                                <code class="text-xs font-bold text-slate-700"
                                                                    id="qrNote">NONGSANVIET</code>
                                                                <button type="button" id="cpBtn" onclick="copyNote()"
                                                                    class="text-[11px] font-bold text-primary hover:underline">copy</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <p class="text-[10px] text-slate-400 text-center">Sau khi chuyển
                                                        khoản, nhấn <strong class="text-primary">Xác nhận đặt
                                                            hàng</strong></p>
                                                </div>

                                            </div>
                                        </div>

                                        <!-- ── COD note ──────────────────────────── -->
                                        <div id="codNote"
                                            class="hidden mb-5 flex items-center gap-3 bg-amber-50 border border-amber-200 rounded-xl p-4 text-sm text-amber-800">
                                            <span class="msym text-amber-500">info</span>
                                            <span>Vui lòng chuẩn bị tiền mặt khi nhận hàng. Shipper sẽ liên hệ trước khi
                                                giao.</span>
                                        </div>

                                    </div>
                                </div>

                            </div><!-- /space-y-5 -->

                            <!-- Submit (mobile only) -->
                            <button type="submit"
                                class="lg:hidden w-full mt-5 bg-primary hover:bg-primary-dark text-white font-extrabold py-4 rounded-2xl shadow-lg transition-all flex items-center justify-center gap-2 text-sm">
                                <span class="msym">check_circle</span> XÁC NHẬN ĐẶT HÀNG
                            </button>
                        </form>
                    </div>

                    <!-- ──── ORDER SUMMARY (1/3) ─────────────────────── -->
                    <div class="lg:col-span-1">
                        <div class="sticky top-20 space-y-4">
                            <div class="bg-white rounded-2xl shadow-sm p-5">
                                <h3 class="font-bold text-base mb-4 pb-3 border-b border-slate-50">Đơn hàng của bạn</h3>

                                <!-- Items -->
                                <div class="space-y-3 max-h-56 overflow-y-auto scrollbar mb-4 pr-1">
                                    <c:forEach items="${cartItems}" var="item">
                                        <div class="flex gap-3 items-center">
                                            <div
                                                class="w-12 h-12 rounded-xl overflow-hidden bg-slate-50 shrink-0 flex items-center justify-center border border-slate-100">
                                                <c:choose>
                                                    <c:when test="${not empty item.product.imageUrl}">
                                                        <img src="${item.product.imageUrl}" alt="${item.product.name}"
                                                            class="w-full h-full object-cover" />
                                                    </c:when>
                                                    <c:otherwise><span
                                                            class="msym text-slate-300 text-xl">inventory_2</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <p class="text-xs font-semibold line-clamp-1 leading-tight">
                                                    ${item.product.name}</p>
                                                <p class="text-[11px] text-slate-400">x${item.quantity}</p>
                                            </div>
                                            <p class="text-xs font-bold text-primary shrink-0">
                                                <fmt:formatNumber value="${item.product.price * item.quantity}"
                                                    type="number" groupingUsed="true" />đ
                                            </p>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Voucher -->
                                <c:if test="${not empty selectedVoucher}">
                                    <div
                                        class="flex items-center gap-2 bg-green-50 border border-green-200 rounded-xl px-3 py-2 mb-4">
                                        <span class="msym text-green-500 text-sm">sell</span>
                                        <span
                                            class="text-xs font-semibold text-green-700 flex-1 truncate">${selectedVoucher.code}</span>
                                        <span class="text-xs font-extrabold text-green-600 shrink-0">
                                            −
                                            <fmt:formatNumber value="${discountAmount}" type="number"
                                                groupingUsed="true" />đ
                                        </span>
                                    </div>
                                </c:if>

                                <!-- Totals -->
                                <div class="space-y-2 text-sm">
                                    <div class="flex justify-between text-slate-500">
                                        <span>Tạm tính</span>
                                        <span>
                                            <fmt:formatNumber value="${subTotal}" type="number" groupingUsed="true" />đ
                                        </span>
                                    </div>
                                    <div class="flex justify-between text-slate-500">
                                        <span>Vận chuyển</span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${shippingFee == 0}"><span
                                                        class="text-green-600 font-semibold">Miễn phí</span></c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${shippingFee}" type="number"
                                                        groupingUsed="true" />đ
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <c:if test="${discountAmount > 0}">
                                        <div class="flex justify-between text-green-600">
                                            <span>Voucher</span>
                                            <span>−
                                                <fmt:formatNumber value="${discountAmount}" type="number"
                                                    groupingUsed="true" />đ
                                            </span>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Total -->
                                <div class="flex justify-between items-center mt-4 pt-4 border-t border-slate-100">
                                    <span class="font-bold text-base">Tổng cộng</span>
                                    <span class="text-2xl font-extrabold text-primary">
                                        <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true" />đ
                                    </span>
                                </div>

                                <!-- Submit button (desktop) -->
                                <button form="checkoutForm" type="submit"
                                    class="hidden lg:flex w-full mt-5 bg-primary hover:bg-primary-dark text-white font-extrabold py-3.5 rounded-2xl shadow-md shadow-primary/25 transition-all items-center justify-center gap-2 text-sm">
                                    <span class="msym">check_circle</span> XÁC NHẬN ĐẶT HÀNG
                                </button>

                                <p
                                    class="text-center text-[11px] text-slate-400 mt-3 flex items-center justify-center gap-1">
                                    <span class="msym text-sm">shield</span> Thanh toán an toàn · Cam kết rau sạch
                                </p>
                            </div>

                            <!-- Quick link voucher -->
                            <a href="${pageContext.request.contextPath}/voucher"
                                class="flex items-center gap-2 bg-white rounded-2xl shadow-sm p-4 hover:shadow-md transition-shadow group">
                                <span class="msym text-primary group-hover:scale-110 transition-transform">sell</span>
                                <span class="text-sm font-semibold">Chọn voucher giảm giá</span>
                                <span class="msym text-slate-300 ml-auto">chevron_right</span>
                            </a>
                        </div>
                    </div>

                </main>

                <!-- ─── FOOTER ─────────────────────────────────────────────────────── -->
                <footer class="mt-16 border-t border-slate-100 py-8 bg-white text-center text-xs text-slate-400">
                    © 2024 Nông Sản Việt — Thực phẩm sạch từ nông trại Việt Nam
                </footer>

                <jsp:include page="WEB-INF/views/chat-widget.jsp" />

                <script>
                    // =================================================================
                    // CẤU HÌNH NGÂN HÀNG — ĐỔI acc THÀNH SỐ TÀI KHOẢN THỰC CỦA SHOP
                    // =================================================================
                    const SHOP = {
                        name: 'NONG SAN VIET',
                        banks: {
                            VCB: { bin: '970436', acc: '1234567890' },
                            TCB: { bin: '970407', acc: '9876543210' },
                            MB: { bin: '970422', acc: '1122334455' },
                            BIDV: { bin: '970418', acc: '5566778899' },
                            AGRIBANK: { bin: '970405', acc: '3344556677' },
                            TPB: { bin: '970423', acc: '7788990011' },
                            VPB: { bin: '970432', acc: '2233445566' },
                            ACB: { bin: '970416', acc: '9900112233' },
                        }
                    };
                    // =================================================================


                    const TOTAL = Number("${totalAmount}");
                    let curBin = SHOP.banks.VCB.bin;
                    let curAcc = SHOP.banks.VCB.acc;

                    // ── Toggle địa chỉ mới ───────────────────────────────────────────
                    function toggleAddr() {
                        const sel = document.getElementById('addressId');
                        const box = document.getElementById('newAddr');
                        if (box) box.classList.toggle('hidden', sel.value !== 'new');
                    }
                    window.addEventListener('load', toggleAddr);

                    // ── Chọn phương thức thanh toán ─────────────────────────────────
                    function selMethod(m, btn) {
                        document.querySelectorAll('.pay-btn').forEach(b => {
                            b.classList.remove('on', 'border-primary', 'bg-primary-light');
                            b.classList.add('border-slate-100');
                        });
                        btn.classList.add('on');
                        btn.classList.remove('border-slate-100');
                        document.getElementById('selPay').value = m;

                        const isQr = m !== 'COD';
                        document.getElementById('qrPanel').classList.toggle('hidden', !isQr);
                        document.getElementById('codNote').classList.toggle('hidden', isQr);

                        if (isQr) {
                            const img = document.getElementById('qrImg');
                            if (!img.dataset.ok) genQr();
                        }
                    }

                    // ── Chọn ngân hàng ───────────────────────────────────────────────
                    function pickBank(bin, acc, logo, label, btn) {
                        curBin = bin; curAcc = acc;
                        document.querySelectorAll('.ibank-btn').forEach(b => {
                            b.classList.remove('on', 'border-primary', 'bg-primary-light');
                            b.classList.add('border-slate-100');
                        });
                        btn.classList.add('on', 'border-primary', 'bg-primary-light');
                        btn.classList.remove('border-slate-100');

                        document.getElementById('qrBankLogo').src = `https://api.vietqr.io/img/${logo}.png`;
                        document.getElementById('qrBankName').textContent = label;
                        document.getElementById('qrBankAcc').textContent = 'STK: ' + acc;
                        genQr();
                    }

                    // ── Sinh QR ──────────────────────────────────────────────────────
                    function genQr() {
                        const img = document.getElementById('qrImg');
                        const spin = document.getElementById('qrSpin');
                        const amt = Math.round(TOTAL);
                        const note = 'NONGSANVIET ' + Date.now().toString().slice(-6);

                        document.getElementById('qrAmt').textContent = amt.toLocaleString('vi-VN') + 'đ';
                        document.getElementById('qrNote').textContent = note;
                        spin.classList.remove('hidden');

                        const url = `https://img.vietqr.io/image/${curBin}-${curAcc}-compact2.png`
                            + `?amount=${amt}`
                            + `&addInfo=${encodeURIComponent(note)}`
                            + `&accountName=${encodeURIComponent(SHOP.name)}`;

                        img.onload = () => { spin.classList.add('hidden'); img.dataset.ok = '1'; };
                        img.onerror = () => {
                            spin.classList.add('hidden');
                            img.src = `https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${encodeURIComponent(note)}`;
                        };
                        img.src = url;
                    }

                    // ── Copy nội dung chuyển khoản ───────────────────────────────────
                    function copyNote() {
                        navigator.clipboard.writeText(document.getElementById('qrNote').textContent.trim()).catch(() => { });
                        const b = document.getElementById('cpBtn');
                        b.textContent = '✓ copied';
                        setTimeout(() => b.textContent = 'copy', 2000);
                    }

                    // ── Khởi chạy ────────────────────────────────────────────────────
                    document.addEventListener('DOMContentLoaded', () => {
                        document.getElementById('selPay').value = 'BANK_TRANSFER';
                        genQr();
                    });
                </script>
            </body>

            </html>