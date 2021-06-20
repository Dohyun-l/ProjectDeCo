package com.deco.share;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;

public class shareListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : shareListAction_execute() 호출");
		
		//한글처리
		req.setCharacterEncoding("utf-8");
		
		// HttpSession session = req.getSession();
		// int user_num = (int) session.getAttribute("user_num");
		//ActionForward forward = new ActionForward();
		
		//객체 생성
		shareDAO sDAO = new shareDAO();
		//디비 메서드 생성
		int cnt = sDAO.numOfShare();
		
		String str_pageSize = req.getParameter("pageSize");
		
		int pageSize = 0;
		
		if (str_pageSize == null){
			pageSize = 5;
		} else {
			pageSize = Integer.parseInt(str_pageSize);
		}
		
		String pageNum = req.getParameter("pageNum");
		
		if(pageNum == null){
		   pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		int endRow = currentPage*pageSize;
		   
		List shareList = sDAO.getShareList(startRow,pageSize);
		
		req.setAttribute("shareList", shareList);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("pageSize", pageSize);
		
		ActionForward forward = new ActionForward("./shareList.jsp",false);
		
		return forward;
	}

	
	
	
}
