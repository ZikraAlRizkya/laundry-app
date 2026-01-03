<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Fauzan.Model.User, Fauzan.Controller.DBConnection" %>
<%@ include file="/WEB-INF/includes/sidebarAdmin.jsp" %>
<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM users");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- SAME CSS AS ADMIN PAGE -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>

<body>

<!-- MAIN CONTENT -->
<div class="content" style="
    position: relative;
    margin-left: 240px;
    padding: 32px 32px 100px 32px;
    min-height: calc(100vh - 56px);
    box-sizing: border-box;
">
    <h1 style="color:white; margin-bottom:40px">User Management</h1>

    <!-- ADD USER -->
    <div class="card mb-5 shadow-sm">
        <div class="card-header bg-dark text-white">
            Add New User
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/auth" method="post" class="row g-3">
                <input type="hidden" name="action" value="addUser">

                <div class="col-md-4">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Password</label>
                    <input type="text" name="password" class="form-control" required>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select">
                        <option value="PELANGGAN">user</option>
                        <option value="ADMIN">admin</option>
                    </select>
                </div>

                <div class="col-md-1 d-flex align-items-end">
                    <button class="btn btn-success w-100">
                        <i class="fa fa-plus"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- USER TABLE -->
    <div class="card">
        <div class="card-body table-responsive">
            <table class="table table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    while (rs.next()) {
                %>
                <tr>
                    <!-- UPDATE FORM -->
                    <form action="${pageContext.request.contextPath}/auth" method="post" class="d-inline">
                        <td><%= rs.getInt("user_id") %></td>

                        <td>
                            <input class="form-control" name="email"
                                   value="<%= rs.getString("email") %>">
                        </td>

                        <td>
                            <input class="form-control" name="password"
                                   value="<%= rs.getString("password") %>">
                        </td>

                        <td><%= rs.getString("role") %></td>

                        <td class="d-flex gap-2">
                            <input type="hidden" name="id" value="<%= rs.getInt("user_id") %>">
                            <input type="hidden" name="action" value="updateUser">
                            <button class="btn btn-sm btn-primary">Update</button>
                    </form>

                    <!-- DELETE FORM -->
                    <form action="${pageContext.request.contextPath}/auth" method="post"
                          onsubmit="return confirm('Delete this user?')">
                        <input type="hidden" name="id" value="<%= rs.getInt("user_id") %>">
                        <input type="hidden" name="action" value="deleteUser">
                        <button class="btn btn-sm btn-danger">Delete</button>
                    </form>
                        </td>
                </tr>
                <% } %>

                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    } finally {
        if (rs != null) rs.close();
        if (st != null) st.close();
        if (con != null) con.close();
    }
%>
