<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laundry Login</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        .login-page {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #020617);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Segoe UI", sans-serif;
        }

        .login-wrapper {
            width: 100%;
            max-width: 600px;
            padding: 20px;
        }

        .login-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 28px 26px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.35);
        }

        .login-card .form-control {
            border-radius: 10px;
            padding: 10px 12px;
        }

        .login-card .btn-primary {
            background: #2563eb;
            border-color: #2563eb;
            border-radius: 10px;
            font-weight: 600;
        }

        .login-card .btn-primary:hover {
            background: #1d4ed8;
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .form-control {
            padding-right: 42px;
        }

        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #6b7280;
            cursor: pointer;
        }

        .password-toggle:hover {
            color: #2563eb;
        }
    </style>
</head>

<body class="login-page">

<div class="login-wrapper">
    <div class="login-card">

        <h3 class="text-center mb-1">Login</h3>
        <p class="text-center text-muted mb-4">
            Silahkan Masukkan Email dan Password untuk Masuk
        </p>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center py-2">
                Email atau Password Salah!
            </div>
        <% } %>

        <% if (request.getParameter("registered") != null) { %>
            <div class="alert alert-success text-center py-2">
                Sukses Registrasi
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="login">

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input
                    type="email"
                    class="form-control"
                    name="email"
                    placeholder="example@gmail.com"
                    required
                >
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>

                <div class="password-wrapper">
                    <input
                        type="password"
                        class="form-control"
                        name="password"
                        id="passwordField"
                        required
                    >

                    <span class="password-toggle" onclick="togglePassword()">
                        <i id="eyeIcon" class="fa-solid fa-eye"></i>
                    </span>
                </div>
            </div>

            <button class="btn btn-primary w-100 py-2">
                Login
            </button>
        </form>

        <div class="text-center mt-3">
            <span class="text-muted">Don't have an account?</span><br>
            <a
                href="${pageContext.request.contextPath}/Fauzan/Register.jsp"
                class="fw-bold"
            >
                Create account
            </a>
        </div>

    </div>
</div>

<script>
    function togglePassword() {
        const input = document.getElementById("passwordField");
        const icon  = document.getElementById("eyeIcon");

        if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }
</script>

</body>
</html>