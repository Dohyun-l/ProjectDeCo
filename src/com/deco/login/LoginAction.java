package com.deco.login;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.user.userDAO;




public class LoginAction implements Action{

	
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String email = req.getParameter("email");
		String pw = req.getParameter("pw");
		String referer = req.getParameter("referer");
		loginDAO loDAO = new loginDAO();
		int flag = loDAO.login(email, pw);
		
		System.out.println(referer);
		
		if(flag == -2){
			res.setContentType("text/html; charset=utf-8");
			PrintWriter out = res.getWriter();
			out.print("<script>");
			out.print("alert('비회원 입니다.');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
		}else if(flag == -1){
			res.setContentType("text/html; charset=utf-8");
			PrintWriter out = res.getWriter();
			out.print("<script>");
			out.print("alert('비밀번호 오류!!');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
		}
		
		
		
		
		
		System.out.println(flag);
		HttpSession session = req.getSession();
		session.setAttribute("flag", flag);
		// ActionForward forward = new ActionForward(req.getContextPath()+"/main.use",true);
		if(referer.equals("null")){
			ActionForward forward = new ActionForward(req.getContextPath()+"/main.use",true);
			return forward;
		}else{
		ActionForward forward = new ActionForward(referer, true);
		return forward;
		}
	}

}
