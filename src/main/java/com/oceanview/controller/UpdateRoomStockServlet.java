package com.oceanview.controller;

import com.oceanview.dao.RoomTypeDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-room-stock")
public class UpdateRoomStockServlet extends HttpServlet {

    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Must be logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Must be ADMIN
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            resp.sendRedirect("access-denied.jsp");
            return;
        }

        String roomTypeIdStr = req.getParameter("roomTypeId");
        String totalRoomsStr = req.getParameter("totalRooms");

        int roomTypeId;
        int totalRooms;

        try {
            roomTypeId = Integer.parseInt(roomTypeIdStr);
            totalRooms = Integer.parseInt(totalRoomsStr);
        } catch (Exception e) {
            resp.sendRedirect("room-stock-error.jsp");
            return;
        }

        if (roomTypeId <= 0 || totalRooms < 0) {
            resp.sendRedirect("room-stock-error.jsp");
            return;
        }

        boolean ok = roomTypeDAO.updateTotalRooms(roomTypeId, totalRooms);

        if (ok) {
            resp.sendRedirect("room-stock-success.jsp");
        } else {
            resp.sendRedirect("room-stock-error.jsp");
        }
    }
}