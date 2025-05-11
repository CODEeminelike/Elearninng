<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Login</title>
</head>
<body>
    <h2>Staff Login</h2>
    <form action="<%= request.getContextPath() %>/stafflogin" method="post">
        <label for="username">Username:</label><br>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" required><br><br>

<!--        <label for="role">Role:</label><br>
        <select id="role" name="role" required>
            <option value="teacher">Teacher</option>
            <option value="admin">Admin</option>
        </select><br><br>-->

        <button type="submit">Login</button>
    </form>
</body>
</html>