<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* Style cho Header */
            .header {
                background-color: #4CAF50;
                padding: 20px;
                text-align: center;
                font-size: 20px;
                color: white;
                position: fixed;
                width: 100%;
                top: 0;
                left: 0;
                z-index: 1000;
            }

            .header button {
                background-color: #f1f1f1;
                color: #4CAF50;
                padding: 14px 20px;
                margin: 0 10px;
                border: none;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .header button:hover {
                background-color: #ddd;
            }

            /* Style cho content phía dưới header */
            .content {
                margin-top: 80px; /* Đảm bảo phần content không bị che khuất bởi header */
                padding: 20px;
            }

            iframe {
                width: 100%;
                height: 600px;
                border: none;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="header">
            <button onclick="loadPage('category')">Category</button>
            <button onclick="loadPage('course')">Course</button>
        </div>

        <!-- Content Area -->
        <div class="content">
            <iframe id="contentFrame" src="about:blank" name="contentFrame"></iframe>
        </div>

        <script>
            // Function to load the appropriate page into iframe
            function loadPage(page) {
                var frame = document.getElementById('contentFrame');
                switch(page) {
                    case 'category':
                        frame.src = "<%= request.getContextPath() %>/views/admin/managecategories.jsp"; // Thay bằng đường dẫn tới trang Category
                        break;
                    case 'course':
                        frame.src = "<%= request.getContextPath() %>/views/admin/course.jsp"; // Thay bằng đường dẫn tới trang Course
                        break;
                    default:
                        frame.src = "about:blank"; // Không làm gì nếu không chọn
                }
            }
        </script>
    </body>
</html>
