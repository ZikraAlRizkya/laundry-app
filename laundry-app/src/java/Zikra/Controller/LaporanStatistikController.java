package Zikra.Controller;
import Zikra.Model.Laporan;
import Zikra.Controller.DBConnection;
import java.sql.ResultSet;

import java.util.List;
import java.util.ArrayList;
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
        Laporan userDetail = new Laporan();
        
        if (db.isConnected) {
            try {
                String sqlCard1 = "SELECT "
                        + "COUNT(DISTINCT user_id) AS total_user, "
                        + "SUM(total_price) AS total_pendapatan, "
                        + "COUNT(order_id) AS total_order "
                        + "FROM orders ";
                
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
                        + "GROUP BY order_date "
                        + ") AS harian";

                
                ResultSet rsCard2 = db.getData(sqlCard2);
                if (rsCard2.next()) {
                     userDetail.setRataRataPendapatanPerHari(rsCard2.getDouble("rata_rata_pendapatan"));
                }
                rsCard2.close();
                
                String sqlBarChart = "SELECT u.city, "
                        + "COUNT(o.order_id) as total_order "
                        + "FROM orders o "
                        + "JOIN users u ON u.user_id = o.user_id "
                        + "GROUP BY u.city";
                
                ResultSet rsBarChart = db.getData(sqlBarChart);
                while (rsBarChart.next()) {
                    userDetail.addCity(rsBarChart.getString("city"));
                    userDetail.addTotalOrderCity(rsBarChart.getInt("total_order"));
                }
                rsBarChart.close();
                
                String sqlLineChart = "SELECT DATE(order_date) as tanggal, "
                        + "SUM(total_price) as total_pendapatan "
                        + "FROM orders "
                        + "GROUP BY tanggal";
                
                ResultSet rsLineChart = db.getData(sqlLineChart);
                while (rsLineChart.next()) {
                    userDetail.addDate(rsLineChart.getString("tanggal"));
                    userDetail.addTotalOrderDate(rsLineChart.getInt("total_pendapatan"));
                }
                rsLineChart.close(); 
                
                String sqlPieChart = "SELECT s.layanan, "
                        + "COUNT(od.service_id) as total_service "
                        + "FROM order_details od "
                        + "JOIN services s ON s.service_id = od.service_id "
                        + "GROUP BY layanan";
                
                ResultSet rsPieChart = db.getData(sqlPieChart);
                while (rsPieChart.next()) {
                    userDetail.addService(rsPieChart.getString("layanan"));
                    userDetail.addTotalOrderService(rsPieChart.getInt("total_service"));
                }
                rsPieChart.close(); 
                
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
