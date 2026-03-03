<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <% boolean isEdit=request.getAttribute("product") !=null; request.setAttribute("isEdit", isEdit); %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>${isEdit ? 'Sửa sản phẩm' : 'Thêm sản phẩm mới'} - Admin Nông Sản Việt</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
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
                                },
                                fontFamily: { "display": ["Inter"] },
                            },
                        },
                    }
                </script>
            </head>

            <body class="bg-background-light text-slate-900 min-h-screen">
                <div class="flex h-screen overflow-hidden">
                    <!-- Sidebar -->
                    <aside class="w-64 bg-white border-r border-slate-200 flex flex-col shrink-0">
                        <div class="p-6 flex items-center gap-3">
                            <div class="size-10 rounded-full bg-primary flex items-center justify-center text-white">
                                <span class="material-symbols-outlined text-2xl">eco</span>
                            </div>
                            <div class="flex flex-col">
                                <h1 class="text-primary text-base font-bold leading-tight">Nông Sản Việt</h1>
                                <p class="text-slate-500 text-xs font-medium">Admin Panel</p>
                            </div>
                        </div>
                        <nav class="flex-1 px-4 space-y-1 mt-4">
                            <a class="flex items-center gap-3 px-3 py-3 text-slate-600 hover:bg-slate-50 rounded-lg transition-colors"
                                href="${pageContext.request.contextPath}/admin.jsp">
                                <span class="material-symbols-outlined">dashboard</span>
                                <span class="text-sm font-medium">Tổng quan</span>
                            </a>
                            <a class="flex items-center gap-3 px-3 py-3 bg-primary/10 text-primary rounded-lg transition-colors font-bold"
                                href="${pageContext.request.contextPath}/admin/inventory">
                                <span class="material-symbols-outlined"
                                    style="font-variation-settings: 'FILL' 1">inventory_2</span>
                                <span class="text-sm font-bold">Kho hàng</span>
                            </a>
                        </nav>
                    </aside>

                    <!-- Main Content -->
                    <main class="flex-1 flex flex-col overflow-y-auto">
                        <header
                            class="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-8 sticky top-0 z-10">
                            <div class="flex items-center gap-4">
                                <a href="${pageContext.request.contextPath}/admin/inventory"
                                    class="p-2 hover:bg-slate-100 rounded-lg text-slate-500 transition-colors">
                                    <span class="material-symbols-outlined">arrow_back</span>
                                </a>
                                <h2 class="text-xl font-bold text-slate-800">${isEdit ? 'Cập nhật Sản phẩm' : 'Thêm Sản
                                    phẩm mới'}</h2>
                            </div>
                        </header>

                        <div class="p-8 max-w-4xl mx-auto w-full">
                            <form
                                action="${pageContext.request.contextPath}${isEdit ? '/admin/product/edit' : '/admin/product/create'}"
                                method="POST" enctype="multipart/form-data"
                                class="bg-white rounded-xl border border-slate-200 shadow-sm p-6 overflow-hidden">
                                <c:if test="${isEdit}">
                                    <input type="hidden" name="id" value="${product.id}" />
                                </c:if>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                                    <!-- Tên sản phẩm -->
                                    <div class="col-span-1 md:col-span-2">
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Tên sản phẩm
                                            *</label>
                                        <input type="text" name="name" value="${product.name}" required
                                            class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-2"
                                            placeholder="Ví dụ: Khoai tây Đà Lạt">
                                    </div>

                                    <!-- Danh mục -->
                                    <div>
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Danh mục *</label>
                                        <select name="categoryId" required
                                            class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-2">
                                            <option value="">-- Chọn danh mục --</option>
                                            <c:forEach items="${categories}" var="cat">
                                                <option value="${cat.id}" ${product.categoryId==cat.id ? 'selected' : ''
                                                    }>${cat.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Link Ảnh / Tải ảnh -->
                                    <div
                                        class="col-span-1 md:col-span-2 space-y-4 border border-slate-200 rounded-xl p-4 bg-slate-50/50">
                                        <label class="block text-sm font-bold text-slate-800">Ảnh sản phẩm</label>
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <!-- Tải từ máy tính -->
                                            <div>
                                                <label class="block text-xs font-semibold text-slate-600 mb-2">Tùy chọn
                                                    1: Tải ảnh lên</label>
                                                <div class="relative w-full">
                                                    <input type="file" name="imageFile" id="imageFile" accept="image/*"
                                                        class="w-full text-sm text-slate-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-primary/10 file:text-primary hover:file:bg-primary/20 transition-all cursor-pointer border border-slate-300 rounded-lg bg-white" />
                                                </div>
                                                <p class="text-[11px] text-slate-500 mt-2">Hệ thống sẽ ưu tiên dùng ảnh
                                                    tải lên nếu bạn chọn file.</p>
                                            </div>

                                            <!-- Dán URL -->
                                            <div>
                                                <label class="block text-xs font-semibold text-slate-600 mb-2">Tùy chọn
                                                    2: Dán đường dẫn URL</label>
                                                <input type="url" name="imageUrl" id="imageUrl"
                                                    value="${product.imageUrl != null ? product.imageUrl : (product.description != null && product.description.startsWith('http') ? product.description : '')}"
                                                    class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-[9px] bg-white"
                                                    placeholder="https://...">
                                            </div>
                                        </div>

                                        <!-- Image Preview Block -->
                                        <div
                                            class="mt-4 p-4 bg-white border border-slate-200 border-dashed rounded-lg flex gap-4 items-center min-h-[120px]">
                                            <div
                                                class="size-20 bg-slate-100 rounded-lg overflow-hidden shrink-0 border border-slate-200 flex items-center justify-center relative group">
                                                <img id="imagePreview"
                                                    src="${(product.imageUrl != null && not empty product.imageUrl) ? product.imageUrl : ((product.description != null && product.description.startsWith('http')) ? product.description : '')}"
                                                    alt="Preview"
                                                    class="w-full h-full object-cover ${(product.imageUrl == null || empty product.imageUrl) && (product.description == null || !product.description.startsWith('http')) ? 'hidden' : ''}" />
                                                <span id="imagePreviewPlaceholder"
                                                    class="material-symbols-outlined text-slate-300 text-3xl ${(product.imageUrl != null && not empty product.imageUrl) || (product.description != null && product.description.startsWith('http')) ? 'hidden' : ''}">hide_image</span>
                                            </div>
                                            <div class="flex-1">
                                                <p class="text-sm font-semibold text-slate-700">Ảnh xem trước</p>
                                                <p class="text-xs text-slate-500 mt-1">Sẽ tự cập nhật nếu bạn chèn URL
                                                    hoặc chọn Text. Ảnh tải lên luôn được ưu tiên hơn Dán URL.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Giá bán -->
                                    <div>
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Giá bán (VNĐ)
                                            *</label>
                                        <input type="number" name="price" value="${product.price}" min="0" required
                                            class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-2"
                                            placeholder="0">
                                    </div>

                                    <!-- Tồn kho -->
                                    <div>
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Tồn kho ban đầu
                                            *</label>
                                        <input type="number" name="stock"
                                            value="${product.quantity != null ? product.quantity : 0}" min="0" required
                                            class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-2"
                                            placeholder="0">
                                    </div>

                                    <!-- Khuyến mãi -->
                                    <div class="col-span-1 md:col-span-2">
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Giảm giá (%)</label>
                                        <input type="number" name="discountPercent" value="${product.discountPercent}"
                                            min="0" max="100"
                                            class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-2"
                                            placeholder="10">
                                    </div>

                                    <!-- Mô tả -->
                                    <div class="col-span-1 md:col-span-2">
                                        <label class="block text-sm font-bold text-slate-700 mb-2">Mô tả sản
                                            phẩm</label>
                                        <textarea name="description" rows="4"
                                            class="w-full text-sm border-slate-300 rounded-lg focus:ring-primary focus:border-primary px-4 py-2"
                                            placeholder="Nhập mô tả sản phẩm của bạn..."><c:out value="${(product.description != null && !product.description.startsWith('http')) ? product.description : ''}"/></textarea>
                                    </div>
                                </div>

                                <div class="flex items-center justify-end gap-3 pt-6 border-t border-slate-100">
                                    <a href="${pageContext.request.contextPath}/admin/inventory"
                                        class="px-6 py-2.5 text-sm font-bold text-slate-600 hover:bg-slate-100 rounded-lg transition-colors">Hủy
                                        bỏ</a>
                                    <button type="submit"
                                        class="bg-primary hover:bg-primary/90 text-white px-6 py-2.5 text-sm font-bold rounded-lg transition-colors shadow-sm flex items-center gap-2">
                                        <span class="material-symbols-outlined text-[18px]">save</span>
                                        ${isEdit ? 'Lưu thay đổi' : 'Tạo sản phẩm'}
                                    </button>
                                </div>
                            </form>
                        </div>
                    </main>
                </div>

                <script>
                    const imageFile = document.getElementById('imageFile');
                    const imageUrl = document.getElementById('imageUrl');
                    const imagePreview = document.getElementById('imagePreview');
                    const imagePreviewPlaceholder = document.getElementById('imagePreviewPlaceholder');

                    function updatePreview() {
                        const file = imageFile.files[0];
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                imagePreview.src = e.target.result;
                                imagePreview.classList.remove('hidden');
                                imagePreviewPlaceholder.classList.add('hidden');
                            };
                            reader.readAsDataURL(file);
                        } else if (imageUrl.value.trim() !== '') {
                            imagePreview.src = imageUrl.value;
                            imagePreview.classList.remove('hidden');
                            imagePreviewPlaceholder.classList.add('hidden');
                        } else {
                            imagePreview.src = '';
                            imagePreview.classList.add('hidden');
                            imagePreviewPlaceholder.classList.remove('hidden');
                        }
                    }

                    imageFile.addEventListener('change', updatePreview);
                    imageUrl.addEventListener('input', updatePreview);
                </script>
            </body>

            </html>