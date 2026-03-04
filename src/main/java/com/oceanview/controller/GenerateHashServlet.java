package com.oceanview.controller;

import com.oceanview.util.PasswordUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/gen-hash")
public class GenerateHashServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Change these passwords if you want
        String adminPass = "admin123";
        String recPass = "reci123";

        String adminHash = PasswordUtil.hashPassword(adminPass);
        String recHash = PasswordUtil.hashPassword(recPass);

        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();

        out.println("ADMIN password = " + adminPass);
        out.println("ADMIN hash     = " + adminHash);
        out.println();
        out.println("RECEPTIONIST password = " + recPass);
        out.println("RECEPTIONIST hash     = " + recHash);
    }
}