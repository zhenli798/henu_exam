package com.lz.servlet;




import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.lz.utils.PageInfo;
import com.lz.utils.PathUtils;
import com.lz.dao.DaoFactory;
import com.lz.entity.Student;
import com.lz.entity.myFile;


@WebServlet("/myfile")
public class FileServlet extends HttpServlet {

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
		if("list".equals(method)) {
			this.list(request, response);
		}else if("delete".equals(method)) {
			this.delete(request, response);
		}
	}
	
	private void delete(HttpServletRequest request, HttpServletResponse response) {
		Integer f_id = Integer.parseInt(request.getParameter("f_id"));
		try {
			DaoFactory.getInstance().getFileDao().delete(f_id);
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"myfile?method=list&msg=Delete file sucessful!");
			//response.sendRedirect("page/Student/mycloud.jsp?msg=Delete file sucessful!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	
	
	private void list(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("======file servlet list========");
		//当前页码
		Integer pageNo = getIntParameter(request, "pageNo");
		//查询条件
		String f_name = request.getParameter("f_name");
		System.out.println("f_name:"+f_name);
		String msg = request.getParameter("msg");
		System.out.println(msg);
		Student student = (Student)request.getSession().getAttribute("user");
		String s_id = student.getS_id();
		//构造了一个pageInfo对象
		myFile file = new myFile();
		file.setF_name(f_name);
		PageInfo<myFile> pageInfo = new PageInfo<>(pageNo);
		try {
			pageInfo = DaoFactory.getInstance().getFileDao().listFile(s_id, f_name, pageInfo);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		try {
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("file",file);
			//回写到页面
			request.getRequestDispatcher("page/Student/mycloud.jsp?msg="+msg).forward(request, response);
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
