package kr.or.iei.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

/**
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet(name = "UpdateMember", urlPatterns = { "/updateMember.do" })
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateMemberServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		1.인코딩
		request.setCharacterEncoding("utf-8");
//		2.값추출
		Member member = new Member();
		member.setMemberId(request.getParameter("memberId"));
		member.setMemberPw(request.getParameter("memberPw"));
		member.setPhone(request.getParameter("phone"));
		member.setAddress(request.getParameter("address"));

//		3.비즈니스로직
		MemberService service = new MemberService();
		int result = service.updateMember(member);
//		4.결과처리
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if (result > 0) {

			HttpSession session = request.getSession();
			Member m = (Member) session.getAttribute("m");
			m.setMemberPw(member.getMemberPw());
			m.setPhone(member.getPhone());
			m.setAddress(member.getAddress());

			request.setAttribute("title", "성공");
			request.setAttribute("msg", "정보 변경이 완료되었습니다.");
			request.setAttribute("icon", "success");
		} else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "정보 변경중 에러가 발생했습니다. 관리자에게 문의하세요.");
			request.setAttribute("icon", "error");
		}
		request.setAttribute("loc", "/mypage2.do?memberId=" + member.getMemberId());
		view.forward(request, response);
		// 정보변경 성공시 -> 알림 -> 마이페이지
		// 정보변경 실패시 -> 알림 -> 마이페이지
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
