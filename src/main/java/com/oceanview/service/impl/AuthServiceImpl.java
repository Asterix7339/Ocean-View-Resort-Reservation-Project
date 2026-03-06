package com.oceanview.service.impl;

import com.oceanview.dao.StaffUserDAO;
import com.oceanview.model.StaffUser;
import com.oceanview.service.AuthService;
import com.oceanview.util.PasswordUtil;

public class AuthServiceImpl implements AuthService {

    private final StaffUserDAO staffUserDAO;

    // Default constructor (used in your real app)
    public AuthServiceImpl() {
        this.staffUserDAO = new StaffUserDAO();
    }

    // Constructor for testing (inject DAO)
    public AuthServiceImpl(StaffUserDAO staffUserDAO) {
        this.staffUserDAO = staffUserDAO;
    }

    @Override
    public StaffUser login(String username, String password) {

        if (username == null || username.trim().isEmpty()) return null;
        if (password == null || password.trim().isEmpty()) return null;

        StaffUser user = staffUserDAO.findByUsername(username.trim());
        if (user == null) return null;

        if (!"ACTIVE".equals(user.getStatus())) return null;

        try {
            boolean ok = PasswordUtil.verifyPassword(password, user.getPasswordHash());
            if (!ok) return null;
        } catch (IllegalArgumentException ex) {
            return null;
        }

        return user;
    }
}