package com.lz.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.lz.dao.DaoFactory;
import com.lz.entity.Exam;
import com.lz.utils.PathUtils;
import com.lz.utils.UploadUtils;

@WebServlet("/updateExam")
public class UpdateExamServlet extends HttpServlet {

	private static final long serialVersionUID = 123L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//MAP目的:携带数据(form表单中的字段)
		Map<String,String> map=new HashMap<String,String>();
		//目的:携带数据,向sercie,dao传递
		Exam exam = (Exam) request.getSession().getAttribute("exam");
		Integer e_id = exam.getE_id();
		try {
			//以下三行代码功能: 通过request.getInputStream();获取到请求体的全部内容
			//进行解析,将每对分割线中的内容封装在了FileItem对象中
			DiskFileItemFactory fac=new DiskFileItemFactory();
			ServletFileUpload upload=new ServletFileUpload(fac);
			List<FileItem> list=upload.parseRequest(request);
			//4_遍历集合
			for (FileItem item : list) {
//				System.out.println("item.key:"+item.getFieldName()+"  "+"item.value:"+item.getString());
//				System.out.println(item.getString()==null);
//				System.out.println(item.getString().isBlank());
//				System.out.println(item.getString());
				if(item.getFieldName().equals("e_autostart")) {
					if(item.getString().equals("on")) {
						System.out.println("ononon");
						exam.setE_autostart(1);
					}else {
						exam.setE_autostart(0);
					}
				}else if(item.getString().isBlank()) {//用户未修改的项（包括，未选择自动开始）
						continue;		
				}else if(item.isFormField()){
					//5_如果当前的FileItem对象是普通项
					//将普通项上name属性的值作为键,将获取到的内容作为值,放入MAP中				
					map.put(item.getFieldName(), item.getString("utf-8"));
				}else{
					
					//获取到原始的文件名称
					String oldFileName=item.getName();
					map.put("q_name", oldFileName);
					//获取到要保存文件的名称  
					String newFileName=UploadUtils.getUUIDName(oldFileName);
					//通过FileItem获取到输入流对象,通过输入流可以获取到图片二进制数据
					InputStream is=item.getInputStream();
					
					//tomcat的安装目录
					//D:\tomcat\tomcat71_sz07\webapps\项目名\file
					String realPath = getServletContext().getRealPath("/file/");
					
					realPath = realPath+e_id.toString();//每个考试，创建一个文件夹，e_id
					File dirFile = new File(realPath);
					if(!dirFile.exists()) {
						dirFile.mkdirs();
					}
					//在服务端创建一个空文件(后缀必须和上传到服务端的文件名后缀一致)
					File file=new File(realPath,newFileName);
					if(!file.exists()){
						file.createNewFile();
					}
					System.out.println("file:ok"+file);
					//建立和空文件对应的输出流
					OutputStream os=new FileOutputStream(file);
					//将输入流中的数据刷到输出流中
					//释放资源
					IOUtils.copy(is, os);
					IOUtils.closeQuietly(is);
					IOUtils.closeQuietly(os);
					System.out.println("file2:ok"+file);
					//向map中存入一个键值对的数据(****这里就是form提交文件名的那个字段)
					map.put("q_path", "/file/"+e_id+"/"+newFileName);
				}
			}
			//7_利用BeanUtils将MAP中的数据填充到exam对象上
			BeanUtils.populate(exam, map);

			//8_调用servcie_dao将exam上携带的数据存入数据仓库
			DaoFactory.getInstance().getExamDao().update(exam);
			request.setAttribute("exam", exam);//更新session里面的exam
			response.sendRedirect("page/Exam/editExam.jsp?msg= Update exam sucessful!");
			} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
