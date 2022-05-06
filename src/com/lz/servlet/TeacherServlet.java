package com.lz.servlet;

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

import com.lz.entity.Teacher;//管理员身份的teacher

@WebServlet("/teacher")
public class TeacherServlet extends HttpServlet {

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
		if("list".equals(method)) {//老师列出所有考试
			this.list(request, response);
		}else if("add".equals(method)) {//老师添加考试
			this.add(request, response);
		}else if("update".equals(method)) {//老师更新考试
			this.update(request, response);
		}else if("delete".equals(method)) {//老师删除考试
			this.delete(request, response);
		}
	}
	private void add(HttpServletRequest request, HttpServletResponse response) {//js已经验证不为空
		String t_id = request.getParameter("t_id");
		String e_name = request.getParameter("e_name");
		String e_starttime = request.getParameter("e_starttime");
		String e_stoptime = request.getParameter("e_stoptime");
		String e_autostartS = request.getParameter("e_autostart");
		Integer e_autostart = 0;
		System.out.print("t,s,add:"+e_starttime);
		if(e_autostartS==null) {
			e_autostart = 0;
		}else {
			e_autostart=1;
		}
		System.out.println("teacherS,add:"+ t_id+" "+e_name+" "+e_starttime);
		//Integer e_hasquestion = Integer.parseInt(request.getParameter("e_hasquestion"));
		//Integer e_status = Integer.parseInt(request.getParameter("e_status"));
		
		Exam exam = new Exam();
		exam.setT_id(t_id);
		exam.setE_name(e_name);
		exam.setE_starttime(e_starttime);
		exam.setE_stoptime(e_stoptime);
		exam.setE_autostart(e_autostart);
		exam.setE_status(0);
		try {
			DaoFactory.getInstance().getExamDao().add(exam);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"teacher?method=list&msg=Add exam sucessful!");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Integer e_id = getIntParameter(request,"e_id");
		try {
			DaoFactory.getInstance().getExamDao().deleteExam(e_id);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"teacher?method=list&msg=Delete exam sucessful!");
		} catch (Exception e) {
			
			e.printStackTrace();
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"teacher?method=list&msg=Sorry,you cannot. Has students exist.");

		} 
	}


	//老师更新某场考试信息
	private void update(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("update");
		String t_id = request.getParameter("t_id");
		String t_name = request.getParameter("t_name");
		Integer t_isadmin = getIntParameter(request,"t_isadmin");
		Teacher teacher = new Teacher();
		teacher.setT_id(t_id);
		teacher.setT_isadmin(t_isadmin);
		teacher.setT_name(t_name);

		try {
			DaoFactory.getInstance().getTeacherDao().update(teacher);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"admin?method=list&msg=Update sucessful!");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//根据老师id，查询他创建的考试
	private void list(HttpServletRequest request, HttpServletResponse response) {
		//当前页码
		Integer pageNo = getIntParameter(request, "pageNo");
		//查询条件
		String e_name = request.getParameter("e_name");
		String msg = request.getParameter("msg");
		Teacher teacher = (Teacher) request.getSession().getAttribute("user");
		String t_id = teacher.getT_id();
		//构造了一个pageInfo对象
		PageInfo<Exam> pageInfo = new PageInfo<>(pageNo);
		try {
			pageInfo = DaoFactory.getInstance().getExamDao().listExam(t_id,e_name,pageInfo);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		try {
			
			request.setAttribute("pageInfo", pageInfo);
			//回写到页面
			request.getRequestDispatcher("page/Teacher/listExam.jsp?msg="+msg).forward(request, response);
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
