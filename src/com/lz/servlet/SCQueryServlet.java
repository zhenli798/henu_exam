package com.lz.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.lz.dao.DaoFactory;
import com.lz.entity.Student;
import com.lz.entity.Teacher;



@WebServlet("/scquery")
public class SCQueryServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String method = request.getParameter("method");
		if ("query_range".equals(method)) {
			this.query_range(request, response);
		} else if ("query_jgl".equals(method)) {
			this.query_jgl(request, response);
		} else if ("query_teacher".equals(method)) {
			this.query_teacher(request, response);
		}else if ("query_student".equals(method)) {
			this.query_student(request, response);
		}
	}

	public void query_teacher(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Teacher teacher = (Teacher) request.getSession().getAttribute("user");
		try {
			List<Map<String, Object>> list = DaoFactory.getInstance().getScoreDao().query_rangeByTid(teacher.getT_id());
			request.setAttribute("list1", list);
			List<Map<String, Object>> list2 = DaoFactory.getInstance().getScoreDao().query_jglByTid(teacher.getT_id());
			request.setAttribute("list2", list2);
			request.getRequestDispatcher("page/Teacher/query_teacher.jsp").forward(request, response);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void query_student(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Student student  = (Student) request.getSession().getAttribute("user");
		try {
			List<Map<String, Object>> list = DaoFactory.getInstance().getScoreDao().query_rangeByS_ID(student.getS_id());
			request.setAttribute("list", list);
			request.getRequestDispatcher("page/Student/main_student.jsp").forward(request, response);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void query_range(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			List<Map<String, Object>> list = DaoFactory.getInstance().getScoreDao().query_range();
			request.setAttribute("list", list);
			request.getRequestDispatcher("page/Admin/query_range.jsp").forward(request, response);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void query_jgl(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<Map<String, Object>> list = DaoFactory.getInstance().getScoreDao().query_jgl();
			request.setAttribute("list", list);
			request.getRequestDispatcher("page/Admin/query_jgl.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
