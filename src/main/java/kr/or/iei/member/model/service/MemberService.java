package kr.or.iei.member.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.naming.spi.DirStateFactory.Result;

import common.JDBCTemplate;
import kr.or.iei.member.model.dao.Memberdao;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.member.model.vo.Msg;
import kr.or.iei.member.model.vo.MsgPageData;

public class MemberService {

	public Member selectOneMember(Member member) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		Member m = dao.selectOneMember(conn, member);
		JDBCTemplate.close(conn);
		return m;
	}

	public int insertMember(Member m) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		int result=dao.insertMember(conn,m);
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public Member selectOneMember(String memberId) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		Member m = dao.selectOneMember(conn, memberId);
		JDBCTemplate.close(conn);
		return m;
	}

	public int updateMember(Member member) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		int result=dao.updateMember(conn,member);
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int deleteMember(int memberNo) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		int result=dao.deleteMember(conn,memberNo);
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public ArrayList<Member> selectAllMember() {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		ArrayList<Member> list=dao.selectAllMember(conn);
		JDBCTemplate.close(conn);
		return list;
	}

	public int changeLevel(int memberNo, int memberLevel) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		int result=dao.changeLevel(conn,memberNo,memberLevel);
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public boolean checkedChangeLevel(String num, String level) {
		Connection conn=JDBCTemplate.getConnection();
		//num	:	5/10/12
		//level	:	2/0/1
		Memberdao dao=new Memberdao();
		StringTokenizer sT1=new StringTokenizer(num,"/");
		StringTokenizer sT2=new StringTokenizer(level,"/");
		boolean result=true;
		while(sT1.hasMoreTokens()) {
			int memberNo=Integer.parseInt(sT1.nextToken());
			int memberLevel=Integer.parseInt(sT2.nextToken());
			int checkResult=dao.changeLevel(conn, memberNo, memberLevel);
			if(checkResult==0) {
				result=false;
				break;
			}
		}
		if(result) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public MsgPageData selectMsgList(int reqPage, String memberId) {
		Connection conn = JDBCTemplate.getConnection();
		Memberdao dao = new Memberdao();
		/** ??????????????? */
		int numPerPage = 10;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		ArrayList<Msg> list = dao.selectMsgList(conn, start, end, memberId);
		// ???????????????
		// ?????? ????????? ????????? ?????? ?????? ????????? ??? ??????
		int totalCount = dao.totalMsgCount(conn);
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		// ????????? ?????????????????? ?????? ??????
		int pageNaviSize = 5;
		// ????????? ?????? ??????
		// 1~5 ????????? ????????? -> 1 2 3 4 5
		// 6~10 ????????? ????????? -> 6 7 8 9 10

		// ????????? ??????????????? ???????????? ??????
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;

		// ????????? ??????????????? ?????? ??????
		String pageNavi = "<ur class='pagination circle-style'>";
		// ????????????
		if (pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/msgList.do?reqPage=" + (pageNo - 1) + "'>";
			pageNavi += "<span class='material-icons'>chevron_left</span>";
			pageNavi += "</a></li>";
		}
		// ????????? ??????
		for (int i = 0; i < pageNaviSize; i++) {
			if (pageNo == reqPage) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item active-item' href='/msgList.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo;
				pageNavi += "</a></li>";
			} else {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='/msgList.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo;
				pageNavi += "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// ????????????
		if (pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/msgList.do?reqPage=" + pageNo + "'>";
			pageNavi += "<span class='material-icons'>chevron_right</span>";
			pageNavi += "</a></li>";
		}
		pageNavi += "</ul>";
		System.out.println(pageNavi);
		MsgPageData mpd = new MsgPageData(list, pageNavi);

		JDBCTemplate.close(conn);
		return mpd;
	}

	public MsgPageData selectSendList(int reqPage, String memberId) {
		Connection conn = JDBCTemplate.getConnection();
		Memberdao dao = new Memberdao();
		/** ??????????????? */
		int numPerPage = 10;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		ArrayList<Msg> list = dao.selectSendList(conn, start, end, memberId);
		// ???????????????
		// ?????? ????????? ????????? ?????? ?????? ????????? ??? ??????
		int totalCount = dao.totalMsgCount(conn);
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		// ????????? ?????????????????? ?????? ??????
		int pageNaviSize = 5;
		// ????????? ?????? ??????
		// 1~5 ????????? ????????? -> 1 2 3 4 5
		// 6~10 ????????? ????????? -> 6 7 8 9 10

		// ????????? ??????????????? ???????????? ??????
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;

		// ????????? ??????????????? ?????? ??????
		String pageNavi = "<ur class='pagination circle-style'>";
		// ????????????
		if (pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/sendList.do?reqPage=" + (pageNo - 1) + "'>";
			pageNavi += "<span class='material-icons'>chevron_left</span>";
			pageNavi += "</a></li>";
		}
		// ????????? ??????
		for (int i = 0; i < pageNaviSize; i++) {
			if (pageNo == reqPage) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item active-item' href='/sendList.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo;
				pageNavi += "</a></li>";
			} else {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='/sendList.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo;
				pageNavi += "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// ????????????
		if (pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/sendList.do?reqPage=" + pageNo + "'>";
			pageNavi += "<span class='material-icons'>chevron_right</span>";
			pageNavi += "</a></li>";
		}
		pageNavi += "</ul>";
		System.out.println(pageNavi);
		MsgPageData mpd = new MsgPageData(list, pageNavi);

		JDBCTemplate.close(conn);
		return mpd;
	}

	public Msg selectOneMsg(int msgNo) {
		Connection conn = JDBCTemplate.getConnection();
		Memberdao dao = new Memberdao();
		Msg m = dao.selectOneMsg(conn, msgNo);
		JDBCTemplate.close(conn);
		return m;
	}

	public Msg selectReceiver(String memberId) {
		Connection conn=JDBCTemplate.getConnection();
		Memberdao dao=new Memberdao();
		Msg r = dao.selectReceiver(conn, memberId);
		JDBCTemplate.close(conn);
		return r;
	}

	public int insertMsg(Msg m) {
		Connection conn = JDBCTemplate.getConnection();
		Memberdao dao = new Memberdao();
		int result = dao.insertMsg(conn, m);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}
}
