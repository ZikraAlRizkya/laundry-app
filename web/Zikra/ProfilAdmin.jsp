<%-- 
    Document   : ProfilAdmin
    Created on : Dec 20, 2025, 2:57:28 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
        <title>Profil Page</title>
    </head>
    <body>
        
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
