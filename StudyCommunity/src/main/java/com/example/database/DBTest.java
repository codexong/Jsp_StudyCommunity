package com.example.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBTest {
	 public static void main(String[] args) {
	        Connection conn = null;

	        try {
	            // JDBC 드라이버 로딩
	            Class.forName("oracle.jdbc.driver.OracleDriver");

	            // DB 연결
	            String url = "jdbc:oracle:thin:@localhost:1521:xe"; // JDBC URL
	            String user = "study"; // DB 계정 이름
	            String password = "study"; // DB 계정 비밀번호
	            conn = DriverManager.getConnection(url, user, password);

	            System.out.println("DB 연결 성공");
	        } catch (ClassNotFoundException e) {
	            System.out.println("JDBC 드라이버 로딩 실패");
	        } catch (SQLException e) {
	            System.out.println("DB 연결 실패");
	        } finally {
	            try {
	                if (conn != null) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
}
