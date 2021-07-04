<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="teamList.css" rel="stylesheet">

</head>
<body>


<div class="cards">
	<%for (int i=0; i<10; i++){ %>
	<div class="card" onclick="location.href='../main.us?idx=<%=i%>'">
		<div class="card-face">
			<div class="card-label">
				#<%=i+1 %><br>
				title : <br>
				master : <br>
				location : <br>
			</div>
		</div>
	</div>
	<%} %>
</div>


</body>
</html>