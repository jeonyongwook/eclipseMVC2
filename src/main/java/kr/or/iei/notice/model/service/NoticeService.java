package kr.or.iei.notice.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import common.JDBCTemplate;
import kr.or.iei.notice.model.dao.NoticeDao;
import kr.or.iei.notice.model.vo.Notice;
import kr.or.iei.notice.model.vo.NoticeComment;
import kr.or.iei.notice.model.vo.NoticePageData;
import kr.or.iei.notice.model.vo.NoticeViewData;

public class NoticeService {
	public NoticePageData selectNoticeList(int reqPage) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		/** 페이징처리 */
		// 1.결정사항 : 한 페이지당 게시물 수
		int numPerPage = 10;
		/*
		 * reqpage=1 -> 1 and 10 reqpage=2 -> 11 and 20 reqpage=3 -> 21 and 30 게시물
		 * rownum 범위 계산
		 */
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		ArrayList<Notice> list = dao.selectNoticeList(conn, start, end);
		// 페이징처리
		// 전체 페이지 계산을 위한 전체 계시물 수 조회
		int totalCount = dao.totalNoticeCount(conn);
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		// 페이지 네비게이션의 길이 지정
		int pageNaviSize = 5;
		// 페이지 모양 지정
		// 1~5 페이지 요청시 -> 1 2 3 4 5
		// 6~10 페이지 요청시 -> 6 7 8 9 10

		// 페이지 네비게이션 시작번호 계산
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;

		// 페이지 네비게이션 제작 시작
		String pageNavi = "<ur class='pagination circle-style'>";
		// 이전버튼
		if (pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/noticeList.do?reqPage=" + (pageNo - 1) + "'>";
			pageNavi += "<span class='material-icons'>chevron_left</span>";
			pageNavi += "</a></li>";
		}
		// 페이지 숫자
		for (int i = 0; i < pageNaviSize; i++) {
			if (pageNo == reqPage) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item active-item' href='/noticeList.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo;
				pageNavi += "</a></li>";
			} else {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='/noticeList.do?reqPage=" + pageNo + "'>";
				pageNavi += pageNo;
				pageNavi += "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// 다음버튼
		if (pageNo <= totalPage) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/noticeList.do?reqPage=" + pageNo + "'>";
			pageNavi += "<span class='material-icons'>chevron_right</span>";
			pageNavi += "</a></li>";
		}
		pageNavi += "</ul>";
		System.out.println(pageNavi);
		NoticePageData npd = new NoticePageData(list, pageNavi);

		JDBCTemplate.close(conn);
		return npd;
	}

	public int insertNotice(Notice n) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.insertNotice(conn, n);

		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public Notice selectOneNotice(int noticeNo) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.updateReadCount(conn, noticeNo);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
			JDBCTemplate.close(conn);
			return null;
		}
		Notice n = dao.selectOneNotice(conn, noticeNo);
		JDBCTemplate.close(conn);
		return n;
	}

	public Notice getNotice(int noticeNo) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		Notice n = dao.selectOneNotice(conn, noticeNo);
		JDBCTemplate.close(conn);
		return n;
	}

	public int noticeDelete(int noticeNo) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.noticeDelete(conn, noticeNo);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int noticeUpdate(Notice n) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.noticeUpdate(conn, n);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int insertNoticeComment(NoticeComment nc) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.insertNoticeComment(conn, nc);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public NoticeViewData selectNoticeView(int noticeNo) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		// 공지사항정보
		Notice n = dao.selectOneNotice(conn, noticeNo);
		// 공지사항에 달려이쓴 일반댓글 조회
		ArrayList<NoticeComment> commentList = dao.selectNoticeComment(conn, noticeNo);
		// 공지사항에 달려있는 댓글의 댓글을 조회
		ArrayList<NoticeComment> reCommentList = dao.selectNoticeReComment(conn, noticeNo);
		JDBCTemplate.close(conn);
		NoticeViewData nvd = new NoticeViewData(n, commentList, reCommentList);
		return nvd;
	}

	public int updateNoticeComment(NoticeComment nc) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.updateNoticeComment(conn, nc);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int deleteComment(int ncNo) {
		Connection conn = JDBCTemplate.getConnection();
		NoticeDao dao = new NoticeDao();
		int result = dao.deleteComment(conn, ncNo);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

}
