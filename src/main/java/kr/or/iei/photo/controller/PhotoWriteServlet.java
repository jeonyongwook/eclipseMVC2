package kr.or.iei.photo.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.or.iei.photo.model.service.PhotoService;
import kr.or.iei.photo.model.vo.Photo;

/**
 * Servlet implementation class PhotoWriteServlet
 */
@WebServlet(name = "PhotoWrite", urlPatterns = { "/photoWrite.do" })
public class PhotoWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PhotoWriteServlet() {
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
		// 2-1. 파일 업로드 경로 지정
		String root=getServletContext().getRealPath("/");
		String saveDirectory=root+"upload/photo";
		// 2-2. 파일업로드 최대크기 지정(10MB)
		int maxSize= 10*1024*1024;
		// 2-3. request -> MultipartRequest로 변환(서버에 파일업로드 시점)
		MultipartRequest mRequest=new MultipartRequest(request, saveDirectory, maxSize,"UTF-8", new DefaultFileRenamePolicy());
		Photo p = new Photo();
		p.setPhotoWriter(mRequest.getParameter("photoWriter"));
		p.setPhotoContent(mRequest.getParameter("photoContent"));
		p.setFilepath(mRequest.getFilesystemName("file"));
		// 3.비즈니스로직
		PhotoService service = new PhotoService();
		int result=service.insertPhoto(p);
		// 4.결과처리
		RequestDispatcher view=request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if(result>0) {
			request.setAttribute("title", "성공");
			request.setAttribute("msg", "게시물이 등록되었습니다.");
			request.setAttribute("icon", "success");
		}else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "게시물이 등록에 실패했습니다.");
			request.setAttribute("icon", "error");
		}
		request.setAttribute("loc", "/photoList.do");
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
