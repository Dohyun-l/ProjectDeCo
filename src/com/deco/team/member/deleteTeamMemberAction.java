package com.deco.team.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class deleteTeamMemberAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : deleteTeamMemberAction_execute() 호출");
		
		HttpSession session = req.getSession();
		
		ActionForward forward = null;
		
		int user_num = 0;
		if(session.getAttribute("user_num") == null) {
			forward = new ActionForward("./teamMain.te", true);
			return forward;
		} else {
			user_num = (int) session.getAttribute("user_num");
		}
		
		teamMemberDTO tmDTO = new teamMemberDTO();
		
		tmDTO.setMember(Integer.parseInt(req.getParameter("member")));
		tmDTO.setTeam_idx(Integer.parseInt(req.getParameter("team_idx")));
		
		teamMemberDAO tmDAO = new teamMemberDAO();
		tmDAO.deleteMember(tmDTO);
		
		forward = new ActionForward("./teamMain.te", true);
		
		return forward;
	}

}
