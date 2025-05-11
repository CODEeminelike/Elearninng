<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Teacher</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error { color: red; }
        .success { color: green; }
    </style>
</head>
<body>
    <h2>Create New Teacher</h2>

    <!-- Hiển thị thông báo thành công hoặc lỗi -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Form tạo Teacher -->
    <form action="${pageContext.request.contextPath}/create-teacher" method="post">
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
        <div>
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" value="${param.email}">
            <c:if test="${not empty errors.email}">
                <span class="error">${errors.email}</span>
            </c:if>
        </div>
        <div>
            <label for="phone">Phone:</label><br>
            <input type="text" id="phone" name="phone" value="${param.phone}">
        </div>

        <div>
            <label for="name">Name:</label><br>
            <input type="text" id="name" name="name" value="${param.name}">
            <c:if test="${not empty errors.name}">
                <span class="error">${errors.name}</span>
            </c:if>
        </div>
        <div>
            <label for="bio">Bio:</label><br>
            <textarea id="bio" name="bio">${param.bio}</textarea>
        </div>
        <div>
            <label for="qualifications">Qualifications:</label><br>
            <textarea id="qualifications" name="qualifications">${param.qualifications}</textarea>
        </div>

        <br>
        <button type="submit">Create Teacher</button>
    </form>

    <p><a href="${pageContext.request.contextPath}/staff_login.jsp">Back to Login</a></p>
</body>
</html>