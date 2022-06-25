package kr.or.iei.notice.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.notice.model.service.NoticeService;
import kr.or.iei.notice.model.vo.Notice;
import kr.or.iei.notice.model.vo.NoticePageData;

/**
 * Servlet implementation class NoticeDeleteServlet
 */
@WebServlet(name = "NoticeDelete", urlPatterns = { "/noticeDelete.do" })
public class NoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NoticeDeleteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1.인코딩
		request.setCharacterEncoding("utf-8");
		// 2.값추출
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		// 3.비즈니스로직
		NoticeService service = new NoticeService();
		Notice n = service.getNotice(noticeNo);
		int result = service.noticeDelete(noticeNo);
		// 4.결과처리
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if (result > 0) {
			if (n.getFilepath() != null) {
				String root = getServletContext().getRealPath("/");
				String deleteFile = root + "upload/notice/" + n.getFilepath();
				File delFile = new File(deleteFile);
				delFile.delete();
			}
			request.setAttribute("title", "성공");
			request.setAttribute("msg", "공지사항이 삭제 완료");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/noticeList.do?reqPage=1");
		} else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "공지사항 삭제 실패");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/noticeView.do?NoticeNo=" + noticeNo);
		}
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
