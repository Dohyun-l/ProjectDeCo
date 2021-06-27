package com.deco.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class createTeamAction implements Action{



	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		teamDTO tdto = new teamDTO();
		tdto.setTitle(req.getParameter("title"));
		tdto.setContent(req.getParameter("content"));
		tdto.setLocation(req.getParameter("location"));
		tdto.setMaster(Integer.parseInt(req.getParameter("master")));
		tdto.setLimit_p(req.getParameter("limit_p"));
		tdto.setDeadline(req.getParameter("deadline"));
		
		teamDAO tdao = new teamDAO();
		tdao.create_team(tdto);
		
		ActionForward forward = new ActionForward("./main.us", true);
		return forward;
	}
	
	
}
