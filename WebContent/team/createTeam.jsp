<%@page import="java.io.Console"%>
<%@page import="com.deco.user.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>팀 - 스터디</title>
<script type="text/javascript">



function createTeamCheck() {
    document.fr.content.value= oEditor.getIR();
   
   var tags = document.querySelectorAll(".tag");
   var cnt = 0;
   for(var i = 0; i < tags.length;i++){
      if(tags[i].checked){
         cnt++;
      }
   }
   
   if(document.fr.title.value == ""){
      alert("제목을 작성해주세요.");
      document.fr.title.focus();
      return false;
   }
   
   if(document.fr.location.value == ""){
      alert("지역을 선택해주세요.");
      document.fr.location.focus();
      return false;
   }
   
   if(document.fr.content.value == "" || document.fr.content.value == "<p><br></p>"){
      alert("내용을 작성해 주세요.");
      return false;
   }
   var chk = grecaptcha.getResponse(); 
    if(chk.length == 0) {
       alert("로봇이 아닙니다 인증을 진행해주세요!");
       return false; 
    }
   
    if(document.fr.deadline.value == ""){
    	alert("모집기간을 설정해주세요.");
    	return false;
    }
   
}
</script>
</head>
<body>
	<h1>WebContent/team/createTeam.jsp</h1>
	<hr>
		
	<%
	
		int userNum = 0;
	
		if(session.getAttribute("user_num") == null){
			response.sendRedirect("./teamMain.te");
		} else {
			userNum = (int) session.getAttribute("user_num");
		}
	
		userDAO udao = new userDAO();
		String nickname = udao.getUserNickNameByNum(userNum);
		
	%>
	
	
		<center>
		<form action="./createTeamAction.te" method="post" name="fr" onsubmit="return createTeamCheck();">
		<!-- 닉네임 -->
		팀리더 : <br>
		<input type="text" id="nickname" name="nickname" value="<%=nickname%>"readonly style="text-align:center"><br>
			<hr>
		<!-- 제목 -->	  		
		<input type="text" name="title" placeholder="제목을 입력해주세요" size="30" style="text-align:center">
		<hr>
		
		<select name='location'>
  			<option value='' selected>지역을 선택해주세요</option>
  			<option value="Seoul">서울</option>
 			<option value="Busan">부산</option>
  			<option value="Incheon">인천</option>
  			<option value="Daegu">대구</option>
  			<option value="Gwangju">광주</option>  
  			<option value="Ulsan">울산</option>
  			<option value="Daejeon">대전</option>		
  			<option value="Changwon">창원</option>
  			<option value="Jeju">제주도</option>					
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
				
				
		모집 기한 : <input type="date" name="deadline" id="deadline"><br>
				
		<input type="hidden" name="content">
		<jsp:include page="edit.jsp"></jsp:include>
		
		<div class="g-recaptcha" id="g-recaptcha" data-sitekey="6LdQ1zEbAAAAAOzJAHtwDc8LTdr2vNQffqV-K15l" 	
		data-callback="recaptcha"></div>
		<br>
		<input type="submit" value="팀만들기"> /
		<input type="reset" value="취소"> /
		<input type="button" value="메인으로" onclick="location.href='./teamMain.te'">
		</form>
	</center>
</body>
</html>