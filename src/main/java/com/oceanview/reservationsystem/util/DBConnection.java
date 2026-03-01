package com.oceanview.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {


    private static DBConnection instance;


    private final String url = "jdbc:mysql://localhost:3306/oceanview_reservation?useSSL=false&serverTimezone=UTC";
    private final String user = "root";
    private final String password = "satham123";



    private DBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }



    public static DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }


    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}