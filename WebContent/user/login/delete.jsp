<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco</title>
<script type="text/javascript">
function cancel(){
		location.href="./main.use";
	}
</script>
<script>
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
	<h2>회원탈퇴? 해보시지</h2>
	<h4>회원탈퇴후 한달간 정상적으로 이용 가능하시며 한달후 탈퇴 처리가 진행됩니다.</h4>
	<form action="./DeleteAction.us" method="post" name="fr" onsubmit="return check();">
		<input type="email" name="email" placeholder="이메일을 입력하세요." style="text-align:center"><br>
		<br>
		<input type="pw" name="pw" placeholder="비밀번호를 입력하세요." style="text-align:center"><br>
		<br>
		<input type="submit" value="탈퇴하기"> | <input type="button" value="취소" onclick="return cancel();">
	</form>
	</center>
</body>
</html>