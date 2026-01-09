<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Fauzan.Model.User" %>

<%
    User userToEdit = (User) request.getAttribute("userToEdit");
    if (userToEdit == null) {
        response.sendRedirect(request.getContextPath() + "/AuthController/admin/users");
        return;
    }

    User currentUser = (User) session.getAttribute("user");
    //deklarasi isEditingSelf agar tidak bisa edit role sendiri
    boolean isEditingSelf =
            currentUser != null && currentUser.getId() == userToEdit.getId();
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <jsp:include page="/WEB-INF/includes/editinterface.jsp" />
</head>


<body class="edit-page">

<div class="edit-wrapper">
    <div class="edit-card">

        <h3 class="text-center mb-1">Edit User</h3>
        <p class="text-center text-muted mb-4">
            Update informasi pengguna
        </p>

        <% if (request.getParameter("error") != null) {
               String errorCode = request.getParameter("error");
               if ("2".equals(errorCode)) { %>
            <div class="alert alert-danger text-center py-2">
                Anda tidak dapat mengubah role Anda sendiri!
            </div>
        <% } else { %>
            <div class="alert alert-danger text-center py-2">
                Gagal mengupdate user!
            </div>
        <% } } %>

        <form action="<%= request.getContextPath() %>/AuthController/admin/updateUser" method="post">
            <input type="hidden" name="id" value="<%= userToEdit.getId() %>">

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input
                        type="email"
                        class="form-control"
                        name="email"
                        value="<%= userToEdit.getEmail() %>"
                        placeholder="example@gmail.com"
                        required
                >
            </div>

            <div class="mb-2">
                <label class="form-label">Password Saat Ini</label>
                <div class="current-password-display">
                    <%= userToEdit.getPassword() != null ? userToEdit.getPassword() : "N/A" %>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Password Baru (Opsional)</label>
                <div class="password-wrapper">
                    <input
                            type="password"
                            class="form-control"
                            name="password"
                            id="passwordField"
                            placeholder="Kosongkan jika tidak ingin mengubah"
                    >
                    <span class="password-toggle" onclick="togglePassword()">
                        <i id="eyeIcon" class="fa-solid fa-eye"></i>
                    </span>
                </div>
                <small class="text-muted">
                    Kosongkan jika tidak ingin mengubah password
                </small>
            </div>

            <div class="mb-4">
                <label class="form-label">Role</label>
                <select
                        name="role"
                        class="form-select"
                        required
                        <%= isEditingSelf ? "disabled" : "" %>>
                    <option value="admin"
                            <%= "admin".equalsIgnoreCase(userToEdit.getRole()) ? "selected" : "" %>>
                        Admin
                    </option>
                    <option value="user"
                            <%= "user".equalsIgnoreCase(userToEdit.getRole()) ? "selected" : "" %>>
                        User
                    </option>
                </select>

                <% if (isEditingSelf) { %>
                    <input type="hidden" name="role" value="<%= userToEdit.getRole() %>">
                    <small class="text-muted">
                        Anda tidak dapat mengubah role Anda sendiri
                    </small>
                <% } %>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary py-2">
                    <i class="fa-solid fa-save me-2"></i>Simpan Perubahan
                </button>
                <a
                        href="<%= request.getContextPath() %>/AuthController/admin/users"
                        class="btn btn-secondary py-2">
                    <i class="fa-solid fa-arrow-left me-2"></i>Kembali
                </a>
            </div>
        </form>

    </div>
</div>

<script>
    function togglePassword() {
        const input = document.getElementById("passwordField");
        const icon = document.getElementById("eyeIcon");

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
