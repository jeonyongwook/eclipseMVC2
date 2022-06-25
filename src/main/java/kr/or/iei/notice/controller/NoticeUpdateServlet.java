package kr.or.iei.notice.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.or.iei.notice.model.service.NoticeService;
import kr.or.iei.notice.model.vo.Notice;
import kr.or.iei.notice.model.vo.NoticePageData;

/**
 * Servlet implementation class NoticeUpdateServlet
 */
@WebServlet(name = "NoticeUpdate", urlPatterns = { "/noticeUpdate.do" })
public class NoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NoticeUpdateServlet() {
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
		// 파일업로드 준비
		// 2-1. 파일업로드 경로 설정
		String root = getServletContext().getRealPath("/");
		String saveDirectory = root + "upload/notice";
		// 2-2. 업로드 파일 최대크기 지정
		int maxSize = 10 * 1024 * 1024;
		// 2-3. request -> MultipartRequest로 변환(파일이 업로드 되는 시점)
		MultipartRequest mRequest = new MultipartRequest(request, saveDirectory, maxSize, "UTF-8",
				new DefaultFileRenamePolicy());

		int noticeNo = Integer.parseInt(mRequest.getParameter("noticeNo"));
		String noticeTitle = mRequest.getParameter("noticeTitle");
		String noticeContent = mRequest.getParameter("noticeContent");
		// filename,filepath는 새 첨부파일 있으면 파일명으로, 새 첨부파일이 없으면 null
		String filename = mRequest.getOriginalFileName("file");
		String filepath = mRequest.getOriginalFileName("file");
		// 수정 전 파일을 유지했으면 stay, 수정 전 삭제했으면 delete
		String status = mRequest.getParameter("status");
		// 수정 전 파일이 존재했으면 값있음, 수정 전 파일이 없으면 null
		String oldFilename = mRequest.getOriginalFileName("oldFilename");
		String oldFilepath = mRequest.getOriginalFileName("oldFilepath");
		if (status.equals("delete")) { // 수정 전 파일을 삭제한 경우 서버에서 파일 삭제
			File delFile = new File(saveDirectory + "/" + oldFilepath);
			delFile.delete();
		} else if (oldFilename != null) {
			filename = oldFilename;
			filepath = oldFilepath;
		}
		Notice n = new Notice();
		n.setNoticeNo(noticeNo);
		n.setNoticeTitle(noticeTitle);
		n.setNoticeContent(noticeContent);
		n.setFilename(oldFilename);
		n.setFilepath(oldFilepath);

		// 3.비즈니스로직
		NoticeService service = new NoticeService();
		int result = service.noticeUpdate(n);
		// 4.결과처리
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if (result > 0) {
			request.setAttribute("title", "성공");
			request.setAttribute("msg", "공지사항 수정 완료");
			request.setAttribute("icon", "success");
		} else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "공지사항 수정 중 문제가 발생했습니다.");
			request.setAttribute("icon", "error");
		}

		request.setAttribute("loc", "/noticeView.do?noticeNo=" + n.getNoticeNo());
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
