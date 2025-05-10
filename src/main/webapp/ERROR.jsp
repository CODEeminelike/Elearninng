<%-- 
    Document   : ERROR
    Created on : May 10, 2025, 1:46:41 PM (Ngày này có thể giữ nguyên hoặc cập nhật)
    Author     : LENOVO (Tên tác giả)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông Báo Lỗi</title> <%-- Thay đổi tiêu đề cho rõ ràng hơn --%>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            .error-container { border: 1px solid #cc0000; background-color: #ffeeee; padding: 15px; }
            .error-title { color: #cc0000; font-size: 24px; }
            .error-message { margin-top: 10px; font-size: 16px; }
        </style>
    </head>
    <body>
        <div class="error-container">
            <h1 class="error-title">Đã có sự cố xảy ra!</h1>
            
            <%-- Kiểm tra xem có thuộc tính lỗi không và hiển thị nó --%>
            <c:if test="${not empty thongDiepLoiEmail}">
                <p class="error-message">
                    <strong>Chi tiết lỗi gửi email:</strong> ${thongDiepLoiEmail}
                </p>
            </c:if>
            
            <%-- Nếu bạn không sử dụng JSTL (c:if), bạn có thể dùng scriptlet (ít được khuyến khích hơn) --%>
            <%-- 
            <% 
                String errorMessage = (String) request.getAttribute("thongDiepLoiEmail");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <p class="error-message">
                    <strong>Chi tiết lỗi gửi email:</strong> <%= errorMessage %>
                </p>
            <%
                } else {
            %>
                <p class="error-message">
                    Không có thông tin chi tiết về lỗi. Vui lòng kiểm tra nhật ký máy chủ.
                </p>
            <%
                }
            %>
            --%>
            
            <p><a href="${pageContext.request.contextPath}/">Quay lại trang chủ</a></p>
        </div>
    </body>
</html>