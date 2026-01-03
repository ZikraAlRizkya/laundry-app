<%-- 
    Document   : navbar
    Created on : Dec 26, 2025, 7:19:41 PM
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
        <nav class="navbar navbar-expand-lg" style="margin-left: 240px" >
        <div class="container-fluid">
            <div class="ms-auto d-flex align-items-center" style="margin-right: 5px">
                <i class="fa-regular fa-bell" style="margin-right: 30px"></i>
                <span class="navbar-text me-2">
                    <a class="nav-link d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/${user.role eq 'user' ? 'EditProfileUserController' : 'EditProfileAdminController'}?user_id=${user.id}">
                        <div class="text-white rounded-circle shadow d-flex justify-content-center align-items-center" style="width: 30px; height: 30px; background-color: #e9ecef; margin-right:10px">
                            <i class="fa-solid fa-user"></i>
                         </div>
                        ${user.firstName}
                    </a>
                </span>
            </div>
        </div>
        </nav>    
    </body>
</html>
