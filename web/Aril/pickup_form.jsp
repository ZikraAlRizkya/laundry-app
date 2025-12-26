<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.math.BigDecimal"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Pickup Form</title>

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

      String error =
        (String) request.getAttribute("error");

      NumberFormat rupiah =
        NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    %>

    <div class="mb-3">
      <a class="btn btn-outline-secondary" href="<%= request.getContextPath() %>/pickup/list">
        ← Kembali
      </a>
    </div>

    <% if (order == null) { %>
      <div class="alert alert-danger">
        Data order tidak ada.
      </div>
    <% } else { %>

      <div class="card p-4">
        <h5 class="mb-1">Konfirmasi Pembayaran & Pengambilan</h5>
        <div class="muted mb-3">Pastikan order benar sebelum confirm.</div>

        <% if (error != null) { %>
          <div class="alert alert-danger">
            <b>Error:</b> <%= error %>
          </div>
        <% } %>

        <div class="row g-3 mb-3">
          <div class="col-md-3">
            <div class="muted">Order ID</div>
            <div><b>#<%= order.get("order_id") %></b></div>
          </div>

          <div class="col-md-5">
            <div class="muted">Pelanggan</div>
            <div><b><%= order.get("customer") %></b></div>
          </div>

          <div class="col-md-4">
            <div class="muted">Total</div>
            <div>
              <b><%= rupiah.format((BigDecimal) order.get("total_price")) %></b>
            </div>
          </div>
        </div>

        <form
          method="post"
          action="<%= request.getContextPath() %>/pickup/confirm"
          onsubmit="return confirm('Confirm pembayaran & set status menjadi done?');"
        >
          <input
            type="hidden"
            name="orderId"
            value="<%= order.get("order_id") %>"
          >

          <div class="mb-3">
            <label class="form-label">Metode Pembayaran</label>
            <select class="form-select" name="paymentMethod" required>
              <option value="cash">Cash</option>
              <option value="transfer">Transfer</option>
              <option value="qris">QRIS</option>
            </select>
          </div>

          <button class="btn btn-primary" type="submit">
            Confirm & Selesai
          </button>
        </form>
      </div>

    <% } %>
  </body>
</html>
