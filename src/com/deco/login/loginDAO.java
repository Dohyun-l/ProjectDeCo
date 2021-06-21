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
	
	public userDTO update(int user_num){
		userDTO udto = null;
		conn = getConnection();
		sql="update ";
		
		
		return udto;
	}
	
}
