package com.oceanview.controller;

import com.oceanview.model.StaffUser;
import com.oceanview.service.AuthService;
import org.junit.jupiter.api.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

class LoginServletTest {

    @Test
    void doPost_shouldRedirectToLoginWithError_whenInvalidCredentials() throws Exception {

        // Mock service
        AuthService authService = mock(AuthService.class);
        when(authService.login("bad", "bad")).thenReturn(null);

        // Servlet with injected mock
        LoginServlet servlet = new LoginServlet(authService);

        // Mock request/response
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);

        when(req.getParameter("username")).thenReturn("bad");
        when(req.getParameter("password")).thenReturn("bad");

        // Execute
        servlet.doPost(req, resp);

        // Verify redirect
        verify(resp).sendRedirect(startsWith("login.jsp?error="));

        // No session should be created when login fails
        verify(req, never()).getSession(true);
    }

    @Test
    void doPost_shouldCreateSessionAndRedirectToDashboard_whenValidCredentials() throws Exception {

        // Mock service returns user
        AuthService authService = mock(AuthService.class);

        StaffUser user = new StaffUser();
        user.setUsername("reception");
        user.setRole("RECEPTIONIST");

        when(authService.login("reception", "abc123")).thenReturn(user);

        LoginServlet servlet = new LoginServlet(authService);

        // Mock request/response/session
        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getParameter("username")).thenReturn("reception");
        when(req.getParameter("password")).thenReturn("abc123");
        when(req.getSession(true)).thenReturn(session);

        // Execute
        servlet.doPost(req, resp);

        // Verify session is set
        verify(session).setAttribute("username", "reception");
        verify(session).setAttribute("role", "RECEPTIONIST");

        // Verify redirect
        verify(resp).sendRedirect(startsWith("dashboard.jsp?success="));
    }
}