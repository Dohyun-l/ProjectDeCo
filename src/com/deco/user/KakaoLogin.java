package com.deco.user;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class KakaoLogin {
	public String sendGet(String apiURL, String access_token) throws Exception {

		StringBuilder sb = null;
		
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection(); 
			con.setConnectTimeout(5000); //서버에 연결되는 Timeout 시간 설정
			con.setReadTimeout(5000); // InputStream 읽어 오는 Timeout 시간 설정
			con.addRequestProperty("Authorization", "Bearer "+access_token); 

			con.setRequestMethod("GET");
			con.setDoOutput(false); 

			sb = new StringBuilder();
			if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line).append("\n");
				}
				br.close();
				System.out.println("" + sb.toString());
			} else {
				System.out.println(con.getResponseMessage());
				return "false";
			}

		} catch (Exception e) {
			System.err.println(e.toString());
			return "false";
		}

		return sb.toString();
    }
}
