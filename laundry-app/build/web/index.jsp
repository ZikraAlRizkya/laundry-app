<%-- 
    Document   : index
    Created on : Dec 14, 2025, 6:13:12 PM
    Author     : Muhammad Zikra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Laundry Service</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e5e7eb;

            /* Background gradient */
            background:
                radial-gradient(circle at top left, #1e3a8a, transparent 40%),
                radial-gradient(circle at bottom right, #0ea5e9, transparent 35%),
                linear-gradient(135deg, #020617, #0f172a);
        }

        .hero {
            max-width: 760px;
            padding: 54px 44px;
            text-align: center;
            background: rgba(255,255,255,0.06);
            border-radius: 20px;
            border: 1px solid rgba(255,255,255,0.1);
            box-shadow: 0 35px 70px rgba(0,0,0,0.6);
            backdrop-filter: blur(14px);
        }

        .hero-icon {
            font-size: 64px;
            color: #60a5fa;
            margin-bottom: 18px;
        }

        .hero h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 14px;
            color: #f8fafc;
        }

        .hero p {
            font-size: 16px;
            color: #cbd5f5;
            line-height: 1.75;
            margin-bottom: 36px;
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 42px;
        }

        .step {
            background: rgba(255,255,255,0.08);
            border-radius: 14px;
            padding: 20px;
            border: 1px solid rgba(255,255,255,0.12);
            transition: transform .25s ease;
        }

        .step:hover {
            transform: translateY(-4px);
        }

        .step i {
            font-size: 22px;
            color: #93c5fd;
            margin-bottom: 10px;
        }

        .step h4 {
            margin: 6px 0;
            font-size: 15px;
            font-weight: 700;
            color: #fff;
        }

        .step span {
            font-size: 13px;
            color: #cbd5f5;
        }

        .btn-start {
            display: inline-block;
            padding: 15px 36px;
            border-radius: 999px;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #fff;
            text-decoration: none;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 15px 35px rgba(59,130,246,0.55);
        }

        .btn-start:hover {
            transform: translateY(-3px);
            box-shadow: 0 25px 50px rgba(59,130,246,0.8);
        }

        footer {
            margin-top: 28px;
            font-size: 12px;
            color: #94a3b8;
        }

        @media (max-width: 768px) {
            .steps {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <div class="hero">
        <div class="hero-icon">
            <h1>
                <i class="fa-brands fa-opencart"></i>
                WashUp
            </h1>
        </div>

        <h2 style="font-size: 30px">Laundry Jadi Lebih Mudah</h2>
        <p>
            Tidak perlu ribet mencuci sendiri.  
            Cukup antar pakaian Anda, kami yang urus hingga bersih, rapi, dan siap dipakai.
        </p>

        <div class="steps">
            <div class="step">
                <i class="fa-solid fa-bag-shopping"></i>
                <h4>Antar Pakaian</h4>
                <span>Bawa cucian Anda ke laundry kami</span>
            </div>

            <div class="step">
                <i class="fa-solid fa-water"></i>
                <h4>Kami Proses</h4>
                <span>Cuci, keringkan, dan setrika dengan rapi</span>
            </div>

            <div class="step">
                <i class="fa-solid fa-shirt"></i>
                <h4>Siap Dipakai</h4>
                <span>Pakaian bersih & wangi kembali ke Anda</span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/Fauzan/Login.jsp" class="btn-start">
            Get Started
        </a>

        <footer>
            © 2025 Laundry Service · Bersih · Cepat · Terpercaya
        </footer>
    </div>

</body>
</html>

