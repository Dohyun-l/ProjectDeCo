<%@page import="com.deco.user.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./user/login/info.css">
<link rel="stylesheet" href="./user/form.css">
<title>Deco | UserInfo</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		userDTO udto = (userDTO) request.getAttribute("udto");
		
	%>
		<div class="table-users">
		<div class="header"><span>User Info</span></div>
		<table cellspacing="0">
			<tr>
				<th>이메일</th>
				<td><%=udto.getEmail() %></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=udto.getName() %></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td><%=udto.getNickname() %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><%=udto.getAddr() %></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=udto.getPhone() %></td>
			</tr>
			<tr>
				<th>전공분야</th>
				<td><%=udto.getMajor() %></td>
			</tr>
			<tr>
				<th>Inter</th>
				<td><%=udto.getInter() %></td>
			</tr>
			<tr>
				<th>생성일</th>
				<td><%=udto.getCreate_at() %></td>
			</tr>
			<tr>
				<th>마지막 로그인날</th>
				<td><%=udto.getLast_login() %></td>
			</tr>
			<tr>
				<th>포인트</th>
				<td><%=udto.getPoint() %></td>
			</tr>
		</table>
	</div>
	<div class="btnWrapper">
		<a href="./main.us"><button>메인 페이지</button></a>
		<a href="./update.us?user_num=<%=udto.getUser_num() %>"><button>정보수정</button></a>
		<a href="./delete.us?user_num=<%=udto.getUser_num() %>"><button>회원탈퇴</button></a>
		<!-- admin_auth 2인 회원 회원탈퇴버튼 숨김 -->
	</div>

</body>
</html>