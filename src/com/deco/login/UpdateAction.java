package com.deco.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class UpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		Integer user_num = Integer.parseInt(req.getParameter("user_num"));
		ActionForward forward = new ActionForward();
		
		loginDAO lodao = new loginDAO();
		lodao.update(user_num);
		
		if(user_num == null){
			
		}
		
		
		return null;
	}

	
}
