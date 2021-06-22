package com.deco.login;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;

public class UpdateAction implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		int user_num = Integer.parseInt(req.getParameter("user_num"));
		System.out.println("액션빔");
		ActionForward forward = new ActionForward();

		// 세션 int user_num 가지고 DAO에서 처리할일 있으면 그때 Integer로 변환 해서 적용
		
		System.out.println(user_num);
		userDTO udto = new userDTO();
		// udto.setUser_num(user_num);
		
		udto.setPw(req.getParameter("pw"));
		udto.setName(req.getParameter("name"));
		udto.setNickname(req.getParameter("nickname"));
		udto.setAddr(req.getParameter("addr"));
		udto.setPhone(req.getParameter("phone"));
		udto.setMajor(req.getParameter("major"));
		
		loginDAO lodao = new loginDAO();
		int check = lodao.update(udto, user_num);
		
		System.out.println(check);
		
		
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		if(check == 0){
			
			out.print("<script>");
			out.print("alert('비밀번호 오류!');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
			
		}else if(check == -1){
			out.print("<script>");
			out.print("alert('잘못된 접근입니다.');");
			out.print("location.href='/ProjectDeCo/login.use';");
			out.print("</script>");
			out.close();
			
			return null;
		}
		out.print("<script>");
		out.print("alert('수정완료!');");
		out.print("location.href='/ProjectDeCo/main.use';");
		out.print("</script>");
		out.close();
		
		return null;
	}

	
}
