package kr.or.iei.photo.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import common.JDBCTemplate;
import kr.or.iei.photo.model.dao.PhotoDao;
import kr.or.iei.photo.model.vo.Photo;

public class PhotoService {

	public int totalCount() {
		Connection conn=JDBCTemplate.getConnection();
		PhotoDao dao=new PhotoDao();
		int totalCount=dao.totalCount(conn);
		JDBCTemplate.close(conn);
		return totalCount;
	}

	public int insertPhoto(Photo p) {
		Connection conn=JDBCTemplate.getConnection();
		PhotoDao dao=new PhotoDao();
		int result=dao.insertPhoto(conn,p);
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public ArrayList<Photo> morePhoto(int start, int amount) {
		Connection conn=JDBCTemplate.getConnection();
		int end=start+amount-1;
		PhotoDao dao=new PhotoDao();
		ArrayList<Photo> list=dao.morePhoto(conn, start, end);
		JDBCTemplate.close(conn);
		return list;
	}

}
