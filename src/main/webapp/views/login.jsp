<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
</head>
<body>
    <h2>Đăng nhập</h2>
    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>
     <%-- Hiển thị thông báo đăng ký thành công nếu có --%>
    <% if ("true".equals(request.getParameter("registrationSuccess"))) { %>
        <p style="color: green;">Đăng ký thành công! Vui lòng đăng nhập.</p>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post">
        <div>
            <label for="username">Tên đăng nhập:</label><br>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Mật khẩu:</label><br>
            <input type="password" id="password" name="password" required>
        </div>
        <br>
        <button type="submit">Đăng nhập</button>
    </form>

    <p>Chưa có tài khoản? <a href="<%= request.getContextPath() %>/register">Đăng ký ngay</a>.</p>
</body>
</html>