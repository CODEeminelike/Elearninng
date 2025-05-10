
 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>??ng Nh?p</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- MDBootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .form-container {
            width: 35%;
            margin: 80px auto;
        }
        @media (max-width: 768px) {
            .form-container {
                width: 90%;
            }
        }
        .error {
            color: red;
            font-size: 0.9em;
        }
        .server-error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .success-message {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <!-- Server error message -->
        <div id="serverError" class="server-error"></div>
        <!-- Registration success message -->
        <div id="successMessage" class="success-message"></div>
        <form id="loginForm" action="/login" method="POST">
            <!-- Username input -->
            <div data-mdb-input-init class="form-outline mb-4">
                <input type="text" id="username" name="username" class="form-control" required />
                <label class="form-label" for="username">Tên ??ng nh?p</label>
                <span id="usernameError" class="error"></span>
            </div>
            <!-- Password input -->
            <div data-mdb-input-init class="form-outline mb-4">
                <input type="password" id="password" name="password" class="form-control" required />
                <label class="form-label" for="password">M?t kh?u</label>
                <span id="passwordError" class="error"></span>
            </div>
            <!-- 2 column layout -->
            <div class="row mb-4">
                <div class="col d-flex justify-content-center">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" checked />
                        <label class="form-check-label" for="rememberMe"> Ghi nh? tôi </label>
                    </div>
                </div>
                <div class="col text-end">
                    <a href="#!">Quên m?t kh?u?</a>
                </div>
            </div>
            <!-- Submit button -->
            <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-block mb-4 w-100">
                ??ng nh?p
            </button>
            <!-- Register buttons -->
            <div class="text-center">
                <p>Ch?a có tài kho?n? <a href="#!">??ng ký</a></p>
                <p>ho?c ??ng nh?p v?i:</p>
                <button type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                    <i class="fab fa-facebook-f"></i>
                </button>
                <button type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                    <i class="fab fa-google"></i>
                </button>
                <button type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                    <i class="fab fa-twitter"></i>
                </button>
                <button type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-link btn-floating mx-1">
                    <i class="fab fa-github"></i>
                </button>
            </div>
        </form>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- MDB JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Simulate JSP server-side logic using URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const errorMessage = urlParams.get("errorMessage");
            const registrationSuccess = urlParams.get("registrationSuccess");
            const username = urlParams.get("username") || "";

            // Display server error
            if (errorMessage) {
                document.getElementById("serverError").textContent = decodeURIComponent(errorMessage);
            }

            // Display registration success
            if (registrationSuccess === "true") {
                document.getElementById("successMessage").textContent = "??ng ký thành công! Vui lòng ??ng nh?p.";
            }

            // Set username value
            document.getElementById("username").value = username;

            // Form validation
            document.getElementById("loginForm").addEventListener("submit", function(event) {
                let isValid = true;

                // Get input values
                const username = document.getElementById("username").value.trim();
                const password = document.getElementById("password").value.trim();

                // Reset error messages
                document.getElementById("usernameError").textContent = "";
                document.getElementById("passwordError").textContent = "";

                // Validate username
                if (username.length < 3) {
                    document.getElementById("usernameError").textContent = "Tên ??ng nh?p ph?i có ít nh?t 3 ký t?";
                    isValid = false;
                }

                // Validate password
                if (password.length < 6) {
                    document.getElementById("passwordError").textContent = "M?t kh?u ph?i có ít nh?t 6 ký t?";
                    isValid = false;
                }

                // Prevent submission if invalid
                if (!isValid) {
                    event.preventDefault();
                }
            });
        });
    </script>
</body>
</html>