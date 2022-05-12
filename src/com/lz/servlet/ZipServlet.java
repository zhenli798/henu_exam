package com.lz.servlet;


import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.lz.utils.ZipUtil;
/**
 *  Servlet implementation class ZipServlet
 */
@WebServlet("/zip")
public class ZipServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//这里是压缩
		ZipUtil z=new ZipUtil();
		String e_id = request.getParameter("e_id");
		String e_name = request.getParameter("e_name").replace(' ','+');
		System.out.println("e_name:"+e_name);
		String realPath = getServletContext().getRealPath("/file/");
		String[] srcDir = { realPath +e_id };
		String outDir = realPath+e_name+".zip";
		System.out.println(outDir);
	
		try {
			z.toZip(srcDir, outDir, true);
			String filename= e_name+".zip";
			String filepath ="/file/"+filename;
			
			//下面是下载
			System.out.println("zip filepath:"+filepath);
			byte[] bytes = filename.getBytes("UTF-8");
			try {
				filename = new String(bytes,"ISO8859-1");
				response.setHeader("content-disposition", "attachment; filename="+filename);
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
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
