<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css" rel="stylesheet">

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth'
		});
		calendar.render();
	});
</script>

</head>
<body>

	<div id='calendar'></div>

</body>
</html>