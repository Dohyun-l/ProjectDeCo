package com.deco.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.deco.Action;
import com.deco.ActionForward;

public class GitLoginFin implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String baseURL = "https://github.com/login/oauth/access_token";
		
		GitLogin gitConfig = new GitLogin();
		String client_id = gitConfig.getCLIENT_CODE();
		String secret = gitConfig.getSECRET_CODE();
		String code = req.getParameter("code");
		
		String finURL = baseURL+"?client_id="+client_id+"&client_secret="+secret+"&code="+code;
		
		System.out.println(finURL);
		
		String PostResponse = gitConfig.sendPost(finURL);
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonParser.parse(PostResponse);
		
		String access_token = (String)jsonObject.get("access_token"); 
		System.out.println("access_token ======> "+access_token);
		if(access_token != null){
			String apiURL = "https://api.github.com";
			
			JSONObject userData = (JSONObject)jsonParser.parse((String)gitConfig.sendGet(apiURL+"/user", access_token));
			
			JSONObject emailData = (JSONObject)jsonParser.parse((String)gitConfig.sendGet(apiURL+"/user/emails", access_token));
		}
		
		return null;
	}
	
}
