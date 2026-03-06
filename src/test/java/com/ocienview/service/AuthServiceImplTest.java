package com.oceanview.service;

import com.oceanview.dao.StaffUserDAO;
import com.oceanview.model.StaffUser;
import com.oceanview.service.impl.AuthServiceImpl;
import com.oceanview.util.PasswordUtil;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AuthServiceImplTest {

    @Test
    void login_shouldReturnNull_whenUsernameEmpty() {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        AuthServiceImpl service = new AuthServiceImpl(dao);

        assertNull(service.login("", "abc123"));
        verifyNoInteractions(dao);
    }

    @Test
    void login_shouldReturnNull_whenPasswordEmpty() {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        AuthServiceImpl service = new AuthServiceImpl(dao);

        assertNull(service.login("admin", ""));
        verifyNoInteractions(dao);
    }

    @Test
    void login_shouldReturnNull_whenUserNotFound() {
        StaffUserDAO dao = mock(StaffUserDAO.class);
        when(dao.findByUsername("admin")).thenReturn(null);

        AuthServiceImpl service = new AuthServiceImpl(dao);

        assertNull(service.login("admin", "abc123"));
        verify(dao).findByUsername("admin");
    }

    @Test
    void login_shouldReturnNull_whenUserInactive() {
        StaffUserDAO dao = mock(StaffUserDAO.class);

        StaffUser u = new StaffUser();
        u.setUsername("admin");
        u.setStatus("INACTIVE");
        u.setPasswordHash(PasswordUtil.hashPassword("abc123"));

        when(dao.findByUsername("admin")).thenReturn(u);

        AuthServiceImpl service = new AuthServiceImpl(dao);

        assertNull(service.login("admin", "abc123"));
        verify(dao).findByUsername("admin");
    }

    @Test
    void login_shouldReturnNull_whenPasswordWrong() {
        StaffUserDAO dao = mock(StaffUserDAO.class);

        StaffUser u = new StaffUser();
        u.setUsername("admin");
        u.setStatus("ACTIVE");
        u.setPasswordHash(PasswordUtil.hashPassword("correct"));

        when(dao.findByUsername("admin")).thenReturn(u);

        AuthServiceImpl service = new AuthServiceImpl(dao);

        assertNull(service.login("admin", "wrong"));
        verify(dao).findByUsername("admin");
    }

    @Test
    void login_shouldReturnUser_whenCredentialsCorrectAndActive() {
        StaffUserDAO dao = mock(StaffUserDAO.class);

        StaffUser u = new StaffUser();
        u.setUsername("reception");
        u.setStatus("ACTIVE");
        u.setRole("RECEPTIONIST");
        u.setPasswordHash(PasswordUtil.hashPassword("abc123"));

        when(dao.findByUsername("reception")).thenReturn(u);

        AuthServiceImpl service = new AuthServiceImpl(dao);

        StaffUser result = service.login("reception", "abc123");

        assertNotNull(result);
        assertEquals("reception", result.getUsername());
        assertEquals("RECEPTIONIST", result.getRole());
        verify(dao).findByUsername("reception");
    }
}