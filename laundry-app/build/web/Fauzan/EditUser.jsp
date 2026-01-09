<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Fauzan.Model.User" %>
<%
    User userToEdit = (User) request.getAttribute("userToEdit");
    if (userToEdit == null) {
        response.sendRedirect(request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
        rel="stylesheet"
    >
    <link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
        rel="stylesheet"
    >

    <style>
        .edit-page {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #020617);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: "Segoe UI", sans-serif;
            padding: 20px;
        }

        .edit-wrapper {
            width: 100%;
            max-width: 600px;
        }

        .edit-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 32px 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.35);
        }

        .form-control,
        .form-select {
            border-radius: 10px;
            padding: 10px 12px;
        }

        .btn-primary {
            background: #2563eb;
            border-color: #2563eb;
            border-radius: 10px;
            font-weight: 600;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;
        }

        .btn-secondary {
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

        .password-toggle:hover {
            color: #2563eb;
        }

        .role-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .role-badge.admin {
            background: #fee2e2;
            color: #991b1b;
        }

        .role-badge.user {
            background: #dbeafe;
            color: #1e40af;
        }

        .section-divider {
            border: 0;
            border-top: 1px solid #e5e7eb;
            margin: 24px 0;
        }
    </style>
</head>

<body class="edit-page">

<div class="edit-wrapper">
    <div class="edit-card">

        <div class="d-flex align-items-center mb-1">
            <i class="fas fa-user-edit fa-2x text-primary me-3"></i>
            <div>
                <h3 class="mb-0">Edit User</h3>
                <p class="text-muted mb-0">Update user information</p>
            </div>
        </div>

        <hr class="section-divider">

        <form action="<%= request.getContextPath() %>/auth" method="post">
            <input type="hidden" name="action" value="updateUser">
            <input type="hidden" name="id" value="<%= userToEdit.getId() %>">

            <!-- User ID Display -->
            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="fas fa-id-badge me-2"></i>User ID
                </label>
                <input
                    type="text"
                    class="form-control"
                    value="<%= userToEdit.getId() %>"
                    disabled
                    readonly
                >
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">
                        <i class="fas fa-user me-2"></i>First Name
                    </label>
                    <input
                        type="text"
                        name="firstName"
                        class="form-control"
                        value="<%= userToEdit.getFirstName() != null ? userToEdit.getFirstName() : "" %>"
                        placeholder="Enter first name"
                    >
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">
                        <i class="fas fa-user me-2"></i>Last Name
                    </label>
                    <input
                        type="text"
                        name="lastName"
                        class="form-control"
                        value="<%= userToEdit.getLastName() != null ? userToEdit.getLastName() : "" %>"
                        placeholder="Enter last name"
                    >
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="fas fa-envelope me-2"></i>Email Address
                </label>
                <input
                    type="email"
                    name="email"
                    class="form-control"
                    value="<%= userToEdit.getEmail() %>"
                    placeholder="user@example.com"
                    required
                >
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="fas fa-phone me-2"></i>Phone Number
                </label>
                <input
                    type="text"
                    name="phone"
                    class="form-control"
                    value="<%= userToEdit.getPhoneNumber() != null ? userToEdit.getPhoneNumber() : "" %>"
                    placeholder="08xxxxxxxxxx"
                >
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">
                    <i class="fas fa-lock me-2"></i>Password
                </label>
                <div class="password-wrapper">
                    <input
                        type="password"
                        name="password"
                        class="form-control"
                        id="passwordField"
                        value="<%= userToEdit.getPassword() %>"
                        required
                        autocomplete="new-password"
                    >
                    <span class="password-toggle" onclick="togglePassword()">
                        <i id="eyeIcon" class="fa-solid fa-eye"></i>
                    </span>
                </div>
                <small class="text-muted">
                    <i class="fas fa-info-circle me-1"></i>Enter new password or keep existing one
                </small>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">
                    <i class="fas fa-shield-alt me-2"></i>User Role
                </label>
                <div>
                    <% if ("admin".equalsIgnoreCase(userToEdit.getRole())) { %>
                        <span class="role-badge admin">
                            <i class="fas fa-crown me-1"></i>Administrator
                        </span>
                    <% } else { %>
                        <span class="role-badge user">
                            <i class="fas fa-user me-1"></i>Regular User
                        </span>
                    <% } %>
                </div>
                <small class="text-muted">
                    <i class="fas fa-info-circle me-1"></i>Role cannot be changed from this form
                </small>
            </div>

            <hr class="section-divider">

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary flex-fill py-2">
                    <i class="fas fa-save me-2"></i>Save Changes
                </button>
                <a 
                    href="<%= request.getContextPath() %>/Fauzan/ManajemenPelanggan.jsp" 
                    class="btn btn-secondary flex-fill py-2"
                >
                    <i class="fas fa-times me-2"></i>Cancel
                </a>
            </div>
        </form>

        <div class="text-center mt-3">
            <a
                href="<%= request.getContextPath() %>/Fauzan/ManajemenPelanggan.jsp"
                class="text-muted"
            >
                <i class="fas fa-arrow-left me-1"></i>Back to User Management
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