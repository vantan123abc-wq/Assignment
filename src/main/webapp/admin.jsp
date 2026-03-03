<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Admin - Nông Sản Việt</title>

                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap"
                    rel="stylesheet" />

                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
                                fontFamily: { "display": ["Inter"] },
                                borderRadius: {
                                    "DEFAULT": "0.25rem",
                                    "lg": "0.5rem",
                                    "xl": "0.75rem",
                                    "2xl": "1rem",
                                    "3xl": "1.5rem",
                                    "full": "9999px"
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
                        <a href="#"
                            class="flex items-center gap-3 px-4 py-3 bg-primary/10 text-primary rounded-xl font-semibold transition-colors">
                            <span class="material-symbols-outlined">dashboard</span> Tổng quan (Chart)
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users"
                            class="flex items-center gap-3 px-4 py-3 text-slate-500 hover:bg-slate-50 hover:text-primary rounded-xl font-medium transition-colors">
                            <span class="material-symbols-outlined">group</span> Người dùng
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/inventory"
                            class="flex items-center gap-3 px-4 py-3 text-slate-500 hover:bg-slate-50 hover:text-primary rounded-xl font-medium transition-colors">
                            <span class="material-symbols-outlined">inventory_2</span> Kho hàng
                        </a>
                        <a href="#"
                            class="flex items-center gap-3 px-4 py-3 text-slate-500 hover:bg-slate-50 hover:text-primary rounded-xl font-medium transition-colors">
                            <span class="material-symbols-outlined">receipt_long</span> Đơn hàng
                        </a>
                    </nav>

                    <div class="p-4 border-t border-slate-100">
                        <a href="logout"
                            class="flex items-center justify-center gap-2 w-full p-3 rounded-xl bg-red-50 text-red-600 font-semibold hover:bg-red-100 transition-colors">
                            <span class="material-symbols-outlined">logout</span> Đăng xuất
                        </a>
                    </div>
                </aside>

                <main class="flex-1 h-full overflow-y-auto bg-background-light p-8">

                    <div class="flex items-center justify-between mb-8">
                        <div>
                            <h2 class="text-3xl font-black text-slate-800">Bảng điều khiển</h2>
                            <p class="text-slate-500 mt-1">Xin chào Admin, đây là tình hình kinh doanh hôm nay.</p>
                        </div>
                        <div class="flex flex-row items-center gap-4">
                            <button
                                class="p-2 text-slate-500 bg-white hover:bg-slate-100 rounded-full relative shadow-sm border border-slate-100 group"
                                <c:if test="${hasStockAlert}">title="Cảnh báo: Có ${outOfStockCount} sản phẩm hết hàng
                                và ${lowStockCount} sản phẩm sắp hết hàng"</c:if>>
                                <span class="material-symbols-outlined">notifications</span>
                                <c:if test="${hasStockAlert}">
                                    <span
                                        class="absolute top-1.5 right-1.5 w-2.5 h-2.5 bg-red-500 rounded-full border-2 border-white animate-pulse"></span>
                                </c:if>

                                <!-- Tooltip Dropdown Menu -->
                                <c:if test="${hasStockAlert}">
                                    <div
                                        class="absolute right-0 top-full mt-2 w-72 bg-white rounded-xl shadow-lg border border-slate-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50 text-left">
                                        <div class="p-4 border-b border-slate-50">
                                            <h3 class="font-bold text-slate-800">Thông báo kho hàng</h3>
                                        </div>
                                        <div class="p-2">
                                            <c:if test="${outOfStockCount > 0}">
                                                <a href="${pageContext.request.contextPath}/admin/inventory?filter=outOfStock"
                                                    class="flex items-start gap-3 p-3 hover:bg-red-50 rounded-lg transition-colors">
                                                    <div class="bg-red-100 text-red-600 p-2 rounded-full shrink-0">
                                                        <span class="material-symbols-outlined text-sm">error</span>
                                                    </div>
                                                    <div>
                                                        <p class="text-sm font-medium text-slate-800">Hết hàng</p>
                                                        <p class="text-xs text-slate-500 mt-0.5">Có ${outOfStockCount}
                                                            sản phẩm đã hết hàng trong kho.</p>
                                                    </div>
                                                </a>
                                            </c:if>
                                            <c:if test="${lowStockCount > 0}">
                                                <a href="${pageContext.request.contextPath}/admin/inventory?filter=lowStock"
                                                    class="flex items-start gap-3 p-3 hover:bg-orange-50 rounded-lg transition-colors">
                                                    <div
                                                        class="bg-orange-100 text-orange-600 p-2 rounded-full shrink-0">
                                                        <span class="material-symbols-outlined text-sm">warning</span>
                                                    </div>
                                                    <div>
                                                        <p class="text-sm font-medium text-slate-800">Sắp hết hàng</p>
                                                        <p class="text-xs text-slate-500 mt-0.5">Có ${lowStockCount} sản
                                                            phẩm sắp hết hàng (kho <= 5).</p>
                                                    </div>
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>
                            </button>
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

                    <div class="space-y-8">

                        <section class="bg-white border border-slate-100 rounded-2xl p-6 shadow-sm">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-xl font-bold flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary">bar_chart</span> Thống kê doanh
                                    thu
                                </h3>
                                <select id="revenueMode"
                                    class="bg-slate-50 border-none rounded-xl text-sm font-medium focus:ring-2 focus:ring-primary/50 px-4 py-2">
                                    <option value="daily">Từng ngày</option>
                                    <option value="monthly">Từng tháng</option>
                                    <option value="yearly">Từng năm</option>
                                </select>
                            </div>
                            <div class="w-full h-[300px]">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </section>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

                            <section class="bg-white border border-slate-100 rounded-2xl p-6 shadow-sm overflow-hidden">
                                <div class="flex items-center justify-between mb-6">
                                    <h3 class="text-xl font-bold">Người dùng hệ thống</h3>
                                </div>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm text-left">
                                        <thead
                                            class="text-xs text-slate-500 uppercase bg-slate-50 border-b border-slate-100">
                                            <tr>
                                                <th class="px-4 py-3 rounded-tl-xl">Khách hàng</th>
                                                <th class="px-4 py-3">Vai trò</th>
                                                <th class="px-4 py-3 rounded-tr-xl text-right">Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <tr class="hover:bg-slate-50 transition-colors">
                                                <td class="px-4 py-3 font-medium text-slate-900">nguyenvana@gmail.com
                                                </td>
                                                <td class="px-4 py-3"><span
                                                        class="bg-slate-100 text-slate-600 px-2 py-1 rounded-md text-xs font-bold">User</span>
                                                </td>
                                                <td class="px-4 py-3 text-right">
                                                    <span
                                                        class="inline-flex items-center gap-1 bg-green-50 text-green-600 px-2.5 py-1 rounded-full text-xs font-bold border border-green-200">
                                                        <span class="size-2 rounded-full bg-green-500"></span> Online
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr class="hover:bg-slate-50 transition-colors">
                                                <td class="px-4 py-3 font-medium text-slate-900">lethib@gmail.com</td>
                                                <td class="px-4 py-3"><span
                                                        class="bg-primary/10 text-primary px-2 py-1 rounded-md text-xs font-bold">Admin</span>
                                                </td>
                                                <td class="px-4 py-3 text-right">
                                                    <span
                                                        class="inline-flex items-center gap-1 bg-slate-100 text-slate-500 px-2.5 py-1 rounded-full text-xs font-bold">
                                                        <span class="size-2 rounded-full bg-slate-400"></span> Offline
                                                    </span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </section>

                            <section class="bg-white border border-slate-100 rounded-2xl p-6 shadow-sm overflow-hidden">
                                <div class="flex items-center justify-between mb-6">
                                    <h3 class="text-xl font-bold">Đơn hàng mới nhất</h3>
                                    <a href="#" class="text-sm font-semibold text-primary hover:underline">Xem tất
                                        cả</a>
                                </div>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm text-left">
                                        <thead
                                            class="text-xs text-slate-500 uppercase bg-slate-50 border-b border-slate-100">
                                            <tr>
                                                <th class="px-4 py-3 rounded-tl-xl">Mã ĐH</th>
                                                <th class="px-4 py-3">Tổng tiền</th>
                                                <th class="px-4 py-3 rounded-tr-xl">Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            <tr class="hover:bg-slate-50 transition-colors">
                                                <td class="px-4 py-3 font-bold text-slate-900">#DH001</td>
                                                <td class="px-4 py-3 font-medium text-primary">350.000₫</td>
                                                <td class="px-4 py-3">
                                                    <select
                                                        class="text-xs font-bold rounded-lg border-slate-200 bg-orange-50 text-orange-600 focus:ring-0 py-1 pl-2 pr-6">
                                                        <option selected>Chờ xác nhận</option>
                                                        <option>Đang giao</option>
                                                        <option>Đã giao</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr class="hover:bg-slate-50 transition-colors">
                                                <td class="px-4 py-3 font-bold text-slate-900">#DH002</td>
                                                <td class="px-4 py-3 font-medium text-primary">1.250.000₫</td>
                                                <td class="px-4 py-3">
                                                    <select
                                                        class="text-xs font-bold rounded-lg border-slate-200 bg-green-50 text-green-600 focus:ring-0 py-1 pl-2 pr-6">
                                                        <option>Chờ xác nhận</option>
                                                        <option>Đang giao</option>
                                                        <option selected>Đã giao</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </section>

                        </div>

                        <section class="bg-white border border-slate-100 rounded-2xl p-6 shadow-sm overflow-hidden">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-xl font-bold">Tình trạng Kho hàng</h3>
                                <button
                                    class="bg-primary hover:bg-primary/90 text-white font-bold py-2 px-4 rounded-xl text-sm transition-transform active:scale-95 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-sm">add</span> Thêm sản phẩm
                                </button>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="w-full text-sm text-left">
                                    <thead
                                        class="text-xs text-slate-500 uppercase bg-slate-50 border-b border-slate-100">
                                        <tr>
                                            <th class="px-4 py-3 rounded-tl-xl">Sản phẩm</th>
                                            <th class="px-4 py-3 text-center">Tồn kho</th>
                                            <th class="px-4 py-3 text-right">Giá bán</th>
                                            <th class="px-4 py-3 rounded-tr-xl text-center">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-100">
                                        <tr class="hover:bg-slate-50 transition-colors">
                                            <td class="px-4 py-3 flex items-center gap-3">
                                                <div
                                                    class="size-10 rounded-lg bg-slate-200 flex items-center justify-center overflow-hidden">
                                                    <img src="https://via.placeholder.com/40" alt="img"
                                                        class="object-cover w-full h-full">
                                                </div>
                                                <div>
                                                    <p class="font-bold text-slate-900">Rau Cải Chíp Hữu Cơ</p>
                                                    <p class="text-xs text-slate-500">Rau Củ Quả</p>
                                                </div>
                                            </td>
                                            <td class="px-4 py-3 text-center">
                                                <span class="font-bold text-slate-700">120</span> <span
                                                    class="text-xs text-slate-400">kg</span>
                                            </td>
                                            <td class="px-4 py-3 text-right font-medium text-primary">45.000₫</td>
                                            <td class="px-4 py-3 text-center">
                                                <button class="text-blue-500 hover:text-blue-700 p-1"><span
                                                        class="material-symbols-outlined text-xl">edit_square</span></button>
                                                <button class="text-red-500 hover:text-red-700 p-1"><span
                                                        class="material-symbols-outlined text-xl">delete</span></button>
                                            </td>
                                        </tr>
                                        <tr class="hover:bg-slate-50 transition-colors">
                                            <td class="px-4 py-3 flex items-center gap-3">
                                                <div
                                                    class="size-10 rounded-lg bg-slate-200 flex items-center justify-center overflow-hidden">
                                                    <img src="https://via.placeholder.com/40" alt="img"
                                                        class="object-cover w-full h-full">
                                                </div>
                                                <div>
                                                    <p class="font-bold text-slate-900">Thịt Heo Iberico</p>
                                                    <p class="text-xs text-slate-500">Thịt Tươi</p>
                                                </div>
                                            </td>
                                            <td class="px-4 py-3 text-center">
                                                <span
                                                    class="font-black text-red-500 bg-red-50 px-2 py-1 rounded-md">4</span>
                                                <span class="text-xs text-slate-400">kg</span>
                                            </td>
                                            <td class="px-4 py-3 text-right font-medium text-primary">250.000₫</td>
                                            <td class="px-4 py-3 text-center">
                                                <button class="text-blue-500 hover:text-blue-700 p-1"><span
                                                        class="material-symbols-outlined text-xl">edit_square</span></button>
                                                <button class="text-red-500 hover:text-red-700 p-1"><span
                                                        class="material-symbols-outlined text-xl">delete</span></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </section>

                    </div>
                </main>

                <script>
                    const ctx = document.getElementById('revenueChart').getContext('2d');

                    // Gradient xanh theo tone website
                    let gradient = ctx.createLinearGradient(0, 0, 0, 400);
                    gradient.addColorStop(0, 'rgba(76, 174, 79, 0.5)');
                    gradient.addColorStop(1, 'rgba(76, 174, 79, 0.0)');

                    // Khởi tạo chart rỗng, data sẽ lấy từ API
                    const revenueChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: [],
                            datasets: [{
                                label: 'Doanh thu (VNĐ)',
                                data: [],
                                borderColor: '#4cae4f',
                                backgroundColor: gradient,
                                borderWidth: 3,
                                pointBackgroundColor: '#ffffff',
                                pointBorderColor: '#4cae4f',
                                pointBorderWidth: 2,
                                pointRadius: 4,
                                fill: true,
                                tension: 0.4
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: false }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: { borderDash: [5, 5], color: '#f1f5f9' },
                                    border: { display: false }
                                },
                                x: {
                                    grid: { display: false },
                                    border: { display: false }
                                }
                            }
                        }
                    });

                    async function loadRevenue(mode) {
                        try {
                            const res = await fetch('api/revenue?mode=' + encodeURIComponent(mode));
                            const data = await res.json();

                            const labels = data.map(x => x.dateLabel);
                            const values = data.map(x => x.totalRevenue);

                            revenueChart.data.labels = labels;
                            revenueChart.data.datasets[0].data = values;
                            revenueChart.update();
                        } catch (e) {
                            console.error('Load revenue failed', e);
                        }
                    }

                    const modeSelect = document.getElementById('revenueMode');
                    modeSelect.addEventListener('change', () => loadRevenue(modeSelect.value));

                    // Load mặc định: theo ngày
                    loadRevenue(modeSelect.value || 'daily');
                </script>
            </body>

            </html>