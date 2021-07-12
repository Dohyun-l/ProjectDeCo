<%@page import="com.deco.user.userDTO"%>
<%@page import="com.deco.team.member.teamMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		teamMemberDTO tmdto = (teamMemberDTO) request.getAttribute("tmdto");
		userDTO udto = (userDTO) request.getAttribute("memberInfo");
		
		int masterNum = (int)request.getAttribute("masterNum");
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
		}
	%>
	<h2>멤버 정보</h2>
	<table border="1">
		<tr>
			<td>이름</td>
			<td><%=udto.getName() %></td>
			<td>닉네임</td>
			<td><%=udto.getNickname() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td colspan="3"><%=udto.getEmail()%></td>
		</tr>
		<tr>
			<td>주소</td>
			<td colspan="3"><%=udto.getAddr()%></td>
		</tr>
		<tr>
			<td>전문분야</td>
			<td colspan="3"><%=udto.getMajor()%></td>
		</tr>
		<tr>
			<td>관심분야</td>
			<td colspan="3"><%=udto.getInter()%></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td colspan="3"><%=udto.getPhone()%></td>
		</tr>
	</table>
	<%if(tmdto.getSubmit() == 0){%>
		<input type="button" value="승인하기" id="joinTeam<%=tmdto.getIdx()%>">
	<%}%>
	<%if(masterNum != userNum){ %>
	<input type="button" value="퇴출하기" id="outMember<%=tmdto.getIdx()%>">
	<%} %>
	
</body>
</html>