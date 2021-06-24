<%@page import="com.deco.share_comment.commentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.deco.share.shareDAO"%>
<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.share.shareDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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

System.out.println();
System.out.println();
System.out.println(category);
System.out.println();
System.out.println();

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
<br><br>


<!-- 댓글 -->

<table border="1">
	<tr>
		<td>글번호</td>
		<td>작성자</td>
		<td>내용</td>
		<td>작성날짜</td>
	</tr>
<%
	List commentList = (ArrayList) request.getAttribute("commentList");

	
	for(int i=0; i<commentList.size(); i++){
		commentDTO cDTO = (commentDTO) commentList.get(i);
		%>
	<tr>
		<td><%=commentList.size()-i %></td>
		<td><%=new userDAO().getUserNickNameByNum(cDTO.getUser_num())%></td>
		<td><%=cDTO.getContent() %></td>
		<td><%=cDTO.getCreate_at() %></td>
	</tr>
<%}%>
</table>


<form action="./shareCommentAction.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category%>" method="post">
 <textarea placeholder="Leave a comment here" id="comment" name="comment" rows="5" cols="40"></textarea>		
 <input type="submit" value="등록하기">
</form>

</body>
</html>