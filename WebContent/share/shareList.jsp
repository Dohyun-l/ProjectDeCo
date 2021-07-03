<%@page import="com.deco.bookmark.db.BookmarkDAO"%>
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
		String category = request.getParameter("category");
		
		int user_num = 0;
		
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
	%>
	
	<a href="./main.us">메인으로 돌아가기</a>
	
	<ul>
		<li><a href="./shareList.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>">전체보기</a></li>
		<li><a href="./shareList.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&category=Tips">Tips</a></li>
		<li><a href="./shareList.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&category=Conference">컨퍼런스</a></li>
		<li><a href="./shareList.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&category=Company">회사추천</a></li>
		<li><a href="./shareList.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&category=Academy">학원추천</a></li>
		<li><a href="./shareList.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&category=HowTo">How to</a></li>
	</ul>
	
	<hr>
	
	<script type="text/javascript">
	function changeBoardSize(){
		pageSize = document.fr.boardSize.value;
		location.href = "./shareList.sh?pageNum=<%=pageNum %>&pageSize="+pageSize;
	}
	
	function searchCheck() {
		if (document.form.condition.value == "")  {
			alert("검색어를 입력해 주세요.");
			return false;
		}
	}
	
	</script>
	
	<form name="form" action="./shareList.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize %>" method="post" onsubmit="return searchCheck()">
	<select name="opt">
                <option value="0">제목</option>
                <option value="1">내용</option>
                <option value="2">제목+내용</option>
                <option value="3">작성자</option>
            </select>
            <input type="text" size="20" name="condition"/>&nbsp;
            <input type="submit" value="검색"/>
	</form>
	<br>
	<script type="text/javascript">
		function share_write_userCheck() {

			var user_num = <%=user_num%>;
			
			if (user_num == 0){
				if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?")){
					location.href = "./login.us";
				}
			} else {
				location.href = './shareWrite.sh';
			}
		}
	</script>
	<input type="button" onclick="share_write_userCheck()" value="글쓰기">
	
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
			<th>카테고리</th>
			<th>즐겨찾기</th>
		</tr>
	<%for(int i=0; i<shareList.size(); i++){ 
		shareDTO sdto = (shareDTO) shareList.get(i);
	%>
		<tr>
			<td><%=sdto.getIdx() %></td>
			<td><a href="./shareContent.sh?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&contentNum=<%=sdto.getIdx()%>&category=<%=category%>">
			<%=sdto.getTitle() %></a></td>
			<%if(sdto.getAnony()==1){%>
				<td>
				<%if(user_num == sdto.getUser_num()){ %>
					<%=new userDAO().getUserNickNameByNum(sdto.getUser_num())%>-
				<%} %>
				익명</td>
			<%} else {%>
			<td><%=new userDAO().getUserNickNameByNum(sdto.getUser_num())%></td>
			<%} %>
			<td><%=sdto.getCreate_at() %></td>
			<td><%=sdto.getRead_cnt() %></td>
			<td><%=sdto.getCategory()%></td>
			<td>
			<%
				BookmarkDAO bmDAO = new BookmarkDAO();
				int result = bmDAO.ckBookmark(user_num, sdto.getIdx());
			%>
			<%if(result != 1){%>
			    <img src="./imgbm/bookmarkx.png" id="bm_img" height="30px" width="30px">
		    <%}else{ %>
			    <img src="./imgbm/bookmarko.png" id="bm_img" height="30px" width="30px">
		    <%} %>
			</td>
		</tr>
	<%} %>
	</table>
	
	<%
	shareDAO sdao = new shareDAO();
	
	int cnt = sdao.numOfShare();
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