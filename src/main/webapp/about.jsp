<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Về Chúng Tôi - Nông Sản Việt</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap"
                rel="stylesheet" />
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
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
                            fontFamily: { "display": ["Work Sans", "sans-serif"], "body": ["Inter", "sans-serif"] },
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
            </style>
        </head>

        <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">

            <!-- Top Navigation Bar (same as index.jsp) -->
            <header
                class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex items-center justify-between h-20">
                        <!-- Logo -->
                        <div class="flex items-center gap-2">
                            <div class="bg-primary p-1.5 rounded-lg text-white">
                                <span class="material-symbols-outlined text-3xl">agriculture</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/"
                                class="text-2xl font-black tracking-tight text-primary">Nông Sản Việt</a>
                        </div>

                        <!-- Desktop Nav Links -->
                        <nav class="hidden md:flex items-center gap-8">
                            <a class="font-medium hover:text-primary transition-colors"
                                href="${pageContext.request.contextPath}/">Trang chủ</a>
                            <a class="font-medium hover:text-primary transition-colors"
                                href="${pageContext.request.contextPath}/shop">Sản phẩm</a>
                            <a class="font-medium hover:text-primary transition-colors"
                                href="${pageContext.request.contextPath}/promotions">Khuyến mãi</a>
                            <a class="font-medium text-primary border-b-2 border-primary"
                                href="${pageContext.request.contextPath}/about">Về chúng tôi</a>
                        </nav>

                        <!-- Actions -->
                        <div class="flex items-center gap-4">
                            <a href="${pageContext.request.contextPath}/cart"
                                class="relative z-50 p-2.5 flex items-center justify-center rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                                <span class="material-symbols-outlined">shopping_cart</span>
                                <c:if test="${sessionScope.cartCount > 0}">
                                    <span
                                        class="absolute top-1 right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full z-50 pointer-events-none">
                                        ${sessionScope.cartCount}
                                    </span>
                                </c:if>
                            </a>
                            <c:choose>
                                <c:when test="${not empty sessionScope.account}">
                                    <a href="${pageContext.request.contextPath}/logout" title="Đăng xuất"
                                        class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-red-50 text-red-600 font-semibold text-sm hover:bg-red-100 transition-colors">
                                        <div
                                            class="size-8 rounded-full bg-red-500 text-white flex items-center justify-center">
                                            <span class="material-symbols-outlined text-xl">logout</span>
                                        </div>
                                        <span>${sessionScope.account.username} (Thoát)</span>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login"
                                        class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                                        <div
                                            class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                            <span class="material-symbols-outlined text-xl">person</span>
                                        </div>
                                        <span>Đăng nhập</span>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </header>

            <div class="relative flex flex-col overflow-x-hidden">

                <!-- Hero Section -->
                <div class="relative bg-cover bg-center flex flex-col justify-end overflow-hidden bg-primary/20 min-h-[400px] md:min-h-[450px]"
                    style='background-image: linear-gradient(to bottom, rgba(0,0,0,0.1), rgba(21,29,21,0.85)), url("https://lh3.googleusercontent.com/aida-public/AB6AXuBLKMAJ1eIBefRi6PXtnTkTuHKHHpbzezyF11gYxNrk5SHifwUPDtDFJc9GyDbw_X1DRi2pVT4GHRpjjKQyqtDhq0FXTLMU93tyomZjK-GKUcSJVM8BW4I8b_EFRZXScpJ0DQbBZAQTrxROdHdNCEweDE67-jrDw9OWOUHI-4m2TZU-HxVzeBUEwiy3rIIRG5v9hLTF5KmRxL2PDzK-CGH-yMTjbsZ9RwPzZFbYxo3gavmcRD6Oo9F4fAtO737Pk7FoWXKxANa7TY3q");'>
                    <div class="flex flex-col p-8 md:p-16 gap-3 max-w-3xl">
                        <span
                            class="bg-primary text-white text-xs font-bold px-3 py-1 rounded-full w-fit uppercase tracking-wider">Since
                            2015</span>
                        <h1 class="text-white text-5xl md:text-6xl font-bold leading-tight font-display">Nông Sản Việt
                        </h1>
                        <p class="text-white/90 text-lg max-w-xl">Kết nối tinh hoa từ đất mẹ đến bàn ăn mọi gia đình
                            Việt.</p>
                    </div>
                </div>

                <main class="max-w-5xl mx-auto w-full px-4 sm:px-6 lg:px-8 py-10 space-y-12">

                    <!-- Brand Intro -->
                    <section>
                        <div class="flex flex-col gap-4">
                            <div class="flex items-center gap-2 text-primary">
                                <span class="material-symbols-outlined font-bold">verified</span>
                                <h2 class="text-xl font-bold font-display uppercase tracking-tight">Về chúng tôi</h2>
                            </div>
                            <p
                                class="text-slate-700 dark:text-slate-300 text-xl leading-relaxed italic border-l-4 border-primary pl-5 py-3 bg-primary/5 rounded-r-xl">
                                "Nông Sản Việt là hệ thống cung cấp nông sản sạch, kết nối trực tiếp giữa nông dân và
                                người tiêu dùng. Chúng tôi cam kết mang đến thực phẩm tươi ngon, đạt chuẩn VietGAP và
                                GlobalGAP."
                            </p>
                        </div>
                    </section>

                    <!-- Mission & Vision -->
                    <section class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div
                            class="bg-white dark:bg-slate-800/50 p-8 rounded-2xl border border-primary/10 shadow-sm hover:shadow-md transition-shadow">
                            <div class="bg-primary/10 p-3 rounded-xl w-fit mb-5">
                                <span class="material-symbols-outlined text-primary text-3xl">target</span>
                            </div>
                            <h3 class="text-primary text-xl font-bold mb-3 font-display">🌱 Sứ mệnh</h3>
                            <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Mang thực phẩm sạch, an toàn
                                đến mọi gia đình Việt với giá cả hợp lý, không qua trung gian.</p>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-800/50 p-8 rounded-2xl border border-primary/10 shadow-sm hover:shadow-md transition-shadow">
                            <div class="bg-primary/10 p-3 rounded-xl w-fit mb-5">
                                <span class="material-symbols-outlined text-primary text-3xl">visibility</span>
                            </div>
                            <h3 class="text-primary text-xl font-bold mb-3 font-display">👁 Tầm nhìn</h3>
                            <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Trở thành thương hiệu nông sản
                                sạch hàng đầu Việt Nam, minh bạch nguồn gốc và phát triển bền vững.</p>
                        </div>
                    </section>

                    <!-- Core Values -->
                    <section>
                        <div class="bg-primary/5 rounded-2xl p-8 md:p-12 border border-primary/10">
                            <h2 class="text-2xl font-bold text-center mb-10 font-display">💚 Giá trị cốt lõi</h2>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-7">
                                <div class="flex items-start gap-4">
                                    <span
                                        class="material-symbols-outlined text-primary bg-white dark:bg-slate-800 rounded-full p-2 shadow-sm shrink-0"
                                        style="font-variation-settings:'FILL' 1">check_circle</span>
                                    <div>
                                        <h4 class="font-bold text-slate-800 dark:text-slate-100 text-base">Minh bạch
                                            nguồn gốc</h4>
                                        <p class="text-sm text-slate-600 dark:text-slate-400 mt-1">Mỗi sản phẩm đều có
                                            thể truy xuất nguồn gốc rõ ràng, đến tên nông trại, người trồng.</p>
                                    </div>
                                </div>
                                <div class="flex items-start gap-4">
                                    <span
                                        class="material-symbols-outlined text-primary bg-white dark:bg-slate-800 rounded-full p-2 shadow-sm shrink-0"
                                        style="font-variation-settings:'FILL' 1">check_circle</span>
                                    <div>
                                        <h4 class="font-bold text-slate-800 dark:text-slate-100 text-base">Hợp tác trực
                                            tiếp với nông dân</h4>
                                        <p class="text-sm text-slate-600 dark:text-slate-400 mt-1">Cắt giảm trung gian,
                                            tăng thu nhập cho người nông dân và giữ giá thành hợp lý.</p>
                                    </div>
                                </div>
                                <div class="flex items-start gap-4">
                                    <span
                                        class="material-symbols-outlined text-primary bg-white dark:bg-slate-800 rounded-full p-2 shadow-sm shrink-0"
                                        style="font-variation-settings:'FILL' 1">check_circle</span>
                                    <div>
                                        <h4 class="font-bold text-slate-800 dark:text-slate-100 text-base">Không chất
                                            bảo quản độc hại</h4>
                                        <p class="text-sm text-slate-600 dark:text-slate-400 mt-1">Quy trình bảo quản
                                            lạnh tự nhiên, không dùng hóa chất độc hại, giữ trọn vị tươi ngon.</p>
                                    </div>
                                </div>
                                <div class="flex items-start gap-4">
                                    <span
                                        class="material-symbols-outlined text-primary bg-white dark:bg-slate-800 rounded-full p-2 shadow-sm shrink-0"
                                        style="font-variation-settings:'FILL' 1">check_circle</span>
                                    <div>
                                        <h4 class="font-bold text-slate-800 dark:text-slate-100 text-base">Sức khỏe là
                                            trên hết</h4>
                                        <p class="text-sm text-slate-600 dark:text-slate-400 mt-1">Đặt sức khỏe khách
                                            hàng là ưu tiên số một trong mọi quyết định vận hành.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Farm Gallery -->
                    <section>
                        <h2 class="text-2xl font-bold mb-6 font-display flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">photo_library</span>
                            🚜 Hình ảnh từ nông trại
                        </h2>
                        <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                            <div class="aspect-square rounded-2xl overflow-hidden shadow-lg group">
                                <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    alt="Nông dân thu hoạch rau xanh"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBqaxjDLUG9IEJDM5QTIPddAGl6bTv2BjMBsBdCm6GefNWVpvJ22k19Yl8zXkTvWNHoEYMsOQ15AEzmZL7hf8VlkTxKO0ELxhe38bXWq0Gq5qG0lZFnoNzrFTU_F4Dx-venFxIUuCYk5JTVp-_YTNLIAxJ7ybNI4Q7ctrXnAMY4X0acMmDDo9n3GTOnNV83OmH-5lTLPEgz9Ij-vStei0pU7OCIRdd4fHJA8DrW-sOewbXswHxz48OqHGhDQ2YLqgDTRwGh6iO6gokR" />
                            </div>
                            <div class="aspect-square rounded-2xl overflow-hidden shadow-lg group">
                                <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    alt="Cánh đồng hữu cơ xanh tươi"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuDp9mqvdd-5dDi-sEnFg7MFq0T77PY90Simg9wDhGK97_Kv6S4elWXgpDyL0wYNq1nj665za4DjZSwgkHj-B-6fOU2BaiSYt-Fq5Tx2bVWt_3yIf__Njmw9NMFpv-hSaflsbeVRrAFDhF0lDbMSpu0zdcESsiDxNBjN5xnceXDGmGyCFGxO2qQDenEzVnkLkB9H-lQUGkal806UlwS0Oz1s7RWsdPXQFXOr2SJMMRZ30SzVbqgTs8B1hsAZufEnbOJ4fxDkoXuq1z5I" />
                            </div>
                            <div
                                class="aspect-square rounded-2xl overflow-hidden shadow-lg col-span-2 md:col-span-1 group">
                                <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    alt="Nhà kính nông nghiệp công nghệ cao"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAzFBOerjgmkgTW1udwBGafWE9zphKmaMAWrQX8YU8ek1swI_d3fI8yBYnJVZISg8Vwq2pmTCIJcNXl0qiAY2OT6aLJuOZlF724oc2W28MW2L2XxqgwkXdu-NedwQ845DBrDDpbGopNwN8x62buSe654nzGV31dzUKuqgRXmvW4E8kH7680QpOLQohi-6d6IGWBkBI6-boENuEuGdQeIVuMq-0dYzH3JlBl91nyf1SDRdB7z_OFq6LJJaHkOIhSyuG_T2v7e8CAZ2_0" />
                            </div>
                        </div>
                    </section>

                    <!-- Why Choose Us -->
                    <section>
                        <div class="text-center mb-10">
                            <h2 class="text-2xl font-bold font-display">📦 Tại sao chọn Nông Sản Việt?</h2>
                            <div class="h-1 w-20 bg-primary mx-auto mt-3 rounded-full"></div>
                        </div>
                        <div class="grid grid-cols-2 lg:grid-cols-4 gap-5">
                            <div
                                class="flex flex-col items-center p-6 bg-white dark:bg-slate-800/50 rounded-2xl text-center hover:-translate-y-2 transition-transform duration-300 border border-primary/10 shadow-sm">
                                <span class="material-symbols-outlined text-5xl text-primary mb-4">eco</span>
                                <p class="text-sm font-bold text-slate-800 dark:text-slate-100">🌿 Nông sản tươi mỗi
                                    ngày</p>
                            </div>
                            <div
                                class="flex flex-col items-center p-6 bg-white dark:bg-slate-800/50 rounded-2xl text-center hover:-translate-y-2 transition-transform duration-300 border border-primary/10 shadow-sm">
                                <span class="material-symbols-outlined text-5xl text-primary mb-4">local_shipping</span>
                                <p class="text-sm font-bold text-slate-800 dark:text-slate-100">🚚 Giao nhanh toàn quốc
                                </p>
                            </div>
                            <div
                                class="flex flex-col items-center p-6 bg-white dark:bg-slate-800/50 rounded-2xl text-center hover:-translate-y-2 transition-transform duration-300 border border-primary/10 shadow-sm">
                                <span
                                    class="material-symbols-outlined text-5xl text-primary mb-4">currency_exchange</span>
                                <p class="text-sm font-bold text-slate-800 dark:text-slate-100">🛡 Cam kết hoàn tiền nếu
                                    lỗi</p>
                            </div>
                            <div
                                class="flex flex-col items-center p-6 bg-white dark:bg-slate-800/50 rounded-2xl text-center hover:-translate-y-2 transition-transform duration-300 border border-primary/10 shadow-sm">
                                <span class="material-symbols-outlined text-5xl text-primary mb-4">support_agent</span>
                                <p class="text-sm font-bold text-slate-800 dark:text-slate-100">📞 Hỗ trợ 24/7</p>
                            </div>
                        </div>
                    </section>

                    <!-- Contact -->
                    <section class="pb-10">
                        <div
                            class="bg-white dark:bg-slate-800/50 rounded-2xl overflow-hidden border border-primary/10 shadow-lg">
                            <div class="p-8">
                                <h2 class="text-2xl font-bold mb-6 font-display flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary">contact_support</span>
                                    📍 Thông tin liên hệ
                                </h2>
                                <div class="space-y-5">
                                    <div class="flex items-center gap-4 text-slate-600 dark:text-slate-400">
                                        <div
                                            class="size-10 rounded-full bg-primary/10 flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-primary">location_on</span>
                                        </div>
                                        <span>Số 123 Đường Nông Nghiệp, Quận Cầu Giấy, Hà Nội</span>
                                    </div>
                                    <div class="flex items-center gap-4 text-slate-600 dark:text-slate-400">
                                        <div
                                            class="size-10 rounded-full bg-primary/10 flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-primary">call</span>
                                        </div>
                                        <span>1900 6789 <span class="text-primary font-semibold">(Hỗ trợ
                                                24/7)</span></span>
                                    </div>
                                    <div class="flex items-center gap-4 text-slate-600 dark:text-slate-400">
                                        <div
                                            class="size-10 rounded-full bg-primary/10 flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-primary">mail</span>
                                        </div>
                                        <span>lienhe@nongsanviet.vn</span>
                                    </div>
                                </div>
                            </div>
                            <!-- Map placeholder -->
                            <div class="h-64 bg-slate-100 dark:bg-slate-700 relative overflow-hidden">
                                <iframe
                                    src="https://maps.google.com/maps?q=C%E1%BA%A7u+Gi%E1%BA%A5y%2C+H%C3%A0+N%E1%BB%99i&t=&z=14&ie=UTF8&iwloc=&output=embed"
                                    width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"
                                    referrerpolicy="no-referrer-when-downgrade" title="Vị trí Nông Sản Việt">
                                </iframe>
                            </div>
                        </div>
                    </section>

                </main>

                <!-- Footer (consistent with index.jsp) -->
                <footer class="bg-white dark:bg-slate-950 border-t border-slate-100 dark:border-slate-800 py-8">
                    <div class="max-w-5xl mx-auto px-4 text-center text-slate-400 text-sm">
                        <p>© 2024 Nông Sản Việt. Tất cả quyền được bảo lưu.</p>
                    </div>
                </footer>

            </div>

            <!-- Chat Widget AI -->
            <jsp:include page="WEB-INF/views/chat-widget.jsp" />

        </body>

        </html>