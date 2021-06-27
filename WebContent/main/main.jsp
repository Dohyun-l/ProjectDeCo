<%@page import="com.deco.user.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco - Main</title>

</head>
<body>
<%
	int user_num = -1;
	int admin_auth = -1;
	userDAO uDAO;
	String name = null;
	
	if(session.getAttribute("user_num") != null){
		user_num = (Integer)session.getAttribute("user_num");
		uDAO = new userDAO();
		name = uDAO.getUserNickNameByNum(user_num);
		admin_auth = uDAO.getAdminByNum(user_num);
	}
	
%>
	<%if(name == null && user_num == -1) {%>
		<a href="./login.us">로그인</a>
	<%} else{%>
		<h2>환영합니다 <%=name %>님</h2>
	
		<a href="./info.us?user_num=<%=user_num %>">회원정보 조회</a>
		<%if(admin_auth == 2){ %><a href="./cancel.us">회원탈퇴 취소</a><%} %>
		<a href="./userlogout.us">로그아웃</a>
	<%} %>
	
	<a href="./Main.nt">공지사항</a>
	
	<a href="./share/shareList.sh">정보공유</a>
	
	
	<!-- 회원탈퇴취소 admin_auth 값이 2인 사람만 보이게 수정 -->
	
	
	
</body>
</html>