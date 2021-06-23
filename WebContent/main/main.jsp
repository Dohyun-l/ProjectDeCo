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
	int user_num = (int) session.getAttribute("user_num");
%>
	<h2>환영합니다<%=user_num %>님</h2>
	<a href="./info.us?user_num=<%=user_num %>">회원정보 조회</a>
	
	<a href="./Main.nt">공지사항</a>
	
	<a href="./shareList.sh">정보공유</a>
	
	
	<a href="./userlogout.us">로그아웃</a>
	
</body>
</html>