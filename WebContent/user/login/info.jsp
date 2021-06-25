<%@page import="com.deco.user.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		userDTO udto = (userDTO) request.getAttribute("udto");
		
	%>
		<center>
		
		<h2>회원정보 조회</h2>
		<table border="1">
			<tr>
				<td>이메일</td>
				<td><%=udto.getEmail() %></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=udto.getName() %></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td><%=udto.getNickname() %></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><%=udto.getAddr() %></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><%=udto.getPhone() %></td>
			</tr>
			<tr>
				<td>전공분야</td>
				<td><%=udto.getMajor() %></td>
			</tr>
			<tr>
				<td>Inter</td>
				<td><%=udto.getInter() %></td>
			</tr>
			<tr>
				<td>생성일</td>
				<td><%=udto.getCreate_at() %></td>
			</tr>
			<tr>
				<td>마지막 로그인날</td>
				<td><%=udto.getLast_login() %></td>
			</tr>
			<tr>
				<td>포인트</td>
				<td><%=udto.getPoint() %></td>
			</tr>
		</table>
	<a href="./main.us">메인 페이지</a> | <a href="./update.us?user_num=<%=udto.getUser_num() %>">정보수정</a> | <a href="./delete.us?user_num=<%=udto.getUser_num() %>">회원탈퇴</a>
	</center>
	<!-- admin_auth 2인 회원 회원탈퇴버튼 숨김 -->


</body>
</html>