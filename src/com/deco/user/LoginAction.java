package com.deco.user;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;




public class LoginAction implements Action{

	
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String email = req.getParameter("email");
		String pw = req.getParameter("pw");
		String referer = req.getParameter("referer");
		userDAO loDAO = new userDAO();
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
		
		
		HttpSession session = req.getSession();
		session.setAttribute("user_num", flag);
		// ActionForward forward = new ActionForward(req.getContextPath()+"/main.us",true);
		String exceptURL = "http://localhost:8088/ProjectDeCo/userlogout.us";
		String exceptURL2 = "http://localhost:8088/ProjectDeCo/DeleteAction.us";
		
		if(referer.equals("null") || referer.equals(exceptURL) || referer.equals(exceptURL2)){
			ActionForward forward = new ActionForward(req.getContextPath()+"/main.us",true);
			return forward;
		}else{
			ActionForward forward = new ActionForward(referer, true);
			return forward;
		}
	}

}
