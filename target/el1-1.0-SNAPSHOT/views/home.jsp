<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Account" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<body>
    <%
        Account loggedInAccount = (Account) session.getAttribute("loggedInAccount");
        if (loggedInAccount != null) {
    %>
            <h2>Chào mừng, <%= loggedInAccount.getUsername() %>!</h2>
            <p>Đây là trang chủ của bạn.</p>
            <p><a href="<%= request.getContextPath() %>/logout">Đăng xuất</a></p>
    <%
        } else {
            // Nếu không có session người dùng, chuyển hướng về trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/login");
        }
    %>
</body>
</html>