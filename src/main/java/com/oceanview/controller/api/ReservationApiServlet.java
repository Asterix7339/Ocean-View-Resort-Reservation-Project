package com.oceanview.controller.api;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/api/reservations")
public class ReservationApiServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String number = req.getParameter("number");
        if (number == null || number.trim().isEmpty()) {
            resp.setStatus(400);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\":\"Missing parameter: number\"}");
            return;
        }

        Reservation r = reservationDAO.findByReservationNumber(number.trim());
        if (r == null) {
            resp.setStatus(404);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\":\"Reservation not found\"}");
            return;
        }

        // Simple JSON manually (no advanced framework)
        resp.setStatus(200);
        resp.setContentType("application/json");

        String json = "{"
                + "\"reservationNumber\":\"" + escape(r.getReservationNumber()) + "\","
                + "\"guestName\":\"" + escape(r.getGuestName()) + "\","
                + "\"address\":\"" + escape(r.getAddress()) + "\","
                + "\"contactNumber\":\"" + escape(r.getContactNumber()) + "\","
                + "\"roomTypeId\":" + r.getRoomTypeId() + ","
                + "\"checkIn\":\"" + r.getCheckIn() + "\","
                + "\"checkOut\":\"" + r.getCheckOut() + "\","
                + "\"totalAmount\":" + r.getTotalAmount()
                + "}";

        resp.getWriter().write(json);
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}