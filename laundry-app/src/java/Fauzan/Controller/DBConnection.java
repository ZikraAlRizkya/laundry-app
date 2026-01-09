package Fauzan.Controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

//Sesuai modul praktikum tidak diubah-ubah
//JDBC menggunakan DBConnection dan bisa dipakai oleh anggota lain

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/laundry_db";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }

    private Connection con;
    private Statement stmt;

    public boolean isConnected;
    public String message;

    public DBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
            stmt = con.createStatement();
            isConnected = true;
            message = "Database berhasil terhubung";
        } catch (Exception e) {
            isConnected = false;
            message = e.getMessage();
        }
    }

    public void runQuery(String query) {
        try {
            int result = stmt.executeUpdate(query);
            message = "Query berhasil, " + result + " baris terpengaruh";
        } catch (Exception e) {
            message = e.getMessage();
        }
    }

    public ResultSet getData(String query) {
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery(query);
        } catch (Exception e) {
            message = e.getMessage();
        }
        return rs;
    }

    public void disconnect() {
        try {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
            isConnected = false;
            message = "Database berhasil diputus";
        } catch (Exception e) {
            message = e.getMessage();
        }
    }
}
