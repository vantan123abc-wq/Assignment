<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Include this in pages that need a simple header -->
        <header
            style="background-color: #ffffff; padding: 15px 30px; border-bottom: 2px solid #4cae4f; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
            <a href="index.jsp" style="text-decoration: none;">
                <h2 style="margin: 0; color: #4cae4f; font-family: 'Segoe UI', Tahoma, sans-serif;">🌿 Nông Sản Việt
                </h2>
            </a>
            <nav style="font-family: 'Segoe UI', Tahoma, sans-serif;">
                <a href="index.jsp"
                    style="margin-right: 20px; text-decoration: none; color: #333; font-weight: 500;">Trang chủ</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <span style="margin-right: 20px; color: #4cae4f; font-weight: bold;">Xin chào,
                            ${sessionScope.account.username}</span>
                        <a href="logout" style="text-decoration: none; color: #d9534f; font-weight: 500;">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login"
                            style="margin-right: 20px; text-decoration: none; color: #333; font-weight: 500;">Đăng
                            nhập</a>
                        <a href="register" style="text-decoration: none; color: #333; font-weight: 500;">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </header>