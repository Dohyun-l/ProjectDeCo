<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco</title>
</head>
<body>
<%
	response.sendRedirect(request.getContextPath()+"/login.use");

	// 마스터 머지전 업로드할 파일 loginDAO last_login 메서드 추가 and LoginAction파일에 loDAO.last_login(email); 구문 추가 <-- 마지막 로그인 날짜 수정
%>



</body>
</html>