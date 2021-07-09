<%@page import="java.util.List"%>
<%@page import="com.deco.user.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./user/myPage/joinTeamList.css">
</head>
<body>
	<%@ include file="../../main/header.jsp" %>
	<%@ include file="../../user/myPageNav.jsp" %>
	
	<%uDAO = new userDAO(); %>
	
	<div class="userTeamList-Wrapper">
		<div class="userTeamList-JoinedList">
		<h1>가입된 리스트</h1>
		
		<div class="TeamList-Wrapper">
		<c:forEach items="${TeamList[0] }" var="joinTeam">
			<div class="userTeamList-JoinedList__item myPage-TeamCard">
				<div class="userTeamList-TeamCard__item-title"><span>${joinTeam.title }</span></div>
				<c:set var="masterID" value="${joinTeam.master }" />
				
				<%int masterID = Integer.parseInt(pageContext.getAttribute("masterID").toString());
				pageContext.setAttribute("masterName", uDAO.getUserNickNameByNum(masterID));
				%>
				
				<div class="userTeamList-TeamCard__item-master">
					<span class="masterHead">마스터</span>
					<span class="masterTail">${masterName }</span>
				</div>
					
				<div class="userTeamList-TeamCard__item-curPersonnel"></div>
			</div>
		</c:forEach>
		</div>
		</div>
		
		<div class="userTeamList-WaitingList">
		<h1>승인 대기중 리스트</h1>
		<div class="TeamList-Wrapper">
			<c:forEach items="${TeamList[1] }" var="waitingTeam">
				<div class="userTeamList-WaitingList__item myPage-TeamCard">
					<div class="userTeamList-TeamCard__item-title"><span>${waitingTeam.title }</span></div>
					<c:set var="masterID" value="${waitingTeam.master }" />
					
					<%int masterID = Integer.parseInt(pageContext.getAttribute("masterID").toString());
					pageContext.setAttribute("masterName", uDAO.getUserNickNameByNum(masterID));
					%>
					
					<div class="userTeamList-TeamCard__item-master">
						<span class="masterHead">마스터</span>
						<span class="masterTail">${masterName }</span>
					</div>
						
					<div class="userTeamList-TeamCard__item-curPersonnel"></div>
				</div>
			</c:forEach>
		</div>
		</div>
	</div>
</body>
</html>