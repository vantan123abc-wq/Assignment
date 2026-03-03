<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Thanh toán QR - Nông Sản Việt</title>
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
                                colors: { "primary": "#4cae4f", "background-light": "#f6f7f6", "background-dark": "#151d15" },
                                fontFamily: { "display": ["Inter"] },
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

                    .bank-btn.active {
                        border-color: #4cae4f;
                        background: rgba(76, 174, 79, 0.08);
                    }

                    @keyframes pulse-ring {

                        0%,
                        100% {
                            opacity: .4;
                            transform: scale(1)
                        }

                        50% {
                            opacity: .8;
                            transform: scale(1.08)
                        }
                    }

                    .qr-pulse {
                        animation: pulse-ring 2s ease-in-out infinite;
                    }

                    @keyframes countdown {
                        from {
                            width: 100%
                        }

                        to {
                            width: 0
                        }
                    }
                </style>
            </head>

            <body
                class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen">

                <!-- HEADER -->
                <header
                    class="sticky top-0 z-50 bg-white/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-primary/10">
                    <div class="max-w-4xl mx-auto px-4 flex items-center justify-between h-16">
                        <a href="${pageContext.request.contextPath}/index" class="flex items-center gap-2 text-primary">
                            <span class="material-symbols-outlined text-2xl">agriculture</span>
                            <span class="font-black tracking-tight">Nông Sản Việt</span>
                        </a>
                        <div class="flex items-center gap-2 text-sm text-slate-500">
                            <span class="material-symbols-outlined text-base text-primary">lock</span>
                            <span>Thanh toán an toàn</span>
                        </div>
                    </div>
                </header>

                <!-- STEP BAR -->
                <div class="bg-white dark:bg-slate-900 border-b border-slate-100 dark:border-slate-800">
                    <div class="max-w-4xl mx-auto px-4 py-3 flex items-center gap-3 text-xs font-semibold">
                        <div class="flex items-center gap-1.5 text-slate-400">
                            <span class="w-5 h-5 rounded-full bg-slate-200 flex items-center justify-center">1</span>
                            Giỏ hàng
                        </div>
                        <span class="material-symbols-outlined text-xs text-slate-300">chevron_right</span>
                        <div class="flex items-center gap-1.5 text-slate-400">
                            <span class="w-5 h-5 rounded-full bg-slate-200 flex items-center justify-center">2</span>
                            Thanh toán
                        </div>
                        <span class="material-symbols-outlined text-xs text-slate-300">chevron_right</span>
                        <div class="flex items-center gap-1.5 text-primary font-bold">
                            <span
                                class="w-5 h-5 rounded-full bg-primary text-white flex items-center justify-center">3</span>
                            Quét QR
                        </div>
                        <span class="material-symbols-outlined text-xs text-slate-300">chevron_right</span>
                        <div class="flex items-center gap-1.5 text-slate-400">
                            <span class="w-5 h-5 rounded-full bg-slate-200 flex items-center justify-center">4</span>
                            Xác nhận
                        </div>
                    </div>
                </div>

                <main class="max-w-4xl mx-auto px-4 py-8">
                    <div class="text-center mb-8">
                        <h1 class="text-2xl font-black mb-1">Quét mã QR để thanh toán</h1>
                        <p class="text-slate-500 text-sm">
                            Mã đơn hàng: <strong class="text-primary">#${orderId}</strong> —
                            Số tiền: <strong class="text-primary text-base">
                                <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true" />đ
                            </strong>
                        </p>
                    </div>

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                        <!-- LEFT: Chọn ngân hàng -->
                        <div class="lg:col-span-1">
                            <h3 class="font-bold text-sm text-slate-600 mb-3 uppercase tracking-wider">Chọn ngân hàng
                            </h3>
                            <div class="space-y-2" id="bankList">
                                <button onclick="selectBank('vcb','970436','0123456789','NONG SAN VIET')"
                                    class="bank-btn active w-full flex items-center gap-3 p-3 rounded-xl border-2 border-primary bg-primary/5 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/VCB.png" alt="VCB"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">Vietcombank</p>
                                        <p class="text-xs text-slate-500">VCB</p>
                                    </div>
                                </button>

                                <button onclick="selectBank('tcb','970407','9876543210','NONG SAN VIET')"
                                    class="bank-btn w-full flex items-center gap-3 p-3 rounded-xl border-2 border-slate-100 hover:border-primary/40 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/TCB.png" alt="TCB"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">Techcombank</p>
                                        <p class="text-xs text-slate-500">TCB</p>
                                    </div>
                                </button>

                                <button onclick="selectBank('mb','970422','1122334455','NONG SAN VIET')"
                                    class="bank-btn w-full flex items-center gap-3 p-3 rounded-xl border-2 border-slate-100 hover:border-primary/40 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/MB.png" alt="MB"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">MB Bank</p>
                                        <p class="text-xs text-slate-500">MB</p>
                                    </div>
                                </button>

                                <button onclick="selectBank('bidv','970418','5566778899','NONG SAN VIET')"
                                    class="bank-btn w-full flex items-center gap-3 p-3 rounded-xl border-2 border-slate-100 hover:border-primary/40 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/BIDV.png" alt="BIDV"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">BIDV</p>
                                        <p class="text-xs text-slate-500">BIDV</p>
                                    </div>
                                </button>

                                <button onclick="selectBank('agri','970405','3344556677','NONG SAN VIET')"
                                    class="bank-btn w-full flex items-center gap-3 p-3 rounded-xl border-2 border-slate-100 hover:border-primary/40 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/AGRIBANK.png" alt="Agribank"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">Agribank</p>
                                        <p class="text-xs text-slate-500">AGR</p>
                                    </div>
                                </button>

                                <button onclick="selectBank('tpb','970423','7788990011','NONG SAN VIET')"
                                    class="bank-btn w-full flex items-center gap-3 p-3 rounded-xl border-2 border-slate-100 hover:border-primary/40 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/TPB.png" alt="TPBank"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">TPBank</p>
                                        <p class="text-xs text-slate-500">TPB</p>
                                    </div>
                                </button>

                                <button onclick="selectBank('vpb','970432','2233445566','NONG SAN VIET')"
                                    class="bank-btn w-full flex items-center gap-3 p-3 rounded-xl border-2 border-slate-100 hover:border-primary/40 transition-all text-left">
                                    <div
                                        class="w-10 h-10 rounded-lg overflow-hidden bg-white flex items-center justify-center shrink-0 shadow-sm">
                                        <img src="https://api.vietqr.io/img/VPB.png" alt="VPBank"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p class="font-bold text-sm">VPBank</p>
                                        <p class="text-xs text-slate-500">VPB</p>
                                    </div>
                                </button>
                            </div>
                        </div>

                        <!-- RIGHT: QR Code + Hướng dẫn -->
                        <div class="lg:col-span-2 flex flex-col gap-6">

                            <!-- QR Box -->
                            <div
                                class="bg-white dark:bg-slate-900 rounded-2xl border border-primary/10 shadow-lg p-8 flex flex-col items-center">
                                <!-- Logo ngân hàng hiện tại -->
                                <div class="flex items-center gap-3 mb-5">
                                    <div id="currentBankLogo"
                                        class="w-12 h-12 rounded-xl bg-white shadow-md flex items-center justify-center overflow-hidden border border-slate-100">
                                        <img src="https://api.vietqr.io/img/VCB.png" alt="Bank"
                                            class="w-full h-full object-contain p-1" />
                                    </div>
                                    <div>
                                        <p id="currentBankName" class="font-black text-lg">Vietcombank</p>
                                        <p id="currentBankAccount" class="text-sm text-slate-500">STK: 0123456789</p>
                                    </div>
                                </div>

                                <!-- QR Image (VietQR API) -->
                                <div class="relative">
                                    <div class="qr-pulse absolute inset-0 rounded-2xl bg-primary/10"></div>
                                    <div class="relative bg-white p-3 rounded-2xl border-4 border-primary/20 shadow-xl">
                                        <img id="qrImage" src="" alt="QR Code thanh toán"
                                            class="w-52 h-52 sm:w-64 sm:h-64 object-contain rounded-xl"
                                            onerror="this.src='https//api.qrserver.com/v1/create-qr-code/?size=250x250&data=DonHang${orderId}'" />
                                    </div>
                                </div>

                                <!-- Amount badge -->
                                <div class="mt-5 bg-primary/10 px-6 py-3 rounded-xl text-center">
                                    <p class="text-xs text-slate-500 uppercase tracking-wider mb-0.5">Số tiền cần chuyển
                                    </p>
                                    <p class="text-2xl font-black text-primary">
                                        <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true" />đ
                                    </p>
                                </div>

                                <!-- Nội dung chuyển khoản -->
                                <div
                                    class="mt-4 w-full bg-slate-50 dark:bg-slate-800 rounded-xl p-4 border border-slate-100 dark:border-slate-700">
                                    <p class="text-xs text-slate-500 uppercase tracking-wider mb-1">Nội dung chuyển
                                        khoản</p>
                                    <div class="flex items-center justify-between gap-3">
                                        <code id="transferContent"
                                            class="text-sm font-bold flex-1">NONGSANVIET ${orderId}</code>
                                        <button onclick="copyContent()"
                                            class="flex items-center gap-1 text-xs text-primary font-bold hover:underline shrink-0">
                                            <span class="material-symbols-outlined text-sm">content_copy</span> Copy
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Hướng dẫn -->
                            <div class="bg-white dark:bg-slate-900 rounded-2xl border border-primary/10 shadow-sm p-6">
                                <h3 class="font-bold mb-4 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary">help</span>
                                    Hướng dẫn thanh toán
                                </h3>
                                <ol class="space-y-3 text-sm">
                                    <li class="flex items-start gap-3">
                                        <span
                                            class="w-6 h-6 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">1</span>
                                        <span>Mở app ngân hàng hoặc ví điện tử trên điện thoại</span>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <span
                                            class="w-6 h-6 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">2</span>
                                        <span>Chọn <strong>Quét QR</strong> — quét mã QR hiển thị bên trên</span>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <span
                                            class="w-6 h-6 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">3</span>
                                        <span>Kiểm tra số tiền <strong class="text-primary">
                                                <fmt:formatNumber value="${totalAmount}" type="number"
                                                    groupingUsed="true" />đ
                                            </strong> và nội dung chuyển khoản</span>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <span
                                            class="w-6 h-6 rounded-full bg-primary text-white text-xs font-bold flex items-center justify-center shrink-0">4</span>
                                        <span>Xác nhận chuyển khoản và nhấn nút <strong>"Tôi đã thanh toán"</strong> bên
                                            dưới</span>
                                    </li>
                                </ol>
                            </div>

                            <!-- Buttons -->
                            <div class="flex flex-col sm:flex-row gap-3">
                                <!-- Xác nhận đã thanh toán -->
                                <form action="${pageContext.request.contextPath}/checkout" method="post" class="flex-1">
                                    <input type="hidden" name="action" value="confirmPayment" />
                                    <input type="hidden" name="orderId" value="${orderId}" />
                                    <button type="submit"
                                        class="w-full bg-primary hover:brightness-110 text-white font-black py-4 rounded-xl shadow-lg shadow-primary/20 transition-all flex items-center justify-center gap-2 text-base">
                                        <span class="material-symbols-outlined">check_circle</span>
                                        Tôi đã thanh toán
                                    </button>
                                </form>
                                <!-- Huỷ -->
                                <form action="${pageContext.request.contextPath}/checkout" method="post">
                                    <input type="hidden" name="action" value="cancelOrder" />
                                    <input type="hidden" name="orderId" value="${orderId}" />
                                    <button type="submit"
                                        class="px-6 py-4 rounded-xl border-2 border-slate-200 text-slate-500 hover:border-red-200 hover:text-red-500 font-semibold transition-all text-sm whitespace-nowrap">
                                        Huỷ đơn
                                    </button>
                                </form>
                            </div>

                            <p class="text-center text-xs text-slate-400">
                                Đơn hàng sẽ được xử lý sau khi chúng tôi xác nhận giao dịch (thường trong 1-5 phút).
                            </p>
                        </div>
                    </div>
                </main>

                <jsp:include page="WEB-INF/views/chat-widget.jsp" />

                <script>
                    // =============================================
                    // Cấu hình ngân hàng — THAY bankAccount và accountName theo thông tin thực
                    // =============================================
                const ORDER_ID = "<%= orderId %>";
               const AMOUNT = "<%= totalAmount %>";
               const ADD_INFO = "NONGSANVIET" + ORDER_ID;
 

                    // VietQR API endpoint:
                    // https://img.vietqr.io/image/{BANK_BIN}-{ACCOUNT_NO}-{TEMPLATE}.png?amount=X&addInfo=Y&accountName=Z
                    function buildQrUrl(bin, account, name) {
                        const template = 'compact2';
                        const url = `https://img.vietqr.io/image/${bin}-${account}-${template}.png`
                            + `?amount=${Math.round(AMOUNT)}`
                            + `&addInfo=${encodeURIComponent(ADD_INFO)}`
                            + `&accountName=${encodeURIComponent(name)}`;
                        return url;
                    }

                    let currentBank = 'vcb';
                    const banks = {                    
                        tcb: { bin: '970407', account: '9007032005', name: 'TRINH NHAT KHANH', logo: 'TCB', label: 'Techcombank' },
                        mb: { bin: '970422', account: '0867590405', name: 'TRINH NHAT KHANH', logo: 'MB', label: 'MB Bank' },                                                                             
                    };

                    function selectBank(key, bin, account, name) {
                        currentBank = key;
                        const b = banks[key];

                        // Update QR image
                        document.getElementById('qrImage').src = buildQrUrl(bin, account, name);

                        // Update bank info display
                        document.getElementById('currentBankLogo').querySelector('img').src
                            = `https://api.vietqr.io/img/${b.logo}.png`;
                        document.getElementById('currentBankName').textContent = b.label;
                        document.getElementById('currentBankAccount').textContent = 'STK: ' + account;

                        // Update active button
                        document.querySelectorAll('.bank-btn').forEach(btn => {
                            btn.classList.remove('active', 'border-primary', 'bg-primary/5');
                            btn.classList.add('border-slate-100');
                        });
                        event.currentTarget.classList.add('active');
                        event.currentTarget.classList.remove('border-slate-100');
                    }

                    function copyContent() {
                        const text = document.getElementById('transferContent').textContent.trim();
                        navigator.clipboard.writeText(text).then(() => {
                            const btn = event.currentTarget;
                            btn.innerHTML = '<span class="material-symbols-outlined text-sm">check</span> Đã copy';
                            setTimeout(() => {
                                btn.innerHTML = '<span class="material-symbols-outlined text-sm">content_copy</span> Copy';
                            }, 2000);
                        });
                    }

                    // Load QR cho ngân hàng đầu tiên khi trang load
                    document.addEventListener('DOMContentLoaded', () => {
                        const b = banks['vcb'];
                        document.getElementById('qrImage').src = buildQrUrl(b.bin, b.account, b.name);
                    });
                </script>
            </body>

            </html>