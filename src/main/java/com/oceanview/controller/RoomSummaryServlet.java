package com.oceanview.controller;

import com.oceanview.dao.RoomSummaryDAO;
import com.oceanview.model.RoomSummary;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rooms-summary")
public class RoomSummaryServlet extends HttpServlet {

    private final RoomSummaryDAO roomSummaryDAO = new RoomSummaryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Must be logged in (ADMIN or RECEPTIONIST both allowed)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<RoomSummary> list = roomSummaryDAO.getTodaySummary();
        req.setAttribute("summary", list);

        req.getRequestDispatcher("rooms-summary.jsp").forward(req, resp);
    }
}