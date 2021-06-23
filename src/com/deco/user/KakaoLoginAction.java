package com.deco.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.deco.Action;
import com.deco.ActionForward;

public class KakaoLoginAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String body = getBody.readBody(req);
		System.out.println(body);
		
		//JSON형식으로 변환
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(body);
		
		KakaoLogin kakao = new KakaoLogin();
		String resData = kakao.sendGet((String)jsonObj.get("url"), (String)jsonObj.get("access_token"));
		System.out.println(resData);
		//return new ActionForward("./SocialJoin.us",true);
		return null;
	}
}
