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
    <title>Pesanan Saya</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>

<body>

<!-- ================= CONTENT ================= -->
<div class="content" style="padding-bottom:80px">
    <h1 style="color:white; margin-bottom:40px">Pesanan Saya</h1>

    <div class="no-hover">
        <div class="card">
            <div class="card-body">

                <h4 class="card-title">Pesanan 7 Hari Terakhir</h4>

                <div class="table-responsive">
                    <table id="tbl">
                        <thead>
                            <tr>
                                <th>Order Code</th>
                                <th>Tanggal Pemesanan</th>
                                <th>Status Pembayaran</th>
                                <th>Status Laundry</th>
                                <th class="right">Total Harga</th>
                                <th class="right">Detail Pesanan</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Map<String,Object>> list =
                                (List<Map<String,Object>>) request.getAttribute("myOrders");

                            if (list != null && !list.isEmpty()) {
                                for (Map<String,Object> row : list) {
                        %>
                            <tr>
                                <td><b><%= row.get("orderId") %></b></td>
                                <td><%= row.get("orderDate") %></td>

                                <td>
                                    <span class="badge
                                        <%= "paid".equals(row.get("paymentStatus"))
                                            ? "bg-success"
                                            : "bg-danger" %>">
                                        <%= row.get("paymentStatus") %>
                                    </span>
                                </td>

                                <td>
                                    <span class="badge
                                        <%= "pending".equals(row.get("status")) ? "bg-warning text-dark" :
                                            "process".equals(row.get("status")) ? "bg-primary" :
                                            "ready to taken".equals(row.get("status")) ? "bg-info text-dark" :
                                            "bg-success" %>">
                                        <%= row.get("status") %>
                                    </span>
                                </td>

                                <td class="right">Rp <%= row.get("totalPrice") %></td>

                                <td class="right">
                                    <a href="${pageContext.request.contextPath}/OrderHistory"
                                       class="btn btn-primary btn-sm btn-nota">
                                        Detail
                                    </a>
                                </td>

                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="6" class="text-center text-muted">
                                    Belum ada pesanan
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
