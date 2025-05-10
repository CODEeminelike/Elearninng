<%--
    Document     : Done.jsp
    Created on : May 10, 2025, 1:42:26 PM
    Author       : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Model.PasswordResetToken"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách Token</title>
        <style>
            table {
                width: 80%;
                border-collapse: collapse;
                margin: 20px auto;
            }
            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            h1 {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Danh sách tất cả Token đặt lại mật khẩu</h1>

        <%-- Lấy danh sách token từ request attribute --%>
        <%
            List<PasswordResetToken> tokenList = (List<PasswordResetToken>) request.getAttribute("allTokens");
        %>

        <%-- Kiểm tra nếu danh sách không rỗng --%>
        <% if (tokenList != null && !tokenList.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Email</th>
                        <th>Token</th>
                        <th>Ngày hết hạn</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Lặp qua danh sách và hiển thị từng token --%>
                    <% for (PasswordResetToken token : tokenList) { %>
                        <tr>
                            <td><%= token.getEmail() %></td>
                            <td><%= token.getToken() %></td>
                            <td><%= token.getExpiryDate() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p style="text-align: center;">Không tìm thấy token nào trong cơ sở dữ liệu.</p>
        <% } %>

    </body>
</html>
