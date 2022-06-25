package kr.or.iei.member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.member.model.vo.Msg;
import kr.or.iei.member.model.vo.MsgPageData;
import kr.or.iei.notice.model.service.NoticeService;
import kr.or.iei.notice.model.vo.NoticePageData;

/**
 * Servlet implementation class MsgListServlet
 */
@WebServlet(name = "MsgList", urlPatterns = { "/msgList.do" })
public class MsgListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MsgListServlet() {
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
		String memberId=request.getParameter("memberId");
		System.out.println(memberId);
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		System.out.println(reqPage);
		// 3.비즈니스로직
		MemberService service = new MemberService();
		MsgPageData mpd=service.selectMsgList(reqPage,memberId);
		// 4.결과처리
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/member/msgList.jsp");
		request.setAttribute("list", mpd.getList());
		request.setAttribute("pageNavi", mpd.getPageNavi());
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
