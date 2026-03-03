<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Đặt Hàng Thành Công - Nông Sản Việt</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap"
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
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 48;
            }

            @keyframes popIn {
                0% {
                    transform: scale(0.5);
                    opacity: 0;
                }

                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            .animate-pop-in {
                animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            }
        </style>
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 antialiased font-display flex items-center justify-center p-4">
        <div
            class="w-full max-w-md bg-white dark:bg-slate-900 shadow-2xl rounded-3xl p-8 text-center animate-pop-in border border-slate-100 dark:border-slate-800">
            <!-- Success Icon -->
            <div class="mx-auto w-24 h-24 bg-primary/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-symbols-outlined text-primary text-6xl">check_circle</span>
            </div>

            <!-- Header -->
            <h1 class="text-2xl font-black text-slate-900 dark:text-white mb-2 tracking-tight">Đặt Hàng Thành Công!</h1>
            <p class="text-slate-500 text-sm mb-8 leading-relaxed">
                Cảm ơn bạn đã mua sắm tại Nông Sản Việt. Đơn hàng của bạn đang được xử lý và sẽ sớm được giao đến bạn.
            </p>

            <!-- Actions -->
            <div class="space-y-3">
                <a href="shop"
                    class="block w-full bg-primary hover:bg-[#3d8c40] text-white font-bold py-3.5 px-6 rounded-xl transition-all shadow-lg hover:shadow-xl active:scale-[0.98]">
                    Tiếp tục mua sắm
                </a>
                <a href="index"
                    class="block w-full bg-slate-50 dark:bg-slate-800 hover:bg-slate-100 dark:hover:bg-slate-700 text-slate-900 dark:text-white font-semibold py-3.5 px-6 rounded-xl border border-slate-200 dark:border-slate-700 transition-all active:scale-[0.98]">
                    Về trang chủ
                </a>
            </div>
        </div>
    </body>

    </html>