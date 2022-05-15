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
import com.lz.entity.Global;
import com.lz.entity.Student;
import com.lz.entity.Teacher;//管理员身份的teacher
import com.lz.utils.MD5;
//此servlet服务完都是跳转到都nav页面，需要给出标记的active号
@WebServlet("/exam")
public class ExamServlet extends HttpServlet {

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

	@Override // exam下
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		System.out.println(method);
		if("detail".equals(method)) {//考生列表->考试编辑
			this.detail(request, response);
		}else if("listStudent".equals(method)) {//考试列出学生
			this.listStudent(request, response);
		}else if("add".equals(method)) {//考试添加学生
			this.add(request, response);
		}else if("update".equals(method)) {//考试修改学生
			this.update(request, response);
		}else if("delete".equals(method)) {//考试删除学生
			this.delete(request, response);
		}else if("listScore".equals(method)) {//评分管理
			this.listScore(request, response);
		}else if("editScore".equals(method)) {//修改单场分数
			this.editScore(request, response);
		}
	}
	//考试编辑模块使用
	private void detail(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String e_idString = request.getParameter("e_id");
		Integer e_id = null;
		HttpSession  session = request.getSession();
		if(e_idString.equals("left")) {//用户点击左侧列表，去session里面看看有没有真正的e_id;
			Integer session_e_id = (Integer)session.getAttribute("e_id");
			System.out.println("session_e_id"+session_e_id);
			if(session_e_id!=null) {//session里面有
				e_id = session_e_id;
				try {
					Exam exam = DaoFactory.getInstance().getExamDao().findById(e_id);
					session.setAttribute("exam",exam);
					//直接重定向到列表页面
					response.sendRedirect(PathUtils.getBasePath(request)+"page/Teacher/nav.jsp?active=0");
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}else{//直接点击左侧,session 里面没有
				System.out.println("直接点击左侧");
				response.sendRedirect(PathUtils.getBasePath(request)+"teacher?method=list&msg=Please choose an exam!");
			};
		}else {//用户直接点击的考试列表中的某场考试
			e_id = Integer.parseInt(e_idString);
			session.setAttribute("e_id", e_id);
		
			System.out.println("e,s,e_id:"+e_id);
			try {
				Exam exam = DaoFactory.getInstance().getExamDao().findById(e_id);
				session.setAttribute("exam",exam);
				//直接重定向到列表页面
				response.sendRedirect(PathUtils.getBasePath(request)+"page/Teacher/nav.jsp?active=0");
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
	}
	//老师删除考生
	private void delete(HttpServletRequest request, HttpServletResponse response) {
		Integer s_i = Integer.parseInt(request.getParameter("s_i"));
		try {
			DaoFactory.getInstance().getStudentDao().delete(s_i);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"exam?method=listStudent&msg=Delete student sucessful!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	
	private void update(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("update");
		Integer s_i = Integer.parseInt(request.getParameter("s_i"));
		String s_id = request.getParameter("s_id");
		String s_name = request.getParameter("s_name");
		String s_class = request.getParameter("s_class");
		Student student = new Student();
		student.setS_i(s_i);
		student.setS_id(s_id);
		student.setS_name(s_name);
		student.setS_class(s_class);
		try {
			DaoFactory.getInstance().getStudentDao().update(student);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"exam?method=listStudent&msg=Update sucessful!");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}private void editScore(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("editscore");
		Integer s_i = Integer.parseInt(request.getParameter("s_i"));
		Integer s_score = Integer.parseInt(request.getParameter("s_score"));
		String s_comment = request.getParameter("s_comment");
		
		try {
			DaoFactory.getInstance().getStudentDao().editScore(s_i,s_score,s_comment);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"exam?method=listScore&msg=Update sucessful!");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//考生管理模块，添加考生
	private void add(HttpServletRequest request, HttpServletResponse response) {//js已经验证不为空
		Integer e_id = Integer.parseInt(request.getParameter("e_id"));
		String s_id = request.getParameter("s_id");
		String s_name = request.getParameter("s_name");;//默认密码
		String s_class = request.getParameter("s_class");
		Student student = new Student();
		
		student.setE_id(e_id);
		student.setS_id(s_id);
		student.setS_name(s_name);
		student.setS_class(s_class);
	
		try {
			DaoFactory.getInstance().getStudentDao().add(student);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"exam?method=listStudent&msg=Add student sucessful!");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void listStudent(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("======examServlet listStudent========");
		//当前页码
		String msg =request.getParameter("msg");
		Integer pageNo = getIntParameter(request, "pageNo");
		//查询条件
		Exam exam = (Exam) request.getSession().getAttribute("exam");
		Integer e_id = exam.getE_id();
		String s_id = request.getParameter("s_id");
		String s_name = request.getParameter("s_name");;//默认密码
		String s_class = request.getParameter("s_class");
		Student student = new Student();
		
		
		student.setE_id(e_id);
		student.setS_id(s_id);
		student.setS_name(s_name);
		student.setS_class(s_class);
		

//		System.out.println()
		//构造了一个pageInfo对象
		PageInfo<Student> pageInfo = new PageInfo<>(pageNo);
		try {
			pageInfo = DaoFactory.getInstance().getStudentDao().listStudent(student,pageInfo);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		try {
			request.setAttribute("pageInfo", pageInfo);
			//回写到页面
			request.setAttribute("student", student);
			//PathUtils.getBasePath(request)+"page/Exam/studentList.jsp"
			request.getRequestDispatcher("page/Exam/studentList.jsp?mag="+msg).forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private void listScore(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("======examServlet listScore========");
		//当前页码
		Integer pageNo = getIntParameter(request, "pageNo");
		//查询条件
		Exam exam = (Exam) request.getSession().getAttribute("exam");
		Integer e_id = exam.getE_id();
		String s_id = request.getParameter("s_id");
		String s_name = request.getParameter("s_name");;//默认密码
		String s_class = request.getParameter("s_class");
		Student student = new Student();
		
		student.setE_id(e_id);
		student.setS_id(s_id);
		student.setS_name(s_name);
		student.setS_class(s_class);
//		System.out.println()
		//构造了一个pageInfo对象
		PageInfo<Student> pageInfo = new PageInfo<>(pageNo);
		try {
			pageInfo = DaoFactory.getInstance().getStudentDao().listStudent(student,pageInfo);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		try {
			request.setAttribute("pageInfo", pageInfo);
			//回写到页面
			request.setAttribute("student", student);
			//PathUtils.getBasePath(request)+"page/Exam/studentList.jsp"
			request.getRequestDispatcher("page/Exam/scoreList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
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
