package com.oceanview.controller;

import com.oceanview.model.StaffUser;
import com.oceanview.service.AuthService;
import com.oceanview.service.impl.AuthServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        StaffUser user = authService.login(username, password);

        if (user == null) {
            resp.sendRedirect("login.jsp?error=" + enc("Login failed - invalid username or password."));
            return;
        }

        // Create session (logged in)
        HttpSession session = req.getSession(true);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        // Redirect with URL toast
        resp.sendRedirect("dashboard.jsp?success=" + enc("Login successful - Welcome, " + user.getUsername() + "!"));
    }

    private String enc(String msg) throws IOException {
        return URLEncoder.encode(msg, "UTF-8");
    }
}