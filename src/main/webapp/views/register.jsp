<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
</head>
<body>
    <h2>Đăng ký tài khoản mới</h2>
     <%-- Hiển thị thông báo lỗi nếu có --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/register" method="post">
        <div>
            <label for="username">Tên đăng nhập:</label><br>
            <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required>
        </div>
        <div>
            <label for="password">Mật khẩu:</label><br>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
        </div>
         <div>
            <label for="phone">Điện thoại:</label><br>
            <input type="text" id="phone" name="phone" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
        </div>
        <%-- Có thể thêm các trường khác cho Student nếu cần --%>
        <br>
        <button type="submit">Đăng ký</button>
    </form>

    <p>Đã có tài khoản? <a href="<%= request.getContextPath() %>/login">Đăng nhập tại đây</a>.</p>
</body>
</html>