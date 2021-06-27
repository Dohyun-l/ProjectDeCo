package com.deco.team.member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.team.teamDAO;

public class joinTeamMemberAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		System.out.println("M : joinTeamMemberAction_execute() 호출");
		
		HttpSession session = req.getSession();
		
		ActionForward forward = null;
		
		int user_num = 0;
		if(session.getAttribute("user_num") == null){
			forward = new ActionForward("./teamMain.te", true);
			return forward;
		} else {
			user_num = (int)session.getAttribute("user_num");
		}
		
		teamMemberDTO tmDTO = new teamMemberDTO();
		
		int team_idx = Integer.parseInt(req.getParameter("team_idx"));
		
		tmDTO.setTeam_idx(team_idx);
		tmDTO.setMember(user_num);
		
		teamMemberDAO tmDAO = new teamMemberDAO();
		
		int result = tmDAO.checkSubmitMember(Integer.parseInt(req.getParameter("team_idx")));
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		if(result < new teamDAO().getLimitPersonOfTeamIdx(team_idx)){
			tmDAO.joinTeam(tmDTO);
			
			out.print("<script>");
			out.print("alert('신청이 완료 되었습니다.');");
			out.print("location.href='./teamMain.te';");
			out.print("</script>");
			out.close();
			
			return null;
			
		} else {
			out.print("<script>");
			out.print("alert('더이상 신청을 하실 수 없습니다.');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
		}
	}

}
