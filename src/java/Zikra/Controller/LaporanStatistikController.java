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

@WebServlet(name = "LaporanStatistikController", urlPatterns = {"/LaporanStatistikController"})
public class LaporanStatistikController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        DBConnection db = new DBConnection();
        Edit userDetail = new Edit();
        
        if (db.isConnected) {
            try {
                String sqlCard1 = "SELECT "
                        + "COUNT(DISTINCT user_id) AS total_user, "
                        + "SUM(total_price) AS total_pendapatan, "
                        + "COUNT(order_id) AS total_order "
                        + "FROM orders "
                        + "where status != 'pending'";
                
                ResultSet rsCard1 = db.getData(sqlCard1);
                if (rsCard1.next()) {
                    userDetail.setTotalPelanggan(rsCard1.getInt("total_user"));
                    userDetail.setTotalPendapatan(rsCard1.getInt("total_pendapatan"));
                    userDetail.setTotalPesanan(rsCard1.getInt("total_order"));
                }
                rsCard1.close();
                
                String sqlCard2 = "SELECT AVG(total_harian) AS rata_rata_pendapatan "
                        + "FROM ( "
                        + "SELECT order_date, SUM(total_price) AS total_harian "
                        + "FROM orders "
                        + "WHERE status != 'pending' "
                        + "GROUP BY order_date "
                        + ") AS harian";

                
                ResultSet rsCard2 = db.getData(sqlCard2);
                if (rsCard2.next()) {
                     userDetail.setRataRataPendapatanPerHari(rsCard2.getDouble("rata_rata_pendapatan"));
                }
                rsCard2.close();
                
                request.getSession().setAttribute("userDetail", userDetail);
            } catch (Exception e) {
                throw new ServletException(e);
            } finally {
                db.disconnect();
            }
            request.getRequestDispatcher("Zikra/Laporan.jsp").forward(request, response);
        }
    }
}
