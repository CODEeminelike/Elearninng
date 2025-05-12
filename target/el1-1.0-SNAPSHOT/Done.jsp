<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test</title>
    
</head>
<body>
    <!-- Danh sách khóa học (chỉ hiển thị khi showCourses = true) -->
   
        <c:if test="${not empty courses}">
            <h1>Có mà</h1>
        </c:if>
            
        <c:if test="${empty courses}">
            <p>No courses found.</p>
        </c:if>
    
</body>
</html>