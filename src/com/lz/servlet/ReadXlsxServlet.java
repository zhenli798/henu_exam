package com.lz.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.List;

import java.io.File;
import java.io.FileOutputStream;


import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.lz.dao.DaoFactory;
import com.lz.entity.Exam;
import com.lz.entity.Student;
import com.lz.utils.PathUtils;
import com.lz.utils.UploadUtils;

import jxl.Cell;
import jxl.Workbook;

/**
 * Servlet implementation class ReadXlsx
 */
@WebServlet("/readXlsx")
public class ReadXlsxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
 
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReadXlsxServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)

			throws ServletException, IOException {

		Exam exam = (Exam) request.getSession().getAttribute("exam");
		Integer e_id = exam.getE_id();
		String newFileName = null;
		try {
			// 以下三行代码功能: 通过request.getInputStream();获取到请求体的全部内容
			// 进行解析,将每对分割线中的内容封装在了FileItem对象中
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			List<FileItem> list = upload.parseRequest(request);
			// 4_遍历集合
			for (FileItem item : list) {
				if (item.isFormField()) {
					continue;
				} else {

					// 获取到原始的文件名称
					String oldFileName = item.getName();

					newFileName = UploadUtils.getUUIDName(oldFileName);

					InputStream is = item.getInputStream();

					String realPath = getServletContext().getRealPath("/studentXlsx/");

					File dirFile = new File(realPath);
					if (!dirFile.exists()) {
						dirFile.mkdirs();
					}
					// 在服务端创建一个空文件(后缀必须和上传到服务端的文件名后缀一致)
					File file = new File(realPath, newFileName);
					if (!file.exists()) {
						file.createNewFile();
					}
					System.out.println("file:ok" + file);
					// 建立和空文件对应的输出流
					OutputStream os = new FileOutputStream(file);
					// 将输入流中的数据刷到输出流中
					// 释放资源
					IOUtils.copy(is, os);
					IOUtils.closeQuietly(is);
					IOUtils.closeQuietly(os);
					System.out.println("filexlsx:ok" + file);

				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		// 读表格

		try {

			Workbook wb = Workbook.getWorkbook(

					new File(getServletContext().getRealPath("/studentXlsx/") + newFileName));

			System.out.println("2222222");

			for (int i = 1; i < wb.getSheet(0).getRows(); i++) {

				Cell[] cell = wb.getSheet(0).getRow(i);
				
				Student student = new Student();
				
				//添加学生
				student.setE_id(e_id);
				student.setS_id(cell[0].getContents());
				student.setS_name(cell[1].getContents());
				student.setS_class(cell[2].getContents());
				try {
					DaoFactory.getInstance().getStudentDao().add(student);
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
			
			//直接重定向到列表页面
			response.sendRedirect(PathUtils.getBasePath(request)+"exam?method=listStudent&msg=Add student sucessful!");
		 
		} catch (Exception e) {

			e.printStackTrace();
		}

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
