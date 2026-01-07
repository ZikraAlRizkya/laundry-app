package Agung.Model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ModelAgung {
    private static final String URL = "jdbc:mysql://localhost:3306/laundry_db";
    private static final String USER = "root";
    private static final String PASS = ""; // Sesuaikan jika ada password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
