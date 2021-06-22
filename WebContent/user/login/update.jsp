<%@page import="javax.mail.Session"%>
<%@page import="com.deco.login.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco</title>
<script type="text/javascript">
function check(){
	if(document.fr.name.value == ""){
		alert("이름을 입력해주세요.");
		document.fr.name.focus();
		return false;
	}
	if(document.fr.nickname.value == ""){
		alert("닉네임을 입력해주세요");
		document.fr.nickname.focus();
		return false;
	}
	if(document.fr.addr.value == ""){
		alert("주소를 입력해주세요.");
		document.fr.addr.focus();
		return false;
	}
	if(document.fr.phone.value == ""){
		alert("전화번호를 입력해주세요.");
		document.fr.phone.focus();
		return false;
	}
	if(document.fr.major.value == ""){
		alert("전공분야를 입력해주세요.");
		document.fr.major.focus();
		return false;
	}
}
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		userDTO udto = (userDTO) request.getAttribute("udto");
		int user_num = Integer.parseInt(request.getParameter("user_num"));
	%>
	<center>
	<form action="./UpdateAction.use" method="post" onsubmit="return check();" name="fr">
	<h2>회원 정보 수정</h2>
				<!-- 닉네임 유니크(ajax로 중복체크) -->
				<input type="hidden" name="user_num" value="<%=user_num %>">
		비밀번호 : <input type="password" name="pw" placeholder="현재 비밀번호를 입력해주세요." style="text-align:center" size="30"><br>
		이름 : <input type="text" name="name" value="<%=udto.getName() %>" style="text-align:center" size="30"><br>
		닉네임 : <input type="text" name="nickname" value="<%=udto.getNickname() %>" style="text-align:center" size="30"><br>
		주소 : <input type="text" name="addr" value="<%=udto.getAddr() %>" style="text-align:center" size="30"><br>
		전화번호 : <input type="text" name="phone" value="<%=udto.getPhone() %>" style="text-align:center" size="30"><br>
		전공분야 : <input type="text" name="major" value="<%=udto.getMajor() %>" style="text-align:center" size="30"><br>
		<input type="submit" value="수정하기">
		
		
	</form>
	
	</center>

</body>
</html>