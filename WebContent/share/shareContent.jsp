<%@page import="com.deco.share.shareDAO"%>
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
String category = request.getParameter("category");


%>


<%if(new shareDAO().preContentNum(sDTO.getIdx(), category) != 0){ %>
<input type="button" value="이전글" onclick="location.href='./shareContent.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=new shareDAO().preContentNum(sDTO.getIdx(), category)%>&category=<%=category%>'">
<%} 
if(new shareDAO().postContentNum(sDTO.getIdx(), category) != 0){ %>
<input type="button" value="다음글" onclick="location.href='./shareContent.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=new shareDAO().postContentNum(sDTO.getIdx(), category)%>&category=<%=category%>'">
<%} %>
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
		<%if(sDTO.getAnony()==1){%>
		<td>*****</td>
		<%} else {%>
		<td><%=new userDAO().getUserNickNameByNum(sDTO.getUser_num())%></td>
		<%} %>
		<td>작성일</td>
		<td colspan="3"><%=sDTO.getCreate_at()%></td>
		
	</tr>
	<tr>	
		<td>제목</td>
		<td colspan="5"><%=sDTO.getTitle()%></td>
	</tr>
  
	<tr>	
		<td>첨부파일</td>
		<%if(sDTO.getFile()!=null){%>	
		<td colspan="5" ><a href="filedown.sh?realPath=upload&file=<%=sDTO.getFile()%>"><%=sDTO.getFile() %></a></td>
		<%} else {%>
		<td colspan="5" >없음</td>
		<%} %>
	</tr>
	
	<tr>
		<td>글내용</td>
		<td colspan="5"><%=sDTO.getContent()%></td>
	</tr>
</table>

<input type="button" value="목록으로" onclick="location.href='./shareList.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&category=<%=category%>';">
<input type="button" value="수정하기" onclick="location.href='./shareContentModify.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category%>';">
<input type="button" value="삭제하기" onclick="location.href='./shareContentDelete.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category%>';">
</body>
</html>