<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Khóa Học</title>
</head>
<body>

    <h1>Chi Tiết Khóa Học: ${course.title}</h1>

    <!-- Hiển thị thông tin khóa học -->
    <p><strong>ID Khóa Học:</strong> ${course.courseId}</p>
    <p><strong>Giá:</strong> $${course.price}</p>

    <!-- Hiển thị mô tả khóa học -->
    <c:if test="${not empty description}">
        <h2>Mô Tả Khóa Học</h2>
        <p><strong>Nội Dung:</strong> ${description.content}</p>
    </c:if>

    <!-- Hiển thị các ngày áp dụng (ScheduleDays) -->
    <c:if test="${not empty applicableDays}">
        <h3>Ngày Áp Dụng (Schedule Days):</h3>
        <ul>
            <c:forEach var="day" items="${applicableDays}">
                <li>${day}</li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty applicableDays}">
        <p>Không có lịch học áp dụng cho khóa học này.</p>
    </c:if>

    <!-- Hiển thị thông tin giáo viên -->
    <c:if test="${not empty teacher}">
        <h3>Thông Tin Giáo Viên:</h3>
        <p><strong>Tên Giáo Viên:</strong> ${teacher.name}</p>
        <p><strong>Tiểu Sử:</strong> ${teacher.bio}</p>
        <p><strong>Bằng Cấp:</strong> ${teacher.qualifications}</p>
    </c:if>

    <c:if test="${empty teacher}">
        <p>Không tìm thấy thông tin giáo viên cho khóa học này.</p>
    </c:if>

</body>
</html>
