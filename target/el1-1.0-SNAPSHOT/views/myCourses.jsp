<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khóa học của tôi</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .course-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 0 20px;
        }
        .course-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: box-shadow 0.2s ease;
        }
        .course-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .course-card .image-wrapper {
            position: relative;
            width: 100%;
            height: 180px;
            background-color: #e0e0e0; /* Placeholder background */
        }
        .course-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            loading: lazy; /* Lazy load images */
        }
        .course-card .content {
            padding: 15px;
        }
        .course-card h3 {
            margin: 0 0 10px;
            font-size: 18px;
            color: #333;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .course-card p {
            margin: 5px 0;
            color: #666;
            font-size: 14px;
        }
        .course-card .price {
            font-weight: 500;
            color: #00bcd4;
        }
        .course-card .access-btn {
            display: block;
            text-align: center;
            padding: 10px;
            background-color: #00bcd4;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
            transition: background-color 0.2s ease;
        }
        .course-card .access-btn:hover {
            background-color: #0097a7;
        }
        .no-courses {
            text-align: center;
            color: #666;
            font-size: 16px;
            margin-top: 50px;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            text-decoration: none;
            color: #00bcd4;
            border: 1px solid #00bcd4;
            border-radius: 4px;
            transition: background-color 0.2s;
        }
        .pagination a:hover {
            background-color: #00bcd4;
            color: white;
        }
        .pagination .active {
            background-color: #00bcd4;
            color: white;
            cursor: default;
        }
        .pagination .disabled {
            color: #ccc;
            border-color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <h1>Khóa học của tôi</h1>

    <c:if test="${not empty error}">
        <p style="color: red; text-align: center;">${error}</p>
    </c:if>

    <c:choose>
        <c:when test="${empty purchasedCourses}">
            <p class="no-courses">Bạn chưa mua khóa học nào.</p>
        </c:when>
        <c:otherwise>
            <div class="course-container">
                <c:forEach var="course" items="${purchasedCourses}">
                    <div class="course-card">
                        <div class="image-wrapper">
                            <img src="<%= request.getContextPath() %>${course.thumbnail}"
                                 alt="${course.title}"
                                 loading="lazy"
                                 onerror="this.src='<%= request.getContextPath() %>/images/default-thumbnail.jpg'"/>
                        </div>
                        <div class="content">
                            <h3>${course.title}</h3>
                            <p class="price">
                                <fmt:formatNumber value="${course.price}" type="currency" currencySymbol="₫"/>
                            </p>
                            <a href="<%= request.getContextPath() %>/course/view?courseId=${course.courseId}" class="access-btn">
                                Truy cập khóa học
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="<%= request.getContextPath() %>/student/mycourses?page=${currentPage - 1}">Trước</a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <a class="active">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="<%= request.getContextPath() %>/student/mycourses?page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="<%= request.getContextPath() %>/student/mycourses?page=${currentPage + 1}">Sau</a>
                    </c:if>
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>

    <script>
        // Tối ưu hiệu suất hình ảnh
        document.addEventListener('DOMContentLoaded', function() {
            const images = document.querySelectorAll('img[loading="lazy"]');
            images.forEach(img => {
                img.addEventListener('error', () => {
                    console.warn('Image failed to load: ' + img.src);
                    img.src = '<%= request.getContextPath() %>/images/default-thumbnail.jpg';
                });
            });
        });
    </script>
</body>
</html>