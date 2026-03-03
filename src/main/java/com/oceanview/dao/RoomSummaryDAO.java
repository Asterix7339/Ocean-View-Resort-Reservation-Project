package com.oceanview.dao;

import com.oceanview.model.RoomSummary;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomSummaryDAO {

    public List<RoomSummary> getTodaySummary() {

        String sql =
                "SELECT rt.id AS room_type_id, rt.code AS room_type_code, " +
                        "       COALESCE(rs.total_rooms, 0) AS total_rooms, " +
                        "       COALESCE(occ.occupied_rooms, 0) AS occupied_rooms " +
                        "FROM room_types rt " +
                        "LEFT JOIN room_stock rs ON rs.room_type_id = rt.id " +
                        "LEFT JOIN ( " +
                        "    SELECT room_type_id, COUNT(*) AS occupied_rooms " +
                        "    FROM reservations " +
                        "    WHERE check_in <= CURDATE() AND check_out > CURDATE() " +
                        "    GROUP BY room_type_id " +
                        ") occ ON occ.room_type_id = rt.id " +
                        "WHERE rt.is_active = 1 " +
                        "ORDER BY rt.id";

        List<RoomSummary> list = new ArrayList<>();

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomSummary s = new RoomSummary();
                s.setRoomTypeId(rs.getInt("room_type_id"));
                s.setRoomTypeCode(rs.getString("room_type_code"));

                int total = rs.getInt("total_rooms");
                int occupied = rs.getInt("occupied_rooms");

                s.setTotalRooms(total);
                s.setOccupiedRooms(occupied);

                int available = total - occupied;
                if (available < 0) available = 0; // safety
                s.setAvailableRooms(available);

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}