package com.oceanview.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // 1) Single instance (Singleton)
    private static DBConnection instance;

    // 2) DB settings (we keep here for now; later we can move to a config file)
    private final String url = "jdbc:mysql://localhost:3306/oceanview_reservation?useSSL=false&serverTimezone=UTC";
    private final String user = "root";
    private final String password = "satham123"; // put your MySQL root password here

    // 3) Private constructor (so no one can create new objects)

    private DBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }


    // 4) Public method to get the one instance
    public static DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    // 5) Provide a new connection when needed
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}