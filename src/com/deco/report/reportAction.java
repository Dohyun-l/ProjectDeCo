package com.deco.report;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.deco.Action;
import com.deco.ActionForward;
import com.deco.user.getBody;

public class reportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("신고 Action");
		
		JSONObject reqObj = getBody.getJsonObj(req);
		System.out.println("넘어온 데이터 : " + reqObj.toString());

		HttpSession session = req.getSession();
		int user_num = Integer.parseInt(session.getAttribute("user_num").toString());
		System.out.println(user_num);
		
		reportDTO rDTO = new reportDTO();
		rDTO.setUser_num(user_num);
		rDTO.setBody(reqObj);
		
		reportDAO rDAO = new reportDAO();
		int flag = rDAO.insertReport(rDTO);
		
		if(flag == -1){
			
			res.setStatus(400);
			return null;
		}
		
		res.setStatus(204);
		return null;
	}
	
}
