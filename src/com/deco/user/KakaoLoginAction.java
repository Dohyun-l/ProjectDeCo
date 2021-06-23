package com.deco.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.deco.Action;
import com.deco.ActionForward;

public class KakaoLoginAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		KakaoLogin kakao = new KakaoLogin();
		
		String code = req.getParameter("code");
		
		String body = kakao.getToken(code);
		
		//JSON형식으로 변환
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(body);
		
		String resData = kakao.sendGet("https://kapi.kakao.com/v2/user/me", (String)jsonObj.get("access_token"));
		
		JSONObject dataObj = (JSONObject) jsonParser.parse(resData);
		
		if(dataObj.get("kakao_account") == null){
			ValueException(res,"이메일 동의해주세요!");
			return null;
		}
		
		JSONObject accountObj = (JSONObject) jsonParser.parse(dataObj.get("kakao_account").toString());
		JSONObject profileObj = (JSONObject) jsonParser.parse(accountObj.get("profile").toString());
		
		String email = (String)accountObj.get("email");
		String nickname = (String)profileObj.get("nickname");
		
		System.out.println(email+" : "+nickname);
		
		//return new ActionForward("./SocialJoin.us",true);
		return null;
	}
	
	public void ValueException(HttpServletResponse res, String msg) throws IOException{
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('" + msg + "');");
		out.println("history.back()");
		out.println("</script>");
		
		out.close();
	}
}
