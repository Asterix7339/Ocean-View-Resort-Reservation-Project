package com.oceanview.dao;

import com.oceanview.model.StaffUser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
public class StaffUserDAO {

    public StaffUser findByUsername(String username) {
        String sql = "SELECT id, username, password_hash, role, status FROM staff_users WHERE username = ?";

        try (Connection conn = com.oceanview.dao.DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    StaffUser user = new StaffUser();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    return user;
                }
            }

        } catch (Exception e) {
            e.printStackTrace(); // later we will improve this
        }

        return null; // not found
    }
    public boolean insertStaffUser(String username, String passwordHash, String role) {
        String sql = "INSERT INTO staff_users (username, password_hash, role, status) VALUES (?, ?, ?, 'ACTIVE')";

        try (Connection conn = com.oceanview.dao.DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, passwordHash);
            ps.setString(3, role);

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}