package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomTypeDAO;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/calculate-bill")
public class CalculateBillServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Must be logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String reservationNumber = req.getParameter("reservationNumber");
        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("bill-not-found.jsp");
            return;
        }

        Reservation r = reservationDAO.findByReservationNumber(reservationNumber.trim());
        if (r == null) {
            resp.sendRedirect("bill-not-found.jsp");
            return;
        }

        double rate = roomTypeDAO.getRateById(r.getRoomTypeId());
        if (rate < 0) {
            resp.sendRedirect("bill-not-found.jsp");
            return;
        }

        // Calculate nights
        LocalDate in = r.getCheckIn().toLocalDate();
        LocalDate out = r.getCheckOut().toLocalDate();
        long nights = ChronoUnit.DAYS.between(in, out);

        if (nights <= 0) {
            resp.sendRedirect("bill-not-found.jsp");
            return;
        }

        double total = nights * rate;

        req.setAttribute("reservation", r);
        req.setAttribute("rate", rate);
        req.setAttribute("nights", nights);
        req.setAttribute("total", total);

        req.getRequestDispatcher("bill-result.jsp").forward(req, resp);
    }
}