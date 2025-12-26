<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@ include file="/WEB-INF/includes/sidebarAdmin.jsp" %>
<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<!DOCTYPE html>
<html>
  <head>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    >
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
    >
    <meta charset="UTF-8">
    <title>Admin Page</title>

    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        background: #0b1220;
        color: #e5e7eb;
      }

      .navbar {
        background-color: #0f172a !important;
        border-bottom: 1px solid rgba(255,255,255,.08);
      }

      .navbar .nav-link,
      .navbar-text {
        color: #e5e7eb !important;
      }

      .wrap {
        max-width: 1000px;
        margin: 24px auto;
        padding: 0 16px;
      }

      .card {
        background: #111827;
        border: 1px solid rgba(255,255,255,.08);
        border-radius: 12px;
        padding: 16px;
        box-shadow: 0 10px 24px rgba(0,0,0,.35);
      }

      h1 {
        margin: 0;
        font-size: 20px;
        color: #fff;
      }

      .muted {
        color: #9ca3af;
        margin-top: 6px;
        font-size: 13px;
      }

      .toolbar {
        display: flex;
        justify-content: space-between;
        gap: 10px;
        flex-wrap: wrap;
        align-items: center;
        margin-top: 10px;
      }

      input[type="text"] {
        padding: 9px 10px;
        border: 1px solid rgba(255,255,255,.12);
        border-radius: 8px;
        background: #0b1220;
        color: #e5e7eb;
        width: 260px;
        outline: none;
      }

      input[type="text"]:focus {
        border-color: #3b82f6;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 12px;
      }

      th, td {
        padding: 10px;
        border-top: 1px solid rgba(255,255,255,.08);
        text-align: left;
        font-size: 14px;
      }

      th {
        background: rgba(255,255,255,.03);
        font-weight: 800;
        color: #cbd5e1;
      }

      .right {
        text-align: right;
      }

      .badge {
        display: inline-block;
        padding: 4px 10px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 800;
        border: 1px solid rgba(59,130,246,.35);
        background: rgba(59,130,246,.12);
        color: #93c5fd;
      }

      .btn {
        display: inline-block;
        padding: 9px 12px;
        border-radius: 8px;
        text-decoration: none;
        border: 1px solid rgba(255,255,255,.12);
        background: rgba(255,255,255,.04);
        color: #e5e7eb;
        font-weight: 800;
      }

      .btn:hover {
        background: rgba(255,255,255,.07);
      }

      .btn-primary {
        background: #2563eb;
        border-color: #2563eb;
        color: #fff;
      }

      .btn-primary:hover {
        background: #1d4ed8;
      }

      .empty {
        padding: 18px;
        color: #9ca3af;
        text-align: center;
      }

      .content {
        background-color: #111827;
        position: relative;
        padding: 40px 20px 80px;
      }
    </style>
  </head>

  <body>
    

    <%
      String currentStatus = "pending";
      String nextStatus = "received";

      String flash = null;
      String flashErr = null;

      if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");

        if ("move".equals(action)) {
          try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            try (Connection c = Aril.Model.DBConnection.getConnection();
                 PreparedStatement ps = c.prepareStatement(
                   "UPDATE orders SET status=? WHERE order_id=? AND status=?"
                 )) {

              ps.setString(1, nextStatus);
              ps.setInt(2, orderId);
              ps.setString(3, currentStatus);

              boolean ok = ps.executeUpdate() > 0;

              if (ok) {
                flash = "Status berhasil diubah: pending → received";
              } else {
                flash = "Gagal: data tidak ditemukan / status sudah berubah.";
              }
            }
          } catch (Exception e) {
            flashErr = "Error: " + e.getMessage();
          }
        }
      }

      List<Map<String, Object>> orders = new ArrayList<>();
      String err = null;

      try (Connection c = Aril.Model.DBConnection.getConnection();
           PreparedStatement ps = c.prepareStatement(
             "SELECT " +
             "o.order_id, " +
             "u.first_name, " +
             "u.last_name, " +
             "o.total_price, " +
             "o.status " +
             "FROM orders o " +
             "JOIN users u ON u.user_id = o.user_id " +
             "WHERE o.status=? " +
             "ORDER BY o.order_id DESC"
           )) {

        ps.setString(1, currentStatus);

        try (ResultSet rs = ps.executeQuery()) {
          while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("order_id", rs.getInt("order_id"));
            row.put("first_name", rs.getString("first_name"));
            row.put("last_name", rs.getString("last_name"));
            row.put("total_price", rs.getBigDecimal("total_price"));
            row.put("status", rs.getString("status"));
            orders.add(row);
          }
        }

      } catch (Exception e) {
        err = e.getMessage();
      }

      NumberFormat rupiah = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    %>

    <!-- KONTEN UTAMA -->
    <div class="content">
      <h1 class="mb-2">
        Pesanan Baru
        <span class="badge"><%= orders.size() %> pending</span>
      </h1>

      <div class="muted mb-4">
        Pesanan baru masuk (status: <b>pending</b>).
        Klik tombol untuk ubah ke <b>received</b>.
      </div>

      <% if (flash != null) { %>
        <div
          class="card"
          style="
            border-color: rgba(34,197,94,.35);
            background: rgba(34,197,94,.08);
            margin-bottom: 12px;
          "
        >
          <b>
            <i class="fa-solid fa-circle-check"></i>
            <%= flash %>
          </b>
        </div>
      <% } %>

      <% if (flashErr != null) { %>
        <div
          class="card"
          style="
            border-color: rgba(239,68,68,.35);
            background: rgba(239,68,68,.08);
            margin-bottom: 12px;
          "
        >
          <b>
            <i class="fa-solid fa-triangle-exclamation"></i>
            <%= flashErr %>
          </b>
        </div>
      <% } %>

      <div class="card">
        <div class="toolbar">
          <div></div>
          <input
            id="q"
            type="text"
            placeholder="Cari pelanggan..."
            onkeyup="filterTable()"
          >
        </div>

        <% if (err != null) { %>
          <div class="empty">
            DB error: <%= err %>
          </div>

        <% } else if (orders.isEmpty()) { %>
          <div class="empty">
            Belum ada pesanan dengan status <b>pending</b>.
          </div>

        <% } else { %>
          <table id="tbl">
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Pelanggan</th>
                <th class="right">Total</th>
                <th>Status</th>
                <th class="right">Aksi</th>
              </tr>
            </thead>

            <tbody>
              <% for (Map<String, Object> o : orders) { %>
                <tr>
                  <td><b>#<%= o.get("order_id") %></b></td>

                  <td>
                    <%= String.valueOf(o.get("first_name")) %>
                    <%= String.valueOf(o.get("last_name")) %>
                  </td>

                  <td class="right">
                    <%= rupiah.format(o.get("total_price")) %>
                  </td>

                  <td>
                    <span class="badge"><%= o.get("status") %></span>
                  </td>

                  <td class="right">
                    <form
                      method="post"
                      style="display:inline;"
                      onsubmit="return confirm('Ubah status pending → received?');"
                    >
                      <input type="hidden" name="action" value="move">
                      <input type="hidden" name="orderId" value="<%= o.get("order_id") %>">

                      <button class="btn btn-primary" type="submit">
                        <i class="fa-solid fa-check"></i>
                        Set Received
                      </button>
                    </form>
                  </td>
                </tr>
              <% } %>
            </tbody>
          </table>
        <% } %>
      </div>

      <script>
        function filterTable() {
          var q = document.getElementById("q").value.toLowerCase();
          var tbl = document.getElementById("tbl");

          if (!tbl) return;

          var rows = tbl.getElementsByTagName("tr");

          for (var i = 1; i < rows.length; i++) {
            var t = rows[i].innerText.toLowerCase();

            if (t.indexOf(q) > -1) {
              rows[i].style.display = "";
            } else {
              rows[i].style.display = "none";
            }
          }
        }
      </script>
    </div>
  </body>
</html>
