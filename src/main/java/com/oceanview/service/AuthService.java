package com.oceanview.service;

import com.oceanview.model.StaffUser;

public interface AuthService {

    /**
     * Returns StaffUser if login is successful, otherwise returns null.
     */
    StaffUser login(String username, String password);
}