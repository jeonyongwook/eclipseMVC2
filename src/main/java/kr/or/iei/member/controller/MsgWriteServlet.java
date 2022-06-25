package kr.or.iei.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Msg;

/**
 * Servlet implementation class MsgWriteServlet
 */
@WebServlet(name = "MsgWrite", urlPatterns = { "/msgWrite.do" })
public class MsgWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MsgWriteServlet() {
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
		String writer=request.getParameter("writer");
		String receiver=request.getParameter("receiver");
		String msgTitle=request.getParameter("msgTitle");
		String msgContent=request.getParameter("msgContent");
		Msg m=new Msg();
		m.setWriter(writer);
		m.setMsgTitle(msgTitle);
		m.setReceiver(receiver);
		m.setMsgContent(msgContent);
		// 3.비즈니스로직
		MemberService service=new MemberService();
		int result = service.insertMsg(m);
		// 4.화면처리
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if (result > 0) {
			request.setAttribute("title", "성공");
			request.setAttribute("msg", "쪽지를 보냈습니다");
			request.setAttribute("icon", "success");
		} else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "쪽지 보내기 실패");
			request.setAttribute("icon", "error");
		}
		request.setAttribute("loc", "/");
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
