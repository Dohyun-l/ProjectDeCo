<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="./user/join/join.css">
<link rel="stylesheet" href="./user/form.css">
<title>Join</title>
</head>
<body>
<%
if(session.getAttribute("user_num") != null){
	response.sendRedirect("./main.us");	
}
%>
<main class="userMain">
	<form id="joinForm" class="userForm" action="joinAction.us" method="post">
		<div class="userForm-TitleWrapper">
			<h2 class="Title">회원가입</h2>
		</div>
		<div class="userForm__inputData">
			<input type="text" name="email" id="email" placeholder="이메일">
			<div class="input__border"></div>
		</div>
		<div class="userForm__inputData">
			<input type="password" name="pw" id="pw" placeholder="비밀번호">
			<div class="input__border"></div>
		</div>
		<div class="userForm__inputData">
			<input type="password" name="pw2" id="pw2" placeholder="비밀번호 확인">
			<div class="input__border"></div>
		</div>
		<div class="userForm__inputData">
			<input type="text" name="name" id="name" placeholder="이름">
			<div class="input__border"></div>
		</div>
		<div class="userForm__inputData">
			<input type="text" name="nickname" id="nickname" placeholder="닉네임">
			<div class="input__border"></div>
		</div>
		<div class="userForm__inputData">
			<input type="text" name="phone" id="phone" placeholder="휴대전화(010-XXXX-XXXX)" maxlength="13">
			<div class="input__border"></div>
		</div>
		<div class="userForm__inputData">
			<input type="text" name="addr" id="addr" placeholder="주소" readonly>
			<div class="input__border"></div>
		</div>
		<button onclick="return callAddress()">주소찾기</button>

		<div id="majorContainer" class="subInputContainer">
			<div class="cofirmContainer"></div>
			<div class="InputContainer">
				<div class="subjectInputWrapper">
					<input type="text" name="major" class="subjectInput" id="major" placeholder="전문분야">
				</div>
				<div id="searchBox1" class="searchBox"></div>
			</div>	
		</div>

		<div id="interContainer" class="subInputContainer">
			<div class="cofirmContainer"></div>
			<div class="InputContainer">
				<div class="subjectInputWrapper">
				<input type="text" name="inter" class="subjectInput" id="inter" placeholder="관심분야">
				</div>
				<div id="searchBox2" class="searchBox"></div>
			</div>	
		</div>
		<button id="joinSubmit">회원가입</button>
	</form>
	<div class="reqLogin" >
		<a href="login.us">이미 회원이신가요? &rarr;</a>
   </div> 
</main>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="./user/join/js/addrAPI.js"></script>
<script type="module" src="./user/join/js/phoneHypen.js"></script>
<script type="module" src="./user/join/js/searchData.js"></script>
<script type="module" src="./user/join/js/searchSubject.js"></script>
</body>
</html>