package com.oceanview.controller;

import com.oceanview.dao.RoomTypeDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/update-room-stock")
public class UpdateRoomStockServlet extends HttpServlet {

    private final RoomTypeDAO roomTypeDAO;

    // Default constructor (real app)
    public UpdateRoomStockServlet() {
        this.roomTypeDAO = new RoomTypeDAO();
    }

    // Constructor for tests
    public UpdateRoomStockServlet(RoomTypeDAO roomTypeDAO) {
        this.roomTypeDAO = roomTypeDAO;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            resp.sendRedirect("dashboard.jsp?error=" + enc("Access denied - Admin only."));
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
            resp.sendRedirect("manage-room-stock.jsp?error=" + enc("Update failed - invalid input."));
            return;
        }

        if (roomTypeId <= 0 || totalRooms < 0) {
            resp.sendRedirect("manage-room-stock.jsp?error=" + enc("Update failed - total rooms must be 0 or more."));
            return;
        }

        boolean ok = roomTypeDAO.updateTotalRooms(roomTypeId, totalRooms);

        if (ok) {
            resp.sendRedirect("manage-room-stock.jsp?success=" +
                    enc("Room stock updated (Type ID: " + roomTypeId + ", Total: " + totalRooms + ")"));
        } else {
            resp.sendRedirect("manage-room-stock.jsp?error=" + enc("Update failed - database error."));
        }
    }

    private String enc(String msg) throws IOException {
        return URLEncoder.encode(msg, "UTF-8");
    }
}