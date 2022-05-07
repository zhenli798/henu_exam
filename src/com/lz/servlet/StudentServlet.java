package com.lz.servlet;

//跳转到servlet：response.sendRedirect()

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import com.lz.utils.PageInfo;
import com.lz.utils.PathUtils;

import com.lz.dao.DaoFactory;
import com.lz.entity.Exam;
import com.lz.entity.Exam2;
import com.lz.entity.Student;//管理员身份的teacher

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

	private static final long serialVersionUID = 2L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
//admin对teacher进行操作
//teacher对exam进行操作
//exam 对student进行操作
//student对file进行操作
//file对打包，评分等进行操作。

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		System.out.println(method);
		if("listMyExam".equals(method)) {//学生查看自己的考试
			this.listMyExam(request, response);
		}else if("myExamDetail".equals(method)) {
			this.myExamDetail(request, response);//学生查看一场考试详情
		}
	}
	
	private void myExamDetail(HttpServletRequest request, HttpServletResponse response) {
		Integer s_i = getIntParameter(request,"s_i");
		try {
			Exam2 exam2 =DaoFactory.getInstance().getExamDao().findBySI(s_i);
			request.setAttribute("exam2",exam2);//联合的实体考试2
			request.getRequestDispatcher("page/Student/editmyExam.jsp").forward(request, response);
	} catch (Exception e) {
			e.printStackTrace();
		} 
	}


	//老师更新某场考试信息


	//根据老师id，查询他创建的考试
	private void listMyExam(HttpServletRequest request, HttpServletResponse response) {
		//当前页码
		Integer pageNo = getIntParameter(request, "pageNo");
		String e_name = request.getParameter("e_name");
		//查询条件
		Student student = (Student) request.getSession().getAttribute("user");
		String s_id = student.getS_id();
		//构造了一个pageInfo对象
		PageInfo<Exam2> pageInfo = new PageInfo<>(pageNo);
		try {
			pageInfo = DaoFactory.getInstance().getExamDao().listMyExam(s_id,e_name,pageInfo);
			request.setAttribute("pageInfo", pageInfo);
			request.getRequestDispatcher("page/Student/myexam.jsp").forward(request, response);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}
	public Integer getIntParameter(HttpServletRequest request,String name) {
		if(StringUtils.isNoneBlank(request.getParameter(name))) {
			return Integer.parseInt(request.getParameter(name));
		}else {
			return null;
		}
	}
}
