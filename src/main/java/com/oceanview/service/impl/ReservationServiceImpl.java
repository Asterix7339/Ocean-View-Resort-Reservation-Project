package com.oceanview.service.impl;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;

import java.sql.Date;

public class ReservationServiceImpl implements ReservationService {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    public boolean addReservation(Reservation r) {

        if (r == null) return false;

        // basic required validations
        if (isEmpty(r.getReservationNumber())) return false;
        if (isEmpty(r.getGuestName())) return false;
        if (isEmpty(r.getAddress())) return false;
        if (isEmpty(r.getContactNumber())) return false;

        if (r.getRoomTypeId() <= 0) return false;

        Date in = r.getCheckIn();
        Date out = r.getCheckOut();
        if (in == null || out == null) return false;

        // date rule: check-out must be after check-in
        if (!out.after(in)) return false;

        // totalAmount can be 0 initially
        return reservationDAO.insert(r);
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}