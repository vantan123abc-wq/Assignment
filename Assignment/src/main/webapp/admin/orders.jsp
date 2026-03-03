<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Chung */
        :root { --bg-color: #f8f9fa; --sidebar-bg: #ffffff; --text-main: #333333; --text-muted: #6c757d; --border-color: #eaedf1; --primary: #4a6cf7; --success: #10b981; --warning: #f59e0b; --danger: #ef4444; --info: #3b82f6; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { display: flex; height: 100vh; background-color: var(--bg-color); color: var(--text-main); }
        
        /* Sidebar */
        .sidebar { width: 260px; background-color: var(--sidebar-bg); display: flex; flex-direction: column; border-right: 1px solid var(--border-color); padding: 20px 0; }
        .logo { font-size: 20px; font-weight: 800; text-align: center; margin-bottom: 40px; }
        .nav-menu { flex: 1; display: flex; flex-direction: column; gap: 5px; padding: 0 15px; }
        .nav-item { display: flex; align-items: center; padding: 12px 20px; text-decoration: none; color: var(--text-muted); border-radius: 8px; font-weight: 500; }
        .nav-item i { width: 25px; font-size: 18px; }
        .nav-item:hover { background-color: #f1f5f9; color: var(--text-main); }
        .nav-item.active { background-color: #f1f5f9; color: #000; font-weight: 600; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
        .logout-btn-container { padding: 20px 15px; }
        .logout-btn { display: flex; align-items: center; justify-content: center; padding: 12px; background-color: #fff4f4; color: var(--danger); border-radius: 8px; text-decoration: none; font-weight: 600; }

        /* Main Content */
        .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .page-header { margin-bottom: 25px; }
        .card { background-color: #ffffff; border-radius: 12px; padding: 25px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px 10px; color: var(--text-muted); font-size: 13px; text-transform: uppercase; border-bottom: 1px solid var(--border-color); }
        td { padding: 15px 10px; border-bottom: 1px solid var(--border-color); font-size: 14px; vertical-align: middle; }
        
        /* Status Elements */
        .status-select { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; border: 1px solid transparent; cursor: pointer; outline: none; }
        .status-Pending { background-color: #fef3c7; color: #d97706; border-color: #fde68a; }
        .status-Shipping { background-color: #dbeafe; color: #2563eb; border-color: #bfdbfe; }
        .status-Completed { background-color: #d1fae5; color: #059669; border-color: #a7f3d0; }
        .status-Cancelled { background-color: #fee2e2; color: #dc2626; border-color: #fecaca; }

        .action-btns { display: flex; gap: 10px; }
        .btn-icon { background: transparent; border: none; cursor: pointer; font-size: 16px; }
        .btn-view { color: var(--info); }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">Admin Panel</div>
        <div class="nav-menu">
            <a href="dashboard.jsp" class="nav-item"><i class="fa-solid fa-chart-pie"></i> Tổng quan</a>
            <a href="users.jsp" class="nav-item"><i class="fa-solid fa-user-group"></i> Người dùng</a>
            <a href="inventory.jsp" class="nav-item"><i class="fa-solid fa-box"></i> Kho hàng</a>
            <a href="orders.jsp" class="nav-item active"><i class="fa-solid fa-receipt"></i> Đơn hàng</a>
        </div>
        <div class="logout-btn-container">
            <a href="../logout" class="logout-btn"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="page-header">
            <h1>Quản lý Đơn hàng</h1>
        </div>

        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>Mã ĐH</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty orderList}">
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 20px;">Chưa có đơn hàng nào.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td><strong>#${order.id}</strong></td>
                            <td>
                                <div>${order.customerEmail}</div>
                                <div style="font-size: 12px; color: var(--text-muted);">${order.customerPhone}</div>
                            </td>
                            <td>
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                            </td>
                            <td>
                                <strong><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></strong>
                            </td>
                            <td>
                                <select class="status-select status-${order.status}" onchange="updateStatus(this, '${order.id}')">
                                    <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Chờ xác nhận</option>
                                    <option value="Shipping" ${order.status == 'Shipping' ? 'selected' : ''}>Đang giao</option>
                                    <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>Đã giao</option>
                                    <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Hủy đơn</option>
                                </select>
                            </td>
                            <td class="action-btns">
                                <a href="order-detail?id=${order.id}" class="btn-icon btn-view"><i class="fa-solid fa-eye"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function updateStatus(selectElement, orderId) {
            selectElement.classList.remove('status-Pending', 'status-Shipping', 'status-Completed', 'status-Cancelled');
            selectElement.classList.add('status-' + selectElement.value);

            // Gửi request ngầm về Server để cập nhật DB
            fetch('UpdateOrderStatusServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'orderId=' + encodeURIComponent(orderId) + '&status=' + encodeURIComponent(selectElement.value)
            })
            .then(response => {
                if(response.ok) {
                    alert('Cập nhật trạng thái thành công cho đơn ' + orderId);
                } else {
                    alert('Có lỗi xảy ra khi cập nhật!');
                }
            });
        }
    </script>
</body>
</html>