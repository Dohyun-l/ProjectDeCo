<%@page import="java.util.List"%>

<%@page import="com.deco.team.comment.Team_commentDAO"%>
<%@page import="com.deco.team.comment.Team_commentDTO"%>
<%@page import="java.io.Console"%>
<%@page import="com.deco.team.member.teamMemberDAO"%>
<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.team.teamDAO"%>
<%@page import="com.deco.team.teamDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>Deco - 팀뷰</title>

</head>
<body>
<center>


<%
	
	String idx = request.getParameter("idx");
	userDAO udao = new userDAO();
	teamDTO tdto = (teamDTO) request.getAttribute("tdto");
	String masternick = udao.getUserNickNameByNum(tdto.getMaster());
	int check = (int) request.getAttribute("check");
	int user_num = (int) session.getAttribute("user_num");
	int limit_p = Integer.parseInt(tdto.getLimit_p());
	int checkSubmitMember = new teamMemberDAO().checkSubmitMember(Integer.parseInt(idx));
	int team_idx = Integer.parseInt(request.getParameter("idx"));
	String nickname = udao.getUserNickNameByNum(user_num);
	
%>
<script type="text/javascript">
function dropteam(){
	if(confirm("정말 프로젝트를 취소하시겠습니까?")){
		
	}else{
		return false;
	}
}

</script>

	
 	<h2>Project <br>
 	<%=tdto.getTitle() %></h2><br>
 	<h3><%=masternick %> 팀장님</h3>
 	<b>지역 : <%=tdto.getLocation() %></b><br>
 	<%if(checkSubmitMember >= limit_p){
 	check = 0;
 	%>
 	<h2>모집 인원이 가득찼습니다.</h2>
 	
 	<%}else{ %>
 	<b><%=checkSubmitMember %> / <%=limit_p %></b>
 	
 	<%} %>
 	<br>
 	<b>모집 마감일 : <%=tdto.getDeadline() %></b><br>
 	<div id="DecotextContentView">
	<h4>프로젝트 상세 내용 : <%=tdto.getContent() %></h4>
 	</div>
	<%
	
	if(session.getAttribute("user_num")!=null){
	
	%>
	
	<%if(check == 1){ %>
		<a href="./joinTeamMember.tm?idx=<%=idx%>">참여하기</a> | 
		<a href="./deleteTeamMember.tm?idx=<%=idx %>">팀 탈퇴하기</a> | 
	<%} %>
	    <a href="./teamPage.tm?idx=<%=idx%>">팀페이지</a> | 
<%-- 		<a href="./deleteTeamMember.tm?idx=<%=idx %>">팀 탈퇴하기</a> | 
 --%>	<%
	}
	%>
		<a href="./teamList.te"> 목록으로</a>
	 <%
	 	
	 		if(session.getAttribute("user_num")==null){
	 			
	 		}else if(tdto.getMaster() == (int)session.getAttribute("user_num")){
	 %>
	 | <a href="">마스터</a> | 
	   <a href="./teamModify.te?idx=<%=idx%>">수정하기</a>
	 | <a href="./deleteTeamAction.te?idx=<%=tdto.getIdx() %>" onclick="return dropteam();">팀삭제</a>
	 <%} %>
	 <br>
	 <br>
	 
	 
	 <br>
	 <br>
	 
	 <script type="text/javascript">
		$(function(){
			$("#oh").on("click", function(){
				$.ajax({
					url:"./Team_commentAction.te",
					type:"post",
					data:{"team_idx":<%=team_idx %>, "nickname":"<%=nickname%>", "content":$("#content").val(), "secret":document.fr.secret.value},
					success:function(data){
						location.reload();
					}
				});
			});
		});
		
	</script>
	 	<form name="fr">
	 
	 	공개 : <input type="radio" checked="checked" name="secret" value="1" id="sec"> | 
	 	비공개 : <input type="radio" name="secret" value="0" id="sec">
	 	<br>
	 	<br>
	 	<input type="text" name="content" id="content" size="30" placeholder="궁금한점을 작성해주세요" style="text-align:center">
	 	<br>
	 	<br>
	 	<input type="button" value="댓글작성하기" id="oh">
	 	</form>
	 	
	 	
	 	
	
	 
	 
</center>
</body>
</html>