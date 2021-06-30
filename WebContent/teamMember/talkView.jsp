<%@page import="com.deco.user.userDAO"%>
<%@page import="com.deco.team.talk.talkDTO"%>
<%@page import="com.deco.team.talk.talkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<%
	int user_num = 0;
	
	if(session.getAttribute("user_num") == null) {
		response.sendRedirect("./teamList.te");
	} else {
		user_num = (int) session.getAttribute("user_num");
	}

	String nickname = new userDAO().getUserNickNameByNum(user_num);

	String idx = request.getParameter("idx");

	talkDAO tdao = new talkDAO();
	talkDTO tdto = tdao.getTalkInfo(Integer.parseInt(idx));
%>

<style type="text/css">
#talkContent {
	margin: 0 auto;
	padding: 0 3%;
	width: 70%;
	height: 700px;
	background: linear-gradient(to bottom left, skyblue, pink);
	overflow: scroll;
}

[id=nick<%=nickname%>] {
	text-align: right;
}

.nickname {
	color: #800080;
}

.content {
	background-color: #FFF56E;
	width: 15%;
	height: auto;
	display: inline-block;
}

</style>
</head>
<body>

	
	
	<script type="text/javascript">
	
	$(function(){

		$("#content").focus();
		
		$.ajax({
		    url: "/updateTalk.tm",
		    data: { idx: <%=idx%>},
		    success: function(data){
		    	$("#talkContent").html(data);
		    	$("#talkContent").scrollTop(100000);
		    }
		});
		setInterval(function () {
			$.ajax({
			    url: "printTalk.tm",
			    data: { idx: <%=idx%>},
			    success: function(data){
			    	$("#talkContent").html(data);
			    	$("#talkContent").scrollTop(100000);
			    }
			});
         }, 5000);
        
	});
	
	function writeContent() {
		var nickname = document.getElementById("nickname").value;
		var content = document.getElementById("content").value;
		
		if(content != ""){
			$(function(){
				$.ajax({
				    url: "updateTalk.jsp?idx=<%=idx%>",
				    data: {nickname: nickname, content:content},
				    method: "POST",
				    success: function(data){
				    	location.reload();
				    }
				});
				
			});			
		}
	}
	
	function enterKey() {
		if(window.event.keyCode == 13){
			writeContent();
		}
	}

	</script>

	<h1><%=idx%> 채팅방</h1>
	<a href="talkList.jsp">채팅방 리스트 보기</a>
	닉네임 : <input type="text" id="nickname" value="<%=nickname%>" readonly>
	내용 : <input type="text" id="content" onkeyup="enterKey()">
	<input type="button" value="전송" onclick="writeContent()">

	<hr>
	<div id="talkContent"></div>
	<hr>
	

</body>
</html>