package Ryan.Controller;

import Fauzan.Controller.DBConnection;
import Fauzan.Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet(urlPatterns = {
    "/CreateOrder",
    "/MyOrders",
    "/OrderHistory"
})
public class OrderController extends HttpServlet {

    // =====================================================
    // GET : MY ORDERS & ORDER HISTORY
    // =====================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ===== AUTH GUARD =====
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"user".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = user.getId();
        String path = request.getServletPath();

        try (Connection con = DBConnection.getConnection()) {

            // =================================================
            // PESANAN SAYA (7 HARI TERAKHIR)
            // =================================================
            if ("/MyOrders".equals(path)) {

                List<Map<String, Object>> list = new ArrayList<>();

                String sql =
                    "SELECT o.order_id, o.order_date, o.status, o.total_price, " +
                    "IFNULL(p.payment_status,'unpaid') payment_status " +
                    "FROM orders o " +
                    "LEFT JOIN payments p ON o.order_id = p.order_id " +
                    "WHERE o.user_id = ? " +
                    "AND o.order_date >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                    "ORDER BY o.order_date DESC";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("orderId", rs.getInt("order_id"));
                        row.put("orderDate", rs.getTimestamp("order_date"));
                        row.put("status", rs.getString("status"));
                        row.put("paymentStatus", rs.getString("payment_status"));
                        row.put("totalPrice", rs.getDouble("total_price"));
                        list.add(row);
                    }
                }

                request.setAttribute("myOrders", list);
                request.getRequestDispatcher("/Ryan/PesananSaya.jsp")
                       .forward(request, response);
            }

            // =================================================
            // RIWAYAT PESANAN (SEMUA)
            // =================================================
            else if ("/OrderHistory".equals(path)) {

                List<Map<String, Object>> list = new ArrayList<>();

                String sql =
                    "SELECT o.order_id, o.order_date, o.status, o.total_price, " +
                    "s.layanan, s.jenis_cucian, d.quantity, d.price, d.subtotal " +
                    "FROM orders o " +
                    "JOIN order_details d ON o.order_id = d.order_id " +
                    "JOIN services s ON d.service_id = s.service_id " +
                    "WHERE o.user_id = ? " +
                    "ORDER BY o.order_date DESC";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        Map<String, Object> row = new HashMap<>();
                        row.put("orderId", rs.getInt("order_id"));
                        row.put("orderDate", rs.getTimestamp("order_date"));
                        row.put("status", rs.getString("status"));
                        row.put("totalPrice", rs.getDouble("total_price"));
                        row.put("layanan", rs.getString("layanan"));
                        row.put("jenisCucian", rs.getString("jenis_cucian"));
                        row.put("quantity", rs.getDouble("quantity"));
                        row.put("price", rs.getDouble("price"));
                        row.put("subtotal", rs.getDouble("subtotal"));
                        list.add(row);
                    }
                }

                request.setAttribute("history", list);
                request.getRequestDispatcher("/Ryan/RiwayatPesanan.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // =====================================================
    // POST : CREATE ORDER
    // =====================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        // ===== AUTH GUARD =====
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"user".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = user.getId();

        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        double qty    = Double.parseDouble(request.getParameter("quantity"));

        try (Connection con = DBConnection.getConnection()) {

            // ===== GET SERVICE PRICE =====
            double price;
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT price FROM services WHERE service_id=?")) {

                ps.setInt(1, serviceId);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    response.sendRedirect(
                        request.getContextPath() + "/Ryan/BuatPesanan.jsp?error=service"
                    );
                    return;
                }
                price = rs.getDouble("price");
            }

            // ===== INSERT ORDER =====
            int orderId;
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO orders (user_id, total_price) VALUES (?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, userId);
                ps.setDouble(2, qty * price);
                ps.executeUpdate();

                ResultSet keys = ps.getGeneratedKeys();
                keys.next();
                orderId = keys.getInt(1);
            }

            // ===== INSERT ORDER DETAIL =====
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO order_details " +
                    "(order_id, service_id, quantity, price, subtotal) " +
                    "VALUES (?, ?, ?, ?, ?)")) {

                ps.setInt(1, orderId);
                ps.setInt(2, serviceId);
                ps.setDouble(3, qty);
                ps.setDouble(4, price);
                ps.setDouble(5, qty * price);
                ps.executeUpdate();
            }

            response.sendRedirect(request.getContextPath() + "/MyOrders");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + "/Ryan/BuatPesanan.jsp?error=1"
            );
        }
    }
}
