package Aril.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class OrderDAO {

    public List<Map<String, Object>> listByStatus(String status) throws SQLException {

        String sql =
            "SELECT " +
            "  o.order_id, " +
            "  CONCAT(u.first_name, ' ', u.last_name) AS customer, " +
            "  o.total_price, " +
            "  o.status " +
            "FROM orders o " +
            "JOIN users u ON u.user_id = o.user_id " +
            "WHERE o.status = ? " +
            "ORDER BY o.order_id DESC";

        List<Map<String, Object>> list = new ArrayList<>();

        try (
            Connection c = DBConnection.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)
        ) {
            ps.setString(1, status);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("order_id", rs.getInt("order_id"));
                    row.put("customer", rs.getString("customer"));
                    row.put("total_price", rs.getBigDecimal("total_price"));
                    row.put("status", rs.getString("status"));
                    list.add(row);
                }
            }
        }

        return list;
    }

    public Map<String, Object> findById(int orderId) throws SQLException {

        String sql =
            "SELECT " +
            "  o.order_id, " +
            "  CONCAT(u.first_name, ' ', u.last_name) AS customer, " +
            "  o.total_price, " +
            "  o.status " +
            "FROM orders o " +
            "JOIN users u ON u.user_id = o.user_id " +
            "WHERE o.order_id = ? " +
            "LIMIT 1";

        try (
            Connection c = DBConnection.getConnection();
            PreparedStatement ps = c.prepareStatement(sql)
        ) {
            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Map<String, Object> row = new HashMap<>();
                row.put("order_id", rs.getInt("order_id"));
                row.put("customer", rs.getString("customer"));
                row.put("total_price", rs.getBigDecimal("total_price"));
                row.put("status", rs.getString("status"));
                return row;
            }
        }
    }

    public boolean confirmPickupAndPayment(int orderId, String method) throws SQLException {

        String updateOrderSql =
            "UPDATE orders " +
            "SET status = 'done', pickup_date = NOW() " +
            "WHERE order_id = ? AND status = 'ready to taken'";

        String insertPaymentSql =
            "INSERT INTO payments (order_id, payment_method, payment_status, payment_date) " +
            "VALUES (?, ?, 'paid', NOW())";

        Connection c = null;

        try {
            c = DBConnection.getConnection();
            c.setAutoCommit(false);

            int updated;

            try (PreparedStatement ps = c.prepareStatement(updateOrderSql)) {
                ps.setInt(1, orderId);
                updated = ps.executeUpdate();
            }

            if (updated <= 0) {
                c.rollback();
                return false;
            }

            try (PreparedStatement ps = c.prepareStatement(insertPaymentSql)) {
                ps.setInt(1, orderId);
                ps.setString(2, method);
                ps.executeUpdate();
            }

            c.commit();
            return true;

        } catch (SQLException e) {
            if (c != null) {
                try { c.rollback(); } catch (SQLException ignore) {}
            }
            throw e;

        } finally {
            if (c != null) {
                try { c.setAutoCommit(true); } catch (SQLException ignore) {}
                try { c.close(); } catch (SQLException ignore) {}
            }
        }
    }
}
