package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class RoomTypeDAO {

    public double getRateById(int roomTypeId) {
        String sql = "SELECT rate_per_night FROM room_types WHERE id = ? AND is_active = 1";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomTypeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("rate_per_night");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // not found or inactive
    }
    public String getNameById(int roomTypeId) {
        String sql = "SELECT code FROM room_types WHERE id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomTypeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("code"); // STANDARD / DELUXE / SUITE
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "UNKNOWN";
    }
    public boolean updateTotalRooms(int roomTypeId, int totalRooms) {

        String sql = "INSERT INTO room_stock (room_type_id, total_rooms) " +
                "VALUES (?, ?) " +
                "ON DUPLICATE KEY UPDATE total_rooms = VALUES(total_rooms)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomTypeId);
            ps.setInt(2, totalRooms);

            return ps.executeUpdate() >= 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}