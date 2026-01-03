<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Fauzan.Model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Fauzan/Login.jsp");
        return;
    }
%>

<%@ include file="/WEB-INF/includes/sidebarUser.jsp" %>
<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Buat Pesanan</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>

<body>

<!-- ================= CONTENT ================= -->
<div class="content" style="padding-bottom:80px">

    <h1 style="color:white; margin-bottom:40px">Buat Pesanan</h1>

    <div class="no-hover">
        <div class="card">
            <div class="card-body">

                <h4 class="card-title">Form Pesanan</h4>

                <form action="${pageContext.request.contextPath}/CreateOrder" method="post">

                    <!-- LAYANAN -->
                    <div class="mb-3">
                        <label class="form-label">Layanan</label>
                        <select id="layanan" class="form-select" onchange="loadJenis()" required>
                            <option value="">-- Pilih Layanan --</option>
                            <option value="Regular">Regular</option>
                            <option value="Ekspres">Ekspres</option>
                        </select>
                    </div>

                    <!-- JENIS -->
                    <div class="mb-3">
                        <label class="form-label">Jenis Cucian</label>
                        <select name="service_id" id="jenis" class="form-select" onchange="hitung()" required>
                            <option value="">-- Pilih Jenis Cucian --</option>
                        </select>
                    </div>

                    <!-- BERAT -->
                    <div class="mb-3">
                        <label class="form-label">Berat (kg)</label>
                        <input type="number" step="0.1" name="quantity" id="qty"
                               class="form-control" oninput="hitung()" required>
                    </div>

                    <!-- TOTAL -->
                    <div class="mb-4">
                        <strong>Total Harga:</strong>
                        <span id="total" class="text-success ms-2">Rp 0</span>
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="fa-solid fa-paper-plane"></i> Pesan
                    </button>

                </form>

            </div>
        </div>
    </div>
</div>

<!-- ================= SCRIPT ================= -->
<script>
function loadJenis() {
    const layanan = document.getElementById("layanan").value;
    const jenis = document.getElementById("jenis");
    const total = document.getElementById("total");

    jenis.innerHTML = "";
    jenis.appendChild(new Option("-- Pilih Jenis Cucian --", ""));
    total.innerHTML = "Rp 0";

    if (!layanan) return;

    fetch("${pageContext.request.contextPath}/GetJenisCucian?layanan=" + encodeURIComponent(layanan))
        .then(res => res.text())
        .then(html => jenis.insertAdjacentHTML("beforeend", html));
}

function hitung() {
    const serviceId = document.getElementById("jenis").value;
    const qty = document.getElementById("qty").value;

    if (!serviceId || !qty) {
        document.getElementById("total").innerHTML = "Rp 0";
        return;
    }

    fetch("${pageContext.request.contextPath}/CalculatePrice?service_id=" + serviceId + "&quantity=" + qty)
        .then(res => res.text())
        .then(total => {
            document.getElementById("total").innerHTML =
                "Rp " + Number(total).toLocaleString("id-ID");
        });
}
</script>

</body>
</html>
