<%@page import="com.deco.user.userDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../../main/header.jsp" %>
	<%@ include file="../../user/myPageNav.jsp" %>
	
	<div class="userContentList-Wrapper">
		<div class="userContentList-LikeWrapper">
		<div><h2>좋아요한 게시물</h2></div>
		<table>
		<c:forEach items="${AllList.likeShare }" var="likeShareOne">
				<tr>
					<td><a href="./shareContent.sh?pageNum=1&pageSize=5&contentNum=${likeShareOne.idx }&category=null">${likeShareOne.title }</a></td>
					<td>${likeShareOne.category }</td>
				</tr>		
		</c:forEach>
		</table>	
		</div>
		<div class="userContentList-LikeWrapper">
		<table>
		<div><h2>즐겨찾기 게시물</h2></div>
		<c:forEach items="${AllList.bookShare }" var="bookShareOne">
				<tr>
					<td><a href="./shareContent.sh?pageNum=1&pageSize=5&contentNum=${bookShareOne.idx }&category=null">${bookShareOne.title }</a></td>
					<td>${bookShareOne.category }</td>
				</tr>	
		</c:forEach>
		</table>	
		</div>
		<div class="userContentList-LikeWrapper">
		<table>
		<div><h2>내가 쓴 게시물</h2></div>
		<c:forEach items="${AllList.userWriteShare }" var="userWriteShareOne">
				<tr>
					<td><a href="./shareContent.sh?pageNum=1&pageSize=5&contentNum=${userWriteShareOne.idx }&category=null">${userWriteShareOne.title }</a></td>
					<td>${userWriteShareOne.category }</td>
				</tr>			
		</c:forEach>
		</table>	
		</div>
	</div>
</body>
</html>