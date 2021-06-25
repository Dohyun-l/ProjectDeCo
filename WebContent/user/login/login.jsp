<%@page import="com.deco.user.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="./user/login/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco</title>
<script type="text/javascript">
function check(){
	if(document.fr.email.value == ""){
		alert("이메일을 입력하세요");
		document.fr.email.focus();
		return false;
	}
	if(document.fr.pw.value == ""){
		alert("비밀번호를 입력하세요");
		document.fr.pw.focus();
		return false;
	}
}
</script>
</head>
<body>
<%
if(session.getAttribute("user_num") != null){
	response.sendRedirect("./main.us");
	return ;
}
%>
<%
	String referer = (String) request.getHeader("REFERER");
%>
 <form action="./LoginAction.us" name="fr" method="post" onsubmit="return check();">
 <center>
 	<h2>로그인</h2>
 	<input type="hidden" name="referer" value="<%=referer %>">
 	<input type="email" name="email" size="20" style="text-align:center" placeholder="이메일을 입력하세요."><br>
 	<br>
 	<input type="password" name="pw" size="20" style="text-align:center" placeholder="비밀번호를 입력하세요."><br>
 	<br>
 	<input type="submit" value="로그인"> | <input type="button" value="회원가입" onclick="location.href='join.us'">
 	<br>
 	<br>
 	<a id="kakaoLogin" href="./kakaoLoginStart.us">
      <img
      src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
      width="222" />
   </a>
    <a href="./githubStart.us" class="github-login">
        <i class="fab fa-github"></i> 깃허브로 로그인
    </a>
   <p id="reauthenticate-popup-result"></p>
 </center>
 </form>
 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</body>
</html>