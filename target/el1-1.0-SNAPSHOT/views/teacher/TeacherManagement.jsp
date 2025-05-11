<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Management</title>
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
        .show-button {
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            overflow-x: auto; /* Thêm cuộn ngang nếu bảng quá rộng */
            display: block; /* Đảm bảo bảng hiển thị đúng */
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            white-space: nowrap; /* Ngăn nội dung xuống dòng */
            max-width: 200px; /* Giới hạn chiều rộng tối đa */
            overflow: hidden; /* Ẩn nội dung vượt quá */
            text-overflow: ellipsis; /* Thêm dấu ... nếu nội dung bị cắt */
        }
        th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
        }
        .actions {
            display: flex;
            gap: 10px;
            flex-wrap: nowrap; /* Ngăn hành động xuống dòng */
        }
        /* Đảm bảo nội dung dài (như bio) có thể cuộn */
        td:nth-child(8), td:nth-child(9) { /* Áp dụng cho cột Bio và Qualifications */
            max-width: 300px;
            overflow-x: auto;
            white-space: normal; /* Cho phép xuống dòng nếu cần */
        }
        /* Container bao quanh bảng để kiểm soát cuộn */
        .table-container {
            max-height: 400px; /* Giới hạn chiều cao */
            overflow-y: auto; /* Thêm cuộn dọc nếu bảng quá dài */
        }
    </style>
</head>
<body>
    <h2>Teacher Management</h2>

    <!-- Hiển thị thông báo thành công hoặc lỗi -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Nút để hiển thị danh sách Teacher -->
    <div class="show-button">
        <form action="${pageContext.request.contextPath}/teacher-management" method="get">
            <button type="submit">Show Teachers</button>
        </form>
    </div>

    <!-- Hiển thị danh sách Teacher chỉ khi có dữ liệu -->
    <c:if test="${not empty teachers}">
        <div class="table-container">
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
                        <th>Actions</th>
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
                            <td class="actions">
                                <!-- Nút xóa -->
                                <form action="${pageContext.request.contextPath}/teacher-management" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="accountId" value="${teacher.accountId}">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this teacher?')">Delete</button>
                                </form>
                                <!-- Nút kích hoạt/khóa -->
                                <form action="${pageContext.request.contextPath}/teacher-management" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="accountId" value="${teacher.accountId}">
                                    <input type="hidden" name="isActive" value="${!teacher.active}">
                                    <button type="submit">${teacher.active ? 'Deactivate' : 'Activate'}</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty teachers and empty errorMessage}">
        <p>No teachers displayed. Click 'Show Teachers' to load the list.</p>
    </c:if>
  
    <p><a href="${pageContext.request.contextPath}/create-teacher">Create New Teacher</a></p>
</body>
</html>