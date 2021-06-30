<%@page import="com.deco.user.userDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.deco.team.member.teamMemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>WebContent/teamMember/memberList.jsp</h1>
	
	<%
		List<teamMemberDTO> memberList = (ArrayList<teamMemberDTO>) request.getAttribute("memberList");		
	%>
	
	<table border="1">
		<tr>
			<th>신청자</th>
			<th>신청일</th>
			<th>승인 상태</th>
		</tr>
		<%for(int i=0; i<memberList.size(); i++){
			teamMemberDTO tmdto = memberList.get(i);
			%>
		<tr>
			<th><%=new userDAO().getUserNickNameByNum(tmdto.getMember()) %></th>
			<th><%=tmdto.getCreate_at() %></th>
			<%if(tmdto.getSubmit() == 1){ %>
			<th>승인</th>
			<%} else { %>
			<th>미승인</th>
			<%} %>
		</tr>
		<%} %>
	</table>

</body>
</html>