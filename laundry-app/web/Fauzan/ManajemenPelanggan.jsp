<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Fauzan.Model.User, Fauzan.Controller.DBConnection" %>
<%@ include file="/WEB-INF/includes/sidebarAdmin.jsp" %>
<%@ include file="/WEB-INF/includes/navbar.jsp" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/AuthController/login");
        return;
    }
    Connection con = DBConnection.getConnection();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM users ORDER BY user_id");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <style>
        .content {
            position: relative;
            padding-bottom: 80px;
        }
        .success-alert {
            animation: slideDown 0.3s ease-out;
        }
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="content">
    <h1 style="color: white; margin-bottom:5px">User Management</h1>
    <h5 style="color: white; margin-bottom:30px">Manage all system users</h5>

    <!-- Success/Error Messages -->
    <% if (request.getParameter("added") != null) { %>
        <div class="alert alert-success alert-dismissible fade show success-alert" role="alert">
            <i class="fas fa-check-circle me-2"></i>User added successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <% if (request.getParameter("updated") != null) { %>
        <div class="alert alert-success alert-dismissible fade show success-alert" role="alert">
            <i class="fas fa-check-circle me-2"></i>User updated successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <% if (request.getParameter("deleted") != null) { %>
        <div class="alert alert-success alert-dismissible fade show success-alert" role="alert">
            <i class="fas fa-check-circle me-2"></i>User deleted successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="card mb-4">
        <div class="card-body">
            <h4 class="card-title mb-3">
                <i class="fas fa-user-plus me-2"></i>Add New User
            </h4>
            <hr style="border: 0; border-top: 1px solid #666; margin-bottom: 20px">
            
            <form action="${pageContext.request.contextPath}/AuthController/admin/addUser" method="post">
                
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" placeholder="user@example.com" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Password" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Role</label>
                        <select name="role" class="form-select" required>
                            <option value="">-- Select Role --</option>
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-success w-100">
                            <i class="fas fa-plus me-1"></i>Add User
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h4 class="card-title mb-3">
                <i class="fas fa-users me-2"></i>All Users
            </h4>
            <hr style="border: 0; border-top: 1px solid #666; margin-bottom: 20px">
            
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th width="5%">ID</th>
                            <th width="20%">First Name</th>
                            <th width="20%">Last Name</th>
                            <th width="25%">Email</th>
                            <th width="12%">Phone</th>
                            <th width="8%">Role</th>
                            <th width="10%" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                    boolean hasData = false;
                    while (rs.next()) { 
                        hasData = true;
                        int userId = rs.getInt("user_id");
                        String firstName = rs.getString("first_name");
                        String lastName = rs.getString("last_name");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        String role = rs.getString("role");
                    %>
                        <tr>
                            <td><%= userId %></td>
                            <td><%= firstName != null ? firstName : "-" %></td>
                            <td><%= lastName != null ? lastName : "-" %></td>
                            <td><%= email %></td>
                            <td><%= phone != null ? phone : "-" %></td>
                            <td>
                                <% if ("admin".equalsIgnoreCase(role)) { %>
                                    <span class="badge bg-danger">Admin</span>
                                <% } else { %>
                                    <span class="badge bg-primary">User</span>
                                <% } %>
                            </td>
                            <td class="text-center">
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/AuthController/admin/edit?id=<%= userId %>" 
                                       class="btn btn-sm btn-primary" 
                                       title="Edit User">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="${pageContext.request.contextPath}/AuthController/admin/deleteUser" 
                                          method="post" 
                                          style="display:inline"
                                          onsubmit="return confirm('Are you sure you want to delete this user?')">
                                        <input type="hidden" name="id" value="<%= userId %>">
                                        <button type="submit" class="btn btn-sm btn-danger" title="Delete User">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                    <% if (!hasData) { %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                <i class="fas fa-inbox fa-2x mb-2"></i>
                                <p class="mb-0">No users found</p>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    rs.close();
    st.close();
    con.close();
%>
