package com.oceanview.controller;

import com.oceanview.dao.RoomTypeDAO;
import org.junit.jupiter.api.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

class UpdateRoomStockServletTest {

    @Test
    void doPost_shouldRedirectToLogin_whenNotLoggedIn() throws Exception {
        RoomTypeDAO dao = mock(RoomTypeDAO.class);
        UpdateRoomStockServlet servlet = new UpdateRoomStockServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getSession(false)).thenReturn(null);

        servlet.doPost(req, resp);

        verify(resp).sendRedirect("login.jsp");
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldRedirectAccessDenied_whenNotAdmin() throws Exception {
        RoomTypeDAO dao = mock(RoomTypeDAO.class);
        UpdateRoomStockServlet servlet = new UpdateRoomStockServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("reception");
        when(session.getAttribute("role")).thenReturn("RECEPTIONIST");

        servlet.doPost(req, resp);

        verify(resp).sendRedirect(startsWith("dashboard.jsp?error="));
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldRedirectInvalidInput_whenParseFails() throws Exception {
        RoomTypeDAO dao = mock(RoomTypeDAO.class);
        UpdateRoomStockServlet servlet = new UpdateRoomStockServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("roomTypeId")).thenReturn("abc");
        when(req.getParameter("totalRooms")).thenReturn("10");

        servlet.doPost(req, resp);

        verify(resp).sendRedirect(startsWith("manage-room-stock.jsp?error="));
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldRedirectValidationError_whenNegativeRooms() throws Exception {
        RoomTypeDAO dao = mock(RoomTypeDAO.class);
        UpdateRoomStockServlet servlet = new UpdateRoomStockServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("roomTypeId")).thenReturn("1");
        when(req.getParameter("totalRooms")).thenReturn("-1");

        servlet.doPost(req, resp);

        verify(resp).sendRedirect(startsWith("manage-room-stock.jsp?error="));
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldRedirectSuccess_whenDaoUpdates() throws Exception {
        RoomTypeDAO dao = mock(RoomTypeDAO.class);
        when(dao.updateTotalRooms(2, 15)).thenReturn(true);

        UpdateRoomStockServlet servlet = new UpdateRoomStockServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("roomTypeId")).thenReturn("2");
        when(req.getParameter("totalRooms")).thenReturn("15");

        servlet.doPost(req, resp);

        verify(dao).updateTotalRooms(2, 15);
        verify(resp).sendRedirect(startsWith("manage-room-stock.jsp?success="));
    }

    @Test
    void doPost_shouldRedirectDbError_whenDaoFails() throws Exception {
        RoomTypeDAO dao = mock(RoomTypeDAO.class);
        when(dao.updateTotalRooms(2, 15)).thenReturn(false);

        UpdateRoomStockServlet servlet = new UpdateRoomStockServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("roomTypeId")).thenReturn("2");
        when(req.getParameter("totalRooms")).thenReturn("15");

        servlet.doPost(req, resp);

        verify(dao).updateTotalRooms(2, 15);
        verify(resp).sendRedirect(startsWith("manage-room-stock.jsp?error="));
    }
}