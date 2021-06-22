package com.deco.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class listAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		HttpSession session = req.getSession();
		// int user_num = (int) session.getAttribute("user_num");
		Integer user_num = Integer.parseInt(req.getParameter("user_num"));
		ActionForward forward = new ActionForward();
		
		loginDAO loDAO = new loginDAO();
		userDTO udto = loDAO.info(user_num);
		
		req.setAttribute("udto", udto);
		
		forward = new ActionForward("./user/login/update.jsp", false);
		
		return forward;
	}
}
