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

import com.sun.org.apache.bcel.internal.generic.CompoundInstruction;

public class shareDAO {

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

	// insertShare
	public void insertShare(shareDTO sDTO) {
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
			if (rs.next()) {
				idx = rs.getInt(1) + 1;
			}

			// 3 sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into share " + "values(?,?,?,?,?,?,?,?,now(),?,?)";

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
		} finally {
			closeDB();

		}

	}
	// insertShare

	// numOfShare() 글의 개수 계산
	public int numOfShare() {
		int cnt = 0;

		try {
			conn = getConnection();
			sql = "select count(*) from share";
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
	// numOfShare()

	// getShareList()
	public List getShareList() {

		List shareList = new ArrayList();

		shareDTO sDTO = null;
		try {
			conn = getConnection();
			sql = "select * from share";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				sDTO = new shareDTO();

				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setUser_num(rs.getInt("user_num"));

				shareList.add(sDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return shareList;

	}
	// getShareList()

	// getShareList(startRow,pageSize)
	public List getShareList(int startRow, int pageSize) {

		List shareList = new ArrayList();

		shareDTO sDTO = null;
		try {
			conn = getConnection();
			sql = "select * from share order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				sDTO = new shareDTO();

				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setUser_num(rs.getInt("user_num"));

				shareList.add(sDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return shareList;

	}
	// getShareList(startRow,pageSize)

	// getShareList(startRow,pageSize,category)
	public List getShareList(int startRow, int pageSize, String category) {

		List shareList = new ArrayList();

		shareDTO sDTO = null;
		try {
			conn = getConnection();
			sql = "select * from share where category=? order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, category);
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				sDTO = new shareDTO();

				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setUser_num(rs.getInt("user_num"));

				shareList.add(sDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return shareList;

	}
	// getShareList(startRow,pageSize,category)

	// getShare(idx)
	public shareDTO getShare(int idx) {
		shareDTO sDTO = null;
		try {
			conn = getConnection();

			sql = "select * from share where idx=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sDTO = new shareDTO();

				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setUser_num(rs.getInt("user_num"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return sDTO;
	}
	// getShare(idx)

	// deleteShareContent(idx)
	public void deleteShareContent(String idx) {

		try {
			conn = getConnection();
			sql = "delete from share where idx=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, idx);

			pstmt.executeUpdate();

			System.out.println("글삭제 완료");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// deleteShareContent(idx)

	// shareUpdateReadcnt(idx)
	public void shareUpdateReadcnt(int idx) {

		try {
			conn = getConnection();

			sql = "update share set read_cnt=read_cnt+1 where idx=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// shareUpdateReadcnt(idx)

	// modifyShareContent(sDTO)
	public void modifyShareContent(shareDTO sDTO) {

		try {
			conn = getConnection();
			sql = "update share set title=?,content=?,anony=?,category=?,tag=? where idx=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sDTO.getTitle());
			pstmt.setString(2, sDTO.getContent());
			pstmt.setInt(3, sDTO.getAnony());
			pstmt.setString(4, sDTO.getCategory());
			pstmt.setString(5, sDTO.getTag());
			pstmt.setInt(6, sDTO.getIdx());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// modifyShareContent(sDTO)

	// modifyShareContentFile(sDTO)
	public void modifyShareContentFile(shareDTO sDTO) {

		try {
			conn = getConnection();
			sql = "update share set title=?,content=?,anony=?,category=?,tag=?,file=? where idx=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sDTO.getTitle());
			pstmt.setString(2, sDTO.getContent());
			pstmt.setInt(3, sDTO.getAnony());
			pstmt.setString(4, sDTO.getCategory());
			pstmt.setString(5, sDTO.getTag());
			pstmt.setString(6, sDTO.getFile());
			pstmt.setInt(7, sDTO.getIdx());

			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// modifyShareContentFile(sDTO)
	
	// preContentNum(idx, category)
		public int preContentNum(int idx, String category) {
			int result = 0;

			try {
				conn = getConnection();
				if (category.equals("null")){
					sql = "select ifnull(max(idx), 0) from deco.share where idx<?";
					pstmt = conn.prepareStatement(sql);

					pstmt.setInt(1, idx);

				} else {
					sql = "select ifnull(max(idx), 0) from deco.share where idx<? and category=?";		

					pstmt = conn.prepareStatement(sql);

					pstmt.setInt(1, idx);
					pstmt.setString(2, category);
				}
				
				rs = pstmt.executeQuery();

				if (rs.next()) {
					result = rs.getInt(1);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return result;
		}
		// preContentNum(idx, category)

		// postContentNum(idx, category)
		public int postContentNum(int idx, String category) {
			int result = 0;

			try {
				conn = getConnection();
				
				if (category.equals("null")){
					sql = "select ifnull(min(idx), 0) from deco.share where idx>?";
					pstmt = conn.prepareStatement(sql);

					pstmt.setInt(1, idx);

				} else {
					sql = "select ifnull(min(idx), 0) from deco.share where idx>? and category=?";	

					pstmt = conn.prepareStatement(sql);

					pstmt.setInt(1, idx);
					pstmt.setString(2, category);
				}


				rs = pstmt.executeQuery();

				if (rs.next()) {
					result = rs.getInt(1);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			return result;
		}
		// postContentNum(idx, category)

	//shareSearchList(opt,condition)
	public List shareSearchList(String opt,String condition){
		shareDTO sDTO = null;
		List shareSearchList = new ArrayList();
		
		try{
			conn = getConnection();
			if(opt.equals("0")){
				sql="select * from share where title like '%"+condition+"%' order by idx desc";
			}else if(opt.equals("1")){
				sql="select * from share where content like '%"+condition+"%' order by idx desc";	
			}else if(opt.equals("2")){
				sql="select * from share where concat(title,content) like '%"+condition+"%' order by idx desc";
			}else if(opt.equals("3")){
				sql="select * from share "
						+ "where user_num = "
						+ "(select user_num from deco.user "
						+ "where nickname like '%"+condition+"%') order by idx desc";
			}
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println(sql);
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				sDTO = new shareDTO();

				sDTO.setAnony(rs.getInt("anony"));
				sDTO.setCategory(rs.getString("category"));
				sDTO.setContent(rs.getString("content"));
				sDTO.setCreate_at(rs.getString("create_at"));
				sDTO.setFile(rs.getString("file"));
				sDTO.setIdx(rs.getInt("idx"));
				sDTO.setLike(rs.getInt("like"));
				sDTO.setRead_cnt(rs.getInt("read_cnt"));
				sDTO.setTag(rs.getString("tag"));
				sDTO.setTitle(rs.getString("title"));
				sDTO.setUser_num(rs.getInt("user_num"));
				
				shareSearchList.add(sDTO);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
			
		return shareSearchList;
	}
	//shareSearchList(opt,condition)
	
	
}
