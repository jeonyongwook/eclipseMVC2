package kr.or.iei.member.model.vo;

public class Msg {
	private int msgNo;
	private String writer;
	private String receiver;
	private String msgTitle;
	private String msgContent;
	private String reqDate;
	public Msg() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Msg(int msgNo, String writer, String receiver, String msgTitle, String msgContent, String reqDate) {
		super();
		this.msgNo = msgNo;
		this.writer = writer;
		this.receiver = receiver;
		this.msgTitle = msgTitle;
		this.msgContent = msgContent;
		this.reqDate = reqDate;
	}
	public int getMsgNo() {
		return msgNo;
	}
	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public String getReqDate() {
		return reqDate;
	}
	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}
	
}
