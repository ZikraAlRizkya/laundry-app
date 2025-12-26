/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Agung.Controller;

import Agung.Model.AdminServiceDAO;
import Agung.Model.AdminServiceDAO.OrderResult;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author Muhammad Zikra
 */
@WebServlet(name = "ServletAgung", urlPatterns = {"/ServletAgung"})
public class ServletAgung extends HttpServlet {
    private AdminServiceDAO serviceDAO = new AdminServiceDAO();

    // Method untuk menangani pengambilan data (Halaman awal & Pencarian)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Ambil keyword dari form pencarian (jika ada)
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = ""; // Jika kosong, tampilkan semua (sesuai logika DAO)
        }

        // 2. Panggil DAO untuk mencari data
        List<OrderResult> listPesanan = serviceDAO.cariPesanan(keyword);

        // 3. Simpan hasil ke dalam request attribute agar bisa dibaca di JSP
        request.setAttribute("listPesanan", listPesanan);
        
        // 4. Kirim data ke halaman manage_service.jsp
        request.getRequestDispatcher("/Agung/ManajemenLayanan.jsp").forward(request, response);
    }

    // Method untuk menangani pengiriman data (Update Harga)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Cek aksi apa yang dilakukan (untuk jaga-jaga jika ada fitur lain nanti)
        String action = request.getParameter("action");

        if ("updateHarga".equals(action)) {
            try {
                // 2. Ambil data dari form edit
                int idService = Integer.parseInt(request.getParameter("service_id"));
                double hargaBaru = Double.parseDouble(request.getParameter("price"));

                // 3. Panggil DAO untuk update
                boolean isSuccess = serviceDAO.updateHargaLayanan(idService, hargaBaru);

                // 4. Berikan pesan notifikasi
                if (isSuccess) {
                    request.setAttribute("message", "Berhasil memperbarui harga layanan!");
                    request.setAttribute("messageType", "success");
                } else {
                    request.setAttribute("message", "Gagal memperbarui harga.");
                    request.setAttribute("messageType", "error");
                }

            } catch (NumberFormatException e) {
                request.setAttribute("message", "Format harga atau ID salah!");
                request.setAttribute("messageType", "error");
            }
        }
        
        // 5. Setelah update (POST), kita panggil doGet() lagi 
        // supaya tabel pesanan di bawahnya tetap muncul/direfresh
        doGet(request, response); 
    }
}
