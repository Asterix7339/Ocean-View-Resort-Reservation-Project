package com.oceanview.service;

import com.oceanview.model.Reservation;

public interface ReservationService {

    /**
     * Validates inputs and saves reservation.
     * Returns true if saved successfully, otherwise false.
     */
    boolean addReservation(Reservation reservation);
}