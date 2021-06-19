package com.deco.user.join;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.ActionForward;
import com.deco.Controller;

@WebServlet("*.us")
public class userController extends Controller{

	protected void doProcess(HttpServletRequest req, HttpServletResponse res) throws Exception{
		setInit(req, res);
		
		if(command.equals("/join.us")){
			forward = new ActionForward("./user/join/join.jsp", false);
		
		}else if(command.equals("/joinAction.us")){
			action = new joinPostAction();
			forward = action.execute(req, res);
		
		}else if(command.equals("/emailAuthAction.us")){
			action = new EmailAuthAction();
			forward = action.execute(req, res);
		
		}
		
		render(forward,req,res);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			doProcess(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			doProcess(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
