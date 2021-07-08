package com.deco.team.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class teamMemberCalendarAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		System.out.println("M : teamMemberCalendarAction_execute() 호출");
		
		String team_idx = req.getParameter("idx");
		
		teamMemberDAO tmdao = new teamMemberDAO();
		List<teamMemberDTO> teamMemberList = tmdao.getSubmitmemberList(Integer.parseInt(team_idx));
		
		req.setAttribute("teamMemberList", teamMemberList);
		
		return new ActionForward("./teamMember/fullcalendar/calendar.jsp", false);
	}

}
