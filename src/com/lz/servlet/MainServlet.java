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


@WebServlet("/main")
public class MainServlet extends HttpServlet {

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<Map<String, Object>> list = DaoFactory.getInstance().getScoreDao().query_jgl();
			request.setAttribute("list", list);
			List<Map<String, Object>> top5List = DaoFactory.getInstance().getScoreDao().top5();
			request.setAttribute("top5List", top5List);
			request.getRequestDispatcher("page/main.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
