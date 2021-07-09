<%@page import="com.deco.user.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./user/myPage/layout.css">
<link rel="stylesheet" href="./user/myPage/myList.css">
<link rel="stylesheet" href="./user/form.css">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../../main/header.jsp" %>
	
	<main class="myPageWrapper">
		<%@ include file="../../user/myPageNav.jsp" %>
		
		<div class="userContentList-Wrapper">
			<div class="userContentList-tableWrapper">
			<div class="tableWrapper__title-Wrapper"><span>좋아요한 게시물</span></div>
			<table>
			<c:forEach items="${AllList.likeShare }" var="likeShareOne">
					<tr>
						<td><a href="./shareContent.sh?pageNum=1&pageSize=5&contentNum=${likeShareOne.idx }&category=null">${likeShareOne.title }</a></td>
						<td>${likeShareOne.category }</td>
					</tr>		
			</c:forEach>
			</table>	
			</div>
			<div class="userContentList-tableWrapper">
			<table>
			<div class="tableWrapper__title-Wrapper"><span>즐겨찾기 게시물</span></div>
			<c:forEach items="${AllList.bookShare }" var="bookShareOne">
					<tr>
						<td><a href="./shareContent.sh?pageNum=1&pageSize=5&contentNum=${bookShareOne.idx }&category=null">${bookShareOne.title }</a></td>
						<td>${bookShareOne.category }</td>
					</tr>	
			</c:forEach>
			</table>	
			</div>
			<div class="userContentList-tableWrapper">
			<table>
			<div class="tableWrapper__title-Wrapper"><span>내가 쓴 게시물</span></div>
			<c:forEach items="${AllList.userWriteShare }" var="userWriteShareOne">
					<tr>
						<td><a href="./shareContent.sh?pageNum=1&pageSize=5&contentNum=${userWriteShareOne.idx }&category=null">${userWriteShareOne.title }</a></td>
						<td>${userWriteShareOne.category }</td>
					</tr>			
			</c:forEach>
			</table>	
			</div>
		</div>
	</main>
</body>
</html>