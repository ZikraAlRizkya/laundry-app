<%-- 
    Document   : Laporan
    Created on : Dec 20, 2025, 2:59:44 PM
    Author     : Muhammad Zikra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/sidebarAdmin.jsp" %>
<%@include file="/WEB-INF/includes/navbar.jsp" %>
<%@page import="java.sql.*,Zikra.Controller.DBConnection,Zikra.Model.Laporan" %>
<%@page import="com.google.gson.Gson"%>

<%  DBConnection db = new DBConnection(); 
    int no = 1;
    if(db.isConnected){
        try{
            String sql = "SELECT CONCAT(u.first_name, ' ',u.last_name) as nama, "
                + "COUNT(o.order_id)as jumlah_pesanan "
                + "from orders o "
                + "left join users u on u.user_id = o.user_id "
                + "group by u.user_id "
                + "order by jumlah_pesanan DESC "
                + "limit 5";
            ResultSet rs = db.getData(sql);

%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    .custom-card {
        position: relative;
        overflow: hidden;
        border: none;
        min-height: 150px;
        color: white; /* Default teks putih untuk card berwarna */
        margin-bottom: 20px;
    }

    .card-icon-bg {
        position: absolute;
        right: -10px;
        bottom: -20px;
        font-size: 4rem;
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
            <h1 style="color: white; margin-bottom:50px">Laporan & Statistik</h1>

            <div class="row">
                <div class="col-md-3">
                    <div class="card custom-card bg-teal shadow">
                        <div class="card-body">
                            <div class="d-flex justify-content-between"><h6>TOTAL PELANGGAN</h6></div>
                            <h2 class="mb-0">${userDetail.totalPelanggan}</h2>
                            <div class="card-icon-bg"><i class="fa-solid fa-users"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card custom-card bg-white shadow">
                        <div class="card-body">
                            <div class="d-flex justify-content-between"><h6>TOTAL PESANAN</h6></div>
                            <h2 class="mb-0">${userDetail.totalPesanan}</h2>
                            <div class="card-icon-bg"><i class="fa-solid fa-box-open"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">

                    <div class="card custom-card bg-teal shadow">
                        <div class="card-body">
                            <div class="d-flex justify-content-between"><h6>TOTAL PENDAPATAN</h6></div>
                            <h5 class="mb-0"><span id="txtPendapatan"></span></h5>
                            <div class="card-icon-bg"><i class="fa-solid fa-sack-dollar"></i></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">

                    <div class="card custom-card bg-teal shadow">
                        <div class="card-body">
                            <div class="d-flex justify-content-between"><h6>RATA RATA</h6></div>
                            <h5 class="mb-0"><span id="txtRatarata"></span></h5>
                            <div class="card-icon-bg"><i class="fa-solid fa-chart-line"></i></div>
                        </div>
                    </div>
                </div>
            </div>
        <div class="card">
            <canvas id="lineChart"></canvas>
        </div>
        <div class="row" style="margin-bottom:50px">
            <div class="col-6">
                <div class="card h-100">
                    <h5 class="card-header" style="font-weight:bold">Top 5 Best Customer</h5>
                    <div class="table-responsive">
                        <table id="tbl" class="table">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama Pelanggan</th>
                                    <th>Jumlah Pemesanan</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                            while (rs.next()) {

                                %>
                                <tr>
                                    <td><%= "#" + no++%></td>
                                    <td><%= rs.getString("nama")%></td>
                                    <td><%= rs.getInt("jumlah_pesanan")%></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="card h-100 d-flex align-items-center justify-content-center">
                    <div style="width:80%; height:80%;">
                        <canvas id="pieChart" style="max-height:100%; max-width:100%"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <canvas id="barChart"></canvas>
        </div>
<%
        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            db.disconnect();
                }
            }  %>
</div>
        </body>
    <%
    Laporan userDetail = (Laporan) session.getAttribute("userDetail");
    Gson gson = new Gson();
    String dates = gson.toJson(userDetail.getDate());
    String totalsDates = gson.toJson(userDetail.getTotalOrderDate());
    String cities = gson.toJson(userDetail.getCity());
    String totalsCities = gson.toJson(userDetail.getTotalOrderCity()); 
    String services = gson.toJson(userDetail.getService());
    String totalsServices = gson.toJson(userDetail.getTotalOrderService());
    %>
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
    
    const lc = document.getElementById('lineChart').getContext('2d');
    const lineChart = new Chart(lc, {
        type: 'line', // Bisa diganti 'line', 'pie', 'bar'
        data: {
            labels: <%= dates %>, // Data dari Java
            datasets: [{
                label: 'Total Pendapatan per Tanggal',
                data: <%= totalsDates %>, // Data angka dari Java
                fill: false,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                tension: 0.1
            }]
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: 'Total Pendapatan Harian', // judul chart
                    font: {
                        size: 18,
                        weight: 'bold'
                    },
                    color: '#00c8ff' // warna teks judul
                }
            }
        }
    });
    
    const pc = document.getElementById('pieChart').getContext('2d');
    const pieChart = new Chart(pc, {
        type: 'pie', // Bisa diganti 'line', 'pie', 'bar'
        data: {
            labels: <%= services %>, // Data dari Java
            datasets: [{
                label: 'Total Pesanan per Service',
                data: <%= totalsServices %>, // Data angka dari Java
                backgroundColor: ['rgba(255, 99, 132, 0.6)',
                                'rgba(54, 162, 235, 0.6)'],
                borderColor: ['rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)'],
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: 'Total Pesanan per Service', // judul chart
                    font: {
                        size: 18,
                        weight: 'bold'
                    },
                    color: '#00c8ff' // warna teks judul
                }
            }
        }
    });
    
    const bc = document.getElementById('barChart').getContext('2d');
    const barChart = new Chart(bc, {
        type: 'bar', // Bisa diganti 'line', 'pie', 'bar'
        data: {
            labels: <%= cities %>, // Data dari Java
            datasets: [{
                label: 'Total Pesanan per Kota',
                data: <%= totalsCities %>, // Data angka dari Java
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: 'Total Pesanan per Kota', // judul chart
                    font: {
                        size: 18,
                        weight: 'bold'
                    },
                    color: '#00c8ff' // warna teks judul
                }
            }
        }
    });
    
    </script>
</html>
