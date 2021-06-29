package com.deco.report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class reportDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	
	private Connection getConnection(){
		try {
			//Context 객체를 생성 (프로젝트 정보를 가지고있는객체)
			Context initCTX = new InitialContext();
			// DB연동 정보를 불러오기(context.xml)
			DataSource ds =
			(DataSource) initCTX.lookup("java:comp/env/jdbc/deco");
			
			conn = ds.getConnection();
			
			System.out.println(" 드라이버 로드, 디비연결 성공! ");
			System.out.println(conn);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	// getConnection() - 디비연결 끝
	
	// 자원해제코드 - finally 구문에서 사용
	public void closeDB(){
		try {
			if(rs != null){ rs.close(); }
			if(pstmt != null){ pstmt.close();}
			if(conn != null){ conn.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	//insertReport
	/**
	 * @return 정상 1, 비정상 -1
	*/
	public int insertReport(reportDTO rDTO){
		int flag = -1;
	
		try {
			conn = getConnection();
			
			int idx = 0;
			
			sql = "select max(idx) from report";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt(1);
			}
			
			sql = "insert into report (idx, user_num, content_num, re_type"
					+ ", content_type, re_comment, re_date) "
					+ "values(?,?,?,?,?,?,now())";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setInt(2, rDTO.getUser_num());
			pstmt.setInt(3, rDTO.getContent_num());
			pstmt.setInt(4, rDTO.getRe_type());
			pstmt.setInt(5, rDTO.getContent_type());
			pstmt.setString(6, rDTO.getRe_comment());
			
			pstmt.executeUpdate();
			flag = 1;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	//insertReport
	
}
