package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author xuant
 */
public class DBUtils {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        String user = "sa";
        String pass = "123";
        Connection conn = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=Vegetable";
        conn = DriverManager.getConnection(url,user,pass);
        return conn;
    }
}