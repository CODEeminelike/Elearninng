<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            display: flex;
            height: 100vh;
        }

       /* Header style */
/* Header style */
/* Header style */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 30px;
    background-color: #ffffff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    z-index: 1000;
    box-sizing: border-box;
}

/* Logo style */
.header .logo {
    font-size: 24px;
    font-weight: 700;
    color: #00bcd4;
    display: flex;
    align-items: center;
}

/* Student info */
.header .student-info {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-shrink: 0;  /* Đảm bảo phần này không thu hẹp */
    white-space: nowrap;  /* Ngăn không cho text bị ngắt dòng */
}

.header .student-info i {
    font-size: 20px;
}

.header .student-info span {
    font-size: 16px;
}

        /* Side navigation (Navi) */
       /* Side navigation (Navi) */
/* Side navigation (Navi) */
.navi {
    position: fixed;
    top: 60px; /* Điều chỉnh top này cho đến khi không còn khe hở */
    left: 0;
    width: 200px;
    background-color: #f5f5f5;
    padding: 20px;
    height: 100%;
    box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.1);
    margin-top: 0; /* Đảm bảo không có margin */
}
        .navi .nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 0;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .navi .nav-item:hover {
            background-color: #00bcd4;
            color: white;
        }

        .navi .nav-item i {
            font-size: 20px;
        }

        .navi .nav-item .text {
            font-size: 16px;
        }

        .navi .logout {
            position: absolute;
            bottom: 20px;
            width: 100%;
            padding: 10px 0;
            text-align: center;
            cursor: pointer;
            background-color: #f44336;
            color: white;
            font-weight: bold;
        }

       /* Main content area */
.main-content {
    margin-left: 220px; /* Điều chỉnh margin để tránh bị đè lên Navigation */
    padding-top: 70px; /* Căn chỉnh với Header */
    flex-grow: 1;
    padding: 20px;
    background-color: #f4f7fa;
}

        .frame {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .nav-item a {
    text-decoration: none;  /* Bỏ gạch dưới */
    color: inherit;         /* Giữ màu của chữ như bình thường */
    display: flex;          /* Đảm bảo icon và text vẫn nằm trên cùng một dòng */
    align-items: center;    /* Căn giữa các phần tử */
    width: 100%;            /* Đảm bảo thẻ <a> chiếm toàn bộ diện tích của div */
}
        
        
    </style>
</head>
<body>

    <!-- Header -->
    <div class="header">
        <div class="logo">
            <i class="fa fa-book"></i> eLEARNING
        </div>
        <div class="student-info">
            <i class="fa fa-user"></i>
            <span>Student</span>
        </div>
    </div>

    <!-- Side Navigation -->
    <div class="navi">
        <div class="nav-item">
            <a href="/el1/views/index.jsp" class="nav-link">
        <i class="fa fa-home"></i>
        <span class="text">Trang chủ</span>
    </a>
        </div>

        <div class="nav-item">
            <i class="fa fa-book"></i>
            <span class="text">Khóa học của tôi</span>
        </div>
        <div class="nav-item">
            <i class="fa fa-chart-bar"></i>
            <span class="text">Thống kê</span>
        </div>
        <div class="nav-item">
            <i class="fa fa-bell"></i>
            <span class="text">Thông báo</span>
        </div>
        <div class="logout">
            <span>Đăng xuất</span>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <div class="frame">
            <!-- Content for the selected option will be displayed here -->
            <h2>Welcome to your Dashboard, Student!</h2>
            <p>Choose a section from the navigation menu.</p>
        </div>
    </div>

</body>
</html>
