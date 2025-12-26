<%-- 
    Document   : Laporan
    Created on : Dec 20, 2025, 2:59:44 PM
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
        <style>
            .card .card-title {
  font-size: 13px;   /* judul kecil */
  font-weight: 600;
}

.card .h2 {
  font-size: 18px;   /* angka utama lebih kecil */
}

.card p {
  font-size: 12px;   /* deskripsi bawah */
}

        </style>
    </head>
    <body>
        <!-- KONTEN UTAMA -->
        <div class="content" style="position: relative; padding-bottom: 80px;">
            <h1 style="color: white; margin-bottom:50px">Laporan & Statistik</h1>

            <div class="container">
                <div class="row" style="margin-bottom:50px">
                    <div class="col-xl-3 col-lg-6">
                        <div class="card card-stats mb-4 mb-xl-0 shadow border-0">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <span class="h2 font-weight-bold mb-0 text-danger">${userDetail.totalPelanggan}</span>
                                        <h5 class="card-title text-muted mb-0" style="font-size: 0.8rem;">Total Pelanggan</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="text-danger" style="font-size: 1.5rem;">
                                            <i class="fa-solid fa-user"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-lg-6">
                        <div class="card card-stats mb-4 mb-xl-0 shadow border-0">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <span class="h2 font-weight-bold mb-0 text-warning">${userDetail.totalPesanan}</span>
                                        <h5 class="card-title text-muted mb-0" style="font-size: 0.8rem;">Total Pesanan</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="text-warning" style="font-size: 1.5rem;">
                                            <i class="fa-solid fa-basket-shopping"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-lg-6">
                        <div class="card card-stats mb-4 mb-xl-0 shadow border-0">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <span id="txtPendapatan" class="h2 font-weight-bold mb-0 text-success"></span>
                                        <h5 class="card-title text-muted mb-0" style="font-size: 0.8rem;">Total Pendapatan</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="text-success" style="font-size: 1.5rem;">
                                            <i class="fa-solid fa-sack-dollar"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-lg-6">
                        <div class="card card-stats mb-4 mb-xl-0 shadow border-0">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <span id="txtRatarata" class="h2 font-weight-bold mb-0 text-info"></span>
                                        <h5 class="card-title text-muted mb-0" style="font-size: 0.8rem;">Rata Rata Pendapatan</h5>
                                    </div>
                                    <div class="col-auto">
                                        <div class="text-info" style="font-size: 1.5rem;">
                                            <i class="fa-solid fa-money-bill-trend-up"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
    // Pastikan angka ini tidak mengandung karakter non-angka
    let rawData = ${userDetail.totalPendapatan}; 
    let rawData2 = ${userDetail.rataRataPendapatanPerHari};
    
    // Format ke Rupiah menggunakan JavaScript murni
    document.getElementById('txtPendapatan').innerText = new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0
    }).format(rawData);
    
    document.getElementById('txtRatarata').innerText = new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    }).format(rawData2);
</script>
</html>
