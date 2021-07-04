<%@page import="com.deco.bookmark.db.BookmarkDAO"%>
<%@page import="com.deco.bookmark.db.BookmarkDTO"%>
<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.notice.db.noticeDAO"%>
<%@page import="com.deco.notice.db.noticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js" charset="UTF-8"></script>

	<h1>WebContent/board/content.jsp</h1>
	
	<%
		request.setCharacterEncoding("utf-8");
		// 페이지 이동시 전달정보(파라미터)가 있으면 항상 가장 먼저 저당
		// num, pageNum
		int idx = Integer.parseInt(request.getParameter("idx"));
		String pageNum = request.getParameter("pageNum");
		
		noticeDTO nDTO = (noticeDTO)request.getAttribute("noticeContent");
		/* int result = (int)request.getAttribute("result"); */

		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
		}
		
		// BoardDAO 객체 생성
		noticeDAO nDAO = new noticeDAO();
		int cntMax = nDAO.getMaxContent();
		int cntMin = nDAO.getMinContent();
		
		int idxExistPre = nDAO.getIdxExistPre(idx);
		int idxExistNext = nDAO.getIdxExistNext(idx);
		
		String fl = nDTO.getFile();
		
		userDAO usDAO = new userDAO();
		String nickName = usDAO.getUserNickNameByNum(user_num);
		
		int adminCheck = usDAO.getAdminByNum(user_num);
	%>
	
	<!-- 북마크 체크 -->
	<script type="text/javascript" src="./bookmark/bookmark.js"></script>
	
	<%
			BookmarkDAO bmDAO = new BookmarkDAO();
			int result = bmDAO.ckBookmark(user_num, idx);
	%>
	
	<%if(result != 1){%>
    	<input type="button" value="☆" id="bmox" onclick="bookmark(${user_num},${param.idx})">
	    <img onclick="bookmark(${user_num},${param.idx})" src="./imgbm/bookmarkx.png" id="bm_img" 
	    	height="50px" width="50px">
    <%}else{ %>
    	<input type="button" value="★" id="bmox" onclick="bookmark(${user_num},${param.idx})">
	    <img onclick="bookmark(${user_num},${param.idx})" src="./imgbm/bookmarko.png" id="bm_img"
	    	 height="50px" width="50px">
    <%} %>
	<!-- 북마크 체크 -->
	
	<table border="1">
		<tr>
			<td>글번호</td>
			<td><%=nDTO.getIdx()%></td>
			<td>작성자</td>
			<td><%=nDTO.getUser_num()%></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><%=nDTO.getCreate_at()%></td>
			<td>조회수</td>
			<td><%=nDTO.getCount()%></td>
			</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td colspan="3"><%=usDAO.getUserNickNameByNum(nDTO.getUser_num()) %></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><%=nDTO.getTitle()%></td>
		</tr>
		<tr>
			<td colspan="4" width="500" height="500"><%=nDTO.getContent()%></td>
		</tr>
		
		<%if(fl != null){ %>
		<tr>
			<td>file</td>
			<td colspan="3">
				<%-- <a href="./upload/<%=nDTO.getFile()%>"><%=nDTO.getFile()%></a> --%>
				<a href="filedown.nt?realPath=upload&file=<%=nDTO.getFile()%>"><%=nDTO.getFile() %></a>
			</td>
		</tr>
		<%} %>
		
	</table>
	
	<hr>
    	
	<script>
	function del(){
		if(confirm("정말 삭제하시겠습니까 ?") == true){
	    	location.href = "./NoticeDeleteAction.nt?idx=" + <%=nDTO.getIdx()%> + "&pageNum=" + <%=pageNum%>;
	        alert("삭제되었습니다");
	    }
	    else{
	        return ;
	    }
	}
	</script>
	
	<%if(adminCheck == 1){%>
		<input type="button" value="수정하기" 
					onclick="location.href='./noticemodify.nt?idx=<%=nDTO.getIdx()%>&pageNum=<%=pageNum%>';">
					
		<input type="button" value="삭제하기" id="delete_btn" onclick="del();">
	<%} %>
	
	<input type="button" value="목록으로" onclick="location.href='noticelist.nt?pageNum=<%=pageNum%>';">
	
	<hr>
	<%if(nDTO.getIdx() != cntMin){
		if(idxExistPre == -1){%>
		<a href="noticecontent.nt?idx=<%=nDTO.getIdx()-1%>&pageNum=<%=pageNum%>">이전글</a> 
	<%}else{%>
		<a href="noticecontent.nt?idx=<%=idxExistPre%>&pageNum=<%=pageNum%>">이전글</a> 
	<%}
	}
	if(nDTO.getIdx() != cntMax){
		if(idxExistNext == -1){%>
			<a href="noticecontent.nt?idx=<%=nDTO.getIdx()+1%>&pageNum=<%=pageNum%>">다음글</a> 
	<%}else{%>
			<a href="noticecontent.nt?idx=<%=idxExistNext%>&pageNum=<%=pageNum%>">다음글</a> 
	<%}} %>

</body>
</html>