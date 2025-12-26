<%-- 
    Document   : Admin
    Created on : Dec 16, 2025, 11:52:36 AM
    Author     : Muhammad Zikra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/sidebarAdmin.jsp" %>
<%@ include file="/WEB-INF/includes/navbar.jsp" %>
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
         
        <!-- KONTEN UTAMA -->
        <div class="content" style="position: relative; padding-bottom: 80px;">
            <%
                java.time.LocalTime now = java.time.LocalTime.now();
                int hour = now.getHour();
                String greeting;

                if (hour >= 5 && hour < 11) {
                    greeting = "Selamat Pagi";
                } else if (hour >= 11 && hour < 15) {
                    greeting = "Selamat Siang";
                } else if (hour >= 15 && hour < 18) {
                    greeting = "Selamat Sore";
                } else {
                    greeting = "Selamat Malam";
                }
            %>
            <h1 style="color: white; margin-bottom:50px; font-size:28px">
                <%= greeting %>, ${user.firstName}
            </h1>
            
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