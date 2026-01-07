package Zikra.Controller;

import Zikra.Model.Edit;
import Zikra.Controller.DBConnection;
import java.sql.ResultSet;
import Zikra.DAO.UserDAO;
import Zikra.DAO.UserDAOImpl;

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
        UserDAO userDAO = new UserDAOImpl();
        Edit userDetail = userDAO.getUserById(user_id);        
        request.getSession().setAttribute("userDetail", userDetail);
          
        request.getRequestDispatcher("Zikra/ProfilPelanggan.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
        String user_id = request.getParameter("user_id");

        Edit user = new Edit();
        user.setId(Integer.parseInt(user_id));
        user.setFirstName(request.getParameter("first_name"));
        user.setLastName(request.getParameter("last_name"));
        user.setCity(request.getParameter("city"));
        user.setBirthDate(java.sql.Date.valueOf(request.getParameter("birth_date")));
        user.setPhoneNumber(request.getParameter("phone"));
        user.setEmail(request.getParameter("email"));

        UserDAO userDAO = new UserDAOImpl();
        userDAO.updateUser(user);
    
        response.sendRedirect("EditProfileUserController?user_id=" + user_id);
    }
}
