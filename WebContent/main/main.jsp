<%@page import="com.deco.user.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="https://unpkg.com/ionicons@4.5.10-0/dist/css/ionicons.min.css">
<link rel="stylesheet" href="./main/style.css">
<link rel="stylesheet" href="./main/main.css">
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
	<form action="./LoginAction.us" class="userForm loginForm" name="fr" method="post" onsubmit="return check();">	
		<main class="userMain">
	<input type="submit" class="userForm__submit" value="로그인">
 </form>
</main>
	</div>
	<%} else{%>
	<div id="Hlogin">
		<h2 class="Hlogin">Welcome <%=name %></h2>
<%-- 마이페이지 추천	<a class="Hlogin" href="./info.us?user_num=<%=user_num %>">회원정보 조회</a> --%>
<%-- 관리자 페이지 추천 	<%if(admin_auth == 2){ %><a class="Hlogin" href="./cancel.us">회원탈퇴 취소</a><%} %> --%>
		<a class="Hlogin" href="./userlogout.us">logout</a>
		</div>
	<%} %>

	
	<!-- 회원탈퇴취소 admin_auth 값이 2인 사람만 보이게 수정 -->
</header>
<article>
<!-- 스크롤 -->
<div class="container">
  <div class="sections">
    <div class="section active" data-bgcolor="#364652">
      <h2 class="section--header">한글 폰트 </h2>
      <div class="section--image"><img src="https://images.unsplash.com/photo-1532275948649-7d97f309ef16?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=db3d266a0c1ec46b95f03a271a78603f&auto=format&fit=crop&w=2250&q=80" /></div>
    </div>
    <div class="section" data-bgcolor="#C1A5A9">
      <h2 class="section--header">좋은 거</h2>
      <div class="section--image"><img src="https://images.unsplash.com/photo-1532173311168-91e999ce4e47?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=cf6ff267733890306ca709fa2184dd3a&auto=format&fit=crop&w=1301&q=80" /></div>
    </div>
    <div class="section" data-bgcolor="#4ECDC4">
      <h2 class="section--header">없을까요</h2>
      <div class="section--image"><img src="https://images.unsplash.com/photo-1532275948649-7d97f309ef16?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=db3d266a0c1ec46b95f03a271a78603f&auto=format&fit=crop&w=2250&q=80" /></div>
    </div>
    <div class="section" data-bgcolor="#D4CBE5">
      <h2 class="section--header">여기에</h2>
      <div class="section--image"><img src="https://images.unsplash.com/photo-1500817487388-039e623edc21?ixlib=rb-0.3.5&s=a21f754569632b81fd47dcaafe30b7c3&auto=format&fit=crop&w=2571&q=80" /></div>
    </div>
        <div class="section" data-bgcolor="#EDD4B2">
      <h2 class="section--header">데코 소개</h2>
      <div class="section--image"><img src="https://images.unsplash.com/photo-1482938289607-e9573fc25ebb?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0a5b239a157c3a39cf32283c50f9cd0c&auto=format&fit=crop&w=934&q=80" /></div>
    </div>
  </div>
</div>

  <script  src="./main/script.js"></script>
  <!-- 스크롤 -->
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>

</article>	
</div>	
	
</body>
</html>