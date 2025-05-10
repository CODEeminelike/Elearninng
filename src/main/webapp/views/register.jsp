<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>??ng Ký Tài Kho?n</title>
   
</head>
<body>

    <h2>??ng Ký Tài Kho?n</h2>
    <%-- Hi?n th? thông báo l?i t? server n?u có --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="server-error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <form id="registerForm" action="<%= request.getContextPath() %>/register" method="POST">
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

        <!-- Email -->
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required placeholder="Nh?p email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
            <span id="emailError" class="error"></span>
        </div>

        <!-- S? ?i?n tho?i -->
        <div class="form-group">
            <label for="phone">S? ?i?n tho?i:</label>
            <input type="text" id="phone" name="phone" placeholder="Nh?p s? ?i?n tho?i"
                   value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
            <span id="phoneError" class="error"></span>
        </div>

        <!-- Nút submit -->
        <div>
            <input type="submit" value="??ng ký">
        </div>
    </form>

    <script>
        document.getElementById("registerForm").addEventListener("submit", function(event) {
            let isValid = true;

            // L?y giá tr? t? các tr??ng
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();
            const email = document.getElementById("email").value.trim();
            const phone = document.getElementById("phone").value.trim();

            // Reset thông báo l?i
            document.getElementById("usernameError").textContent = "";
            document.getElementById("passwordError").textContent = "";
            document.getElementById("emailError").textContent = "";
            document.getElementById("phoneError").textContent = "";

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

            // Ki?m tra email
            const emailRegex = /^\S+@\S+\.\S+$/;
            if (!emailRegex.test(email)) {
                document.getElementById("emailError").textContent = "Email không ?úng ??nh d?ng";
                isValid = false;
            }

            // Ki?m tra s? ?i?n tho?i (n?u có)
            if (phone) {
                const phoneRegex = /^\d{10,11}$/;
                impegno.getElementById("phoneError").textContent = "S? ?i?n tho?i ph?i có 10-11 ch? s?";
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