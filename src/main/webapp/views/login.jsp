<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>??ng Nh?p</title>
   
</head>
<body>

    <h2>??ng Nh?p</h2>
    <%-- Hi?n th? thông báo l?i t? server n?u có --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="server-error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <%-- Hi?n th? thông báo ??ng ký thành công n?u có --%>
    <% if ("true".equals(request.getParameter("registrationSuccess"))) { %>
        <div style="color: green; font-weight: bold; margin-bottom: 15px;">
            ??ng ký thành công! Vui lòng ??ng nh?p.
        </div>
    <% } %>

    <form id="loginForm" action="<%= request.getContextPath() %>/login" method="POST">
        <!-- Tên ??ng nh?p -->
        <div class="form-group">
            <label for="username">Tên ??ng nh?p:</label>
            <input type="text" id="username" name="username" required placeholder="Nh?p tên ??ng nh?p"
                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
            <span id="usernameError" class="error"></span>
        </div>

        <!-- M?t kh?u -->
        <div class="form-group">
            <label for="password">M?t kh?u:</label>
            <input type="password" id="password" name="password" required placeholder="Nh?p m?t kh?u">
            <span id="passwordError" class="error"></span>
        </div>

        <!-- Nút submit -->
        <div>
            <input type="submit" value="??ng nh?p">
        </div>
    </form>

    <script>
        document.getElementById("loginForm").addEventListener("submit", function(event) {
            let isValid = true;

            // L?y giá tr? t? các tr??ng
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();

            // Reset thông báo l?i
            document.getElementById("usernameError").textContent = "";
            document.getElementById("passwordError").textContent = "";

            // Ki?m tra tên ??ng nh?p
            if (username.length < 3) {
                document.getElementById("usernameError").textContent = "Tên ??ng nh?p ph?i có ít nh?t 3 ký t?";
                isValid = false;
            }

            // Ki?m tra m?t kh?u
            if (password.length < 6) {
                document.getElementById("passwordError").textContent = "M?t kh?u ph?i có ít nh?t 6 ký t?";
                isValid = false;
            }

            // Ng?n submit n?u có l?i
            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>

</body>
</html>