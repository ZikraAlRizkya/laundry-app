<%-- 
    Document   : sidebarAdmin
    Created on : Dec 26, 2025, 7:31:12 PM
    Author     : Muhammad Zikra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String currentPage = request.getServletPath();
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
                <a href="${pageContext.request.contextPath}/LaporanController?user_id=${user.id}" class="<%= currentPage.equals("/Zikra/Admin.jsp") ? "active" : "" %>">
                    <i class="fa-solid fa-house"></i>
                    Home
                </a>
                    
                <a href="${pageContext.request.contextPath}/EditProfileAdminController?user_id=${user.id}" class="<%= currentPage.equals("/Zikra/ProfilAdmin.jsp") ? "active" : "" %>">
                    <i class="fa-solid fa-user"></i>
                    Profil
                </a>

                <a href="${pageContext.request.contextPath}/Fauzan/ManajemenPelanggan.jsp" class="<%= currentPage.equals("/Fauzan/ManajemenPelanggan.jsp") ? "active" : "" %>">
                    <i class="fa-solid fa-basket-shopping"></i>
                    Manajemen Pelanggan
                </a>

                <a href="${pageContext.request.contextPath}/Agung/ManajemenLayanan.jsp" class="<%= currentPage.equals("/Agung/ManajemenLayanan.jsp") ? "active" : "" %>">
                    <i class="fa-solid fa-clock-rotate-left"></i>
                    Manajemen Layanan
                </a>

                <a href="${pageContext.request.contextPath}/LaporanStatistikController?user_id=${user.id}" class="<%= currentPage.equals("/Zikra/Laporan.jsp") ? "active" : "" %>">
                    <i class="fa-solid fa-file-lines"></i>
                    Laporan & Statistik
                </a>
            </div>

            <!-- Footer -->
            <div class="sidebar-footer">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    Logout
                </a>
            </div>
        </div>
    </body>
</html>
