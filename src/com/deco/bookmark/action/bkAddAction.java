package com.deco.bookmark.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.bookmark.db.BookmarkDAO;
import com.deco.bookmark.db.BookmarkDTO;

public class bkAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BookmarkDTO bmDTO = new BookmarkDTO();
		bmDTO.setUser_num(Integer.parseInt(request.getParameter("user_num")));
		bmDTO.setContent_num(Integer.parseInt(request.getParameter("content_num")));
		
		BookmarkDAO bmDAO = new BookmarkDAO();
		
		int result = bmDAO.checkBookmark(bmDTO);
		
		if(result != 1){
			bmDAO.addBookmark(bmDTO);
		}
		
		// 페이지 이동(./AdminGoodsList.ag)
		ActionForward forward = new ActionForward("./noticelist.nt", true);
		
		/*request.setAttribute("page_num", page_num);*/
		
		return forward;
	}

}
