<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pelanggan Sidebar</title>
</head>
<body>

<%
    String currentPage = request.getServletPath();
    String pathInfo = request.getPathInfo();
    String fullPath = currentPage;

    if (pathInfo != null) {
        fullPath = currentPage + pathInfo;
    }
%>

<div class="sidebar">

    <!-- Header -->
    <div class="sidebar-header">
        <h4>
            <i class="fa-brands fa-opencart"></i>
            WashUp
        </h4>
    </div>

    <!-- Menu -->
    <div class="sidebar-menu">

        <!-- Home -->
        <a href="${pageContext.request.contextPath}/LaporanController?user_id=${user.id}"
           class="<%= currentPage.equals("/Zikra/Pelanggan.jsp") ? "active" : "" %>">
            <i class="fa-solid fa-house"></i>
            Home
        </a>

        <!-- Profil -->
        <a href="${pageContext.request.contextPath}/EditProfileUserController?user_id=${user.id}"
           class="<%= currentPage.equals("/Zikra/ProfilPelanggan.jsp") ? "active" : "" %>">
            <i class="fa-solid fa-user"></i>
            Profil
        </a>

        <!-- Buat Pesanan -->
        <a href="${pageContext.request.contextPath}/Ryan/BuatPesanan.jsp"
           class="<%= currentPage.contains("BuatPesanan") ? "active" : "" %>">
            <i class="fa-solid fa-plus"></i>
            Buat Pesanan
        </a>

        <!-- Pesanan Saya (Servlet-safe) -->
        <a href="${pageContext.request.contextPath}/MyOrders"
           class="<%= fullPath.contains("/MyOrders") || currentPage.equals("/Ryan/PesananSaya.jsp") ? "active" : "" %>">
            <i class="fa-solid fa-basket-shopping"></i>
            Pesanan Saya
        </a>

        <!-- Riwayat Pesanan (Servlet-safe) -->
        <a href="${pageContext.request.contextPath}/OrderHistory"
           class="<%= fullPath.contains("/OrderHistory") || currentPage.equals("/Ryan/RiwayatPesanan.jsp") ? "active" : "" %>">
            <i class="fa-solid fa-clock-rotate-left"></i>
            Riwayat Pesanan
        </a>

    </div>

    <!-- Footer -->
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/AuthController/logout"
           onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
            <i class="fa-solid fa-arrow-right-from-bracket"></i>
            Logout
        </a>

        <form id="logout-form"
              action="${pageContext.request.contextPath}/AuthController/logout"
              method="post"
              style="display:none;">
        </form>
    </div>

</div>

</body>
</html>
