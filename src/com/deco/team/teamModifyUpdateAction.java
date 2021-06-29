package com.deco.team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class teamModifyUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : teamModifyUpdateAction_execute() 호출");
		
		//한글처리
		req.setCharacterEncoding("utf-8");
				
		//세션처리
		HttpSession session = req.getSession();
				
		int idx = Integer.parseInt(req.getParameter("idx"));
				
		if(session.getAttribute("user_num") != null){
			int userNum = (int) session.getAttribute("user_num");
		}
		
		String pageSize = req.getParameter("pageSize");
		String pageNum = req.getParameter("pageNum");
		String location = req.getParameter("location");
		String limit_p = req.getParameter("limit_p");
		
		teamDTO tdto = new teamDTO();
		tdto.setTitle(req.getParameter("title"));
		tdto.setContent(req.getParameter("content"));
		tdto.setLocation(req.getParameter("location"));
		tdto.setLimit_p(req.getParameter("limit_p"));
		tdto.setMaster(Integer.parseInt(req.getParameter("master")));
		tdto.setIdx(idx);
		
		teamDAO tdao = new teamDAO();
		tdao.teamUpdate(tdto);
		
		ActionForward forward = new ActionForward();
		
		return forward;
	}

}
