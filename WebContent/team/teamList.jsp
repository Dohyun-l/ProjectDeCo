<%@page import="java.util.List"%>
<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.team.teamDTO"%>
<%@page import="com.deco.team.teamDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco - 팀</title>
</head>
<body>
<%
		userDAO udao = new userDAO();
		teamDAO tdao = new teamDAO();
		List teamList = tdao.teamList();
	
	  int pageSize = (int)request.getAttribute("pageSize");
      String pageNum = (String)request.getAttribute("pageNum");
      // String category = request.getParameter("category");
      
      int user_num = 0;
      
      if(session.getAttribute("user_num") != null) {
         user_num = (int) session.getAttribute("user_num");
      }

	
%>
<center>
<h2>프로젝트 리스트</h2>
	<table border="1">
		<tr>
			<td width="130" style="text-align:center">프로젝트 리더</td>
			<td width="300" style="text-align:center">프로젝트 제목</td>
			<td width="100" style="text-align:center">지역</td>
			<td width="200" style="text-align:center">프로젝트 시작일</td>
			<td width="200" style="text-align:center">모집 마감일</td>
		</tr>
		<%
		for(int i=0;i<teamList.size();i++){
			teamDTO tdto = (teamDTO) teamList.get(i);
			String masternick = udao.getUserNickNameByNum(tdto.getMaster());
		%>
		<tr>
			<td style="text-align:center"><%=masternick %></td>
			<td style="text-align:center"><a href="./teamView.te?idx=<%=tdto.getIdx() %>";><%=tdto.getTitle() %></a></td>
			<td style="text-align:center"><%=tdto.getLocation() %></td>
			<td style="text-align:center"><%=tdto.getCreate_at() %></td>
			<td style="text-align:center"><%=tdto.getDeadline() %></td>
		</tr>
		<%} %>
	</table>
	<%
 
   
   int cnt = tdao.numOfTeam();
   int currentpage = Integer.parseInt(pageNum);
   
   if(cnt != 0){
   
      int pageCount = cnt/pageSize + (cnt % pageSize == 0 ? 0 : 1);
      int pageBlock = 2;
      int startPage = ((currentpage - 1)/pageBlock) * pageBlock + 1;
      int endPage = startPage + pageBlock -1;
      if(endPage > pageCount){
         endPage = pageCount;
      }
      if(startPage > pageBlock){
         %>
         <a href="./teamList.te?pageNum=<%=startPage-pageBlock %>&pageSize=<%=pageSize%>">[이전]</a>
         <%
      }
      for(int i=startPage; i<=endPage; i++){
         %>
            <a href="./teamList.te?pageNum=<%=i%>&pageSize=<%=pageSize%>">[<%=i %>]</a>
         <%
      }
      if(endPage < pageCount){
         %>
         <a href="./teamList.te?pageNum=<%=startPage+pageBlock %>&pageSize=<%=pageSize%>">[다음]</a>
         <%
      }
   }
%>
	
</center>



</body>
</html>