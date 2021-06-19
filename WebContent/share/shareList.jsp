<%@page import="com.deco.share.shareDAO"%>
<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.share.shareDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정보공유</title>



</head>
<body>

	<h1>정보공유 글보기</h1>
	
	<%
		List shareList = (ArrayList)request.getAttribute("shareList");
	
		int pageSize = (int)request.getAttribute("pageSize");
		String pageNum = (String)request.getAttribute("pageNum");
		
	%>
	
	<script type="text/javascript">
	function changeBoardSize(){
		pageSize = document.fr.boardSize.value;
		location.href = "./shareList.sh?pageNum=<%=pageNum %>&pageSize="+pageSize;
	}
	</script>
	
	<input type="button" onclick="location.href='./shareWrite.sh'" value="글쓰기">
	
	<form name="fr">
		<select id="boardSize" onchange="changeBoardSize()" name="changePageSize">
			<option>n개씩 보기</option>
			<option value="5">5개씩 보기</option>
			<option value="10">10개씩 보기</option>
			<option value="15">15개씩 보기</option>
			<option value="20">20개씩 보기</option>
		</select>
	</form>
	<table border="1">
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	<%for(int i=0; i<shareList.size(); i++){ 
		shareDTO sdto = (shareDTO) shareList.get(i);
	%>
		<tr>
			<td><%=sdto.getIdx() %></td>
			<td><%=sdto.getTitle() %></td>
			<td><%=new userDAO().getUserNickNameByNum(sdto.getUser_num())%></td>
			<td><%=sdto.getCreate_at() %></td>
			<td><%=sdto.getRead_cnt() %></td>
		</tr>
	<%} %>
	</table>
	
	<%
	shareDAO sdao = new shareDAO();
	
	int cnt = sdao.getShareReadCount();
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
			<a href="./shareList.sh?pageNum=<%=startPage-pageBlock %>&pageSize=<%=pageSize%>">[이전]</a>
			<%
		}
		for(int i=startPage; i<=endPage; i++){
			%>
				<a href="./shareList.sh?pageNum=<%=i%>&pageSize=<%=pageSize%>">[<%=i %>]</a>
			<%
		}
		if(endPage < pageCount){
			%>
			<a href="./shareList.sh?pageNum=<%=startPage+pageBlock %>&pageSize=<%=pageSize%>">[다음]</a>
			<%
		}
	}
%>

</body>
</html>