<%-- 
    Document   : ProfilAdmin
    Created on : Dec 20, 2025, 2:57:28 PM
    Author     : Muhammad Zikra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
        <title>Profil Page</title>
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
        <!-- KONTEN UTAMA -->
        <div class="content" style="position: relative; padding-bottom: 80px;">
            <h1 style="color: white; margin-bottom:5px">Halaman Profil</h1>
            <h5 style="color: white; margin-bottom:30px">Halo ${userDetail.firstName}!</h5>
            <div class="card">
                <div class="card-body">
                    <form action="editProfile" method="post">
                        <input type="hidden" name="user_id" value="${userDetail.id}">
                        
                    <h4 class="card-title">
                        Edit Profile
                        <button type="submit" class="btn btn-primary float-end">Edit</button>
                    </h4>
                    <hr style="border: 0; border-top: 1px solid #666; width: 100%; margin-top: 25px">
                    <p class="card-text">User Information</p>
                    <div> 
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="exampleFormControlInput1" class="form-label">First Name</label>
                                        <input type="text" class="form-control" name="first_name" value="${userDetail.firstName}">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="exampleFormControlInput1" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" name="last_name" value="${userDetail.lastName}">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="exampleFormControlInput1" class="form-label">City</label>
                                        <input type="text" class="form-control" name="city" value="${userDetail.city}">
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="exampleFormControlInput1" class="form-label">Birth Date</label>
                                        <input type="text" class="form-control" name="birth_date" value="${userDetail.birthDate}" onfocus="this.type='date'">
                                    </div>    
                                </div>
                            </div>
                        </div>
                        <hr style="border: 0; border-top: 1px solid #999; width: 100%;">

                        <p class="card-text">Contact Information</p>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">Phone Number</label>
                                            <input type="tel" class="form-control" name="phone" value="${userDetail.phoneNumber}">
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">Role</label>
                                            <input class="form-control" type="text" value="${userDetail.role}" aria-label="Disabled input example" disabled readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="mb-3">
                                            <label for="exampleFormControlInput1" class="form-label">Email address</label>
                                            <input type="email" class="form-control" name="email" value="${userDetail.email}">
                                        </div>
                                    </div>
                                    <div class="col">

                                        <div class="mb-3">
                                            <label class="form-label">Password</label>
                                            <div style="position: relative;">
                                                <input id="passwordField" class="form-control" type="password" value="${userDetail.password}" disabled>
                                                <span onclick="togglePassword()" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">
                                                    <i id="eyeIcon" class="fa-solid fa-eye"></i>
                                                </span>
                                            </div>
                                        </div>

                                        <script>
                                        function togglePassword() {
                                            const input = document.getElementById("passwordField");
                                            const icon = document.getElementById("eyeIcon");

                                            if (input.type === "password") {
                                                input.type = "text";
                                                icon.classList.remove("fa-eye");
                                                icon.classList.add("fa-eye-slash");
                                            } else {
                                                input.type = "password";
                                                icon.classList.remove("fa-eye-slash");
                                                icon.classList.add("fa-eye");
                                            }
                                        }
                                        </script>    
                                    </div>
                                </div>
                            </div>
                            <hr style="border: 0; border-top: 1px solid #999; width: 100%;">

                    </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
