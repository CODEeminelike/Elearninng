<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>??ng Nh?p</title>
   
</head>
<body>

    <h2>??ng Nh?p</h2>
    <%-- Hi?n th? th�ng b�o l?i t? server n?u c� --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="server-error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <%-- Hi?n th? th�ng b�o ??ng k� th�nh c�ng n?u c� --%>
    <% if ("true".equals(request.getParameter("registrationSuccess"))) { %>
        <div style="color: green; font-weight: bold; margin-bottom: 15px;">
            ??ng k� th�nh c�ng! Vui l�ng ??ng nh?p.
        </div>
    <% } %>

    <form id="loginForm" action="<%= request.getContextPath() %>/login" method="POST">
        <!-- T�n ??ng nh?p -->
        <div class="form-group">
            <label for="username">T�n ??ng nh?p:</label>
            <input type="text" id="username" name="username" required placeholder="Nh?p t�n ??ng nh?p"
                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
            <span id="usernameError" class="error"></span>
        </div>

        <!-- M?t kh?u -->
        <div class="form-group">
            <label for="password">M?t kh?u:</label>
            <input type="password" id="password" name="password" required placeholder="Nh?p m?t kh?u">
            <span id="passwordError" class="error"></span>
        </div>

        <!-- N�t submit -->
        <div>
            <input type="submit" value="??ng nh?p">
        </div>
    </form>

    <script>
        document.getElementById("loginForm").addEventListener("submit", function(event) {
            let isValid = true;

            // L?y gi� tr? t? c�c tr??ng
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();

            // Reset th�ng b�o l?i
            document.getElementById("usernameError").textContent = "";
            document.getElementById("passwordError").textContent = "";

            // Ki?m tra t�n ??ng nh?p
            if (username.length < 3) {
                document.getElementById("usernameError").textContent = "T�n ??ng nh?p ph?i c� �t nh?t 3 k� t?";
                isValid = false;
            }

            // Ki?m tra m?t kh?u
            if (password.length < 6) {
                document.getElementById("passwordError").textContent = "M?t kh?u ph?i c� �t nh?t 6 k� t?";
                isValid = false;
            }

            // Ng?n submit n?u c� l?i
            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>

</body>
</html>