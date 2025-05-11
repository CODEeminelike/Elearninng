<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error2</title>
</head>
<body>
    <h2>Error</h2>
    
    <!-- Hiển thị thông báo lỗi từ servlet -->
    <c:if test="${not empty errorMessage}">
        <p style="color: red">${errorMessage}</p>
    </c:if>
    
    <!-- Thông báo mặc định nếu không có lỗi cụ thể -->
    <c:if test="${empty errorMessage}">
        <p style="color: red">An unexpected error occurred.</p>
    </c:if>
    
    <p><a href="<%= request.getContextPath() %>/staff_login.jsp">Back to Login</a></p>
</body>
</html>