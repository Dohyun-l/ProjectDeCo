package com.deco.team.talk;

public class talkDTO {

	private int idx;
	private int master;
	private String filename;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getMaster() {
		return master;
	}
	public void setMaster(int master) {
		this.master = master;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	@Override
	public String toString() {
		return "talkDTO [idx=" + idx + ", master=" + master + ", filename=" + filename + "]";
	}
}
