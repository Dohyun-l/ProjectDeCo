package com.deco.team.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class joinTeamMemberAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : joinTeamMemberAction_execute() 호출");
		
		HttpSession session = req.getSession();
		
		ActionForward forward = null;
		
		int user_num = 0;
		if(session.getAttribute("user_num") == null){
			forward = new ActionForward("./teamMain.te", true);
			return forward;
		} else {
			user_num = (int)session.getAttribute("user_num");
		}
		
		teamMemberDTO tmDTO = new teamMemberDTO();
		
		tmDTO.setTeam_idx(Integer.parseInt(req.getParameter("team_idx")));
		tmDTO.setMember(user_num);
		
		teamMemberDAO tmDAO = new teamMemberDAO();
		
		int result = tmDAO.checkSubmitMember(Integer.parseInt(req.getParameter("team_idx")));
		
		
		
		tmDAO.joinTeam(tmDTO);
		
		forward = new ActionForward("./teamMain.te", true);
		
		return forward;
	}

}
