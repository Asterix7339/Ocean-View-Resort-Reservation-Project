package com.oceanview.model;

public class StaffUser {
    private int id;
    private String username;
    private String passwordHash;
    private String role;   // "ADMIN" or "RECEPTIONIST"
    private String status; // "ACTIVE" or "DISABLED"

    public StaffUser() {}

    public StaffUser(int id, String username, String passwordHash, String role, String status) {
        this.id = id;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}