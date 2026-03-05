package com.oceanview.controller;

import com.oceanview.dao.StaffUserDAO;
import com.oceanview.model.StaffUser;
import com.oceanview.util.PasswordUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/register-receptionist")
public class RegisterStaffServlet extends HttpServlet {

    private final StaffUserDAO staffUserDAO;

    // Default constructor (real app)
    public RegisterStaffServlet() {
        this.staffUserDAO = new StaffUserDAO();
    }

    // Constructor for tests
    public RegisterStaffServlet(StaffUserDAO staffUserDAO) {
        this.staffUserDAO = staffUserDAO;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String currentRole = (String) session.getAttribute("role");
        if (!"ADMIN".equals(currentRole)) {
            resp.sendRedirect("dashboard.jsp?error=" + enc("Access denied - Admin only."));
            return;
        }

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if (isEmpty(username) || isEmpty(password) || isEmpty(role)) {
            resp.sendRedirect("register-receptionist.jsp?error=" + enc("Please fill all fields."));
            return;
        }

        username = username.trim();
        role = role.trim().toUpperCase();

        if (!"ADMIN".equals(role) && !"RECEPTIONIST".equals(role)) {
            resp.sendRedirect("register-receptionist.jsp?error=" + enc("Invalid role selected."));
            return;
        }

        StaffUser existing = staffUserDAO.findByUsername(username);
        if (existing != null) {
            resp.sendRedirect("register-receptionist.jsp?error=" + enc("Username already exists: " + username));
            return;
        }

        String hash;
        try {
            hash = PasswordUtil.hashPassword(password);
        } catch (IllegalArgumentException ex) {
            resp.sendRedirect("register-receptionist.jsp?error=" + enc("Password is invalid (too long)."));
            return;
        }

        boolean ok = staffUserDAO.insertStaffUser(username, hash, role);

        if (ok) {
            resp.sendRedirect("register-receptionist.jsp?success=" + enc("Staff created (" + username + " - " + role + ")"));
        } else {
            resp.sendRedirect("register-receptionist.jsp?error=" + enc("Database error. Please try again."));
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String enc(String msg) throws IOException {
        return URLEncoder.encode(msg, "UTF-8");
    }
}