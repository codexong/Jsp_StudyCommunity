package com.example.database;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

public class DBConnection {
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException  {		

		Connection conn = null;		
	
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "study";
		String password = "study";

		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);		
		
		return conn;
	}	
}