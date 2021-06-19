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
		
		//한글처리
		req.setCharacterEncoding("utf-8");
		
		// HttpSession session = req.getSession();
		// int user_num = (int) session.getAttribute("user_num");
		//ActionForward forward = new ActionForward();
		
		//객체 생성
		shareDAO sDAO = new shareDAO();
		//디비 메서드 생성
	    int cnt = sDAO.getShareReadCount();
		
	    int pageSize = 5;
	    
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
		
		ActionForward forward = new ActionForward("./share/shareList.jsp",false);
		
		return forward;
	}

	
	
	
}
