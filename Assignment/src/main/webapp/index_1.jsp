<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Nông Sản Việt - Fresh from Farm to Table</title>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
          rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700&display=swap"
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
                    borderRadius: {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>

    <style>
        body { font-family: 'Inter', sans-serif; }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">

<!-- Top Navigation Bar -->
<header class="sticky top-0 z-50 bg-white/90 dark:bg-background-dark/90 backdrop-blur-md border-b border-primary/10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">

            <!-- Logo -->
            <div class="flex items-center gap-2">
                <div class="bg-primary p-1.5 rounded-lg text-white">
                    <span class="material-symbols-outlined text-3xl">agriculture</span>
                </div>
                <h1 class="text-2xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
            </div>

            <!-- Desktop Nav Links -->
            <nav class="hidden md:flex items-center gap-8">
                <a class="font-medium text-primary border-b-2 border-primary" href="#">Trang chủ</a>
                <a class="font-medium hover:text-primary transition-colors" href="#">Sản phẩm</a>
                <a class="font-medium hover:text-primary transition-colors" href="#">Khuyến mãi</a>
                <a class="font-medium hover:text-primary transition-colors" href="#">Về chúng tôi</a>
            </nav>

            <!-- Search & Actions -->
            <div class="flex items-center gap-4 flex-1 max-w-md ml-8">
                <div class="relative w-full">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
                    <input
                            class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-full py-2.5 pl-10 pr-4 focus:ring-2 focus:ring-primary/50 text-sm"
                            placeholder="Tìm kiếm nông sản..."
                            type="text" />
                </div>

                <div class="flex items-center gap-2">
                    <button class="p-2.5 rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                        <span class="material-symbols-outlined">favorite</span>
                    </button>

                    <button class="relative p-2.5 rounded-full hover:bg-primary/10 text-slate-600 dark:text-slate-300">
                        <span class="material-symbols-outlined">shopping_cart</span>
                        <span class="absolute top-1 right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">3</span>
                    </button>

                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <a href="#"
                               class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                                <div class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                    <span class="material-symbols-outlined text-xl">person</span>
                                </div>
                                <span>${sessionScope.account.username}</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="login"
                               class="flex items-center gap-2 ml-2 p-1 pr-3 rounded-full bg-primary/10 text-primary font-semibold text-sm hover:bg-primary/20 transition-colors">
                                <div class="size-8 rounded-full bg-primary text-white flex items-center justify-center">
                                    <span class="material-symbols-outlined text-xl">person</span>
                                </div>
                                <span>Đăng nhập</span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>

        </div>
    </div>
</header>

<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-12">

    <!-- Hero Section -->
    <section class="relative h-[500px] rounded-3xl overflow-hidden shadow-2xl">
        <div class="absolute inset-0 bg-cover bg-center"
             data-alt="Fresh vegetable market landscape background"
             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCVj1hLs9-DlBz3V8-O9Eo6EBRa0EUN9pebGEBBHNKWSReYxVLOFXd6o2lDm-YqsehrI4U_Lr-q8yjSKmERLPUxgXPUVu8zRLg9xho7x2Ijq2T1TCIb4jLhLeBDAE8JCd9y-KBzC4ngFIWvFSaB5csLafcNLvHNTxSRXezigBlkzhitblKHwLn0qW1vlS8TBsfihxMshKwvxA3eo0Wc65HGOlNGUp1wWO72eLIW8YnHCpoeVGMQKPuoft0RkPDW63QVvgl3gW_kkXaU');">
        </div>

        <div class="absolute inset-0 bg-gradient-to-r from-black/70 via-black/40 to-transparent"></div>

        <div class="relative h-full flex flex-col justify-center items-start px-12 lg:px-20 max-w-2xl">
            <span class="bg-primary/20 text-primary border border-primary/30 px-4 py-1.5 rounded-full text-sm font-bold mb-6 backdrop-blur-sm">
                Sạch từ Nông Trại - Tươi tới Bàn Ăn
            </span>

            <h2 class="text-5xl lg:text-7xl font-black text-white leading-[1.1] mb-6">
                Nông Sản Tươi Sạch Cho Gia Đình Việt
            </h2>

            <p class="text-lg text-slate-200 mb-10 leading-relaxed">
                Chúng tôi kết nối trực tiếp với những người nông dân tâm huyết nhất để mang đến những sản phẩm
                nông nghiệp đạt chuẩn VietGAP và GlobalGAP.
            </p>

            <div class="flex gap-4">
                <button class="bg-primary hover:bg-primary/90 text-white font-bold py-4 px-10 rounded-xl text-lg transition-transform active:scale-95">
                    Mua sắm ngay
                </button>
                <button class="bg-white/10 hover:bg-white/20 text-white font-bold py-4 px-8 rounded-xl text-lg backdrop-blur-md transition-colors">
                    Khám phá thêm
                </button>
            </div>
        </div>
    </section>

    <!-- Category Grid -->
    <section>
        <div class="flex items-center justify-between mb-8">
            <h3 class="text-2xl font-bold">Danh mục sản phẩm</h3>
            <a class="text-primary font-semibold flex items-center gap-1 hover:underline" href="#">
                Xem tất cả <span class="material-symbols-outlined text-sm">arrow_forward</span>
            </a>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">

            <!-- Cat 1 -->
            <div class="group cursor-pointer">
                <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                    <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                         data-alt="Fresh organic green vegetables"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuBpS_FD-G6bHlv68CLd4E0K-kqziiMSG4pWFfDHdXqFa4ZAf3rxo2hwdWnss_BEpsKXeNskc7Hse68aR8wDaJ3qV5etVi-Qeh8732vti2tnUg_wCCF5nhRlfG8lZ2M9yjMPUSMog_wWE2eRV7cT-tuSivDfVeK0BdrGCeMvVHrxfytl5UYtDIjd0gHuAgJ61sYLGoe4IQnx_rcKZBpmNmWg7xIxpFlrNDErr9uUIHjJn-NPmPqn_PvLw5E4972k39bxDT6wGJlZHAW9" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                        <span class="text-white font-bold text-lg">Rau Xanh Tươi</span>
                    </div>
                </div>
            </div>

            <!-- Cat 2 -->
            <div class="group cursor-pointer">
                <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                    <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                         data-alt="Selection of tropical and seasonal fruits"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuA3ViUs5dwuRUlP5n8dI8PXyW7ymK709v5CxN4EwqjqhIguZCdtTKJt4IiwFIWuHecaUNsaBrf_Er8cC7nxsPUnc4XDVYpMRA5F9b6lnSn4coe5LBa-678dA8DR7Eym75Qoc8U4W7V1KytzdD9Cl_Uxhn0mbkUxPvdlYpYWMUmdyS400iLSl7OFmmb4pfaYDD4KKlN61K24xJTpPxyzXPP6m_9QYPI4iR42kwLfQ_AVvySXfI0itt2qIYFOK_fI63S_tCD_PyZejxTk" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                        <span class="text-white font-bold text-lg">Trái Cây Mùa Vụ</span>
                    </div>
                </div>
            </div>

            <!-- Cat 3 -->
            <div class="group cursor-pointer">
                <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                    <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                         data-alt="Fresh cuts of raw meat"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuBnbDygKW4NS1acCH_yFkMK9Nsl_uhNDefI55C68p2ekkRsx7io5_1Ct4_PhVMmdZ8_H7Eux4LRBnWFko-3kBEgjP7n1vST3YwwG2OxhMZQXVkxYnEahJQQar0TSf858tJILQTdWsFiA-S_xBsxgc9kRqHXxmoofyM3FajOxpufgbtHDC9FPNxQTCHB4Dl9AkhcFl1aaMvGuwrJv6u3GPHQBW1JXBHXMOIDO2OAqRKuglO2OUPJnH-xIkLnD6r79PjxKiuiyh8A--VP" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                        <span class="text-white font-bold text-lg">Thịt &amp; Hải Sản</span>
                    </div>
                </div>
            </div>

            <!-- Cat 4 -->
            <div class="group cursor-pointer">
                <div class="relative h-48 rounded-2xl overflow-hidden mb-3">
                    <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                         data-alt="Assorted dry goods and grains"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuAgoKvtfUywgTquPI5XBApK7jH_dSTMWjdUFolwOGL6aho7R05NueYWmbTGr5RDelfug_j0dF3ix82y0X5eoNBxz-95Pg82c_E4iSYTWsmbAhLf5-rQNG3GcLng7eoY5RthGdmKOouqeZUhG6qvgQZ-fu1rC8LJFlY8rup7wTJ6gw3kgapUiPNpLRo4j2apxqfEXK9S0RV0KCWvZ1I3nG2oprxWkmKggs82oypp_NuEcIDH2omjiig9OWzhUKDBwdmC6dNoaBT_F2pC" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
                        <span class="text-white font-bold text-lg">Đồ Khô &amp; Gia Vị</span>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <!-- Featured Products -->
    <section>
        <div class="flex items-center justify-between mb-8">
            <div class="space-y-1">
                <h3 class="text-2xl font-bold">Sản phẩm nổi bật</h3>
                <p class="text-slate-500 text-sm">Sản phẩm được lựa chọn nhiều nhất hôm nay</p>
            </div>

            <div class="flex gap-2">
                <button class="p-2 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-white dark:hover:bg-slate-800 transition-colors">
                    <span class="material-symbols-outlined">chevron_left</span>
                </button>
                <button class="p-2 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-white dark:hover:bg-slate-800 transition-colors">
                    <span class="material-symbols-outlined">chevron_right</span>
                </button>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

            <!-- Product Card 1 -->
            <div class="bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl p-4 group transition-shadow hover:shadow-xl">
                <div class="relative aspect-square rounded-xl overflow-hidden mb-4 bg-slate-50 dark:bg-slate-800">
                    <img class="w-full h-full object-cover transition-transform group-hover:scale-105"
                         data-alt="Fresh small potatoes in a bunch"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuCWMTUSM5YLbmU3839QK5MPC4diZv1ZkSTdVRtphTM3BFW6sNhuJl9N1zIhhXQW4c9zjx3FhXTXyoaN57eMPMkm27xx9RZ6m1VwpExhjlNfrWuFq684btGItwspjzKBGUdKcEpVVDwFtjcd4XmVLoeTGv0E7_sKm2vfCzLltuMTeo8RGiUMSGx_NqVw15v5njILT1lG2n7UGMglN1jV4xO9Agy8vG02k5eNTaFX3-HvwJ6V64F71R24Kb0mjAXGhhcn2wKli20G19sP" />
                    <span class="absolute top-2 left-2 bg-red-500 text-white text-[10px] font-bold px-2 py-1 rounded">-15%</span>
                </div>

                <div class="space-y-1">
                    <span class="text-xs text-primary font-bold uppercase">Rau Củ Quả</span>
                    <h4 class="font-bold text-lg leading-tight line-clamp-1">Khoai Tây Đà Lạt</h4>
                    <p class="text-xs text-slate-500">Túi 1.0kg</p>
                </div>

                <div class="mt-4 flex items-center justify-between">
                    <div class="flex flex-col">
                        <span class="text-primary font-black text-xl">32.000₫</span>
                        <span class="text-xs text-slate-400 line-through">45.000₫</span>
                    </div>

                    <button class="bg-primary text-white size-10 rounded-xl flex items-center justify-center shadow-lg shadow-primary/30 transition-transform active:scale-90">
                        <span class="material-symbols-outlined">add</span>
                    </button>
                </div>
            </div>

            <!-- Product Card 2 -->
            <div class="bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl p-4 group transition-shadow hover:shadow-xl">
                <div class="relative aspect-square rounded-xl overflow-hidden mb-4 bg-slate-50 dark:bg-slate-800">
                    <img class="w-full h-full object-cover transition-transform group-hover:scale-105"
                         data-alt="Fresh bunch of bananas"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuBZMBcMa2TxH9twygRQ8RtFbfv42YuHgYfzH-IQENVO2JPmhRcqvOa8DAYSMgjGWm4D9PHhu4IKVegP76luKRh20IyvXzxNkRbV___J0IKUfHL_4JaPEGNGVN6wWMIPEEVzLTA2JaOciAh0YNEWcZ6o1yyeVTbhZBtrhQwO_KBoSS2YJSvaQcrRo9HbNSYuJI5QlBErsyjBI2ZldPq3fhOgDGdZO9LOjnYdKXDLdYcDtg6MWb8OteIYCvqTI9F21tRuweI1ebjZJF-5" />
                </div>

                <div class="space-y-1">
                    <span class="text-xs text-primary font-bold uppercase">Trái Cây</span>
                    <h4 class="font-bold text-lg leading-tight line-clamp-1">Chuối Laba Đà Lạt</h4>
                    <p class="text-xs text-slate-500">Nải ~1.2kg</p>
                </div>

                <div class="mt-4 flex items-center justify-between">
                    <div class="flex flex-col">
                        <span class="text-primary font-black text-xl">28.500₫</span>
                    </div>

                    <button class="bg-primary text-white size-10 rounded-xl flex items-center justify-center shadow-lg shadow-primary/30 transition-transform active:scale-90">
                        <span class="material-symbols-outlined">add</span>
                    </button>
                </div>
            </div>

            <!-- Product Card 3 -->
            <div class="bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl p-4 group transition-shadow hover:shadow-xl">
                <div class="relative aspect-square rounded-xl overflow-hidden mb-4 bg-slate-50 dark:bg-slate-800">
                    <img class="w-full h-full object-cover transition-transform group-hover:scale-105"
                         data-alt="Red fresh cherry tomatoes"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuC_1K2MUuW8xJBEltYisg-yzAUhfCT9Etm-EYRFyFlU8Lb0qXzSYMLvJ5K9MxB5TmJNDqccQQcEcuu3dV4yPHkzzisxpx1gFzlan13TUOixjG-l2oCxj2LSKwjKYDfziOuUVaqt_K-pbvqZMUvZqCEw-DOOxZXaR7DqUZrXZE1Uo5l-kW5bbW4wz9cYA8F5TCTgIa5Jca6KzsU_0EImlJ7lzHgl34tDWPUeQxh8wwhKLLGfhSzjUy1YQ5Sb2K9Ee_qISioQGOKk4ZkX" />
                    <span class="absolute top-2 right-2 bg-primary text-white text-[10px] font-bold px-2 py-1 rounded">VietGAP</span>
                </div>

                <div class="space-y-1">
                    <span class="text-xs text-primary font-bold uppercase">Rau Củ Quả</span>
                    <h4 class="font-bold text-lg leading-tight line-clamp-1">Cà Chua Cherry</h4>
                    <p class="text-xs text-slate-500">Hộp 500g</p>
                </div>

                <div class="mt-4 flex items-center justify-between">
                    <div class="flex flex-col">
                        <span class="text-primary font-black text-xl">45.000₫</span>
                    </div>

                    <button class="bg-primary text-white size-10 rounded-xl flex items-center justify-center shadow-lg shadow-primary/30 transition-transform active:scale-90">
                        <span class="material-symbols-outlined">add</span>
                    </button>
                </div>
            </div>

            <!-- Product Card 4 -->
            <div class="bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl p-4 group transition-shadow hover:shadow-xl">
                <div class="relative aspect-square rounded-xl overflow-hidden mb-4 bg-slate-50 dark:bg-slate-800">
                    <img class="w-full h-full object-cover transition-transform group-hover:scale-105"
                         data-alt="Whole fresh chicken on wooden board"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuBI1LxZXN3DJTNQuMNJ08W-ikCRJC8xvSObdfbDWE6VNmDtJSXAgJ7mzXhG83FTWs_wXpjQ5b1WfSGF0E_mpOrhdgfBVkPE_sQVO_sFuBrjXMcy1VWIou0sxaF7X2EXavM2N0N-1SmRdVCWq4UyHmrpMvPkjLa0a4PB_69dkYbAIQU3ldvzmjX0N15y0Xl8woJAAXKCHg4Tzj6mOHA5FnxXKJnGJjIfBGxZVA4-XKNJIi2WrUDIH-ZySorSkvYNGuSrjU2NCw6DM9Vh" />
                </div>

                <div class="space-y-1">
                    <span class="text-xs text-primary font-bold uppercase">Thịt Sạch</span>
                    <h4 class="font-bold text-lg leading-tight line-clamp-1">Gà Ta Thả Vườn</h4>
                    <p class="text-xs text-slate-500">Con ~1.5kg</p>
                </div>

                <div class="mt-4 flex items-center justify-between">
                    <div class="flex flex-col">
                        <span class="text-primary font-black text-xl">185.000₫</span>
                    </div>

                    <button class="bg-primary text-white size-10 rounded-xl flex items-center justify-center shadow-lg shadow-primary/30 transition-transform active:scale-90">
                        <span class="material-symbols-outlined">add</span>
                    </button>
                </div>
            </div>

        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="bg-primary rounded-3xl p-8 lg:p-16 flex flex-col lg:flex-row items-center justify-between gap-8 text-white">
        <div class="max-w-xl text-center lg:text-left">
            <h3 class="text-3xl font-black mb-4">Đăng ký nhận tin từ Nông Sản Việt</h3>
            <p class="text-white/80">
                Nhận thông báo về các đợt thu hoạch mới nhất và mã giảm giá đặc biệt cho thành viên.
            </p>
        </div>

        <div class="flex w-full max-w-md bg-white p-2 rounded-2xl shadow-xl">
            <input class="flex-1 border-none focus:ring-0 text-slate-900 font-medium px-4 bg-transparent"
                   placeholder="Địa chỉ email của bạn"
                   type="email" />
            <button class="bg-primary hover:bg-primary/90 text-white font-bold px-8 py-3 rounded-xl transition-colors">
                Đăng ký
            </button>
        </div>
    </section>

</main>

<!-- Footer -->
<footer class="bg-white dark:bg-slate-950 border-t border-slate-100 dark:border-slate-800 pt-20 pb-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-16">

            <!-- Branding -->
            <div class="space-y-6">
                <div class="flex items-center gap-2">
                    <div class="bg-primary p-1.5 rounded-lg text-white">
                        <span class="material-symbols-outlined text-2xl">agriculture</span>
                    </div>
                    <h1 class="text-xl font-black tracking-tight text-primary">Nông Sản Việt</h1>
                </div>

                <p class="text-slate-500 text-sm leading-relaxed">
                    Tự hào là đơn vị cung ứng nông sản sạch hàng đầu Việt Nam. Chúng tôi cam kết chất lượng trên
                    từng sản phẩm.
                </p>

                <div class="flex gap-4">
                    <a class="size-10 rounded-full bg-primary/10 text-primary flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                       href="#"><span class="material-symbols-outlined text-xl">share</span></a>
                    <a class="size-10 rounded-full bg-primary/10 text-primary flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                       href="#"><span class="material-symbols-outlined text-xl">groups</span></a>
                    <a class="size-10 rounded-full bg-primary/10 text-primary flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                       href="#"><span class="material-symbols-outlined text-xl">public</span></a>
                </div>
            </div>

            <!-- Quick Links -->
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-6">Liên Kết Nhanh</h4>
                <ul class="space-y-4 text-sm text-slate-500">
                    <li><a class="hover:text-primary transition-colors" href="#">Về chúng tôi</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Hệ thống cửa hàng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Tuyển dụng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Liên hệ</a></li>
                </ul>
            </div>

            <!-- Customer Support -->
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-6">Hỗ Trợ Khách Hàng</h4>
                <ul class="space-y-4 text-sm text-slate-500">
                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách giao hàng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách đổi trả</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Hướng dẫn mua hàng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Câu hỏi thường gặp</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-6">Thông Tin Liên Hệ</h4>
                <ul class="space-y-4 text-sm text-slate-500">
                    <li class="flex items-start gap-3">
                        <span class="material-symbols-outlined text-primary text-xl">location_on</span>
                        <span>123 Đường Nông Nghiệp, Quận Cầu Giấy, Hà Nội</span>
                    </li>
                    <li class="flex items-center gap-3">
                        <span class="material-symbols-outlined text-primary text-xl">phone</span>
                        <span>1900 6789 (Hỗ trợ 24/7)</span>
                    </li>
                    <li class="flex items-center gap-3">
                        <span class="material-symbols-outlined text-primary text-xl">mail</span>
                        <span>lienhe@nongsanviet.vn</span>
                    </li>
                </ul>
            </div>

        </div>

        <div class="border-t border-slate-100 dark:border-slate-800 pt-8 flex flex-col md:flex-row items-center justify-between gap-4">
            <p class="text-slate-400 text-xs text-center md:text-left">
                © 2024 Nông Sản Việt. Tất cả quyền được bảo lưu. MSDN: 0123456789 được cấp bởi Sở KH&ĐT Hà Nội.
            </p>

            <div class="flex items-center gap-6">
                <img alt="Visa" class="h-6 opacity-50 grayscale hover:grayscale-0 transition-all cursor-pointer"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuBLt976I4iDYE0wo91SHnXKSzUaqT_iJ3eQ0RU_dS5pZsE8Quiiy6yyUT2lafuBMgt74A3OZTCwZ1lf7V1tqJ3I_-ozarDzOevbbmoLu-awf_duyjHv94__dNsBKuIHM6lSAzUhJQr58ApQA_fryFYbskYtVzCZ0m_AWHOgZnFHXEW7XdxFliQwAk3j17p_c7_9dSJuK1X8-fWn28evWRgIh2YQiyrsqUuwve7GynUNbzEqgYLeNqNNkQ8BGJNLRr874MjUY2yeNW_P" />
                <img alt="Mastercard" class="h-6 opacity-50 grayscale hover:grayscale-0 transition-all cursor-pointer"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuAjGLXz8ChF_tOz8zZfnlrz9UnfB8Yty926eFm_M2HfL0Rx0tLZCVvY5vnvYZVk4YF0IwOCG--70oGw7ImhUYR5ZaVOfl9FwoU5KNQx3so5qn05YIfY6JQFOVWto3QTthM9UzFb23cTe6DL4CRy9IYxCBl0djLGlHT2GtBRFQbrFBKjQoIYdnoe1ICsGakMRar1k9Z30c58Xs2qiZ3Cmqn2FYWKrKkpLEV8oEtc_Gxvkuwvy6sy04Q2xzNVcewjvA9TVR0dza6NIAZL" />
                <img alt="Paypal" class="h-6 opacity-50 grayscale hover:grayscale-0 transition-all cursor-pointer"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuBlDlMwCJS798KjMoN2S7ziuGmRPKVCSwM-BmV7GxKq1sVhBag_MoTY4WC6XNgDOKXKdN2ZjwOW7OQ0axedajkDaaO92vUm-3uIkV3-S4K5tfzHCCLG3cduK4rMiHAqBCxX2DwhEnLVQrUs_uG1XAXPZdOTLr-tQKVrVph3KJlOCnULsac6HhMQUtJ3KSBZDnB1e-PHR6JSjW-qhD6PeE5ZuLLXAC4BP1IoQnj3pENXeKmUteX1m_YVtSEnKjG8c4_jyF5Cay_o0qU9" />
            </div>
        </div>

    </div>
</footer>

</body>
</html>