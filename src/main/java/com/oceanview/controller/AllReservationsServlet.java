package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/all-reservations")
public class AllReservationsServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Must be logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String q = req.getParameter("q"); // search keyword (optional)
        List<Reservation> list = reservationDAO.findAllOrSearch(q);

        req.setAttribute("reservations", list);
        req.setAttribute("q", q == null ? "" : q);

        req.getRequestDispatcher("all-reservations.jsp").forward(req, resp);
    }
}