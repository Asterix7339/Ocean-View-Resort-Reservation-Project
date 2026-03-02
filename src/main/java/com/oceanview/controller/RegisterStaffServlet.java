package com.oceanview.web;

import com.oceanview.dao.StaffUserDAO;
import com.oceanview.model.StaffUser;
import com.oceanview.util.PasswordUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register-receptionist") // keep this because your form action uses it
public class RegisterStaffServlet extends HttpServlet {

    private final StaffUserDAO staffUserDAO = new StaffUserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Must be logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Must be ADMIN (server-side protection)
        String currentRole = (String) session.getAttribute("role");
        if (!"ADMIN".equals(currentRole)) {
            resp.sendRedirect("access-denied.jsp");
            return;
        }

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        // Basic validation
        if (isEmpty(username) || isEmpty(password) || isEmpty(role)) {
            resp.sendRedirect("staff-create-error.jsp");
            return;
        }

        role = role.trim().toUpperCase();

        // Only allow these two roles (important!)
        if (!"ADMIN".equals(role) && !"RECEPTIONIST".equals(role)) {
            resp.sendRedirect("staff-create-error.jsp");
            return;
        }

        // Check duplicate username
        StaffUser existing = staffUserDAO.findByUsername(username.trim());
        if (existing != null) {
            resp.sendRedirect("staff-create-error.jsp");
            return;
        }

        // Hash password
        String hash;
        try {
            hash = PasswordUtil.hashPassword(password);
        } catch (IllegalArgumentException ex) {
            resp.sendRedirect("staff-create-error.jsp");
            return;
        }

        boolean ok = staffUserDAO.insertStaffUser(username.trim(), hash, role);

        if (ok) {
            resp.sendRedirect("staff-create-success.jsp");
        } else {
            resp.sendRedirect("staff-create-error.jsp");
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}