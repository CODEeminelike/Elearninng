<%-- /views/teacher/managecourses.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Courses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
        }
        .courses-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
            padding: 20px;
        }
        .course-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 280px;
            padding: 20px;
            text-align: center;
            overflow: hidden;
        }
        .course-card img {
            width: 100%;
            border-radius: 8px;
            object-fit: cover;
        }
        .course-card h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
        }
        .course-card .price {
            font-size: 22px;
            font-weight: bold;
            color: #2196F3;
            margin: 10px 0;
        }
        .course-card .rating {
            color: #ffb400;
            margin: 10px 0;
        }
        .course-card .description {
            font-size: 14px;
            color: #777;
            margin: 10px 0;
        }
        .course-card .actions button {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }
        .actions button:hover {
            background-color: #1976D2;
        }
        
        .show-btn {
        background-color: #2196F3; /* Blue background */
        color: white; /* Text color */
        padding: 10px 20px; /* Button padding */
        border: none; /* Remove default border */
        border-radius: 5px; /* Rounded corners */
        font-size: 16px; /* Font size */
        cursor: pointer; /* Pointer cursor on hover */
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s ease; /* Smooth transition for hover */
    }
    
    .show-btn:hover {
        background-color: #1976D2; /* Darker blue on hover */
    }

    .show-btn:focus {
        outline: none; /* Remove focus outline */
    }
    </style>
</head>
<body>
    <h2>COURSES</h2>
    
<!-- Thanh tìm kiếm và sắp xếp (sortOrder mặc định là 'asc') -->
<form action="${pageContext.request.contextPath}/BrowseCourseServlet" method="post">
    <!-- Thanh tìm kiếm -->
    <input type="text" name="searchKeyword" placeholder="Nhập từ khóa tìm kiếm..." required value="${param.searchKeyword}">
    
<!--     sortOrder mặc định là 'asc', có thể thay đổi thành 'desc' 
    <input type="hidden" name="sortOrder" value="${param.sortOrder != null ? param.sortOrder : 'asc'}">-->
    
    <!-- Dropdown cho lựa chọn sắp xếp -->
    <select name="sortOrder" onchange="this.form.submit()">
        <option value="asc" ${param.sortOrder == 'asc' ? 'selected' : ''}>Giá tăng dần</option>
        <option value="desc" ${param.sortOrder == 'desc' ? 'selected' : ''}>Giá giảm dần</option>
    </select>
    
    <button type="submit">Tìm kiếm</button>
</form>

    
   <!-- Hiển thị thông báo lỗi hoặc thành công -->
<!-- courses.jsp -->
<c:if test="${showCourses}">
    <c:if test="${not empty courses}">
        <div class="courses-container">
            <c:forEach var="course" items="${courses}">
                <div class="course-card">
                    <img src="${pageContext.request.contextPath}/${course.thumbnail}" alt="Thumbnail" />
                    <h3>${course.title}</h3>
                    <div class="price">$${course.price}</div>
                    <div class="description">${course.description.content}</div>
                    <div class="actions">
    <!-- Nút Read More -->
    <form action="${pageContext.request.contextPath}/student/readmore" method="post" style="display:inline;">
        <input type="hidden" name="courseTitle" value="${course.title}">
        <button type="submit">Read More</button>
    </form>

    <!-- Nút Join Now -->
    <form action="${pageContext.request.contextPath}/student/join-course" method="post" onsubmit="return confirmPurchase('${course.title}');" style="display:inline;">
        <input type="hidden" name="courseId" value="${course.courseId}">
        <button type="submit">Join Now</button>
    </form>
</div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${empty courses}">
        <p>No courses found.</p>
    </c:if>
</c:if>


</body>
</html>
