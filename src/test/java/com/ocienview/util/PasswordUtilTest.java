package com.oceanview.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PasswordUtilTest {

    @Test
    void hashPassword_shouldReturnNonEmptyHash() {
        String hash = PasswordUtil.hashPassword("abc123");
        assertNotNull(hash);
        assertFalse(hash.trim().isEmpty());
    }

    @Test
    void verifyPassword_shouldReturnTrueForCorrectPassword() {
        String password = "abc123";
        String hash = PasswordUtil.hashPassword(password);

        assertTrue(PasswordUtil.verifyPassword(password, hash));
    }

    @Test
    void verifyPassword_shouldReturnFalseForWrongPassword() {
        String hash = PasswordUtil.hashPassword("abc123");
        assertFalse(PasswordUtil.verifyPassword("wrong", hash));
    }

    @Test
    void verifyPassword_shouldReturnFalseIfStoredHashIsNullOrEmpty() {
        assertFalse(PasswordUtil.verifyPassword("abc123", null));
        assertFalse(PasswordUtil.verifyPassword("abc123", ""));
        assertFalse(PasswordUtil.verifyPassword("abc123", "   "));
    }

    @Test
    void hashPassword_shouldThrowIfNull() {
        IllegalArgumentException ex =
                assertThrows(IllegalArgumentException.class, () -> PasswordUtil.hashPassword(null));

        assertTrue(ex.getMessage().toLowerCase().contains("null"));
    }

    @Test
    void verifyPassword_shouldThrowIfPasswordNull() {
        assertThrows(IllegalArgumentException.class, () -> PasswordUtil.verifyPassword(null, "$2a$10$anything"));
    }

    @Test
    void hashPassword_shouldThrowIfPasswordExceeds72BytesUtf8() {
        // 73 ASCII chars = 73 bytes in UTF-8 (exceeds 72)
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 73; i++) {
            sb.append("a");
        }
        String tooLong = sb.toString();

        IllegalArgumentException ex =
                assertThrows(IllegalArgumentException.class, () -> PasswordUtil.hashPassword(tooLong));

        assertTrue(ex.getMessage().toLowerCase().contains("too long"));
    }
}