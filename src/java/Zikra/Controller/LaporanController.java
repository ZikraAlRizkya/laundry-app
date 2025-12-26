package Zikra.Controller;
import Zikra.Model.Edit;
import Zikra.Controller.DBConnection;
import java.sql.ResultSet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LaporanController", urlPatterns = {"/LaporanController"})
public class LaporanController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        DBConnection db = new DBConnection();
        Edit userDetail = new Edit();
        
        if (db.isConnected) {
            try {
                // Query sakti untuk menghitung berbagai status sekaligus
                String sql = "SELECT o.user_id, u.role,"
                        + "COUNT(CASE WHEN o.status != 'done' THEN 1 END) AS aktif, "
                        + "COUNT(CASE WHEN o.status = 'process' THEN 1 END) AS proses, "
                        + "COUNT(CASE WHEN o.status = 'done' THEN 1 END) AS selesai "
                        + "FROM orders o JOIN users u ON u.user_id = o.user_id WHERE u.user_id = '" + user_id + "'"
                        + "GROUP BY o.user_id, u.role";
                
                String sql2 = "SELECT "
                        + "COUNT(CASE WHEN status = 'pending' THEN 1 END) AS baru, "
                        + "COUNT(CASE WHEN status = 'received' THEN 1 END) AS diterima, "
                        + "COUNT(CASE WHEN status = 'process' THEN 1 END) AS proses, "
                        + "COUNT(CASE WHEN status = 'ready to taken' THEN 1 END) AS ambil "
                        + "FROM orders";
                  
                ResultSet rs = db.getData(sql);
                if (rs.next()) {
                    userDetail.setTotalPesananUser(rs.getInt("aktif"));
                    userDetail.setTotalDiprosesUser(rs.getInt("proses"));
                    userDetail.setTotalSelesaiUser(rs.getInt("selesai"));
                    userDetail.setRole(rs.getString("role"));
                }
                rs.close();
                
                ResultSet rs2 = db.getData(sql2);
                if (rs2.next()) {
                    userDetail.setTotalPesananBaruAdmin(rs2.getInt("baru"));
                    userDetail.setTotalDiterimaAdmin(rs2.getInt("diterima"));
                    userDetail.setTotalDiprosesAdmin(rs2.getInt("proses"));
                    userDetail.setTotalSiapDiambilAdmin(rs2.getInt("ambil"));
                }
                rs2.close();
                request.getSession().setAttribute("userDetail", userDetail);
            } catch (Exception e) {
                throw new ServletException(e);
            } finally {
                db.disconnect();
            }
        }
        // forward ke JSP profil
        if("user".equals(userDetail.getRole())){
            request.getRequestDispatcher("Zikra/Pelanggan.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("Zikra/Admin.jsp").forward(request, response);
        }
    }
}
