package Fauzan.Controller;

import Fauzan.Model.User;
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns = {
    "/login",
    "/register",
    "/auth"
})
public class AuthController extends HttpServlet {

    // =====================================================
    // GET : PAGE NAVIGATION
    // =====================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                response.sendRedirect(
                    request.getContextPath() + "/Fauzan/Login.jsp"
                );
                break;

            case "/register":
                response.sendRedirect(
                    request.getContextPath() + "/Fauzan/Register.jsp"
                );
                break;

            default:
                response.sendRedirect(
                    request.getContextPath() + "/index.jsp"
                );
        }
    }

    // =====================================================
    // POST : FORM ACTIONS
    // =====================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                response.sendRedirect(
                    request.getContextPath() + "/index.jsp"
                );
                return;
            }

            switch (action) {

                case "login":
                    processLogin(request, response);
                    break;

                case "register":
                    processRegister(request, response);
                    break;

                case "addUser":
                    addUser(request, response);
                    break;

                case "updateUser":
                    updateUser(request, response);
                    break;

                case "deleteUser":
                    deleteUser(request, response);
                    break;

                case "logout":
                    logout(request, response);
                    break;

                default:
                    response.sendRedirect(
                        request.getContextPath() + "/index.jsp"
                    );
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // =====================================================
    // LOGIN
    // =====================================================
    private void processLogin(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT user_id, email, role, password, first_name, last_name FROM users WHERE email=? AND password=?"
        );

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            User user = new User();
            user.setId(rs.getInt("user_id"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            user.setFirstName(rs.getString("first_name"));

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            if ("admin".equals(user.getRole())) {
                response.sendRedirect(
                    request.getContextPath() + "/LaporanController?user_id=" + user.getId()
                );
            } else {
                response.sendRedirect(
                    request.getContextPath() + "/LaporanController?user_id=" + user.getId()
                );
            }

        } else {
            response.sendRedirect(
                request.getContextPath() + "/Fauzan/Login.jsp?error=1"
            );
        }
    }

    // =====================================================
    // REGISTER
    // =====================================================
    private void processRegister(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        String role      = request.getParameter("role");
        String phone     = request.getParameter("phone");

        Date birthDate = null;
        String city    = null;

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users " +
            "(first_name, last_name, email, password, role, city, phone, birth_date) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );

        ps.setString(1, firstName);
        ps.setString(2, lastName);
        ps.setString(3, email);
        ps.setString(4, password);
        ps.setString(5, role);
        ps.setString(6, city);
        ps.setString(7, phone);
        ps.setDate(8, birthDate);

        ps.executeUpdate();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/Login.jsp?registered=1"
        );
    }

    // =====================================================
    // ADD USER
    // =====================================================
    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users " +
            "(email, password, role, first_name, last_name, city, phone, birth_date) " +
            "VALUES (?, ?, ?, NULL, NULL, NULL, NULL, NULL)"
        );

        ps.setString(1, email);
        ps.setString(2, password);
        ps.setString(3, role);

        ps.executeUpdate();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp"
        );
    }

    // =====================================================
    // UPDATE USER
    // =====================================================
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id          = Integer.parseInt(request.getParameter("id"));
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "UPDATE users SET email=?, password=? WHERE id=?"
        );

        ps.setString(1, email);
        ps.setString(2, password);
        ps.setInt(3, id);

        ps.executeUpdate();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp"
        );
    }

    // =====================================================
    // DELETE USER
    // =====================================================
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM users WHERE user_id=?"
        );

        ps.setInt(1, id);
        ps.executeUpdate();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp"
        );
    }

    // =====================================================
    // LOGOUT
    // =====================================================
    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(
            request.getContextPath() + "/index.jsp"
        );
    }
}
