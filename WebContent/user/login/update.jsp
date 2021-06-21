<%@page import="com.deco.user.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		userDTO udto = (userDTO) request.getAttribute("udto");
	%>
	<center>
	<form action="./UpdateAction.use" method="post">
	<h2>회원 정보 수정</h2>
		이름 : <input type="text" name="name" value="<%=udto.getName() %>"><br>
		닉네임 : <input type="text" name="nickname" value="<%=udto.getNickname() %>"><br>
		주소 : <input type="text" name="addr" value="<%=udto.getAddr() %>" >
		전화번호 : <input type="text" name="phone" value="<%=udto.getPhone() %>">
		전공분야 : <input type="text" name="major" value="<%=udto.getMajor() %>">
		
		
		
	</form>
	
	</center>

</body>
</html>