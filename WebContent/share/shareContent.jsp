<%@page import="com.deco.user.userDTO"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<link href="./share/css/list.css" rel="stylesheet">
<title>Insert title here</title>
 <!-- jquery 준비 시작 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- jquery 준비 끝 -->



</head>
<div class="wrap">
<body>

<%
request.setCharacterEncoding("utf-8");

shareDTO sDTO =(shareDTO) request.getAttribute("shareContent");


String pageSize = request.getParameter("pageSize");
String pageNum = request.getParameter("pageNum");
String category = request.getParameter("category");
int user_num = 0;

if (session.getAttribute("user_num") != null) {
	user_num = (int)session.getAttribute("user_num");
}


%>

<%if(new shareDAO().preContentNum(sDTO.getIdx(), category) != 0){ %>
<input type="button" value="이전글" onclick="location.href='./shareContent.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=new shareDAO().preContentNum(sDTO.getIdx(), category)%>&category=<%=category%>'">
<%} 
if(new shareDAO().postContentNum(sDTO.getIdx(), category) != 0){ %>
<input type="button" value="다음글" onclick="location.href='./shareContent.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=new shareDAO().postContentNum(sDTO.getIdx(), category)%>&category=<%=category%>'">
<%} %>
<table border="1" class="table table-bordered">
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
		<td><%if(user_num == sDTO.getUser_num()){ %>
		<%=new userDAO().getUserNickNameByNum(sDTO.getUser_num())%>-
		<%} %>
		익명</td>
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
<%if(user_num == sDTO.getUser_num()){ %>
<input type="button" value="수정하기" onclick="location.href='./shareContentModify.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category%>';">
<input type="button" value="삭제하기" onclick="location.href='./shareContentDelete.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category%>';">
<%} %>
<br><br>


<!-- 댓글 -->
<form action="" name="commentListfr" id="commentListfr">
<table border="1" class="table table-hover">
	<thead>
	<tr>
		<td>글번호</td>
		<td>작성자</td>
		<td>내용</td>
		<td>작성날짜</td>
		<td>수정/삭제</td>
	</tr>
	</thead>
<%
	List commentList = (ArrayList) request.getAttribute("commentList");

	
	for(int i=0; i<commentList.size(); i++){
		commentDTO cDTO = (commentDTO) commentList.get(i);
		%>
		
		<script type="text/javascript">

		//jquery 시작
		$(function() {
		    // 댓글 수정
		     $("#cm<%=i%>").on("click",function() {
		    	 if(document.getElementById("cc<%=i%>").readOnly){
		    			document.getElementById("cc<%=i%>").readOnly=false;
		    			document.getElementById("cc<%=i%>").focus();
		    		}else{
		    			document.getElementById("cc<%=i%>").readOnly=true;	
					    $.ajax({
					    	url:"./shareCommentModifyUpdateAction.sh",
					        type:"post",
					        data:{"content":$("#cc<%=i%>").val(), "comment_idx":$("#ci<%=i%>").val()},
					        success:function(data){
					          	location.reload();
					         } 
					   });
		    		}
		   });
		});
		</script>
		<tbody>
	<tr>
		<td><%=commentList.size()-i %></td>
		<td><%=new userDAO().getUserNickNameByNum(cDTO.getUser_num())%></td>
		<td><input type="text" value="<%=cDTO.getContent() %>" readonly id="cc<%=i%>"></td>
		<td><%=cDTO.getCreate_at() %></td>
		<%
		if(user_num == cDTO.getUser_num()){ %>
		<td><input type="button" value="수정하기" id="cm<%=i%>">/
		<input type="button" value="삭제하기" onclick="location.href='./shareCommentDeleteAction.sh?comment_idx=<%=cDTO.getComment_idx()%>&pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category %>'">
		<input type="hidden" value="<%=cDTO.getComment_idx() %>" id="ci<%=i%>"/>
		</td>
		
		<%} %>
<% } %>
</tr>
</tbody>
</table>
</form>
<script type="text/javascript">

	function insertCommentCheck() {
		var user_num = <%=user_num%>;
		if(user_num == 0){
			if(confirm("로그인이 필요합니다. 로그인페이지로 가시겠습니까?")) {
				location.href = "./login.us";
				return false;
			} else {
				return false;				
			}
		}
		if(document.commentfr.comment.value == ""){
			alert("댓글을 작성해 주세요.");
			document.commentfr.comment.focus();
			return false;
		}
	}

</script>

<form action="./shareCommentAction.sh?pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&contentNum=<%=sDTO.getIdx()%>&category=<%=category %>"
		 method="post" onsubmit="return insertCommentCheck()" name="commentfr">
 <textarea placeholder="Leave a comment here" id="comment" name="comment" rows="5" cols="60" style="resize: none;"></textarea>		
 <input type="submit" value="등록하기">
 <input type="reset" value="취소">
</form>

</div>
</body>
</html>