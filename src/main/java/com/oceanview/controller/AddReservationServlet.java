package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import com.oceanview.service.impl.ReservationServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/add-reservation")
public class AddReservationServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Must be logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Read inputs
        String reservationNumber = req.getParameter("reservationNumber");
        String guestName = req.getParameter("guestName");
        String address = req.getParameter("address");
        String contactNumber = req.getParameter("contactNumber");
        String roomTypeIdStr = req.getParameter("roomTypeId");
        String checkInStr = req.getParameter("checkIn");
        String checkOutStr = req.getParameter("checkOut");

        // Convert roomTypeId + dates (conversion stays in controller)
        int roomTypeId;
        try {
            roomTypeId = Integer.parseInt(roomTypeIdStr);
        } catch (Exception e) {
            resp.sendRedirect("reservation-error.jsp");
            return;
        }

        Date checkIn;
        Date checkOut;
        try {
            checkIn = Date.valueOf(checkInStr);
            checkOut = Date.valueOf(checkOutStr);
        } catch (Exception e) {
            resp.sendRedirect("reservation-error.jsp");
            return;
        }

        // Build model
        Reservation r = new Reservation();
        r.setReservationNumber(trim(reservationNumber));
        r.setGuestName(trim(guestName));
        r.setAddress(trim(address));
        r.setContactNumber(trim(contactNumber));
        r.setRoomTypeId(roomTypeId);
        r.setCheckIn(checkIn);
        r.setCheckOut(checkOut);
        r.setTotalAmount(0);

        boolean saved = reservationService.addReservation(r);

        if (saved) {
            resp.sendRedirect("reservation-success.jsp");
        } else {
            resp.sendRedirect("reservation-error.jsp");
        }
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}