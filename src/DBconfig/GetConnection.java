package DBconfig;

import java.sql.Connection;
import java.sql.DriverManager;

public class GetConnection {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/eTurnDB",
                "root",
                ""
            );

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
