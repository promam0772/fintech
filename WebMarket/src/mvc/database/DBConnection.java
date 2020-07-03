package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static Connection getConnection() throws SQLException, ClassNotFoundException{
		
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/webmarketDB";
		String user = "root";
		String passwd = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");    //드라이버 로딩
		conn = DriverManager.getConnection(url,user,passwd);
		
		return conn;
	}
}
