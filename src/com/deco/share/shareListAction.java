package com.deco.share;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class shareListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		//한글처리
		req.setCharacterEncoding("utf-8");
		
		// HttpSession session = req.getSession();
		// int user_num = (int) session.getAttribute("user_num");
		
		
		
		
		
		
		return null;
	}

	
	
	
}
