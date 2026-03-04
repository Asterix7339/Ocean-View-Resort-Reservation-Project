package com.oceanview.dao;
import com.oceanview.model.Reservation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReservationDAO {

    public boolean insert(Reservation r) {
        String sql = "INSERT INTO reservations " +
                "(reservation_number, guest_name, address, contact_number, room_type_id, check_in, check_out, total_amount) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getReservationNumber());
            ps.setString(2, r.getGuestName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getContactNumber());
            ps.setInt(5, r.getRoomTypeId());
            ps.setDate(6, r.getCheckIn());
            ps.setDate(7, r.getCheckOut());
            ps.setDouble(8, r.getTotalAmount());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Reservation findByReservationNumber(String reservationNumber) {
        String sql = "SELECT id, reservation_number, guest_name, address, contact_number, room_type_id, check_in, check_out, total_amount " +
                "FROM reservations WHERE reservation_number = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservationNumber);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Reservation r = new Reservation();
                    r.setId(rs.getInt("id"));
                    r.setReservationNumber(rs.getString("reservation_number"));
                    r.setGuestName(rs.getString("guest_name"));
                    r.setAddress(rs.getString("address"));
                    r.setContactNumber(rs.getString("contact_number"));
                    r.setRoomTypeId(rs.getInt("room_type_id"));
                    r.setCheckIn(rs.getDate("check_in"));
                    r.setCheckOut(rs.getDate("check_out"));
                    r.setTotalAmount(rs.getDouble("total_amount"));
                    return r;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public java.util.List<Reservation> findTodayCheckIns() {
        String sql = "SELECT id, reservation_number, guest_name, address, contact_number, room_type_id, check_in, check_out, total_amount " +
                "FROM reservations WHERE check_in = CURDATE() ORDER BY reservation_number";

        java.util.List<Reservation> list = new java.util.ArrayList<>();

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setReservationNumber(rs.getString("reservation_number"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setRoomTypeId(rs.getInt("room_type_id"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
                r.setTotalAmount(rs.getDouble("total_amount"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public java.util.List<Reservation> findAllOrSearch(String keyword) {

        java.util.List<Reservation> list = new java.util.ArrayList<>();

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        String sql;

        if (!hasKeyword) {
            sql = "SELECT id, reservation_number, guest_name, address, contact_number, room_type_id, check_in, check_out, total_amount " +
                    "FROM reservations ORDER BY id DESC";
        } else {
            sql = "SELECT id, reservation_number, guest_name, address, contact_number, room_type_id, check_in, check_out, total_amount " +
                    "FROM reservations " +
                    "WHERE reservation_number LIKE ? OR guest_name LIKE ? OR contact_number LIKE ? " +
                    "ORDER BY id DESC";
        }

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (hasKeyword) {
                String k = "%" + keyword.trim() + "%";
                ps.setString(1, k);
                ps.setString(2, k);
                ps.setString(3, k);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reservation r = new Reservation();
                    r.setId(rs.getInt("id"));
                    r.setReservationNumber(rs.getString("reservation_number"));
                    r.setGuestName(rs.getString("guest_name"));
                    r.setAddress(rs.getString("address"));
                    r.setContactNumber(rs.getString("contact_number"));
                    r.setRoomTypeId(rs.getInt("room_type_id"));
                    r.setCheckIn(rs.getDate("check_in"));
                    r.setCheckOut(rs.getDate("check_out"));
                    r.setTotalAmount(rs.getDouble("total_amount"));
                    list.add(r);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean updateByReservationNumber(Reservation r) {

        String sql = "UPDATE reservations SET guest_name=?, address=?, contact_number=?, room_type_id=?, check_in=?, check_out=? " +
                "WHERE reservation_number=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getContactNumber());
            ps.setInt(4, r.getRoomTypeId());
            ps.setDate(5, r.getCheckIn());
            ps.setDate(6, r.getCheckOut());
            ps.setString(7, r.getReservationNumber());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteByReservationNumber(String reservationNumber) {

        String sql = "DELETE FROM reservations WHERE reservation_number=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservationNumber);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}