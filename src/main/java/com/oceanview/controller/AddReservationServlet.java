package com.oceanview.web;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/add-reservation")
public class AddReservationServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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

        // Basic validation
        if (isEmpty(reservationNumber) || isEmpty(guestName) || isEmpty(address) || isEmpty(contactNumber)
                || isEmpty(roomTypeIdStr) || isEmpty(checkInStr) || isEmpty(checkOutStr)) {
            resp.sendRedirect("reservation-error.jsp");
            return;
        }

        int roomTypeId;
        try {
            roomTypeId = Integer.parseInt(roomTypeIdStr);
        } catch (NumberFormatException e) {
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

        // Date rule: check-out must be after check-in
        if (!checkOut.after(checkIn)) {
            resp.sendRedirect("reservation-error.jsp");
            return;
        }

        // Create object
        Reservation r = new Reservation();
        r.setReservationNumber(reservationNumber.trim());
        r.setGuestName(guestName.trim());
        r.setAddress(address.trim());
        r.setContactNumber(contactNumber.trim());
        r.setRoomTypeId(roomTypeId);
        r.setCheckIn(checkIn);
        r.setCheckOut(checkOut);
        r.setTotalAmount(0); // bill will be calculated later

        boolean saved = reservationDAO.insert(r);

        if (saved) {
            resp.sendRedirect("reservation-success.jsp");
        } else {
            resp.sendRedirect("reservation-error.jsp");
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}