package com.deco.team.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class Team_commentAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		req.setCharacterEncoding("UTF-8");
		
		
		Team_commentDTO tcdto = new Team_commentDTO();
		tcdto.setTeam_idx(Integer.parseInt(req.getParameter("idx")));
		tcdto.setNickname(req.getParameter("nickname"));
		tcdto.setContent(req.getParameter("content"));
		tcdto.setSecret(Integer.parseInt(req.getParameter("secret")));
		
		Team_commentDAO tcdao = new Team_commentDAO();
		
		tcdao.teamComment_insert(tcdto);
		
		
		return null;
	}

	
}
