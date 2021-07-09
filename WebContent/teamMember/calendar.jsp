<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css" rel="stylesheet">

<link href="./css/teamMember/calendar.css" rel="stylesheet">

<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth',
			headerToolbar: {
				  start: "",
				  center: "prev title next",
				  end: "today"
			},
			titleFormat: function(date) {
				return date.date.year+"년 "+(date.date.month + 1)+"월";
			},
			dayHeaderContent: function (date) {
				  let weekList = ["일", "월", "화", "수", "목", "금", "토"];
				  return weekList[date.dow];
			},
			contentHeight: 800,
			fixedWeekCount: true,
			showNonCurrentDates: true
		});
		calendar.render();
	});
	
	
</script>

</head>
<body>

	<h1>팀일정공유</h1>

	<div id='calendar'></div>

</body>
</html>