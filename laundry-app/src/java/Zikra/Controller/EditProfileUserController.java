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

@WebServlet(name = "EditProfileUserController", urlPatterns = {"/EditProfileUserController"})
public class EditProfileUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        DBConnection db = new DBConnection();
        
        if (db.isConnected) {
            try {
                ResultSet rs = db.getData("select * from users where user_id='" + user_id + "'");
                if (rs.next()) {
                    Edit userDetail = new Edit();
                    userDetail.setId(rs.getInt("user_id"));
                    userDetail.setFirstName(rs.getString("first_name"));
                    userDetail.setLastName(rs.getString("last_name"));
                    userDetail.setCity(rs.getString("city"));
                    userDetail.setBirthDate(rs.getDate("birth_date"));
                    userDetail.setPhoneNumber(rs.getString("phone"));
                    userDetail.setEmail(rs.getString("email"));
                    userDetail.setRole(rs.getString("role"));
                    userDetail.setPassword(rs.getString("password"));
                    request.getSession().setAttribute("userDetail", userDetail);
                }
                rs.close();
            } catch (Exception e) {
                throw new ServletException(e);
            } finally {
                db.disconnect();
            }
        }
        // forward ke JSP profil
        request.getRequestDispatcher("Zikra/ProfilPelanggan.jsp").forward(request, response);
    }
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    DBConnection db = new DBConnection();
    String user_id = request.getParameter("user_id");
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String city = request.getParameter("city");
    String birthDate = request.getParameter("birth_date");
    String phoneNumber = request.getParameter("phone");
    String email = request.getParameter("email");
    
    if (db.isConnected) {
        String sql = "UPDATE users SET first_name = '" + firstName + "', "
                   + "last_name = '" + lastName + "', city = '" + city + "', "
                   + "birth_date = '" + birthDate + "', phone = '" + phoneNumber + "', "
                   + "email = '" + email + "' WHERE user_id = '" + user_id + "'";
        
        db.runQuery(sql);
        db.disconnect();
    }
    
    // Redirect kembali ke doGet untuk menampilkan data terbaru
    response.sendRedirect("EditProfileUserController?user_id=" + user_id);
}
}
