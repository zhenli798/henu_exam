package com.lz.servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/download")
public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 23L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String filepath = request.getParameter("filepath");
		String filename = request.getParameter("filename");
		System.out.println("filepath:"+filepath);
		byte[] bytes = filename.getBytes("UTF-8");
		try {
			filename = new String(bytes,"ISO8859-1");
			response.setHeader("content-disposition", "attachment; filename="+filename);
			System.out.println("download filepath: "+filepath);
			InputStream is = this.getServletContext().getResourceAsStream(filepath);
			ServletOutputStream os = response.getOutputStream();
			
			int len = -1;
			byte[] buf = new byte[1024];
			while((len = is.read(buf)) != -1) {
				os.write(buf,0, len);
			}
			
			//关闭流
			os.close();
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
