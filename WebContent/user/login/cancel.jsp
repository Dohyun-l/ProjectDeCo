<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./user/myPage/layout.css">
<link rel="stylesheet" href="./user/form.css">
<title>Deco - cancel</title>
<script type="text/javascript">
function check(){
	if(document.fr.email.value == ""){
		alert("이메일을 입력해주세요.");
		document.fr.email.focus();
		return false;
	}
	if(document.fr.pw.value == ""){
		alert("비밀번호를 입력해주세요.");
		document.fr.pw.focus();
		return false;
	}
}
</script>
</head>
<body>
<%@ include file="../../main/header.jsp" %>

<main class="myPageWrapper">

<%@ include file="../../user/myPageNav.jsp" %>
	<center>
	<h2>회원탈퇴 취소</h2>
	<form action="./CancelAction.us" method="post" name="fr" onsubmit="return check();" class="userForm">
			<input type="email" name="email" placeholder="이메일을 입력하세요." style="text-align:center" size="40"><br>
			<br>
			<input type="pw" name="pw" placeholder="비밀번호를 입력하세요." style="text-align:center" size="40"><br>
			<br>
			<input type="submit" value="취소하기">
		</form>
	</center>
</main>
</body>
</html>