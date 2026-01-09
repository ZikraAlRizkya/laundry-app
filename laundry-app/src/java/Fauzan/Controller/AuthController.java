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
    "/auth",
    "/editUser"
})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                response.sendRedirect(request.getContextPath() + "/Fauzan/Login.jsp");
                break;

            case "/register":
                response.sendRedirect(request.getContextPath() + "/Fauzan/Register.jsp");
                break;

            case "/editUser":
                handleEditUserGet(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
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
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT user_id, email, role, first_name, last_name " +
            "FROM users WHERE email=? AND password=?"
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
            user.setLastName(rs.getString("last_name"));

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(
                    request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp"
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

        rs.close();
        ps.close();
        con.close();
    }

    private void processRegister(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        String role      = request.getParameter("role");
        String phone     = request.getParameter("phone");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users " +
            "(first_name, last_name, email, password, role, phone) " +
            "VALUES (?, ?, ?, ?, ?, ?)"
        );

        ps.setString(1, firstName);
        ps.setString(2, lastName);
        ps.setString(3, email);
        ps.setString(4, password);
        ps.setString(5, role);
        ps.setString(6, phone);

        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/Login.jsp?registered=1"
        );
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users (email, password, role) VALUES (?, ?, ?)"
        );

        ps.setString(1, email);
        ps.setString(2, password);
        ps.setString(3, role);

        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp?added=1"
        );
    }

    private void handleEditUserGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User admin = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT user_id, email, password, role, first_name, last_name, phone " +
                "FROM users WHERE user_id=?"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User userToEdit = new User();
                userToEdit.setId(rs.getInt("user_id"));
                userToEdit.setEmail(rs.getString("email"));
                userToEdit.setPassword(rs.getString("password"));
                userToEdit.setRole(rs.getString("role"));
                userToEdit.setFirstName(rs.getString("first_name"));
                userToEdit.setLastName(rs.getString("last_name"));
                userToEdit.setPhoneNumber(rs.getString("phone"));

                request.setAttribute("userToEdit", userToEdit);
                request.getRequestDispatcher("/Fauzan/EditUser.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "UPDATE users SET email=?, password=?, first_name=?, last_name=?, phone=? WHERE user_id=?"
        );

        ps.setString(1, email);
        ps.setString(2, password);
        ps.setString(3, firstName);
        ps.setString(4, lastName);
        ps.setString(5, phone);
        ps.setInt(6, id);

        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp?updated=1"
        );
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM users WHERE user_id=?"
        );

        ps.setInt(1, id);
        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect(
            request.getContextPath() + "/Fauzan/ManajemenPelanggan.jsp?deleted=1"
        );
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
