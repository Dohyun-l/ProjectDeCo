<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.share.shareDTO"%>
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
request.setCharacterEncoding("utf-8");

shareDTO sDTO =(shareDTO) request.getAttribute("shareContent");

String pageSize = request.getParameter("pageSize");
String pageNum = request.getParameter("pageNum");

%>


<table border="1">
	<tr>
		<td>글번호</td>
		<td><%=sDTO.getIdx()%></td>
		<td>카테고리</td>	
		<td><%=sDTO.getCategory()%></td>
		<td>조회수</td>	
		<td><%=sDTO.getRead_cnt()%></td>
	</tr>
	<tr>
		<td>태그</td>
		<td colspan="5"><%=sDTO.getTag()%></td>
	</tr>
	<tr>	
		<td>작성자</td>
		<td><%=new userDAO().getUserNickNameByNum(sDTO.getUser_num())%></td>
		<td>작성일</td>
		<td colspan="3"><%=sDTO.getCreate_at()%></td>
		
	</tr>
	<tr>	
		<td>제목</td>
		<td colspan="5"><%=sDTO.getTitle()%></td>
	</tr>	
	<tr>	
		<td>첨부파일</td>
		<td colspan="5" ><img src="share/upload/<%=sDTO.getFile()%>" width="400" height="300" alt="<%=sDTO.getFile()%>"></td>
	</tr>	
	<tr>
		<td>글내용</td>
		<td colspan="5"><%=sDTO.getContent()%></td>
	</tr>
</table>

<input type="button" value="목록으로" onclick="location.href='shareList.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>';">

</body>
</html>