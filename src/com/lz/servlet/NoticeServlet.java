package com.lz.servlet;


import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.lz.dao.DaoFactory;

import com.lz.entity.Exam;

import com.lz.entity.Notice;
import com.lz.utils.PathUtils;


//此servlet服务完都是跳转到都nav页面，需要给出标记的active号
@WebServlet("/notice")
public class NoticeServlet extends HttpServlet {

	private static final long serialVersionUID = 2L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
//admin对teacher进行操作
//teacher对exam进行操作
//exam 对notice进行操作
//notice对file进行操作
//file对打包，评分等进行操作。

	@Override //exam下
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		System.out.println(method);
		if("listNotice".equals(method)) {//考试列出通知
			this.listNotice(request, response);
		}else if("add".equals(method)) {//考试添加通知
			this.add(request, response);
		}else if("delete".equals(method)) {//考试删除通知
			this.delete(request, response);
		}
	}
	//考试编辑模块使用
	
	private void delete(HttpServletRequest request, HttpServletResponse response) {
		Integer n_id = Integer.parseInt(request.getParameter("n_id"));
		try {
			DaoFactory.getInstance().getNoticeDao().delete(n_id);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"notice?method=listNotice&msg=Delete notice sucessful!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	
	

	private void add(HttpServletRequest request, HttpServletResponse response) {//js已经验证不为空
		Exam exam = (Exam)request.getSession().getAttribute("exam");
		Integer e_id = exam.getE_id();
		String n_text = request.getParameter("n_text");
		System.out.println("add notice servelt");
		SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date(System.currentTimeMillis());
		String n_time =formatter.format(date);
		System.out.println("n_time:"+n_time);
		
		Notice notice = new Notice();
		
		notice.setE_id(e_id);
		notice.setN_text(n_text);
		notice.setN_time(n_time);
		try {
			DaoFactory.getInstance().getNoticeDao().add(notice);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"notice?method=listNotice&msg=Add notice sucessful!");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void listNotice(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("======noticeServlet listNotice========");
		Exam exam = (Exam)request.getSession().getAttribute("exam");
		Integer e_id = exam.getE_id();
		//当前页码
		try {
			List<Notice> notices = DaoFactory.getInstance().getNoticeDao().listNotice(e_id);
			request.setAttribute("noticeList", notices);
			request.getRequestDispatcher("page/Exam/notice.jsp").forward(request, response);
		} catch (Exception e1) {
			e1.printStackTrace();
		}

	}

	
}
