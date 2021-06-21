<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Deco</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 	6b804dbdaf7fff8b3aaf8447df5e7295 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
function check(){
	if(document.fr.email.value == ""){
		alert("이메일을 입력하세요");
		document.fr.email.focus();
		return false;
	}
	if(document.fr.pw.value == ""){
		alert("비밀번호를 입력하세요");
		document.fr.pw.focus();
		return false;
	}
}
</script>
</head>
<body>
   <script type="text/javascript">
   
   var email = "";
   var nickname = "";
   var image = "";
   
   
   // https://developers.kakao.com/console/app/592102 - JavaScript 키 사용
   window.Kakao.init("6b804dbdaf7fff8b3aaf8447df5e7295");
   
      function loginFormWithKakao() {
         Kakao.Auth.loginForm({
            success : function(authObj) {
               showResult(JSON.stringify(authObj))
               
               window.Kakao.API.request({
                  
                  url:'/v2/user/me',
                  success: function(res) {
                  
                     const kakao_account = res.kakao_account;
                     console.log(kakao_account);
                     
                     email = kakao_account.email;
                     
                     nickname = kakao_account.profile.nickname;
                     
                     image = kakao_account.profile.profile_image_url;
                     
                     var img = "<img src='"+image+"'>";
                     
                     var t = ""
                     
                     t += "<table>";
                     t += "<tr>";
                     t += "<td>"+img+"</td>";
                     t += "<td> 닉네임 : "+nickname+"<br>이메일 : "+email+"</td>";
                     
                     
                     t += "</tr>";
                     t += "</table>";
                     
                     showResultHTML(t);
                     
                     
                  }
                  
               });
               
               
            },
            fail : function(err) {
               showResult(JSON.stringify(err))
            },
         })
      }
      
      function showResult(result) {
         document.getElementById('reauthenticate-popup-result').innerText = result;
      }
      
      function showResultHTML(result) {
          document.getElementById('reauthenticate-popup-result').innerHTML = result;
       }
      
      
      
   </script>
<%
	String referer = (String) request.getHeader("REFERER");
%>
 <form action="./LoginAction.use" name="fr" method="post" onsubmit="return check();">
 <center>
 	<h2>로그인</h2>
 	<input type="hidden" name="referer" value="<%=referer %>">
 	<input type="email" name="email" size="20" style="text-align:center" placeholder="이메일을 입력하세요."><br>
 	<br>
 	<input type="password" name="pw" size="20" style="text-align:center" placeholder="비밀번호를 입력하세요."><br>
 	<br>
 	<input type="submit" value="로그인"> | <input type="button" value="회원가입" onclick="">
 	<br>
 	<br>
 	<a id="reauthenticate-popup-btn" href="javascript:loginFormWithKakao()">
      <img
      src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
      width="222" />
   </a>
   <p id="reauthenticate-popup-result"></p>
 </center>
 </form>
</body>
</html>