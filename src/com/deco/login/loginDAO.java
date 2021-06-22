package com.deco.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.mindrot.jbcrypt.BCrypt;



public class loginDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	private Connection getConnection(){
		try {
			Context initCTX = new InitialContext();
			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/deco");
			conn = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	public void closeDB(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// HashPW(pw).equals(rs.getString("pw"))
	
	// HashPW로 돌린 DAO
	public int login(String email, String pw){
		//userDTO udto = null;
		int flag = -2;
		
		try {
				conn = getConnection();
				sql="select user_num, pw from user where email=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				if(rs.next()){
					flag = -1;
					//  if(BCrypt.checkpw(pw, rs.getString("pw"))){  <-- 실적용
					if(pw.equals(rs.getString("pw"))){	// 테스트용 코드
						sql="select user_num from user where email=?";
						pstmt.setString(1, email);
						
						rs = pstmt.executeQuery();
							if(rs.next()){
								flag = rs.getInt("user_num");
							}
						}
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	
	public void last_login(String email){
		try {
				conn = getConnection();
				sql="update user set last_login=now() where email=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				closeDB();
			}
	}
	
	
	public userDTO info(int user_num){
		userDTO udto = null;
		try {
			conn = getConnection();
			sql="select * from user where user_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_num);
			rs = pstmt.executeQuery();
				if(rs.next()){
					udto = new userDTO();
					udto.setUser_num(rs.getInt("user_num"));
					udto.setEmail(rs.getString("email"));
					udto.setName(rs.getString("name"));
					udto.setNickname(rs.getString("nickname"));
					udto.setAddr(rs.getString("addr"));
					udto.setPhone(rs.getString("phone"));
					udto.setMajor(rs.getString("major"));
					udto.setInter(rs.getString("inter"));
					udto.setCreate_at(rs.getDate("create_at"));
					udto.setLast_login(rs.getDate("last_login"));
					udto.setPoint(rs.getInt("point"));
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return udto;
	}
	
	public int update(userDTO udto, int user_num){
		int check = -1;
		try {
			conn = getConnection();
			sql="select pw from user where user_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(udto.getPw().equals(rs.getString("pw"))){
					sql="update user set name=?, nickname=?, addr=?, phone=?, major=? where user_num=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, udto.getName());
					pstmt.setString(2, udto.getNickname());
					pstmt.setString(3, udto.getAddr());
					pstmt.setString(4, udto.getPhone());
					pstmt.setString(5, udto.getMajor());
					
					pstmt.setInt(6, user_num);
					
					check = pstmt.executeUpdate();
				}else{
					// 비밀번호 오류
					check = 0;
				}
			}else{
				// user_num 비어있다
				check = -1;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return check;
	}
	public int delete(String email, String pw){
		int check = -1;
		try {
			conn = getConnection();
			sql = "select pw from user where email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){
					sql="delete from user where email=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, email);
					check = pstmt.executeUpdate();
					
					
				}else{
					// 비밀번호 오류!!
					check = 0;
				}
			}else{
				// 존재하지 않는 회원
				check = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		
		return check;
	}
	
	
}
