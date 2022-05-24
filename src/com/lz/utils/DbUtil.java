package com.lz.utils;
import java.sql.*;

public class DbUtil {
  //澹版槑杩炴帴鏁版嵁搴撶殑淇℃伅锛屼緥濡傛暟鎹簱URL銆佺敤鎴峰悕鍙婂瘑鐮�

	private static final String URL="jdbc:mysql://localhost:3306/exam?serverTimezone=UTC";//杩欓噷鏄垜鏁版嵁搴撶殑鍚嶅瓧

	private static final String USER="root";
	private static final String PASSWORD="549436";//杩欓噷鏄垜鏁版嵁搴撶殑瀵嗙爜
	//澹版槑JDBC鐨勭浉鍏冲璞�
	protected static Statement s = null;
	protected static ResultSet rs = null;
	protected static boolean rsd = false;
	protected static Connection conn = null;
	//鍒涘缓鏁版嵁搴撹繛鎺�	鍗曚釜绾跨▼璁块棶
	public static synchronized Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL,USER,PASSWORD);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	//鎵цINSERT銆乁PDATE銆丏ELETE璇彞 sql SQL璇彞锛屽瓧绗︿覆绫诲瀷 鎵ц缁撴灉int绫诲瀷
	public static int executeUpdate(String sql) {
		int result = 0;
		try {
			s = getConnection().createStatement();
			result = s.executeUpdate(sql);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return result;
		
	}
	//鎵цSELECT璇彞 sql SQL璇彞锛屽瓧绗︿覆绫诲瀷 return ResultSet缁撴灉闆�
	public static ResultSet executeQuery(String sql) {
		try {
			s = getConnection().createStatement();
			rs = s.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return rs;
	}
	
	/*
	 * 鎵ц鍔ㄦ�丼QL璇彞
	 * sql鍚湁鍙傛暟鐨勫姩鎬丼QL璇彞
	 * return 杩斿洖PreparedStatement瀵硅薄
	 * */
	public static PreparedStatement executePreparedStatement(String sql) {
		PreparedStatement ps = null;
		try {
			ps = getConnection().prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ps;
	}
	/*
	 * 浜嬪姟鍥炴粴
	 * */
	public static void rollback() {
		try {
			getConnection().rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * 鍏抽棴鏁版嵁搴撹繛鎺ュ璞�
	 * */
	public static void close() {
		
			try {
				if(rs!=null)
				rs.close();
				if(s!=null) s.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
}
