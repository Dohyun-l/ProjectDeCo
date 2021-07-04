<%@page import="java.util.ArrayList"%>
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
<script type="text/javascript">
function need(){
	if(document.fr.content.value == ""){
		alert("댓글을 입력해주세요.");
		document.fr.content.focus();
		return false;
	} else {
		return true;
	}
}
</script>

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
	<!-- 댓글 -->
	
	<script type="text/javascript">
		// 댓글 달기 ajax
		$(function(){
			$(this).off("click").on("click", ".oh",function(){
				if(need()){
					$.ajax({
						url:"./Team_commentAction.te",
						type:"post",
						data:{"team_idx":<%=team_idx %>, "user_num":<%=user_num %>, "content":$("#content").val(), "secret":document.fr.secret.value},
						success:function(data){
							location.reload();
						}
					});
				}
			});
		});
		// 댓글 달기 ajax
	</script>
	

<table border="1" style="text-align:center">
	<tr>
		
		<td width="200">작성자</td>
		<td width="400">내용</td>
		<td width="200">작성날짜</td>
		<td width="200">수정/삭제</td>
	</tr>
<%
	List teamCommentList = (ArrayList) request.getAttribute("teamCommentList");
	
	for(int i=0; i<teamCommentList.size(); i++){
		Team_commentDTO tcdto = (Team_commentDTO) teamCommentList.get(i);
		String commentnick = udao.getUserNickNameByNum(tcdto.getUser_num());
		%>
		
	
		<script type="text/javascript">
		// 댓글 수정버튼 이벤트 처리
		$(function(){
			var t ="<td colspan='5'><form name='fr<%=i%>' onsubmit='return false;'>";
				t +="<input type='text' id='re<%=i %>' name='content' placeholder='수정할내용을 입력해주세요.' size='40'' style='text-align:center'>&nbsp";
				t +="<input type='button' id='remove<%=i %>' value='수정하기' >";
				if(<%=tcdto.getSecret() %>==1){
				t +="<br>공개 : <input type='radio' value='1' name='ret<%=i %>' checked> / 비공개 : <input type='radio' value='0' name='ret<%=i %>'>";
				}else{
				t +="<br>공개 : <input type='radio' value='1' name='ret<%=i %>' > / 비공개 : <input type='radio' value='0' name='ret<%=i %>' checked>";
				}
				t +="</form></td>";
			$("#god<%=i %>").on("click",function(){
				$(".hid<%=i %>").html(t);
				$(".hid<%=i %>").fadeToggle(t);
			});
		});
		// 댓글 수정버튼 이벤트 처리
		
		//댓글 수정 ajax
		$(function(){
			$(document).on("click", "#remove<%=i %>",function(){
				
			if(document.fr<%=i%>.content.value == ""){
				alert("수정하실 댓글의 내용을 입력해주세요.");
				return false;
			}else{
				$.ajax({
					url:"./Team_commentUpdateAction.te",
					type:"post",
					data:{"idx":<%=tcdto.getIdx() %>, "content":$("#re<%=i %>").val(), "secret":document.fr<%=i%>.ret<%=i %>.value},
					success:function(data){
						location.reload();
					}
				});
				}
			});
			
		});
		//댓글 수정 ajax
		
		// 댓글 삭제 ajax
		$(function(){
			$("#my<%=i %>").on("click",function(){
				
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					url:"./Team_commentdeleteAction.te",
					type:"post",
					data:{"idx":<%=tcdto.getIdx() %>},
					success:function(check){
						if(check == 1){
						location.reload();
						}else if(check == 0){
							alert("본인이 단 글이 아닙니다.");
						}else{
							alert("잘못된 접근입니다.");
						}
						}
					});
				}else{
					return false;
				}
			});
		});
		// 댓글 삭제 ajax
	</script> 
	
	
	<tr>
		
		<td><%=commentnick %></td>
		<%if(tcdto.getSecret() == 1 ||tdto.getMaster()== user_num || tcdto.getUser_num()== user_num){ %>
		<td><%=tcdto.getContent() %></td>
		<%}else{ %>
		<td>비공개 글입니다.</td>
		<%} %>
		<td><%=tcdto.getCreate_at() %></td>
		<%if(tcdto.getUser_num()==user_num){ %>
			<td><input type="button" value="댓글삭제" id="my<%=i %>"> | <input type="button" value="댓글수정" id="god<%=i %>"></td>
		<%}else{ %>
			<td>작성자가 아닙니다.</td>
		<%} %>
	</tr>
			<tr class="hid<%=i %>" style="display:none">
				
			</tr>
<%} %>	
		</table>	
	 	<form name="fr" onsubmit="return false;">
	 
	 	<br>
	 	<br>
	 	공개 : <input type="radio" checked="checked" name="secret" value="1" id="sec"> | 
	 	비공개 : <input type="radio" name="secret" value="0" id="sec">
	 	<br>
	 	<br>
	 	<input type="text" name="content" id="content" size="30" placeholder="궁금한점을 작성해주세요" style="text-align:center">
	 	
<!-- 	 	<input type="button" value="댓글작성하기" class="oh" onclick="return need();"> -->
	 		<input type="button" value="댓글작성하기" class="oh">
	 	</form>
</center>
</body>
</html>