package com.deco.share;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class shareContentAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : shareContentAction_execute() 호출");
		
		//한글처리
		req.setCharacterEncoding("utf-8");
		
		System.out.println(req.getParameter("category"));
		
		//세션처리
		HttpSession session = req.getSession();
		
		// 저장된 쿠키 불러오기
		Cookie[] cookieFromRequest = req.getCookies();
		String cookieValue = null;
		for(int i = 0 ; i<cookieFromRequest.length; i++) {
		// 요청정보로부터 쿠키를 가져오기
		cookieValue = cookieFromRequest[0].getValue();		
		}
		
		// 글 목록 -> 글 상세 : 글번호(idx)
		int idx = Integer.parseInt(req.getParameter("contentNum"));
	 	
	 	// 쿠키 세션 입력
		if (session.getAttribute(idx+":cookie") == null) {
		 	session.setAttribute(idx+":cookie", idx + ":" + cookieValue);
		} else {
			session.setAttribute(idx+":cookie ex", session.getAttribute(idx+":cookie"));
			if (!session.getAttribute(idx+":cookie").equals(idx + ":" + cookieValue)) {
			 	session.setAttribute(idx+":cookie", idx + ":" + cookieValue);
			}
		}
		
		//DAO객체 생성
		shareDAO sDAO = new shareDAO();
		
		// 조회수 증가 카운트
	 	if (!session.getAttribute(idx+":cookie").equals(session.getAttribute(idx+":cookie ex"))) {
	 		sDAO.shareUpdateReadcnt(idx);
		 
	 	}	
	 	//글번호에 해당하는 글 가져오기
	 	req.setAttribute("shareContent", sDAO.getShare(idx));
		
		ActionForward forward = new ActionForward("./share/shareContent.jsp",false);
			
		return forward;
	}

	
	
}
