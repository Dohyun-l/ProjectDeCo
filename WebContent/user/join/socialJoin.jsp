<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://unpkg.com/mvp.css">
<link rel="stylesheet" href="./user/join/style.css">
<title>소설 회원가입</title>
</head>
<body>

<main>
	<form id="joinForm" action="SocialJoinAction.us" method="post">
		<h2>소셜 회원가입 추가정보</h2>
		<input type="text" name="email" id="email" placeholder="이메일" value="${uDTO.email}" readonly>
		<input type="text" name="name" id="name" placeholder="이름" value="${uDTO.name}">
		<input type="text" name="nickname" id="nickname" placeholder="닉네임">
		<input type="text" name="phone" id="phone" placeholder="휴대전화(010-XXXX-XXXX)" maxlength="13">
		<input type="text" name="addr" id="addr" placeholder="주소" readonly>
		<button onclick="return callAddress()">주소찾기</button>

		<div id="majorContainer" class="subInputContainer">
			<div class="cofirmContainer"></div>
			<div class="InputContainer">
				<div>
				<input type="text" name="major" class="subjectInput" id="major" placeholder="전문분야">
				</div>
				<div id="searchBox1" class="searchBox"></div>
			</div>	
		</div>

		<div id="interContainer" class="subInputContainer">
			<div class="cofirmContainer"></div>
			<div class="InputContainer">
				<div>
				<input type="text" name="inter" class="subjectInput" id="inter" placeholder="관심분야">
				</div>
				<div id="searchBox2" class="searchBox"></div>
			</div>	
		</div>
		<button id="joinSubmit">정보수정</button>
	</form>
	<a href="./userlogout.us"><button>로그아웃</button></a>
</main>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="./user/join/js/addrAPI.js"></script>
<script type="module" src="./user/join/js/phoneHypen.js"></script>
<script type="module" src="./user/join/js/searchData.js"></script>
<script type="module" src="./user/join/js/searchSubject.js"></script>
</body>
</html>