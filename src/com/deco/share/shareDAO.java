package com.deco.share;
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


public class shareDAO {
	
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

	// insertShare
		public void insertShare(shareDTO sDTO){
			int idx = 0;
			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();		
				
				// 3 sql (글번호를 계산하는 구문)
				sql = "select max(idx) from share";

				pstmt = conn.prepareStatement(sql);
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리
				if(rs.next()){
					idx = rs.getInt(1)+1;
				}
				
				// 3 sql 작성 (insert) & pstmt 객체 생성
				sql = "insert into share "
						+ "values(?,?,?,?,?,?,?,?,now(),?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				// ?
				pstmt.setInt(1, idx);
				pstmt.setInt(2, sDTO.getUser_num());
				pstmt.setString(3, sDTO.getTitle());
				pstmt.setString(4, sDTO.getContent());
				pstmt.setString(5, sDTO.getFile());
				pstmt.setString(6, sDTO.getCategory());
				pstmt.setInt(7, sDTO.getRead_cnt());
				pstmt.setInt(8, sDTO.getLike());
				pstmt.setString(9, sDTO.getTag());
				pstmt.setInt(10, sDTO.getAnony());
				
				// 4 sql 실행	
				
				pstmt.executeUpdate();
				
				System.out.println(" sql 구문 실행완료  : 글쓰기 완료! ");
				
			} catch (SQLException e) {
				System.out.println("디비 연결 실패!!");
				e.printStackTrace();
			} finally{
				closeDB();
				
			}
			
		}
		// insertShare
	
		//getShareReadCount() 글의 개수 계산
		public int getShareReadCount(){
			int cnt =0;
			
			try{
		  conn = getConnection();
		  sql="select count(*) from share";
		  pstmt = conn.prepareStatement(sql);
		  
		  rs = pstmt.executeQuery();
		  
		  if(rs.next()){
			  cnt = rs.getInt(1);
		  }
		  
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return cnt;
		}
		//getShareReadCount()
	
		//getShareList()
		public List getShareList(){
			
			List shareList = new ArrayList();
			
			shareDTO sDTO = null;
			try{
			conn = getConnection();
			sql="select * from share";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				sDTO = new shareDTO();
				
				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("tag"));
				sDTO.setUser_num(rs.getInt("user_num"));
				
				
				shareList.add(sDTO);
			}
			
			
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return shareList;
			
		}
		//getShareList()
	
		//getShareList(startRow,pageSize)
		public List getShareList(int startRow,int pageSize){
			
			List shareList = new ArrayList();
			
			shareDTO sDTO = null;
			try{
			conn = getConnection();
			sql="select * from share limit ?,?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				sDTO = new shareDTO();
				
				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("tag"));
				sDTO.setUser_num(rs.getInt("user_num"));
				
				
				shareList.add(sDTO);
			}			
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return shareList;
			
		}
		//getShareList(startRow,pageSize)
	
	
	
	
	
}
