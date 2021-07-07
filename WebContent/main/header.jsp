<%@page import="com.deco.user.userDAO"%>
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
	int user_num = -1;
	int admin_auth = -1;
	userDAO uDAO;
	String name = null;
	
	if(session.getAttribute("user_num") != null){
		user_num = (Integer)session.getAttribute("user_num");
		uDAO = new userDAO();
		name = uDAO.getUserNickNameByNum(user_num);
		admin_auth = uDAO.getAdminByNum(user_num);
	}
	
%>
<div id="wrap">
<header>
  <div class="Alogo">
      <div class="link-1">
        <a class="Hlogo" href="./main.us" >
          <span class="thick">D</span><span class="thin">e</span><span class="thick">C</span><span class="thin">o</span>
        </a>
        <p><a class="p" href="./main.us">Developer Completion</a></p>    
      </div>
  </div>
	<nav id="Hnav">
	  <ul>
		<li>
		<a class="Hmenu" href="./Main.nt">Notice</a>
		</li>
		<li>
		<a class="Hmenu" href="./shareList.sh">Share</a>
		</li>
		<li>
		<a class="Hmenu" href="./shareList.sh">Project</a>
		</li>
		<li>
		<a class="Hmenu" href="./shareList.sh">My Page</a>
		</li>
	  </ul>
	</nav>	
	
	<div id="Hsearch">
		<input type="text" value="검색창" onclick="this.value=''"> <!-- 나중에 구글 검색 넣기  -->
	</div>
	
	<%if(name == null && user_num == -1) {%>
	<div id="Hlogin">
<!-- 		<a class="Hlogin" href="./login.us">login</a> /
		<a class="Hlogin" href="./login.us">join</a> -->
	<form class="userForm loginForm" name="fr">	
		<main class="userMain">
	<input type="button" class="userForm__button" value="로그인" onclick="location.href='./login.us'">
 </form>
</main>
	</div>
	<%} else{%>
	<div id="Hlogin">
	<form class="userForm loginForm" name="fr">	
		<h2 class="Hlogin">Welcome <%=name %></h2>
<%-- 마이페이지 추천	<a class="Hlogin" href="./info.us?user_num=<%=user_num %>">회원정보 조회</a> --%>
<%-- 관리자 페이지 추천 	<%if(admin_auth == 2){ %><a class="Hlogin" href="./cancel.us">회원탈퇴 취소</a><%} %> --%>
<!-- 		<a class="Hlogin" href="./userlogout.us">logout</a> -->
		<main class="userMain">
		<input type="button" class="userForm__button" value="로그아웃" onclick="location.href='./userlogout.us'">
 		</form>
		</div>
	<%} %>

	
	<!-- 회원탈퇴취소 admin_auth 값이 2인 사람만 보이게 수정 -->
</header>

</body>
</html>