package com.deco.team.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class joinMemberAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		System.out.println("M : joinMemberAction_execute() 호출");
		
		String idx = req.getParameter("idx");
		
		teamMemberDAO tmdao = new teamMemberDAO();
		tmdao.joinMember(Integer.parseInt(idx));
		
		return null;
	}

}
