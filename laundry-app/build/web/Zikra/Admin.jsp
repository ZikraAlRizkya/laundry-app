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
        <style>
    .custom-card {
        position: relative;
        overflow: hidden;
        border: none;
        min-height: 150px;
        color: white;
        margin-bottom: 20px;
    }

    .card-icon-bg {
        position: absolute;
        right: -10px;
        bottom: -20px;
        font-size: 6rem;
        opacity: 0.2;
    }
    
    .bg-teal {
        background-color: #2c8ea1;
    }
    .text-teal {
        color: #2c8ea1 !important;
    }
        </style>
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
            
            <div class="row">
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/Aril/PesananBaruAdmin.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card custom-card shadow" style="background: linear-gradient(135deg, #1e293b 0%, #475569 100%); border: none; color: #fff; border-radius: 15px;">
                            <div class="card-body">
                                <div class="d-flex justify-content-between"><h6>TOTAL PESANAN BARU</h6></div>
                                <h1 class="display-4">${userDetail.totalPesananBaruAdmin}</h1>
                                <div class="card-icon-bg"><i class="fa-solid fa-box"></i></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/Aril/PesananDiterimaAdmin.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card custom-card shadow" style="background: linear-gradient(135deg, #1e293b 0%, #475569 100%); border: none; color: #fff; border-radius: 15px;">
                            <div class="card-body">
                                <div class="d-flex justify-content-between"><h6>TOTAL PESANAN DITERIMA</h6></div>
                                <h1 class="display-4">${userDetail.totalDiterimaAdmin}</h1>
                                <div class="card-icon-bg"><i class="fa-solid fa-circle-check"></i></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/Aril/PesananDiprosesAdmin.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card custom-card shadow" style="background: linear-gradient(135deg, #1e293b 0%, #475569 100%); border: none; color: #fff; border-radius: 15px;">
                            <div class="card-body">
                                <div class="d-flex justify-content-between"><h6>TOTAL PESANAN DIPROSES</h6></div>
                                <h1 class="display-4">${userDetail.totalDiprosesAdmin}</h1>
                                <div class="card-icon-bg"><i class="fa-solid fa-clock"></i></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/Aril/PesananSiapDiambilAdmin.jsp" style="text-decoration: none; color: inherit;">
                        <div class="card custom-card shadow" style="background: linear-gradient(135deg, #1e293b 0%, #475569 100%); border: none; color: #fff; border-radius: 15px;">
                            <div class="card-body">
                                <div class="d-flex justify-content-between"><h6>TOTAL PESANAN SIAP DIAMBIL</h6></div>
                                <h1 class="display-4">${userDetail.totalSiapDiambilAdmin}</h1>
                                <div class="card-icon-bg"><i class="fa-solid fa-dolly"></i></div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>