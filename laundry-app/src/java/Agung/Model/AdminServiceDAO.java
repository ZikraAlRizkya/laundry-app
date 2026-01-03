/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Agung.Model;

/**
 *
 * @author USER
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminServiceDAO {

    // --- FITUR 1: UPDATE HARGA LAYANAN ---
    public boolean updateHargaLayanan(int serviceId, double hargaBaru) {
        String query = "UPDATE services SET price = ? WHERE service_id = ?";
        
        try (Connection conn = ModelAgung.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setDouble(1, hargaBaru);
            ps.setInt(2, serviceId);
            
            int rowAffected = ps.executeUpdate();
            return rowAffected > 0; // Mengembalikan true jika berhasil update
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- FITUR 2: CARI PESANAN BERDASARKAN ID ATAU NAMA LAYANAN ---
    // Kita butuh class bantu (inner class) untuk menampung hasil gabungan tabel
    public static class OrderResult {
        public int orderId;
        public String customerName;
        public String namaLayanan;
        public String status;
        public double subtotal;
    }

    public List<OrderResult> cariPesanan(String keyword) {
        List<OrderResult> listPesanan = new ArrayList<>();
        
        // Query ini menggabungkan 4 tabel: orders, users, order_details, services
        // Agar kita tahu Si A pesan Order No 1 isinya Layanan Apa.
        String sql = "SELECT o.order_id, u.first_name, s.layanan, o.status, od.subtotal " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "JOIN order_details od ON o.order_id = od.order_id " +
                     "JOIN services s ON od.service_id = s.service_id " +
                     "WHERE CAST(o.order_id AS CHAR) LIKE ? OR s.layanan LIKE ?";

        try (Connection conn = ModelAgung.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Menggunakan % agar pencarian fleksibel (search pattern)
            ps.setString(1, "%" + keyword + "%"); 
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderResult data = new OrderResult();
                data.orderId = rs.getInt("order_id");
                data.customerName = rs.getString("first_name");
                data.namaLayanan = rs.getString("layanan"); // Cuci Kilat/Reguler
                data.status = rs.getString("status");
                data.subtotal = rs.getDouble("subtotal");
                listPesanan.add(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listPesanan;
    }
}
