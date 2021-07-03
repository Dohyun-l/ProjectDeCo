package com.deco.team;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.team.member.teamMemberDAO;
import com.deco.team.member.teamMemberDTO;
import com.deco.team.talk.talkDAO;
import com.deco.team.talk.talkDTO;

public class createTeamAction implements Action{



	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		
		req.setCharacterEncoding("UTF-8");
		int master = (int)session.getAttribute("user_num");
		
		teamDTO tdto = new teamDTO();
		tdto.setTitle(req.getParameter("title"));
		tdto.setContent(req.getParameter("content"));
		tdto.setLocation(req.getParameter("location"));
		tdto.setMaster(master);
		tdto.setLimit_p(req.getParameter("limit_p"));
		tdto.setDeadline(req.getParameter("deadline"));
		
		teamDAO tdao = new teamDAO();
		int idx = tdao.create_team(tdto);
		
		// 프로젝트 생성시 팀원 자동 편입
		teamMemberDTO tmDTO = new teamMemberDTO();
		
		tmDTO.setTeam_idx(idx);
		tmDTO.setMember(master);
		
		teamMemberDAO tmDAO = new teamMemberDAO();
		tmDAO.joinTeam(tmDTO);
		//
		// 프로젝트 생성시 submit 자동 1변환
		tmDAO.onMemberSubmit(tmDTO);
		
		
		
		
		///////////////////////////////////////////////////////////////
		
		req.setCharacterEncoding("UTF-8");

		talkDTO tadto = new talkDTO(); 
		tadto.setTeam_idx(idx);
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "_yyyyMMdd_HHmmss");
		Date time = new Date();
		String filename = "team"+idx+"_"+master+format1.format(time);
		tadto.setFilename(filename);
		talkDAO tadao = new talkDAO();
		tadao.createTalk(tadto);
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter("C://talk/team/"+filename+".txt")));
		
		br.close();
		pw.close();
		
		///////////////////////////////////////////////////////////////
		
		//
		System.out.println(master+"님이 "+idx+"번째 팀을 만드셨습니다, 또한 team_member테이블 자동으로 마스터 등록");
		ActionForward forward = new ActionForward("./main.us", true);
		return forward;
	}
	
	
}