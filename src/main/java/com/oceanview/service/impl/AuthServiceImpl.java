package com.oceanview.service.impl;

import com.oceanview.dao.StaffUserDAO;
import com.oceanview.model.StaffUser;
import com.oceanview.service.AuthService;
import com.oceanview.util.PasswordUtil;

public class AuthServiceImpl implements AuthService {

    private final StaffUserDAO staffUserDAO = new StaffUserDAO();

    @Override
    public StaffUser login(String username, String password) {

        // basic validation
        if (username == null || username.trim().isEmpty()) return null;
        if (password == null || password.trim().isEmpty()) return null;

        StaffUser user = staffUserDAO.findByUsername(username.trim());
        if (user == null) return null;

        // status check
        if (!"ACTIVE".equals(user.getStatus())) return null;

        // password check
        try {
            boolean ok = PasswordUtil.verifyPassword(password, user.getPasswordHash());
            if (!ok) return null;
        } catch (IllegalArgumentException ex) {
            return null;
        }

        return user; // success
    }
}