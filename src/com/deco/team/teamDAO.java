package com.deco.team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class teamDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";

	private Connection getConnection() {
		try {
			// Context 객체를 생성 (프로젝트 정보를 가지고있는객체)
			Context initCTX = new InitialContext();
			// DB연동 정보를 불러오기(context.xml)
			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/deco");

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
	public void closeDB() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// 자원해제코드 - finally 구문에서 사용
	
	
	
	public void create_team(teamDTO tdto){
					int idx = 0;
			try {
					conn = getConnection();
					sql="select count(*) from team";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()){
						idx = rs.getInt(1)+1;
					}
					
					sql = "insert into team (idx, title, content, location, master, limit_p, create_at, deadline) "
						+ "values(?,?,?,?,?,?,now(),?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, idx);
					pstmt.setString(2, tdto.getTitle());
					pstmt.setString(3, tdto.getContent());
					pstmt.setString(4,tdto.getLocation());
					pstmt.setInt(5, tdto.getMaster());
					pstmt.setString(6, tdto.getLimit_p());
					pstmt.setString(7, tdto.getDeadline());
					pstmt.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}finally{
					closeDB();
				}
	}
}
