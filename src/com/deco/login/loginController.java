package com.deco.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.Controller;


@WebServlet("*.use")
public class loginController extends Controller{

protected void doProcess(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		
//		String requestURI = req.getRequestURI();
//		String contextPath = req.getContextPath();
//		String command = requestURI.substring(contextPath.length());
//		System.out.println(command);
//		ActionForward forward = null;
//		Action action = null;
		setInit(req, res);
	
		if(command.equals("/login.use")){
				forward = new ActionForward("./user/login/login.jsp", false);
		}else if(command.equals("/LoginAction.use")){
				action = new LoginAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/main.use")){
				forward = new ActionForward("./main/main.jsp",false);
		}else if(command.equals("/info.use")){
				System.out.println("info.use 호출");
				action = new UserInfoAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/userlogout.use")){
			action = new userLogoutAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/update.use")){
				action = new listAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}else if(command.equals("/UpdateAction.use")){
				action = new UpdateAction();
			try {
				forward = action.execute(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// -------------------------------------------------------------------------------
		if(forward != null){
			if(forward.isRedirect()){
				res.sendRedirect(forward.getURL());
			}else{
				RequestDispatcher dis = req.getRequestDispatcher(forward.getURL());
				dis.forward(req, res);
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doProcess(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doProcess(req, res);
	}
}
