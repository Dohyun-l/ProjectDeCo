package com.deco.share;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class shareContentAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : shareContentAction_execute() 호출");
		
		int idx = Integer.parseInt(req.getParameter("contentNum"));
		
		shareDAO sDAO = new shareDAO();
		
		//조회수 증가 중복안되게 하는거..?
		
		//글번호에 해당하는 글정보 가져와서 출력
		sDAO.getShare(idx);
		
		ActionForward forward = new ActionForward("/shareContent.jsp",false);
			
		return forward;
	}

	
	
}
