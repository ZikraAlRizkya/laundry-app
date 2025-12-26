<%-- 
    Document   : Admin
    Created on : Dec 16, 2025, 11:52:36 AM
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
        <title>Admin Page</title>
    </head>
    <body>
        <%
            String currentPage = request.getServletPath();
        %>
        <div class="sidebar">

            <!-- Header -->
            <div class="sidebar-header">
                <h4>Admin Panel</h4>
                <span>Dashboard</span>
            </div>

            <!-- Menu -->
            <div class="sidebar-menu">
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
                    
        <nav class="navbar navbar-expand-lg" style="margin-left: 240px" >
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link" href="${pageContext.request.contextPath}/EditProfileAdminController?user_id=${user.id}">
                        <i class="fa-solid fa-house"></i>
                    </a>
                </div>
            </div>
            <i class="fa-regular fa-bell" style="margin-right: 30px"></i>
            <div class="ms-auto d-flex align-items-center" style="margin-right: 5px">
                <span class="navbar-text me-2">
                    <a class="nav-link d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/Zikra/ProfilAdmin.jsp">
                        <div class="text-white rounded-circle shadow d-flex justify-content-center align-items-center" style="width: 30px; height: 30px; background-color: #e9ecef; margin-right:10px">
                            <i class="fa-solid fa-user"></i>
                         </div>
                        ${userDetail.firstName}
                    </a>
                </span>
            </div>
        </div>
        </nav>    
        <!-- KONTEN UTAMA -->
        <div class="content" style="position: relative; padding-bottom: 80px;">
            <h1 style="color: white; margin-bottom:50px">Halaman Utama Admin</h1>
            
            <div class="container">
                <div class="row" style="margin-bottom:50px">
                    <div class="col-6 d-flex justify-content-start">
                        
                        <div style="width: 27rem;">
                            <a href="${pageContext.request.contextPath}/Aril/PesananBaruAdmin.jsp" style="text-decoration: none; color: inherit;">
                                <div class="card card-stats mb-4 mb-lg-0 shadow">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Jumlah Pesanan Baru</h5>
                                                <span class="h2 font-weight-bold mb-0">${userDetail.totalPesananBaruAdmin}</span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="bg-danger text-white rounded-circle shadow d-flex justify-content-center align-items-center" style="width: 50px; height: 50px">
                                                    <i class="fa-solid fa-star"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="mt-3 mb-0 text-muted text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Since last month</span>
                                        </p>
                                    </div>
                                </div>
                            </a>
                            
                        </div> 
                    </div>
                    <div class="col-6 d-flex justify-content-start">
                        <div style="width: 27rem;">
                            <a href="${pageContext.request.contextPath}/Aril/PesananDiterimaAdmin.jsp" style="text-decoration: none; color: inherit;">
                                <div class="card card-stats mb-4 mb-lg-0 shadow">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Jumlah Pesanan Diterima</h5>
                                                <span class="h2 font-weight-bold mb-0">${userDetail.totalDiterimaAdmin}</span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="bg-warning text-white rounded-circle shadow d-flex justify-content-center align-items-center" style="width: 50px; height: 50px">
                                                    <i class="fa-solid fa-basket-shopping"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="mt-3 mb-0 text-muted text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Since last month</span>
                                        </p>
                                    </div>
                                </div>
                            </a>                           
                        </div>
                    </div>
                </div>
                
                <div class="row" style="margin-bottom:50px">
                    <div class="col-6 d-flex justify-content-start">
                        
                        <div style="width: 27rem;">
                            <a href="${pageContext.request.contextPath}/Aril/PesananDiprosesAdmin.jsp" style="text-decoration: none; color: inherit;">
                                <div class="card card-stats mb-4 mb-lg-0 shadow">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Jumlah Pesanan Diproses</h5>
                                                <span class="h2 font-weight-bold mb-0">${userDetail.totalDiprosesAdmin}</span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="bg-primary text-white rounded-circle shadow d-flex justify-content-center align-items-center" style="width: 50px; height: 50px">
                                                    <i class="fa-solid fa-shirt"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="mt-3 mb-0 text-muted text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Since last month</span>
                                        </p>
                                    </div>
                                </div>
                            </a>                                                     
                        </div>
                    </div>
                    <div class="col-6 d-flex justify-content-start">
                        <div style="width: 27rem;">
                            <a href="${pageContext.request.contextPath}/Aril/PesananSiapDiambilAdmin.jsp" style="text-decoration: none; color: inherit;">
                                <div class="card card-stats mb-4 mb-lg-0 shadow">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Jumlah Pesanan Siap Diambil</h5>
                                                <span class="h2 font-weight-bold mb-0">${userDetail.totalSiapDiambilAdmin}</span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="bg-success text-white rounded-circle shadow d-flex justify-content-center align-items-center" style="width: 50px; height: 50px">
                                                    <i class="fa-solid fa-check"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="mt-3 mb-0 text-muted text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Since last month</span>
                                        </p>
                                    </div>
                                </div>
                            </a>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>