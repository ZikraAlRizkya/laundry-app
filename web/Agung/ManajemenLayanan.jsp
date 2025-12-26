<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Agung.Model.AdminServiceDAO.OrderResult"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <style>
            /* Tambahan CSS internal sedikit untuk merapikan layout utama tanpa ganggu file style.css */
            .main-content {
                margin-left: 240px; /* Menyesuaikan lebar sidebar */
                padding: 20px;
                min-height: 100vh;
                transition: all 0.3s;
            }
            
            /* Agar card tidak saling tempel */
            .card {
                margin-bottom: 20px;
                padding: 20px;
                border: none;
                box-shadow: 0 0 10px rgba(0,0,0,0.1); /* Opsional: Biar lebih cantik */
                border-radius: 8px;
            }

            /* Responsif untuk layar kecil (Mobile) */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0; /* Di HP margin hilang agar full screen */
                }
                .navbar {
                    margin-left: 0 !important; /* Navbar juga full screen di HP */
                }
            }
        </style>
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
                <a href="${pageContext.request.contextPath}/Zikra/ProfilAdmin.jsp" class="<%= currentPage.equals("/Zikra/ProfilAdmin.jsp") ? "active" : "" %>">
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

                <a href="${pageContext.request.contextPath}/LaporanController?user_id=${user.id}" class="<%= currentPage.equals("/Zikra/Laporan.jsp") ? "active" : "" %>">
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
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="margin-left: 240px" >
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link" href="${pageContext.request.contextPath}/LaporanController?user_id=${user.id}">
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

        <div class="main-content">
            <div class="container-fluid"> <h2 class="mb-4">Dashboard Admin Laundry</h2>

                <% 
                    String msg = (String) request.getAttribute("message");
                    String type = (String) request.getAttribute("messageType");
                    if (msg != null) {
                %>
                    <div class="alert <%= type.equals("success") ? "alert-success" : "alert-danger" %> alert-dismissible fade show" role="alert">
                        <%= msg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <div class="row">
                    
                    <div class="col-12 mb-4"> <div class="card">
                            <h3 class="card-title">Update Harga Layanan</h3>
                            <p class="text-muted">Silakan masukkan ID Layanan dan Harga Baru.</p>
                            
                            <form action="${pageContext.request.contextPath}/ServletAgung" method="POST" class="row g-3 align-items-end">
                                <input type="hidden" name="action" value="updateHarga">
                                
                                <div class="col-md-5">
                                    <label class="form-label">Pilih Layanan (ID):</label>
                                    <select name="service_id" class="form-select" required>
                                        <option value="1">Cuci Reguler (ID: 1)</option>
                                        <option value="2">Cuci Kilat (ID: 2)</option>
                                        <option value="3">Setrika Saja (ID: 3)</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-5">
                                    <label class="form-label">Harga Baru (Rp):</label>
                                    <input type="number" name="price" class="form-control" placeholder="Contoh: 7000" required step="500">
                                </div>
                                
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100">Simpan</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="card">
                            <h3 class="card-title mb-3">Cari Pesanan</h3>
                            
                            <form action="${pageContext.request.contextPath}/ServletAgung" method="GET" class="row g-2 mb-4">
                                <div class="col-md-8">
                                    <input type="text" name="keyword" class="form-control" placeholder="Cari ID Order atau Nama Layanan (Contoh: Kilat)...">
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-success w-100">Cari</button>
                                </div>
                                <div class="col-md-2">
                                    <a href="${pageContext.request.contextPath}/ServletAgung" class="btn btn-secondary w-100">Reset</a>
                                </div>
                            </form>

                            <div class="table-responsive">
                                <table class="table table-striped table-hover table-bordered">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Nama Pelanggan</th>
                                            <th>Layanan</th>
                                            <th>Status Order</th>
                                            <th>Subtotal (Rp)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<OrderResult> list = (List<OrderResult>) request.getAttribute("listPesanan");
                                            
                                            if (list != null && !list.isEmpty()) {
                                                for (OrderResult row : list) {
                                        %>
                                        <tr>
                                            <td><%= row.orderId %></td>
                                            <td><%= row.customerName %></td>
                                            <td><%= row.namaLayanan %></td>
                                            <td>
                                                <span class="badge bg-info text-dark"><%= row.status %></span>
                                            </td>
                                            <td><%= String.format("%,.0f", row.subtotal) %></td>
                                        </tr>
                                        <% 
                                                } 
                                            } else { 
                                        %>
                                        <tr>
                                            <td colspan="5" class="text-center py-3">Tidak ada data ditemukan.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div> </div>
                    </div>
                </div> </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>