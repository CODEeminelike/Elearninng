<%-- /views/teacher/ListTeacher.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Teachers</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            overflow-x: auto;
            display: block;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            white-space: nowrap;
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
        }
        .actions {
            display: flex;
            gap: 10px;
            flex-wrap: nowrap;
        }
        td:nth-child(8), td:nth-child(9) {
            max-width: 300px;
            overflow-x: auto;
            white-space: normal;
        }
        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }
        .back-link {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #666;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back-link:hover {
            background-color: #555;
        }
        .action-button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            display: inline-block;
        }
        .view-button {
            background-color: #2196F3;
        }
        .view-button:hover {
            background-color: #1976D2;
        }
        .delete-button {
            background-color: #f44336;
        }
        .delete-button:hover {
            background-color: #d32f2f;
        }
        .status-button {
            background-color: #4CAF50;
        }
        .status-button:hover {
            background-color: #45a049;
        }
           /* Style cho nút nhẹ */
            .btn-light {
                background-color: #f0f0f0;
                color: #333;
                border: 1px solid #ccc;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease, border-color 0.3s ease;
                text-align: center;
            }

            /* Hover effect */
            .btn-light:hover {
                background-color: #e0e0e0;
                border-color: #bbb;
            }

            /* Focus effect */
            .btn-light:focus {
                outline: none;
                border-color: #888;
            }
    </style>
</head>
<body>
    <h2>List of Teachers</h2>

    <!-- Hiển thị thông báo thành công hoặc lỗi -->
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>
 <!-- Nút gửi GET tới /teacher-management -->
        <div style="text-align: center; margin-top: 50px;">
            <form action="<%= request.getContextPath() %>/teacher-management" method="get">
                <button type="submit" class="btn-light">Danh sách giáo viên</button>
            </form>
        </div>
    <!-- Hiển thị danh sách Teacher -->
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
                                <!-- Nút Xem -->
                                <a href="${pageContext.request.contextPath}/teacher-management?action=view&accountId=${teacher.accountId}" 
                                   class="action-button view-button">View</a>
                                <!-- Nút Xóa -->
                                <form action="${pageContext.request.contextPath}/teacher-management" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="accountId" value="${teacher.accountId}">
                                    <button type="submit" class="action-button delete-button" 
                                            onclick="return confirm('Are you sure you want to delete this teacher?')">Delete</button>
                                </form>
                                <!-- Nút Kích hoạt/Khóa -->
                                <form action="${pageContext.request.contextPath}/teacher-management" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="accountId" value="${teacher.accountId}">
                                    <input type="hidden" name="isActive" value="${!teacher.active}">
                                    <button type="submit" class="action-button status-button">${teacher.active ? 'Deactivate' : 'Activate'}</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${empty teachers and empty errorMessage}">
        <p>No teachers found.</p>
    </c:if>

    <!-- Liên kết quay lại Teacher Management -->
<!--    <p><a href="${pageContext.request.contextPath}/teacher-management" class="back-link">Back to Teacher Management</a></p>-->
</body>
</html>