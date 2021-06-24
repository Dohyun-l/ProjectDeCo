package com.deco.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.mindrot.jbcrypt.BCrypt;

public class userDAO {
	
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
	
	//getUserInfo
	public userDTO getUserInfo(int user_num){
		userDTO uDTO = null;
		
		try {
			conn = getConnection();
			sql = "select * from user where user_num=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				uDTO = new userDTO();
				uDTO.setRs(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return uDTO;
	}
	//getUserInfo
	
	//getUserNickNameByNum
	public String getUserNickNameByNum(int userNum){
		String UserName = null;
		
		try {
			conn = getConnection();
			sql = "select nickname from user where user_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				UserName = rs.getString(1);
				System.out.println(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return UserName;
	}
	//getUserNickNameByNum
	
	//getUserNumByEmail
	public int getUserNumByEmail(String email){
		int user_num = -5;
		
		try {
			conn = getConnection();
			sql = "select user_num from user where email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				user_num = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user_num;
	}
	//getUserNumByEmail

	//getAdminByNum
	public int getAdminByNum(int userNum){
		
		//0 -> 일반  |  1 -> 관리자  | -1 -> 에러
		int flag = -1;

		try {
			conn = getConnection();
			sql = "select admin_auth from user where user_num=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				flag = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	//getAdminByNum
	
	//HashPW
	private String HashPW(String pw){
		return BCrypt.hashpw(pw, BCrypt.gensalt(5));
	}
	//HashPW
	
	//setJoinInitSet()
	private void setJoinInitSet(userDTO uDTO) throws SQLException{
		pstmt.setInt(1, uDTO.getUser_num());
		pstmt.setString(2, uDTO.getEmail());
		pstmt.setString(3, HashPW(uDTO.getPw()));
		pstmt.setString(4, uDTO.getName());
		pstmt.setString(5, uDTO.getNickname());
		pstmt.setString(6, uDTO.getAddr());
		pstmt.setString(7, uDTO.getPhone());
		pstmt.setString(8, uDTO.getMajor());
		pstmt.setString(9, uDTO.getInter());
	}
	//setJoinInitSet()
	
	//setJoinPreState
	private void setJoinPreState(userDTO uDTO) throws SQLException{
		
		setJoinInitSet(uDTO);
		
		//private user는 기본적으로 계정 공개로 0으로 설정(참고: 비공개는 1로 함)
		pstmt.setInt(10, 0);
		
		//회원가입한 유저는 -1로 이메일 인증을 안한 유저이다.
		pstmt.setInt(11, -1);
		
		//회원가입한 유저의 발송된 인증 코드 저장
		pstmt.setString(12, uDTO.getEmail_auth());
	}
	//setJoinPreState
	
	//setJoinGitPreState
	private void setJoinGitPreState(userDTO uDTO) throws SQLException{
		
		setJoinInitSet(uDTO);
		
		//private user는 기본적으로 계정 공개로 0으로 설정(참고: 비공개는 1로 함)
		pstmt.setInt(10, 0);
		
		//Git으로 회원가입한 유저는 이메일 인증을 한 유저이지만, 추가적인 정보가 필요하다.
		// -10으로 설정  =>  추가 필수 정보 입력시 0으로 변경
		pstmt.setInt(11, -10);
	}
	//setJoinGitPreState
	
	//insertUser
	public int insertUser(userDTO uDTO){
		int flag = -5; 
		
		try {
			conn = getConnection();
			
			//user_num 얻기
			sql = "select max(user_num) from user";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				uDTO.setUser_num(rs.getInt(1) + 1);
			}
			
			//유저 DB에 넣기
			//관리자면 1, 일반 유저 0, 이메일 인증전 유저 -1
			sql = "insert into user (user_num, email, pw, name, nickname, addr, "
					+ "phone, major, inter, create_at, last_login, private_user, admin_auth, "
					+ "email_auth) "
					+ "values(?,?,?,?,?,?,?,?,?,now(),now(),?,?,?)";

			pstmt = conn.prepareStatement(sql);
			setJoinPreState(uDTO);
			pstmt.executeUpdate();
			
			flag = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	//insertUser
	
	//insertGitUser
	public int insertSocialUser(userDTO uDTO){
		int flag = -5; 
		
		try {
			conn = getConnection();
			
			//user_num 얻기
			sql = "select max(user_num) from user";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				uDTO.setUser_num(rs.getInt(1) + 1);
			}
			
			//유저 DB에 넣기
			//관리자면 1, 일반 유저 0, 이메일 인증전 유저 -1
			sql = "insert into user (user_num, email, pw, name, nickname, addr, "
					+ "phone, major, inter, create_at, last_login, private_user, admin_auth)"
					+ "values(?,?,?,?,?,?,?,?,?,now(),now(),?,?)";

			pstmt = conn.prepareStatement(sql);
			setJoinGitPreState(uDTO);
			pstmt.executeUpdate();
			
			flag = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	//insertGitUser
	
	//searchUserEmail
	public boolean searchUserEmail(String nowEmail){
		boolean flag = false;
		
		try {
			conn = getConnection();
			sql = "select user_num from user where email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nowEmail);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				flag = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	//serachUserEmail
	
	//searchUserNickname
	public boolean searchUserNickname(String nowNickname){
		boolean flag = false;
		
		try {
			conn = getConnection();
			sql = "select user_num from user where nickname=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nowNickname);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				flag = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	//searchUserNickname
	
	//getAuthEmail
	public int getAuthEmail(String code, String email){
		int flag = -1;
		try {
			System.out.println(email);
			conn = getConnection();
			sql = "select email_auth from user where email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				flag = rs.getString(1).equals(code) ? 1 : 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag;
	}
	//getAuthEmail
	
	//setUserAuth
	public void setUserAuth(int authCode, String email){
		try {
			conn = getConnection();
			sql = "update user set admin_auth=? where email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, authCode);
			pstmt.setString(2, email);
			
			pstmt.executeUpdate();
			System.out.println(email + " 유저 권한 부여 => " + authCode);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
	}
	//setUserAuth
	
	//changeEamilCode
	public int changeEamilCode(userDTO uDTO){
		int flag = -1;
		
		try {
			conn = getConnection();
			sql = "update user set email_auth=? where email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uDTO.getEmail_auth());
			pstmt.setString(2, uDTO.getEmail());
			
			pstmt.executeUpdate();
			System.out.println("이메일 인증코드 재발급!");
			flag = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag; 
	}
	//changeEamilCode
	
	//updateSocialUser
	public int updateSocialUser(userDTO uDTO){
		int flag = -5;
		
		try {
			conn = getConnection();
			sql = "update user set name=?,nickname=?,phone=?,addr=?,major=?,inter=?,admin_auth=? "
					+ "where user_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uDTO.getName());
			pstmt.setString(2, uDTO.getNickname());
			pstmt.setString(3, uDTO.getPhone());
			pstmt.setString(4, uDTO.getAddr());
			pstmt.setString(5, uDTO.getMajor());
			pstmt.setString(6, uDTO.getInter());
			
			//추가 입력 성공시, 일반 유저로 조정
			pstmt.setInt(7, 0);
			pstmt.setInt(8, uDTO.getUser_num());
			
			pstmt.executeUpdate();
			flag = 1;
			System.out.println("소셜 로그인 유저 정보추가 완료!=!");
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return flag; 
	}
	//updateSocialUser
	
	//===========================================================================
	
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
					if(BCrypt.checkpw(pw, rs.getString("pw"))){  //<-- 실적용
					//if(pw.equals(rs.getString("pw"))){	// 테스트용 코드
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
					udto.setCreate_at(rs.getString("create_at"));
					udto.setLast_login(rs.getString("last_login"));
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
