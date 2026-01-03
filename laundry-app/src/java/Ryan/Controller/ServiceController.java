package Ryan.Controller;

import Fauzan.Controller.DBConnection;
import Fauzan.Model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(urlPatterns = {
    "/CalculatePrice",
    "/GetJenisCucian"
})
public class ServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // =============================
        // AUTH GUARD
        // =============================
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"user".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String path = request.getServletPath();

        try (Connection con = DBConnection.getConnection()) {

            // =============================
            // AJAX HITUNG HARGA
            // =============================
            if ("/CalculatePrice".equals(path)) {

                int serviceId = Integer.parseInt(request.getParameter("service_id"));
                double qty    = Double.parseDouble(request.getParameter("quantity"));

                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT price FROM services WHERE service_id=?")) {

                    ps.setInt(1, serviceId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        double total = qty * rs.getDouble("price");
                        response.setContentType("text/plain");
                        response.getWriter().print(total);
                    }
                }
            }

            // =============================
            // AJAX DROPDOWN JENIS CUCIAN
            // =============================
            else if ("/GetJenisCucian".equals(path)) {

                String layanan = request.getParameter("layanan");

                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT service_id, jenis_cucian, price " +
                        "FROM services WHERE layanan=?")) {

                    ps.setString(1, layanan);
                    ResultSet rs = ps.executeQuery();

                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();

                    while (rs.next()) {
                        out.println(
                            "<option value='" + rs.getInt("service_id") + "'>" +
                            rs.getString("jenis_cucian") +
                            " (Rp " + rs.getDouble("price") + "/kg)</option>"
                        );
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
