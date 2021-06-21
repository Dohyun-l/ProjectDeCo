package com.deco.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;


public class UserInfoAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		HttpSession session = req.getSession();
		Integer user_num = Integer.parseInt(req.getParameter("user_num"));
		
		
		ActionForward forward = new ActionForward();
		if(user_num == null){
			forward = new ActionForward("./login.use", true);
			return forward;
		}
		loginDAO udao = new loginDAO();
		userDTO udto = udao.info(user_num);
		
		req.setAttribute("udto", udto);
		
		forward = new ActionForward("./user/login/info.jsp", false);
		
		return forward;
	}

	
}
