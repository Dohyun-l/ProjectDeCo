package com.deco.team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	public void create_team(teamDTO tdto) {
		int idx = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from team";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				idx = rs.getInt(1) + 1;
			}

			sql = "insert into team (idx, title, content, location, master, limit_p, create_at, deadline) "
					+ "values(?,?,?,?,?,?,now(),?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, tdto.getTitle());
			pstmt.setString(3, tdto.getContent());
			pstmt.setString(4, tdto.getLocation());
			pstmt.setInt(5, tdto.getMaster());
			pstmt.setString(6, tdto.getLimit_p());
			pstmt.setString(7, tdto.getDeadline());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}

	// teamList()
	public List teamList() {

		List teamList = new ArrayList();

		teamDTO tdto = null;
		try {
			conn = getConnection();
			sql = "select * from team";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				tdto = new teamDTO();

				tdto.setContent(rs.getString("content"));
				tdto.setCreate_at(rs.getString("create_at"));
				tdto.setDeadline(rs.getString("deadline"));
				tdto.setIdx(rs.getInt("idx"));
				tdto.setLimit_p(rs.getString("limit_p"));
				tdto.setLocation(rs.getString("location"));
				tdto.setMaster(rs.getInt("master"));
				tdto.setTitle(rs.getString("title"));

				teamList.add(tdto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return teamList;
	}
	// teamList()

	// teamList(startRow,pageSize)
	public List teamList(int startRow, int pageSize) {

		List teamList = new ArrayList();

		teamDTO tdto = null;
		try {
			conn = getConnection();
			sql = "select * from team order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				tdto = new teamDTO();

				tdto.setContent(rs.getString("content"));
				tdto.setCreate_at(rs.getString("create_at"));
				tdto.setDeadline(rs.getString("deadline"));
				tdto.setIdx(rs.getInt("idx"));
				tdto.setLimit_p(rs.getString("limit_p"));
				tdto.setLocation(rs.getString("location"));
				tdto.setMaster(rs.getInt("master"));
				tdto.setTitle(rs.getString("title"));

				teamList.add(tdto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return teamList;
	}
	// teamList(startRow,pageSize)

	// numOfTeam() 팀생성 글 개수 보기
	public int numOfTeam() {
		int cnt = 0;

		try {
			conn = getConnection();
			sql = "select count(*) from team";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return cnt;
	}

	// numOfTeam()

	// getLimitPersonOfTeamIdx(int idx)
	public int getLimitPersonOfTeamIdx(int idx) {
		int result = 0;
		
		try {
			conn = getConnection();
			sql = "select limit_p from team where idx=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = rs.getInt(1);
			}
			
			System.out.println("DAO : 팀 제한 인원수 " + result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}
	// getLimitPersonOfTeamIdx(int idx)
	// getteamView
	public teamDTO getteamView(int idx){
		teamDTO tdto = null;
		try {
			conn = getConnection();
			sql = "select * from team where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				tdto.setContent(rs.getString("content"));
				tdto.setCreate_at(rs.getString("create_at"));
				tdto.setDeadline(rs.getString("deadline"));
				tdto.setIdx(rs.getInt("idx"));
				tdto.setLimit_p(rs.getString("limit_p"));
				tdto.setLocation(rs.getString("location"));
				tdto.setMaster(rs.getInt("master"));
				tdto.setTitle(rs.getString("title"));
				
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return tdto;
	}
	
	// getteamView

	// getTeam(idx) 
	public teamDTO getTeam(int idx){
		teamDTO tdto = null;
		
		try {
		conn = getConnection();
		sql="select * from team where idx=?";
		
		pstmt =	conn.prepareStatement(sql);
		pstmt.setInt(1, idx);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			 tdto = new teamDTO();
			
			 tdto.setContent(rs.getString("content"));
			 tdto.setCreate_at(rs.getString("create_at"));
			 tdto.setDeadline(rs.getString("deadline"));
			 tdto.setIdx(rs.getInt("idx"));
			 tdto.setLimit_p(rs.getString("limit_p"));
			 tdto.setLocation(rs.getString("location"));
			 tdto.setMaster(rs.getInt("master"));
			 tdto.setTitle(rs.getString("title"));
			
		}
				
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return tdto;
	}
	
	// getTeam(idx)
	
}