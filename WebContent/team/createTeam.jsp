<%@page import="com.deco.user.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>팀 - 스터디</title>

</head>
<body>
	<h1>WebContent/team/teamWrite.jsp</h1>
	<hr>
		
	<%
	
		int userNum = 0;
	
		if(session.getAttribute("user_num") == null){
			response.sendRedirect("./shareList.sh");
		} else {
			userNum = (int) session.getAttribute("user_num");
		}
	
		userDAO udao = new userDAO();
		String nickname = udao.getUserNickNameByNum(userNum);
	%>
	
		
		<form action="./teamWriteAction.sh" method="post" name="fr">
		<!-- 닉네임 -->
		닉네임 : <input type="text" id="nickname" name="nickname" value="<%=nickname%>"readonly>
		<input type="radio" name="anony" value="0" checked="checked">공개
		<input type="radio" name="anony" value="1">비공개
		<hr>
		<!-- 게시판 분류 -->
		
		<!-- 제목 -->	  		
		<input type="text" name="title" placeholder="제목을 입력해주세요">
		<select name='limit_p'>
  			<option value='' selected>인원을 선택해주세요</option>
  			<option value=4>4명</option>
 			<option value=5>5명</option>
  			<option value=6>6명</option>
  			<option value=7>7명</option>
  			<option value=8>8명</option>  
  			<option value=9>9명</option>
  			<option value=10>10명</option>			
		</select><hr>
				
		<input type="hidden" name="content">
		<jsp:include page="edit.jsp"></jsp:include>
		
		<br>
		<input type="submit" value="등록">
		<input type="reset" value="취소"> 
		<input type="button" value="메인으로" onclick="location.href='./teamMain.te'">
		</form>
	
</body>
</html>