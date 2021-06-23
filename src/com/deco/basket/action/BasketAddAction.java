package com.deco.basket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.basket.db.BasketDAO;
import com.deco.basket.db.BasketDTO;

public class BasketAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M : BasketAddAction_execute() 호출");
		
		HttpSession session = request.getSession();
		Integer user_num = Integer.parseInt(request.getParameter("user_num"));
		
		ActionForward forward = new ActionForward();
		if(user_num == null){
			forward = new ActionForward("./login.us", true);
			return forward;
		}
		
		// 장바구니 동작
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 정보 저장(n_user_num, bm_num, n_c_num)
		BasketDTO bkDTO = new BasketDTO();
		bkDTO.setN_user_num(Integer.parseInt(request.getParameter("n_user_num")));
		bkDTO.setN_c_num(Integer.parseInt(request.getParameter("n_c_num")));
		
		System.out.println("M : " + bkDTO);
		
		// DAO 객체 생성
		BasketDAO bkDAO = new BasketDAO();
		// 기존의 상품을 중복체크해서 있을경우 수량변경
		// checkGoods(DTO)
		int result = bkDAO.checkBookmark(bkDTO);
		// 기존의 상품을 중복체크해서 없을경우 상품을 장바구니에 추가
		if(result != 1){
			bkDAO.bookmarkAdd(bkDTO);
		}else if(result == 0){
			System.out.println("이미 북마크한 글입니다");
		}
		
		// 기존의 상품을 중복체크해서 없을경우 상품을 장바구니에 추가
		bkDAO.bookmarkAdd(bkDTO);
		
		// 페이지 이동(./BasketList.ba)
		forward = new ActionForward("./noticecontent.nt", true);
		
		return forward;
	}

}
