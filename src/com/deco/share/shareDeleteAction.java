package com.deco.share;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class shareDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : shareDeleteAction_execute() 호출");
		
		String idx = req.getParameter("contentNum");
		String pageNum = req.getParameter("pageNum");
		String pageSize = req.getParameter("pageSize");
		
		shareDAO sDAO = new shareDAO();
		
		sDAO.deleteShareContent(idx);
		
		ActionForward forward = new ActionForward("./shareList?pageNum="+pageNum+"&pageSize="+pageSize, true);
		
		return forward;
	}

}
