package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomSummaryDAO;
import com.oceanview.dao.RoomTypeDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.RoomSummary;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@WebServlet("/reports")
public class ReportsControllerServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
    private final RoomSummaryDAO roomSummaryDAO = new RoomSummaryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Must be logged in (ADMIN or RECEPTIONIST)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "bill":
                handleBill(req, resp);
                break;

            case "todayCheckins":
                handleTodayCheckins(req, resp);
                break;

            case "roomsSummary":
                handleRoomsSummary(req, resp);
                break;

            default:
                resp.sendRedirect("dashboard.jsp?error=" + enc("Invalid report action."));
                break;
        }
    }

    // ========== BILL ==========
    private void handleBill(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String reservationNumber = req.getParameter("reservationNumber");

        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("bill.jsp?error=" + enc("Bill failed - please enter reservation number."));
            return;
        }

        Reservation r = reservationDAO.findByReservationNumber(reservationNumber.trim());
        if (r == null) {
            resp.sendRedirect("bill.jsp?error=" + enc("Bill failed - reservation not found: " + reservationNumber.trim()));
            return;
        }

        double rate = roomTypeDAO.getRateById(r.getRoomTypeId());
        if (rate < 0) {
            resp.sendRedirect("bill.jsp?error=" + enc("Bill failed - room rate not found."));
            return;
        }

        LocalDate in = r.getCheckIn().toLocalDate();
        LocalDate out = r.getCheckOut().toLocalDate();
        long nights = ChronoUnit.DAYS.between(in, out);

        if (nights <= 0) {
            resp.sendRedirect("bill.jsp?error=" + enc("Bill failed - invalid check-in / check-out dates."));
            return;
        }

        double total = nights * rate;

        req.setAttribute("reservation", r);
        req.setAttribute("rate", rate);
        req.setAttribute("nights", nights);
        req.setAttribute("total", total);

        req.getRequestDispatcher("bill-result.jsp").forward(req, resp);
    }

    // ========== TODAY CHECK-INS ==========
    private void handleTodayCheckins(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Reservation> list = reservationDAO.findTodayCheckIns();
        req.setAttribute("checkins", list);
        req.setAttribute("todayCheckinsCount", list.size());

        req.getRequestDispatcher("today-checkins.jsp").forward(req, resp);
    }

    // ========== ROOMS SUMMARY ==========
    private void handleRoomsSummary(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<RoomSummary> list = roomSummaryDAO.getTodaySummary();
        req.setAttribute("summary", list);

        req.getRequestDispatcher("rooms-summary.jsp").forward(req, resp);
    }

    private String enc(String msg) throws IOException {
        return URLEncoder.encode(msg, "UTF-8");
    }
}