<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Register Page</title>

    <!-- Bootstrap & Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
        rel="stylesheet"
    >
    <link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
        rel="stylesheet"
    >

    <style>
        .register-page {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #020617);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Segoe UI", sans-serif;
        }

        .register-wrapper {
            width: 100%;
            max-width: 480px;
            padding: 20px;
        }

        .register-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 28px 26px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.35);
        }

        .form-control,
        .form-select {
            border-radius: 10px;
            padding: 10px 12px;
        }

        .btn-success {
            border-radius: 10px;
            font-weight: 600;
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
    </style>
</head>

<body class="register-page">

<div class="register-wrapper">
    <div class="register-card">

        <h3 class="text-center mb-1">Registration</h3>
        <p class="text-center text-muted mb-4">
            Create your account
        </p>

        <form action="<%= request.getContextPath() %>/auth" method="post">
            <input type="hidden" name="action" value="register">

            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">First Name</label>
                    <input
                        type="text"
                        name="firstName"
                        class="form-control"
                        required
                    >
                </div>

                <div class="col">
                    <label class="form-label">Last Name</label>
                    <input
                        type="text"
                        name="lastName"
                        class="form-control"
                        required
                    >
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input
                    type="email"
                    name="email"
                    class="form-control"
                    placeholder="example@gmail.com"
                    required
                >
            </div>

            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input
                    type="text"
                    name="phone"
                    class="form-control"
                    placeholder="08xxxxxxxxxx"
                    required
                >
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>

                <div class="password-wrapper">
                    <input
                        type="password"
                        name="password"
                        class="form-control"
                        id="passwordField"
                        required
                        autocomplete="new-password"
                    >

                    <span class="password-toggle" onclick="togglePassword()">
                        <i id="eyeIcon" class="fa-solid fa-eye"></i>
                    </span>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Role</label>
                <select name="role" class="form-select" required>
                    <option value="">-- Select Role --</option>
                    <option value="user">Pelanggan</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <button class="btn btn-success w-100 py-2">
                Register
            </button>
        </form>

        <div class="text-center mt-3">
            <a
                href="<%= request.getContextPath() %>/Fauzan/Login.jsp"
                class="fw-bold"
            >
                Back to Login
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