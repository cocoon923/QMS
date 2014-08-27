package dbOperation;

import java.sql.*;
import java.util.*;

public class DBConnection {
	String sDBDriver = "oracle.jdbc.driver.OracleDriver";
	// private static String sDBDriver = "com.mysql.jdbc.Driver";
//	private static String sDBURL = "jdbc:oracle:thin:@10.11.32.157:1521:CASE";
	private static String sDBURL = "jdbc:oracle:thin:@127.0.0.1:1521:ORCL";
	private static String sDBUser = "qms";
	private static String sDBPassword = "qms";

	private Connection conn = null;
	private Statement stmt = null;
	ResultSet rs = null;

	public DBConnection() {
		try {
			Class.forName(sDBDriver);
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("DBConnection():" + e.getMessage());
		}
	}

	public ResultSet executeQuery(String sql) {
		rs = null;
		try {
			// conn=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:yanwg","AICMS","AICMS");
			conn = DriverManager.getConnection(sDBURL, sDBUser, sDBPassword);

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException ex) {
			System.out.print(sql);
			System.err.println("aq.executeQuery:" + ex.getMessage());
		}
		return rs;
	}

	public Vector selectVector(String sql) {
		Vector ver = new Vector();
		// System.out.print(sql);
		try {
			// conn=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:yanwg","AICMS","AICMS");
			conn = DriverManager.getConnection(sDBURL, sDBUser, sDBPassword);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rmd = rs.getMetaData();
			int columCount = rmd.getColumnCount();
			String[] columNames = new String[columCount];
			while (rs.next()) {
				HashMap hash = new HashMap();
				String rss = "";
				int idss = 0;
				for (int j = 0; j < columCount; j++)
				// for(int j=columCount-1;j>0;j--)
				{
					columNames[idss] = rmd.getColumnName(j + 1);
					rss = rs.getString(columNames[idss]);
					// System.out.print(rss);
					hash.put(columNames[idss], rss);
				}
				ver.add(idss, hash);
				idss++;
			}
		} catch (SQLException e) {
			closeStmt();
			closeConn();
			System.out.print(sql);
			e.printStackTrace();
			// System.out.println(ExceptionUtils.getExceptionStackTraceString(e));
		}
		closeStmt();
		closeConn();
		return ver;
	}

	public boolean executeUpdate(String sql) {
		stmt = null;
		rs = null;
		try {
			// conn=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:yanwg","AICMS","AICMS");
			conn = DriverManager.getConnection(sDBURL, sDBUser, sDBPassword);

			stmt = conn.createStatement();
			stmt.executeQuery(sql);
			stmt.close();
			conn.close();
		} catch (SQLException ex) {
			closeStmt();
			closeConn();
			System.out.print(sql);
			System.err.println("aq.executeQuery:" + ex.getMessage());
			return false;
		}
		return true;
	}

	public void closeStmt() {
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void executeProcess(String sProcedure) {
		try {
			// conn=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:yanwg","AICMS","AICMS");
			conn = DriverManager.getConnection(sDBURL, sDBUser, sDBPassword);
			CallableStatement cstmt = conn.prepareCall(sProcedure);
			cstmt.executeUpdate();
			closeConn();
		} catch (SQLException e) {
			closeConn();
			e.printStackTrace();
		}

	}

	public void closeConn() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
