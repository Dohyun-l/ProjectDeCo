package com.deco.team.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.ActionForward;
import com.deco.Controller;

@WebServlet("*.tm")
public class teamMemberFrontController extends Controller {

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("C : teamMemberFrontControlle_doProcess()호출");

		setInit(req, resp);
		System.out.println(command);

		/////////////////////////////////////////////////////////

		if (command.equals("/joinTeamMember.tm")) {
			System.out.println("C : /joinTeamMember.tm 호출");
			action = new joinTeamMemberAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/deleteTeamMember.tm")) {
			System.out.println("C : /deleteTeamMember.tm 호출");
			action = new deleteTeamMemberAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/submitMember.tm")) {
			System.out.println("C : /submitMember.tm 호출");
			action = new submitMemberAction();			
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		/////////////////////////////////////////////////////////

		if (forward != null) {
			if (forward.isRedirect()) {
				resp.sendRedirect(forward.getURL());
				System.out.println("C : sendRedirect() 방식, " + forward.getURL() + "페이지 이동");
			} else { // false
				System.out.println(forward.getURL());
				RequestDispatcher dis = req.getRequestDispatcher(forward.getURL());

				dis.forward(req, resp);
				System.out.println("C : forward() 방식, " + forward.getURL());
			}
		}

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("C : teamMemberFrontControlle_doGet()호출");
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("C : teamMemberFrontControlle_doPost()호출");
		doProcess(req, resp);
	}

}
