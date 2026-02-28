package com.oceanview.reservationsystem.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/ocean_restaurant_reservation?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "YOUR_PASSWORD";

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}