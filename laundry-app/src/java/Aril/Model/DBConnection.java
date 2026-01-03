package Aril.Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // IMPORTANT: jangan sampai jadi jdbc:mysql:///127.0.0.1...
    private static final String URL =
        "jdbc:mysql://localhost:3306/laundry_db";

    private static final String USER = "root";
    private static final String PASS = "";

    static {
        try {
            // Paksa register driver ke DriverManager
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver (com.mysql.cj.jdbc.Driver) tidak ditemukan di classpath", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
