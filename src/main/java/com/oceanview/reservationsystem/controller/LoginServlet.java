package com.oceanview.reservationsystem.controller;

import com.oceanview.reservationsystem.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");


        if (ValidationUtil.isBlank(username) || ValidationUtil.isBlank(password)) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }


        boolean ok = "admin".equals(username) && "admin123".equals(password);

        if (ok) {
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            response.sendRedirect("menu.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}