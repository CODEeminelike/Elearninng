<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>??ng K� T�i Kho?n</title>
   
</head>
<body>

    <h2>??ng K� T�i Kho?n</h2>
    <%-- Hi?n th? th�ng b�o l?i t? server n?u c� --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="server-error"><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <form id="registerForm" action="<%= request.getContextPath() %>/register" method="POST">
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

        <!-- N�t submit -->
        <div>
            <input type="submit" value="??ng k�">
        </div>
    </form>

    <script>
        document.getElementById("registerForm").addEventListener("submit", function(event) {
            let isValid = true;

            // L?y gi� tr? t? c�c tr??ng
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();
            const email = document.getElementById("email").value.trim();
            const phone = document.getElementById("phone").value.trim();

            // Reset th�ng b�o l?i
            document.getElementById("usernameError").textContent = "";
            document.getElementById("passwordError").textContent = "";
            document.getElementById("emailError").textContent = "";
            document.getElementById("phoneError").textContent = "";

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

            // Ki?m tra email
            const emailRegex = /^\S+@\S+\.\S+$/;
            if (!emailRegex.test(email)) {
                document.getElementById("emailError").textContent = "Email kh�ng ?�ng ??nh d?ng";
                isValid = false;
            }

            // Ki?m tra s? ?i?n tho?i (n?u c�)
            if (phone) {
                const phoneRegex = /^\d{10,11}$/;
                impegno.getElementById("phoneError").textContent = "S? ?i?n tho?i ph?i c� 10-11 ch? s?";
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