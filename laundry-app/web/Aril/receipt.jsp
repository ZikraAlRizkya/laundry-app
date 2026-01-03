<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.math.BigDecimal"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Receipt</title>

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    >

    <style>
      body {
        margin: 0;
        padding: 24px;
        background: #f5f7fb;
        font-family: Arial, sans-serif;
      }
      .card { border-radius: 14px; }
      .muted { color: #6b7280; font-size: 14px; }
    </style>
  </head>

  <body>
    <%
      Map<String, Object> order =
        (Map<String, Object>) request.getAttribute("order");

      String paymentMethod =
        (String) request.getAttribute("paymentMethod");

      NumberFormat rupiah =
        NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    %>

    <% if (order == null) { %>
      <div class="alert alert-danger">
        Data receipt tidak ada.
      </div>
    <% } else { %>

      <div class="card p-4">
        <h4 class="mb-1">Receipt</h4>
        <div class="muted mb-3">Bukti pembayaran & pengambilan.</div>

        <div class="row g-3">
          <div class="col-md-4">
            <div class="muted">Order ID</div>
            <div><b>#<%= order.get("order_id") %></b></div>
          </div>

          <div class="col-md-8">
            <div class="muted">Pelanggan</div>
            <div><b><%= order.get("customer") %></b></div>
          </div>

          <div class="col-md-4">
            <div class="muted">Total</div>
            <div><b><%= rupiah.format((BigDecimal) order.get("total_price")) %></b></div>
          </div>

          <div class="col-md-4">
            <div class="muted">Metode</div>
            <div><b><%= paymentMethod %></b></div>
          </div>

          <div class="col-md-4">
            <div class="muted">Status</div>
            <div><b><%= order.get("status") %></b></div>
          </div>
        </div>

        <hr>

        <div class="d-flex gap-2">
          <a class="btn btn-outline-secondary" href="<%= request.getContextPath() %>/pickup/list">
            Kembali ke List
          </a>

          <button class="btn btn-primary" onclick="window.print()">
            Print
          </button>
        </div>
      </div>

    <% } %>
  </body>
</html>
