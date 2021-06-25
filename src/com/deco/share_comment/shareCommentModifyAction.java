package com.deco.share_comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.share.shareDAO;

public class shareCommentModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : shareCommentModifyAction_execute() 호출");
		
		//한글처리
		req.setCharacterEncoding("utf-8");
		
		//세션처리
		HttpSession session = req.getSession();
		
		int userNum = 0;
		
		if(session.getAttribute("user_num") == null){
			resp.sendRedirect("./shareList.sh");
		} else {
			userNum = (int) session.getAttribute("user_num");
		}
		
		commentDTO cDTO = new commentDTO();
		
		String share_idx = req.getParameter("contentNum");
		String pageNum = req.getParameter("pageNum");
		String pageSize = req.getParameter("pageSize");
		String category = req.getParameter("category");
		int comment_idx = Integer.parseInt(req.getParameter("comment_idx"));
		
		cDTO.setComment_idx(comment_idx);
	
		
		commentDAO cDAO = new commentDAO();
		cDAO.modifyShareComment(cDTO);
		
		//글번호에 해당하는 댓글 가져오기
	 	req.setAttribute("Content", new commentDAO().getCommentList(Integer.parseInt(share_idx)));
		
	 	ActionForward forward = new ActionForward("./share/shareContent.jsp",true);

		return forward;
	}

	
}
