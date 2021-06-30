<%@page import="com.deco.team.teamDTO"%>
<%@page import="com.deco.team.teamDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>WebContent/teamMember/memberMain.jsp</h1>
	
	<%
		String idx = request.getParameter("idx");

		int user_num = 0;
	
		if(session.getAttribute("user_num") == null) {
			response.sendRedirect("./teamList.te");
		} else {
			user_num = (int) session.getAttribute("user_num");
		}
		
		teamDAO tdao = new teamDAO();
		teamDTO tdto = tdao.getteamView(Integer.parseInt(idx));
	%>
	<a href="./teamView.te?idx=<%=idx %>">팀 뷰가기</a>
	
	<a href="/teamMemberTalk.tm">팀 채팅방</a>
	
	<a href="#">일정 공유</a>
	
	<%if(user_num == tdto.getMaster()) { %>
	<a href="./memberList.tm?idx=<%=idx%>">멤버 관리</a>	
	<%} %>



</body>
</html>