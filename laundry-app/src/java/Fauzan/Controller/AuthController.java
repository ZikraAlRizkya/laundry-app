package Fauzan.Controller;

import Fauzan.Model.User;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns = {"/AuthController/*"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        if (pathInfo.startsWith("/login")) {
            showLoginPage(request, response);
        } else if (pathInfo.startsWith("/register")) {
            showRegisterPage(request, response);
        } else if (pathInfo.startsWith("/admin/users")) {
            showUserManagementPage(request, response);
        } else if (pathInfo.startsWith("/admin/edit")) {
            showEditUserPage(request, response);
        } else if (pathInfo.startsWith("/laporan")) {
            redirectToLaporan(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            if (pathInfo.startsWith("/login")) {
                processLogin(request, response);
            } else if (pathInfo.startsWith("/register")) {
                processRegister(request, response);
            } else if (pathInfo.startsWith("/admin/addUser")) {
                addUser(request, response);
            } else if (pathInfo.startsWith("/admin/updateUser")) {
                updateUser(request, response);
            } else if (pathInfo.startsWith("/admin/deleteUser")) {
                deleteUser(request, response);
            } else if (pathInfo.startsWith("/logout")) {
                logout(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Fauzan/Login.jsp").forward(request, response);
    }

    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Fauzan/Register.jsp").forward(request, response);
    }

    private void showUserManagementPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        User admin = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM users ORDER BY user_id");

            request.setAttribute("usersResultSet", rs);
            request.setAttribute("dbConnection", con);
            request.setAttribute("dbStatement", st);

            request.getRequestDispatcher("/Fauzan/ManajemenPelanggan.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (st != null) st.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
            throw new ServletException(e);
        }
    }

    private void showEditUserPage(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        User admin = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/AuthController/admin/users");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int userId = Integer.parseInt(idParam);
            con = DBConnection.getConnection();
            ps = con.prepareStatement(
                "SELECT user_id, email, password, role, first_name, last_name, phone " +
                "FROM users WHERE user_id=?"
            );
            ps.setInt(1, userId);
            rs = ps.executeQuery();

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
                request.getRequestDispatcher("/Fauzan/EditUser.jsp")
                       .forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/AuthController/admin/users");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
    }

    private void redirectToLaporan(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String userId = request.getParameter("user_id");
        if (userId != null) {
            response.sendRedirect(
                request.getContextPath() + "/LaporanController?user_id=" + userId
            );
        } else {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
        }
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(
                "SELECT user_id, email, role, first_name, last_name " +
                "FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

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
                        request.getContextPath() + "/AuthController/laporan?user_id=" + user.getId()
                    );
                } else {
                    response.sendRedirect(
                        request.getContextPath() + "/AuthController/laporan?user_id=" + user.getId()
                    );
                }
            } else {
                response.sendRedirect(
                    request.getContextPath() + "/AuthController/login?error=1"
                );
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    private void processRegister(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        String role      = request.getParameter("role");
        String phone     = request.getParameter("phone");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(
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

            response.sendRedirect(
                request.getContextPath() + "/AuthController/login?registered=1"
            );
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(
                "INSERT INTO users (email, password, role) VALUES (?, ?, ?)"
            );

            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.executeUpdate();

            response.sendRedirect(
                request.getContextPath() + "/AuthController/admin/users?added=1"
            );
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        User admin = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AuthController/login");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            if (password != null && !password.trim().isEmpty()) {
                ps = con.prepareStatement(
                    "UPDATE users SET email=?, password=?, role=? WHERE user_id=?"
                );
                ps.setString(1, email);
                ps.setString(2, password);
                ps.setString(3, role);
                ps.setInt(4, id);
            } else {
                ps = con.prepareStatement(
                    "UPDATE users SET email=?, role=? WHERE user_id=?"
                );
                ps.setString(1, email);
                ps.setString(2, role);
                ps.setInt(3, id);
            }

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect(
                    request.getContextPath() + "/AuthController/admin/users?updated=1"
                );
            } else {
                response.sendRedirect(
                    request.getContextPath() + "/AuthController/admin/edit?id=" + id + "&error=1"
                );
            }
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement("DELETE FROM users WHERE user_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect(
                request.getContextPath() + "/AuthController/admin/users?deleted=1"
            );
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
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
