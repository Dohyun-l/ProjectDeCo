package com.deco.team.comment;

public class Team_commentDTO {

	private int idx;
	private int team_idx;
	private String nickname;
	private String content;
	private String date;
	private int secret;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(int team_idx) {
		this.team_idx = team_idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getSecret() {
		return secret;
	}
	public void setSecret(int secret) {
		this.secret = secret;
	}
	@Override
	public String toString() {
		return "Team_commentDTO [idx=" + idx + ", team_idx=" + team_idx + ", nickname=" + nickname + ", content="
				+ content + ", date=" + date + ", secret=" + secret + "]";
	}
	
	
	
	
}
