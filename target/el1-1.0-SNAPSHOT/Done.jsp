<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .error {
            color: red;
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
    </style>
</head>
<body>
    <h2>Teacher List</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Hiển thị danh sách Teacher -->
    <c:if test="${not empty teachers}">
        <table>
            <thead>
                <tr>
                    <th>Account ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Avatar</th>
                    <th>Active</th>
                    <th>Name</th>
                    <th>Bio</th>
                    <th>Qualifications</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="teacher" items="${teachers}">
                    <tr>
                        <td>${teacher.accountId}</td>
                        <td>${teacher.username}</td>
                        <td>${teacher.email}</td>
                        <td>${teacher.phone}</td>
                        <td>${teacher.avatar}</td>
                        <td>${teacher.active ? 'Yes' : 'No'}</td>
                        <td>${teacher.name}</td>
                        <td>${teacher.bio}</td>
                        <td>${teacher.qualifications}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty teachers}">
        <p>No teachers found.</p>
    </c:if>

    <p><a href="${pageContext.request.contextPath}/staff_login.jsp">Back to Login</a></p>
</body>
</html>