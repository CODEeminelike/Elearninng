<%-- /views/teacher/managecourses.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Courses</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .create-btn {
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <h2>Manage Courses</h2>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>

    <!-- Nút tạo khóa học mới -->
    <a href="${pageContext.request.contextPath}/teacher/create-course" class="create-btn">Create New Course</a>

    <!-- Danh sách khóa học -->
    <c:if test="${not empty courses}">
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Price</th>
                <th>Thumbnail</th>
                <th>Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="course" items="${courses}">
                <tr>
                    <td>${course.courseId}</td>
                    <td>${course.title}</td>
                    <td>${course.price}</td>
                    <td>
                        <c:if test="${not empty course.thumbnail}">
                            <img src="${pageContext.request.contextPath}/${course.thumbnail}" alt="Thumbnail" width="50"/>
                        </c:if>
                    </td>
                    <td>${course.category.name}</td>
                    <td>${course.description.content}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/teacher/edit-course?courseId=${course.courseId}">Edit</a>
                        <a href="${pageContext.request.contextPath}/teacher/delete-course?courseId=${course.courseId}" 
                           onclick="return confirm('Are you sure you want to delete this course?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    <c:if test="${empty courses}">
        <p>No courses found.</p>
    </c:if>
</body>
</html>