package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/view-reservation")
public class ViewReservationServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String reservationNumber = req.getParameter("reservationNumber");
        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("reservation-not-found.jsp");
            return;
        }

        Reservation r = reservationDAO.findByReservationNumber(reservationNumber.trim());

        if (r == null) {
            resp.sendRedirect("reservation-not-found.jsp");
            return;
        }

        req.setAttribute("reservation", r);
        req.getRequestDispatcher("reservation-details.jsp").forward(req, resp);
    }
}