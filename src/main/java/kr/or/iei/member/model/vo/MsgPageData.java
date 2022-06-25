package kr.or.iei.member.model.vo;

import java.util.ArrayList;

public class MsgPageData {
	private ArrayList<Msg> list;
	private String pageNavi;
	public MsgPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MsgPageData(ArrayList<Msg> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public ArrayList<Msg> getList() {
		return list;
	}
	public void setList(ArrayList<Msg> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
}
