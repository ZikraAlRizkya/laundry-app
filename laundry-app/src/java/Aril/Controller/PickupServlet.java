package Aril.Controller;

import Aril.Model.OrderDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "PickupServlet", urlPatterns = {"/pickup", "/pickup/*"})
public class PickupServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            response.sendRedirect(request.getContextPath() + "/pickup/list");
            return;
        }

        try {
            if ("/list".equals(pathInfo)) {

                List<Map<String, Object>> orders =
                    orderDAO.listByStatus("ready to taken");

                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/pickup_list.jsp").forward(request, response);
                return;
            }

            if ("/form".equals(pathInfo)) {

                String idStr = request.getParameter("id");

                if (idStr == null || idStr.isBlank()) {
                    response.sendError(400, "Missing id");
                    return;
                }

                int orderId = Integer.parseInt(idStr);

                Map<String, Object> order = orderDAO.findById(orderId);

                if (order == null) {
                    response.sendError(404, "Order not found");
                    return;
                }

                request.setAttribute("order", order);
                request.getRequestDispatcher("/pickup_form.jsp").forward(request, response);
                return;
            }

            response.sendError(404, "Not found");

        } catch (SQLException e) {
            throw new ServletException("DB error: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            response.sendError(404, "Not found");
            return;
        }

        if (!"/confirm".equals(pathInfo)) {
            response.sendError(404, "Not found");
            return;
        }

        try {
            String orderIdStr = request.getParameter("orderId");

            if (orderIdStr == null || orderIdStr.isBlank()) {
                response.sendError(400, "Missing orderId");
                return;
            }

            int orderId = Integer.parseInt(orderIdStr);

            String method = request.getParameter("paymentMethod");

            if (method == null || method.isBlank()) {
                method = "cash";
            }

            Map<String, Object> order = orderDAO.findById(orderId);

            if (order == null) {
                response.sendError(404, "Order not found");
                return;
            }

            String status = String.valueOf(order.get("status"));

            if (!"ready to taken".equalsIgnoreCase(status)) {
                request.setAttribute("error", "Status order bukan 'ready to taken'.");
                request.setAttribute("order", order);
                request.getRequestDispatcher("/pickup_form.jsp").forward(request, response);
                return;
            }

            boolean ok = orderDAO.confirmPickupAndPayment(orderId, method);

            if (!ok) {
                response.sendError(409, "Gagal confirm. Status sudah berubah / order tidak valid.");
                return;
            }

            Map<String, Object> doneOrder = orderDAO.findById(orderId);

            request.setAttribute("order", doneOrder);
            request.setAttribute("paymentMethod", method);

            request.getRequestDispatcher("/receipt.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("DB error: " + e.getMessage(), e);
        }
    }
}
