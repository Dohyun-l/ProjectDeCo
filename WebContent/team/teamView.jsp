<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.team.teamDAO"%>
<%@page import="com.deco.team.teamDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco - 팀뷰</title>
</head>
<body>
<center>
<%
	
	userDAO udao = new userDAO();
	teamDTO tdto = (teamDTO) request.getAttribute("tdto");
	String masternick = udao.getUserNickNameByNum(tdto.getMaster());
	
	
%>


	<h2>프로젝트 현황</h2>
 	<b><%=tdto.getTitle() %></b> | <b><%=masternick %></b> | <b><%=tdto.getLocation() %></b><br>
 	<b>참여인원수</b> | <b><%=tdto.getDeadline() %></b><br>
 	<textarea rows="30" cols="50">
	<%=tdto.getContent() %>
	</textarea><br>
	<input type="button" value="참여하기"> | <input type="button" value="목록으로" onclick="location.href='./teamList.te';"> | <input type="button" value="관리자페이지"><br>
	<input type="button" value="팀페이지 가기"> | <input type="button" value="탈퇴하기">
</center>
</body>
</html>