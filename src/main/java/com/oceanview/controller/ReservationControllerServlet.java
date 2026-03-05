package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;

@WebServlet("/reservation")
public class ReservationControllerServlet extends HttpServlet {

    private final ReservationDAO reservationDAO;

    // Default constructor (real app)
    public ReservationControllerServlet() {
        this.reservationDAO = new ReservationDAO();
    }

    // Constructor for tests
    public ReservationControllerServlet(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "view":
                handleView(req, resp);
                break;

            case "edit":
                handleEdit(req, resp);
                break;

            case "delete":
                handleDelete(req, resp);
                break;

            default:
                resp.sendRedirect("all-reservations?error=" + enc("Invalid action."));
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        if ("update".equals(action)) {
            handleUpdate(req, resp);
        } else {
            resp.sendRedirect("all-reservations?error=" + enc("Invalid action."));
        }
    }

    private void handleView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String reservationNumber = req.getParameter("reservationNumber");

        if (isEmpty(reservationNumber)) {
            resp.sendRedirect("all-reservations?error=" + enc("Reservation not found - missing reservation number."));
            return;
        }

        Reservation r = reservationDAO.findByReservationNumber(reservationNumber.trim());
        if (r == null) {
            resp.sendRedirect("all-reservations?error=" + enc("Reservation not found (" + reservationNumber.trim() + ")"));
            return;
        }

        req.setAttribute("reservation", r);
        req.getRequestDispatcher("reservation-details.jsp").forward(req, resp);
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String reservationNumber = req.getParameter("reservationNumber");

        if (isEmpty(reservationNumber)) {
            resp.sendRedirect("all-reservations?error=" + enc("Reservation not found - missing reservation number."));
            return;
        }

        Reservation r = reservationDAO.findByReservationNumber(reservationNumber.trim());
        if (r == null) {
            resp.sendRedirect("all-reservations?error=" + enc("Reservation not found (" + reservationNumber.trim() + ")"));
            return;
        }

        req.setAttribute("reservation", r);
        req.getRequestDispatcher("edit-reservation.jsp").forward(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNumber = req.getParameter("reservationNumber");
        if (isEmpty(reservationNumber)) {
            resp.sendRedirect("all-reservations?error=" + enc("Delete failed - missing reservation number."));
            return;
        }

        boolean ok = reservationDAO.deleteByReservationNumber(reservationNumber.trim());

        if (ok) {
            resp.sendRedirect("all-reservations?success=" + enc("Reservation deleted (" + reservationNumber.trim() + ")"));
        } else {
            resp.sendRedirect("all-reservations?error=" + enc("Delete failed - reservation not found."));
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNumber = req.getParameter("reservationNumber");
        String guestName = req.getParameter("guestName");
        String address = req.getParameter("address");
        String contactNumber = req.getParameter("contactNumber");
        String roomTypeIdStr = req.getParameter("roomTypeId");
        String checkInStr = req.getParameter("checkIn");
        String checkOutStr = req.getParameter("checkOut");

        if (isEmpty(reservationNumber) || isEmpty(guestName) || isEmpty(address) || isEmpty(contactNumber)
                || isEmpty(roomTypeIdStr) || isEmpty(checkInStr) || isEmpty(checkOutStr)) {

            resp.sendRedirect("reservation?action=edit&reservationNumber=" + safe(reservationNumber)
                    + "&error=" + enc("Update failed - please fill all fields."));
            return;
        }

        int roomTypeId;
        try {
            roomTypeId = Integer.parseInt(roomTypeIdStr);
        } catch (Exception e) {
            resp.sendRedirect("reservation?action=edit&reservationNumber=" + safe(reservationNumber)
                    + "&error=" + enc("Update failed - invalid room type."));
            return;
        }

        Date checkIn;
        Date checkOut;
        try {
            checkIn = Date.valueOf(checkInStr);
            checkOut = Date.valueOf(checkOutStr);
        } catch (Exception e) {
            resp.sendRedirect("reservation?action=edit&reservationNumber=" + safe(reservationNumber)
                    + "&error=" + enc("Update failed - invalid dates."));
            return;
        }

        if (!checkOut.after(checkIn)) {
            resp.sendRedirect("reservation?action=edit&reservationNumber=" + safe(reservationNumber)
                    + "&error=" + enc("Update failed - check-out must be after check-in."));
            return;
        }

        Reservation r = new Reservation();
        r.setReservationNumber(reservationNumber.trim());
        r.setGuestName(guestName.trim());
        r.setAddress(address.trim());
        r.setContactNumber(contactNumber.trim());
        r.setRoomTypeId(roomTypeId);
        r.setCheckIn(checkIn);
        r.setCheckOut(checkOut);

        boolean ok = reservationDAO.updateByReservationNumber(r);

        if (ok) {
            resp.sendRedirect("all-reservations?success=" + enc("Reservation updated (" + r.getReservationNumber() + ")"));
        } else {
            resp.sendRedirect("reservation?action=edit&reservationNumber=" + safe(reservationNumber)
                    + "&error=" + enc("Update failed - please try again."));
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String safe(String s) {
        return (s == null) ? "" : s.trim();
    }

    private String enc(String msg) throws IOException {
        return URLEncoder.encode(msg, "UTF-8");
    }
}