package com.deco.basket.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BasketDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";

   private Connection getConnection(){
	   try {
		   // Context 객체를 생성(프로젝트 정보를 가지고있는 객체)
		   Context initCTX = new InitialContext();
		   
		   // DB연동 정보를 불러오기(context.xml)
		   DataSource ds = 
				   (DataSource)initCTX.lookup("java:comp/env/jdbc/deco");
		   
		   conn = ds.getConnection();
		   
		   System.out.println(" 드라이버 로드, 디비연결 성공! ");
		   System.out.println(conn);
		   
	   } catch (NamingException e) {
		   e.printStackTrace();
	   } catch (SQLException e) {
		   e.printStackTrace();
	   }
	   
    	return conn;
    }// getConnectino() - 디비연결 끝
   
   // 자원해제코드 - finally 구문에서 사용
   public void closeDB(){
	   // 자원해제
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
   }
   
   /////////////////////////////////////////////////////////////////////////////////////////////
   
   //checkBookmark(bkDTO)
 	public int checkBookmark(BasketDTO bkDTO){
 		int result = 0;
 		
 		try {
 			conn = getConnection();
 			
 			// 전달받은 옵션값 (b_g_num, b_g_color, b_g_size, b_m_id) 사용하여
 			// 기존의 추가된 상품이 있는지 체크	=> 상품이 있을때 1리턴 + 상품의 수량만 update
 			//							=> 상품이 없을때 0리턴
 			sql = "select bm_num from basket where n_user_num=? and n_c_num=?";
 			pstmt = conn.prepareStatement(sql);
 			
 			pstmt.setInt(1, bkDTO.getN_user_num());
 			pstmt.setInt(2, bkDTO.getN_c_num());
 			
 			rs = pstmt.executeQuery();
 			
 			if(rs.next()){
 				result = 1;
/* 				
 				// 장바구니 상품의 정보를 수정
 				sql = "update basket set bm_num = 1 where n_user_num=?";
 				pstmt = conn.prepareStatement(sql);
 				
 				pstmt.setInt(1, bkDTO.getN_id());
 				
 				result = pstmt.executeUpdate();*/
 			}else{
 				result = 0;
 			}
 			System.out.println("DAO : 북마크 체크 완료! -> " + result);
 			
 		} catch (SQLException e) {
 			e.printStackTrace();
 		}finally {
 			closeDB();
 		}
 		return result;
 	}
 	//checkBookmark(bkDTO)
   
 	
 	//bookmarkAdd(bkDTO)
 	public void bookmarkAdd(BasketDTO bkDTO){
		
		// 장바구니 번호
		int n_num = 0;
		
		try {
			conn = getConnection();
			
			// 상품번호 계산 : 기존의 장바구니가 있으면 해당번호 + 1
			sql = "select max(n_num) from basket";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				n_num = rs.getInt(1) + 1;
			}

			System.out.println("DAO : 번호 + " + n_num);
			
			// 상품을 장바구니에 추가
			sql = "insert into basket(n_num, n_user_num, bm_num, n_c_num) values(?,?,1,?);";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, n_num);
			pstmt.setInt(2, bkDTO.getN_user_num());
			pstmt.setInt(3, bkDTO.getN_c_num());
			
			pstmt.executeUpdate();
			
			System.out.println("DAO : 북마크 추가 완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}
 	//bookmarkAdd(bkDTO)
   
	
	
}
