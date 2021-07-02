package com.deco.team.comment;

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

import com.deco.share_comment.commentDTO;

public class Team_commentDAO {

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
	
	public void teamComment_insert(Team_commentDTO tcdto){
		int idx=0;
		
		try {
			conn = getConnection();
			sql="select max(COMMENTNUM) from team_comment";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt(1)+1;
			}
			sql ="insert into team_comment(idx, team_idx, nickname, content, create_at, secret) "
					+ "values(?,?,?,?,now(),?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setInt(2, tcdto.getTeam_idx());
			pstmt.setString(3, tcdto.getNickname());
			pstmt.setString(4, tcdto.getContent());
			pstmt.setInt(5, tcdto.getSecret());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
		
	// teamComment_List()
		public List teamComment_List() {
			List commentList = new ArrayList();

			Team_commentDTO tcdto = null;
			try {
				conn = getConnection();
				sql = "select * from team_comment order by create_at desc";
				pstmt = conn.prepareStatement(sql);

				rs = pstmt.executeQuery();

				while (rs.next()) {

					tcdto = new Team_commentDTO();

					

					commentList.add(tcdto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return commentList;
		}
		// teamComment_List()

		// teamComment_List(team_idx)
		public List getCommentList(int team_idx) {
			List commentList = new ArrayList();

			Team_commentDTO tcdto = null;
			try {
				conn = getConnection();
				sql = "select * from team_comment where team_idx=? order by create_at desc";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, team_idx);

				rs = pstmt.executeQuery();

				while (rs.next()) {

					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return commentList;
		}
		// teamComment_List(team_idx)
	
	
	
	
	
	
	
	
	
	
	
}
