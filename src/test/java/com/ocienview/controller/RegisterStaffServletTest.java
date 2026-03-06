package com.oceanview.controller;

import com.oceanview.dao.StaffUserDAO;
import com.oceanview.model.StaffUser;
import org.junit.jupiter.api.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

class RegisterStaffServletTest {

    @Test
    void doPost_shouldRedirectLogin_whenNotLoggedIn() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getSession(false)).thenReturn(null);

        servlet.doPost(req, resp);

        verify(resp).sendRedirect("login.jsp");
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldDeny_whenNotAdmin() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

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
    void doPost_shouldReject_whenMissingFields() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("username")).thenReturn("");
        when(req.getParameter("password")).thenReturn("123");
        when(req.getParameter("role")).thenReturn("RECEPTIONIST");

        servlet.doPost(req, resp);

        verify(resp).sendRedirect(startsWith("register-receptionist.jsp?error="));
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldReject_whenInvalidRole() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("username")).thenReturn("newuser");
        when(req.getParameter("password")).thenReturn("123");
        when(req.getParameter("role")).thenReturn("MANAGER"); // invalid

        servlet.doPost(req, resp);

        verify(resp).sendRedirect(startsWith("register-receptionist.jsp?error="));
        verifyNoInteractions(dao);
    }

    @Test
    void doPost_shouldReject_whenUsernameExists() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("username")).thenReturn("existing");
        when(req.getParameter("password")).thenReturn("123");
        when(req.getParameter("role")).thenReturn("RECEPTIONIST");

        StaffUser existingUser = new StaffUser();
        existingUser.setUsername("existing");
        when(dao.findByUsername("existing")).thenReturn(existingUser);

        servlet.doPost(req, resp);

        verify(dao).findByUsername("existing");
        verify(resp).sendRedirect(startsWith("register-receptionist.jsp?error="));
        verify(dao, never()).insertStaffUser(anyString(), anyString(), anyString());
    }

    @Test
    void doPost_shouldRedirectSuccess_whenInsertOk() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        when(dao.findByUsername("newuser")).thenReturn(null);
        when(dao.insertStaffUser(eq("newuser"), anyString(), eq("RECEPTIONIST"))).thenReturn(true);

        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("username")).thenReturn("newuser");
        when(req.getParameter("password")).thenReturn("GoodPass123");
        when(req.getParameter("role")).thenReturn("RECEPTIONIST");

        servlet.doPost(req, resp);

        verify(dao).findByUsername("newuser");
        verify(dao).insertStaffUser(eq("newuser"), anyString(), eq("RECEPTIONIST"));
        verify(resp).sendRedirect(startsWith("register-receptionist.jsp?success="));
    }

    @Test
    void doPost_shouldRedirectDbError_whenInsertFails() throws Exception {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        when(dao.findByUsername("newuser")).thenReturn(null);
        when(dao.insertStaffUser(eq("newuser"), anyString(), eq("ADMIN"))).thenReturn(false);

        RegisterStaffServlet servlet = new RegisterStaffServlet(dao);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("username")).thenReturn("admin");
        when(session.getAttribute("role")).thenReturn("ADMIN");

        when(req.getParameter("username")).thenReturn("newuser");
        when(req.getParameter("password")).thenReturn("GoodPass123");
        when(req.getParameter("role")).thenReturn("ADMIN");

        servlet.doPost(req, resp);

        verify(dao).insertStaffUser(eq("newuser"), anyString(), eq("ADMIN"));
        verify(resp).sendRedirect(startsWith("register-receptionist.jsp?error="));
    }
}