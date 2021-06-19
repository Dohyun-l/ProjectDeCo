package com.deco.share;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.ActionForward;
import com.deco.Controller;

@WebServlet("*.sh")
public class shareFrontController extends Controller {
	
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("C : shareFrontControlle_doProcess()호출");
		
		setInit(req, resp);
		System.out.println(command);
		
		/////////////////////////////////////////////////////////
		
		if (command.equals("/share/shareWrite.sh")){
			System.out.println("C : /share/shareWrite.sh 호출");
			forward = new ActionForward("./writeShare.jsp", false);
		} else if(command.equals("/share/shareWriteAction.sh")){
			System.out.println("C : /share/shareWriteAction.sh 호출");
			action = new shareWriteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/share/shareList.sh")) {
			System.out.println("C : /share/shareList.sh 호출");
			action = new shareListAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/share/shareContent.sh")){
			System.out.println("C : /share/shareContent.sh 호출");
			action = new shareContentAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/////////////////////////////////////////////////////////
		
		if(forward != null){
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getURL());
				System.out.println("C : sendRedirect() 방식, " + forward.getURL() + "페이지 이동");
			}else{ //false
				System.out.println(forward.getURL());
				RequestDispatcher dis = req.getRequestDispatcher(forward.getURL());
				
				dis.forward(req, resp);
				System.out.println("C : forward() 방식, " + forward.getURL());
			}
		}
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("C : shareFrontControlle_doGet()호출");
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("C : shareFrontControlle_doPost()호출");
		doProcess(req, resp);
	}

	
	
}
