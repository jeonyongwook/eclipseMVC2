package kr.or.iei.notice.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.notice.model.service.NoticeService;
import kr.or.iei.notice.model.vo.Notice;
import kr.or.iei.notice.model.vo.NoticePageData;

/**
 * Servlet implementation class FileDownServlet
 */
@WebServlet(name = "FileDown", urlPatterns = { "/fileDown.do" })
public class FileDownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FileDownServlet() {
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
		// 4.결과처리
		// 파일과 현재 서블릿을 연결
		String root = getServletContext().getRealPath("/");// webapp
		String downloadFile = root + "upload/notice/" + n.getFilepath();
		// 파일을 서블릿으로 읽어오기위한 스트림 생성
		FileInputStream fis = new FileInputStream(downloadFile);
		BufferedInputStream bis = new BufferedInputStream(fis);
		// 읽어온파일을 사용자에게 전달할 스트림 생성
		ServletOutputStream sos = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		// 파일명처리
		String resFilename = new String(n.getFilename().getBytes("UTF-8"), "ISO-8859-1");
		// 파일다운로드를 위한 HTTP header 설정
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + resFilename);
		// 파일전송
		while (true) {
			int read = bis.read();
			if (read != -1) {
				bos.write(read);
			} else {
				break;
			}
		}
		bos.close();
		bis.close();
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
