package com.oceanview.reservationsystem.util;

public final class ValidationUtil {

    private ValidationUtil() {}

    public static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}