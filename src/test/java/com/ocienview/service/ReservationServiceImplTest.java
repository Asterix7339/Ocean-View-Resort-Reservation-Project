package com.ocienview.service;

import com.oceanview.model.Reservation;
import com.oceanview.service.impl.ReservationServiceImpl;
import org.junit.jupiter.api.Test;

import java.sql.Date;

import static org.junit.jupiter.api.Assertions.*;

class ReservationServiceImplTest {

    private final ReservationServiceImpl service = new ReservationServiceImpl();

    private Reservation buildValidReservation() {
        Reservation r = new Reservation();
        r.setReservationNumber("R001");
        r.setGuestName("John Doe");
        r.setAddress("Colombo");
        r.setContactNumber("0771234567");
        r.setRoomTypeId(1);
        r.setCheckIn(Date.valueOf("2026-03-10"));
        r.setCheckOut(Date.valueOf("2026-03-12"));
        return r;
    }

    @Test
    void addReservation_shouldReturnFalse_whenReservationNull() {
        assertFalse(service.addReservation(null));
    }

    @Test
    void addReservation_shouldReturnFalse_whenReservationNumberEmpty() {
        Reservation r = buildValidReservation();
        r.setReservationNumber("");
        assertFalse(service.addReservation(r));
    }

    @Test
    void addReservation_shouldReturnFalse_whenGuestNameEmpty() {
        Reservation r = buildValidReservation();
        r.setGuestName("");
        assertFalse(service.addReservation(r));
    }

    @Test
    void addReservation_shouldReturnFalse_whenAddressEmpty() {
        Reservation r = buildValidReservation();
        r.setAddress("");
        assertFalse(service.addReservation(r));
    }

    @Test
    void addReservation_shouldReturnFalse_whenContactNumberEmpty() {
        Reservation r = buildValidReservation();
        r.setContactNumber("");
        assertFalse(service.addReservation(r));
    }

    @Test
    void addReservation_shouldReturnFalse_whenRoomTypeInvalid() {
        Reservation r = buildValidReservation();
        r.setRoomTypeId(0);
        assertFalse(service.addReservation(r));
    }

    @Test
    void addReservation_shouldReturnFalse_whenDatesInvalid() {
        Reservation r = buildValidReservation();
        r.setCheckIn(Date.valueOf("2026-03-10"));
        r.setCheckOut(Date.valueOf("2026-03-09")); // checkout before checkin
        assertFalse(service.addReservation(r));
    }

    @Test
    void addReservation_shouldReturnFalse_whenCheckInEqualsCheckOut() {
        Reservation r = buildValidReservation();
        r.setCheckIn(Date.valueOf("2026-03-10"));
        r.setCheckOut(Date.valueOf("2026-03-10"));
        assertFalse(service.addReservation(r));
    }

}