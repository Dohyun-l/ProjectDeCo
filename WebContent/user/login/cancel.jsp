<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco - 회원탈퇴취소</title>
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
<center>
<h2>사랑은 돌아오는거야~~!! (회원탈퇴 취소)</h2>
<form action="./CancelAction.us" method="post" name="fr" onsubmit="return check();">
		<input type="email" name="email" placeholder="이메일을 입력하세요." style="text-align:center" size="40"><br>
		<br>
		<input type="password" name="pw" placeholder="비밀번호를 입력하세요." style="text-align:center" size="40"><br>
		<br>
		<input type="submit" value="취소하기"> | <input type="button" value="취소" onclick="return cancel();">
	</form>
</center>

</body>
</html>