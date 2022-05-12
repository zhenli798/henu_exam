
package com.lz.servlet;

import java.io.IOException;
import java.sql.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.json.Json;

import com.lz.dao.DaoFactory;
import com.lz.entity.Exam;
import com.lz.entity.Notice;

import net.sf.json.JSONArray;
import utils.DbUtil;


@WebServlet("/StudentNoticeServlet")
public class StudentNoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentNoticeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("deprecation")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("noticeservet");
		// TODO Auto-generated method stub
		//String id = requesget.getParameter("e_id");
		//int e_id = Inter.valueOf(id).intValue();
		//获取正在考试的考试id
		response.setContentType("text/plain; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		//int e_id = 1;   //这里需要更改为正在考试的id或者学生考试的id 获取方法暂时未写
		ArrayList<Integer> eIdList = new ArrayList<Integer>();
		Date date = new Date();
		String sdate=(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm")).format(date); 
		//System.out.println(sdate);
		int m=-1;
		ResultSet rs = DbUtil.executeQuery("select e_id,e_starttime,e_stoptime from exam");
		//System.out.println(rs);
		try {
			while(rs.next())
			{
				//System.out.println("n,s,63:"+rs.getString(2));
				//System.out.println(rs.getString(3));
				    if(sdate.compareTo(rs.getString(2))>=0&&sdate.compareTo(rs.getString(3))<=0)
				    {
				    	if(rs.getInt(1)==m) continue;
				    	m = rs.getInt(1);
				    	eIdList.add(rs.getInt(1));
				    	//System.out.println(rs.getInt(1));
				    }
					//System.out.println(rs.getString(1));
					//System.out.println("n,s,73:"+rs.getString(2));
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		for(int i=0;i<eIdList.size();i++) {
			//System.out.print("ns,eid:81"+eIdList.get(i));
		try {
		//	System.out.println("n,s,82"+eIdList.get(i));
			List<Notice> notices = DaoFactory.getInstance().getNoticeDao().listNotice(eIdList.get(i));
			//这里需要增加一个根据考试名来进行查找考试的操作，并将新的列表中添加一列或者将第一列改为查找考试姓名的操作
			//System.out.println("n,s,85"+notices);
			if(null==notices||notices.size()==0) break;
			Exam exam = DaoFactory.getInstance().getExamDao().findById(eIdList.get(i));
			
			//System.out.println("notice,s,88:"+exam);
			Notice temp = new Notice();
			temp.setN_time("");
			temp.setN_text(exam.getE_name());
			notices.add(temp);
			JSONArray jsonArray=JSONArray.fromObject(notices); //List转json
			
			//jsonArray.add(Json.createObjectBuilder().add("e_id", exam.getE_name()).add("n_time",notices.get(2).getN_time()).add("n_text", "").build());
			//System.out.println("0" + Json.createObjectBuilder().add("e_id", exam.getE_name()).add("n_time",notices.get(2).getN_time()).add("n_text", "").build());
			//System.out.println("1" + jsonArray);
			response.getWriter().print(jsonArray);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		
		DbUtil.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	

}