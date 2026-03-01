package com.oceanview.util;

import org.bouncycastle.crypto.generators.OpenBSDBCrypt;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

public class PasswordUtil {

    // BCrypt uses only first 72 bytes of the password
    private static final int MAX_PASSWORD_BYTES = 72;

    // BCrypt salt size is 16 bytes
    private static final int SALT_BYTES = 16;

    // Cost factor (work factor)
    private static final int COST = 12;

    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    private PasswordUtil() {}

    public static String hashPassword(String plainPassword) {
        validatePasswordLength(plainPassword);

        byte[] salt = new byte[SALT_BYTES];
        SECURE_RANDOM.nextBytes(salt);

        // BouncyCastle BCrypt
        return OpenBSDBCrypt.generate(plainPassword.toCharArray(), salt, COST);
    }

    public static boolean verifyPassword(String plainPassword, String storedHash) {
        validatePasswordLength(plainPassword);
        if (storedHash == null || storedHash.trim().isEmpty()) return false;

        return OpenBSDBCrypt.checkPassword(storedHash, plainPassword.toCharArray());
    }

    private static void validatePasswordLength(String plainPassword) {
        if (plainPassword == null) {
            throw new IllegalArgumentException("Password cannot be null");
        }
        byte[] bytes = plainPassword.getBytes(StandardCharsets.UTF_8);
        if (bytes.length > MAX_PASSWORD_BYTES) {
            throw new IllegalArgumentException("Password is too long (max 72 bytes)");
        }
    }
}