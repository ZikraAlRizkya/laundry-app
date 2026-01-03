<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Fauzan.Model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<%@ include file="/WEB-INF/includes/sidebarUser.jsp" %>
<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Riwayat Pesanan</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>

<body>

<!-- ================= CONTENT ================= -->
<div class="content" style="padding-bottom:80px">
    <h1 style="color:white; margin-bottom:40px">Riwayat Pesanan</h1>

    <div class="no-hover">
        <div class="card">
            <div class="card-body">

                <h4 class="card-title">Semua Riwayat Pesanan</h4>

                <div class="table-responsive">
                    <table id="tbl">
                        <thead>
                            <tr>
                                <th>Order</th>
                                <th>Tanggal</th>
                                <th>Status</th>
                                <th>Layanan</th>
                                <th>Jenis</th>
                                <th>Berat</th>
                                <th class="right">Total Harga</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Map<String,Object>> history =
                                (List<Map<String,Object>>) request.getAttribute("history");

                            if (history != null && !history.isEmpty()) {
                                for (Map<String,Object> row : history) {
                        %>
                            <tr>
                                <td><b><%= row.get("orderId") %></b></td>
                                <td><%= row.get("orderDate") %></td>
                                <td>
                                    <span class="badge
                                        <%= "pending".equals(row.get("status")) ? "bg-warning text-dark" :
                                            "process".equals(row.get("status")) ? "bg-primary" :
                                            "ready to taken".equals(row.get("status")) ? "bg-info text-dark" :
                                            "bg-success" %>">
                                        <%= row.get("status") %>
                                    </span>
                                </td>
                                <td><%= row.get("layanan") %></td>
                                <td><%= row.get("jenisCucian") %></td>
                                <td><%= row.get("quantity") %> Kg</td>
                                <td class="right">
                                    Rp <strong><%= row.get("totalPrice") %></strong>
                                </td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="7" class="text-center text-muted">
                                    Tidak ada riwayat pesanan
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>
