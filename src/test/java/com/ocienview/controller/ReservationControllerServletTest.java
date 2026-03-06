package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import org.junit.jupiter.api.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

class ReservationControllerServletTest {

    @Test
    void doGet_shouldRedirectToLogin_whenNotLoggedIn() throws Exception {
        ReservationDAO dao = mock(ReservationDAO.class);
        ReservationControllerServlet servlet = new ReservationControllerServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getSession(false)).thenReturn(null);

        servlet.doGet(req, resp);

        verify(resp).sendRedirect("login.jsp");
        verifyNoInteractions(dao);
    }

    @Test
    void doGet_delete_shouldRedirectSuccess_whenDaoDeletes() throws Exception {
        ReservationDAO dao = mock(ReservationDAO.class);
        when(dao.deleteByReservationNumber("R001")).thenReturn(true);

        ReservationControllerServlet servlet = new ReservationControllerServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("reception");

        when(req.getParameter("action")).thenReturn("delete");
        when(req.getParameter("reservationNumber")).thenReturn("R001");

        servlet.doGet(req, resp);

        verify(dao).deleteByReservationNumber("R001");
        verify(resp).sendRedirect(startsWith("all-reservations?success="));
    }

    @Test
    void doGet_delete_shouldRedirectError_whenReservationMissing() throws Exception {
        ReservationDAO dao = mock(ReservationDAO.class);
        ReservationControllerServlet servlet = new ReservationControllerServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("reception");

        when(req.getParameter("action")).thenReturn("delete");
        when(req.getParameter("reservationNumber")).thenReturn("");

        servlet.doGet(req, resp);

        verify(resp).sendRedirect(startsWith("all-reservations?error="));
        verifyNoInteractions(dao);
    }

    @Test
    void doGet_delete_shouldRedirectError_whenDaoReturnsFalse() throws Exception {
        ReservationDAO dao = mock(ReservationDAO.class);
        when(dao.deleteByReservationNumber("R404")).thenReturn(false);

        ReservationControllerServlet servlet = new ReservationControllerServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("reception");

        when(req.getParameter("action")).thenReturn("delete");
        when(req.getParameter("reservationNumber")).thenReturn("R404");

        servlet.doGet(req, resp);

        verify(dao).deleteByReservationNumber("R404");
        verify(resp).sendRedirect(startsWith("all-reservations?error="));
    }

    @Test
    void doPost_update_shouldRedirectToEditWithError_whenMissingFields() throws Exception {
        ReservationDAO dao = mock(ReservationDAO.class);
        ReservationControllerServlet servlet = new ReservationControllerServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("reception");

        when(req.getParameter("action")).thenReturn("update");

        when(req.getParameter("reservationNumber")).thenReturn("R001");
        when(req.getParameter("guestName")).thenReturn(""); // missing
        when(req.getParameter("address")).thenReturn("Colombo");
        when(req.getParameter("contactNumber")).thenReturn("0771234567");
        when(req.getParameter("roomTypeId")).thenReturn("1");
        when(req.getParameter("checkIn")).thenReturn("2026-03-10");
        when(req.getParameter("checkOut")).thenReturn("2026-03-12");

        servlet.doPost(req, resp);

        verify(resp).sendRedirect(startsWith("reservation?action=edit&reservationNumber=R001&error="));
        verifyNoInteractions(dao);
    }
}