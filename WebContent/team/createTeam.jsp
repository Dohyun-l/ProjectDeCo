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
			
		<!-- 제목 -->	  		
		<input type="text" name="title" placeholder="제목을 입력해주세요">
		
		<select name='location'>
  			<option value='' selected>지역을 선택해주세요</option>
  			<option value="seoul">서울</option>
 			<option value="busan">부산</option>
  			<option value="Incheon">인천</option>
  			<option value="daegu">대구</option>
  			<option value="gwangju">광주</option>  
  			<option value="ulsan">울산</option>
  			<option value="daejeon">대전</option>		
  			<option value="changwon">창원</option>
  			<option value="jeju">제주도</option>					
		</select><hr>
		
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
				
		모집 기한 : <input type="date" name="deadline">	<br>
				
		<input type="hidden" name="content">
		<jsp:include page="edit.jsp"></jsp:include>
		
		<br>
		<input type="submit" value="팀만들기">
		<input type="reset" value="취소"> 
		<input type="button" value="메인으로" onclick="location.href='./teamMain.te'">
		</form>
	
</body>
</html>