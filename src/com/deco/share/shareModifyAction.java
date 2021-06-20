package com.deco.share;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class shareModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : shareModifyAction_execute() 호출");
		
		//세션처리하기
		
		
		String idx = req.getParameter("contentNum");
		String pageNum = req.getParameter("pageNum");
		String pageSize = req.getParameter("pageSize");
		
		//글번호에 해당하는 글 가져오기
	 	req.setAttribute("shareContent", new shareDAO().getShare(Integer.parseInt(idx)));
		
	 	ActionForward forward = new ActionForward("./shareModify.jsp",false);

		return forward;
	}

}
