package com.oceanview.controller;

import com.oceanview.model.StaffUser;
import com.oceanview.service.AuthService;
import com.oceanview.service.impl.AuthServiceImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        StaffUser user = authService.login(username, password);

        if (user == null) {
            resp.sendRedirect("login-error.jsp");
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());

        resp.sendRedirect("dashboard.jsp");
    }
}