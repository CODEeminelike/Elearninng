<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
</head>
<body>
    <%
        // Kiểm tra đăng nhập
        if (session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/staff_login.jsp");
            return;
        }
    %>
    <h2>Welcome to Admin Dashboard</h2>
    
    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty error}">
        <p style="color: red">${error}</p>
    </c:if>

        
        
    <a href="/el1/views/admin/AdminManagment.jsp">Thêm Accont cho Admint</a> 
    
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
    
    <a href="${pageContext.request.contextPath}/teacher-management">Manage Teachers</a>
    
    
</body>
</html>