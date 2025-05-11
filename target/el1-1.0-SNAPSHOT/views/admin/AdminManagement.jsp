<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .error {
            color: red;
        }
        .success {
            color: green;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .form-container {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h2>Admin Management</h2>

    <!-- Hiển thị thông báo thành công hoặc lỗi -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Form tạo Admin mới (chỉ cần username và password) -->
    <div class="form-container">
        <h3>Create New Admin</h3>
        <form action="${pageContext.request.contextPath}/admin-management" method="post">
            <input type="hidden" name="action" value="create">
            <div>
                <label for="username">Username:</label><br>
                <input type="text" id="username" name="username" value="${param.username}">
                <c:if test="${not empty errors.username}">
                    <span class="error">${errors.username}</span>
                </c:if>
            </div>
            <div>
                <label for="password">Password:</label><br>
                <input type="password" id="password" name="password">
                <c:if test="${not empty errors.password}">
                    <span class="error">${errors.password}</span>
                </c:if>
            </div>
            <br>
            <button type="submit">Create Admin</button>
        </form>
    </div>

        <p><a href="${pageContext.request.contextPath}/staff_login.jsp">Back to Login</a></p>
</body>
</html>