<%-- /views/teacher/createcourse.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create New Course</title>
    <style>
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .submit-btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>Create New Course</h2>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/teacher/create-course" method="post">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" min="0" required>
        </div>
        <div class="form-group">
            <label for="thumbnail">Thumbnail:</label>
            <input type="text" id="thumbnail" name="thumbnail" placeholder="Enter image path (e.g., views/img/image.jpg)">
            <a href="${pageContext.request.contextPath}/select-image" target="_blank">Choose Image</a>
        </div>
        <div class="form-group">
            <label for="categoryId">Category:</label>
            <select id="categoryId" name="categoryId" required>
                <option value="">-- Select Category --</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryId}">${category.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="descriptionContent">Description:</label>
            <textarea id="descriptionContent" name="descriptionContent" rows="5" required></textarea>
        </div>
        <button type="submit" class="submit-btn">Create Course</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/teacher/manage-courses">Back to Manage Courses</a>
</body>
</html>
