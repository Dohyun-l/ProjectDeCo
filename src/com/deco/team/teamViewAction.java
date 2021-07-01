package com.deco.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.team.member.teamMemberDAO;

public class teamViewAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		int idx = Integer.parseInt(req.getParameter("idx"));
		int user_num = (int) session.getAttribute("user_num");
		if(session.getAttribute("user_num") != null){
			int userNum = (int) session.getAttribute("user_num");
		}
		teamDAO tdao = new teamDAO();
		teamDTO tdto = tdao.getteamView(idx);
		String deadline = (String) tdto.getDeadline();
		int check = tdao.teamDeadlineCheck(deadline, idx);
		
		
		req.setAttribute("tdto", tdto);
		req.setAttribute("check", check);
		
		ActionForward forward = new ActionForward();
		forward = new ActionForward("./team/teamView.jsp", false);
		return forward;
	}

	
}