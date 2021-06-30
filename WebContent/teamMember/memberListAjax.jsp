<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DeCo - 팀프로젝트(멤버 관리)</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<%
	String team_idx = request.getParameter("idx");

%>
<script type="text/javascript">
$(function(){
	$.ajax({
		url: "./printSubmitMemberList.tm",
		data: {team_idx:"<%=team_idx%>"},
		success: function(data){
			$("#submitMember").html(data);
			setTimeout(function(){isAjaxing=false;}, 1000);
		},
		async: false
	});
	
	$.ajax({
		url: "./printNoneSubmitMemberList.tm",
		data: {team_idx:"<%=team_idx%>"},
		success: function(data){
			$("#noneSubmitMember").html(data);
			setTimeout(function(){isAjaxing=false;}, 1000);
		},
		async: false
	});
	

	$(document).on('click',"[id*=member]",function(){
		$.ajax({
			url: "./memberInfo.tm",
			data: {idx:$(this).attr("id").substr(6)},
			success: function(data){
				$("#userInfo").html(data);
				setTimeout(function(){isAjaxing=false;}, 1000);
			}
		});
		
	});
	
	$(document).on('click',"[id*=joinTeam]",function(){
		$.ajax({
			url: "./joinTeam.tm",
			data: {idx:$(this).attr("id").substr(8)},
			success: function(data){
				alert("승인완료");
				userReload();
			}
		});
		
	});
	
	$(document).on('click',"[id*=outMember]",function(){
		$.ajax({
			url: "./outMember.tm",
			data: {idx:$(this).attr("id").substr(9)},
			success: function(data){
				alert("퇴출완료");
				userReload();
			}
		});
		
	});
	
	function userReload() {
		$.ajax({
			url: "./printSubmitMemberList.tm",
			data: {team_idx:"<%=team_idx%>"},
			success: function(data){
				$("#submitMember").html(data);
				setTimeout(function(){isAjaxing=false;}, 1000);
			},
			async: false
		});
		
		
		$.ajax({
			url: "./printNoneSubmitMemberList.tm",
			data: {team_idx:"<%=team_idx%>"},
			success: function(data){
				$("#noneSubmitMember").html(data);
				setTimeout(function(){isAjaxing=false;}, 1000);
			},
			async: false
		});
	}
	
});
</script>
</head>
<body>
<h1>멤버관리</h1>
<a href="./teamPage.tm?idx=<%=team_idx%>">팀페이지</a>
<hr>
<h2>승인유저</h2>
<div id="submitMember"></div>
<hr>
<h2>미승인유저</h2>
<div id="noneSubmitMember"></div>
<hr>
<div id="userInfo"></div>

</body>
</html>