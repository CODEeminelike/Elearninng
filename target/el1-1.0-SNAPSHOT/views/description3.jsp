<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.DescriptionDAO" %>
<%@ page import="ENum.ScheduleDay" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Test ScheduleDay</title>
</head>
<body>

<h1>TEST - Lấy danh sách ScheduleDay theo descriptionId</h1>

<!-- Form nhập descriptionId -->
<form method="get" action="description3.jsp">
    <label for="descId">Nhập descriptionId:</label>
    <input type="number" id="descId" name="descId" required>
    <button type="submit">Lấy Schedule</button>
</form>

<%
    String descIdStr = request.getParameter("descId");
    if (descIdStr != null) {
        try {
            Long descriptionId = Long.parseLong(descIdStr);
            DescriptionDAO dao = new DescriptionDAO();
            Set<ScheduleDay> scheduleDays = dao.getScheduleDay(descriptionId);

            if (scheduleDays != null && !scheduleDays.isEmpty()) {
%>
                <h2>ScheduleDay áp dụng:</h2>
                <ul>
                <%
                    for (ScheduleDay day : scheduleDays) {
                %>
                        <li><%= day.name() %></li>
                <%
                    }
                %>
                </ul>
<%
            } else {
%>
                <p>Không tìm thấy ScheduleDay cho descriptionId này.</p>
<%
            }
        } catch (NumberFormatException e) {
%>
            <p style="color: red;">Giá trị descriptionId không hợp lệ.</p>
<%
        }
    }
%>

</body>
</html>
