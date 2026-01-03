<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.math.BigDecimal"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Pickup List</title>

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
    <div class="d-flex align-items-center justify-content-between mb-3">
      <h3 class="m-0">Laundry Admin</h3>

      <a class="btn btn-outline-primary" href="<%= request.getContextPath() %>/pickup/list">
        Refresh
      </a>
    </div>

    <div class="card p-4">
      <h5 class="mb-1">Daftar Pesanan Siap Diambil</h5>
      <div class="muted mb-3">
        Status: <b>ready to taken</b>
      </div>

      <%
        List<Map<String, Object>> orders =
          (List<Map<String, Object>>) request.getAttribute("orders");

        NumberFormat rupiah =
          NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
      %>

      <% if (orders == null || orders.isEmpty()) { %>
        <div class="text-center text-muted py-4">
          Belum ada data (atau belum ada pesanan status <b>ready to taken</b>).
        </div>
      <% } else { %>
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Pelanggan</th>
                <th class="text-end">Total</th>
                <th>Status</th>
                <th class="text-end">Aksi</th>
              </tr>
            </thead>

            <tbody>
              <% for (Map<String, Object> o : orders) { %>
                <tr>
                  <td><b>#<%= o.get("order_id") %></b></td>
                  <td><%= o.get("customer") %></td>
                  <td class="text-end">
                    <%= rupiah.format((BigDecimal) o.get("total_price")) %>
                  </td>
                  <td>
                    <span class="badge bg-secondary"><%= o.get("status") %></span>
                  </td>
                  <td class="text-end">
                    <a
                      class="btn btn-primary btn-sm"
                      href="<%= request.getContextPath() %>/pickup/form?id=<%= o.get("order_id") %>"
                    >
                      Proses
                    </a>
                  </td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>
      <% } %>
    </div>
  </body>
</html>
