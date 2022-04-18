package com.lz.utils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns= {"/*"},initParams= {
		@WebInitParam(name="exclude",value="/login.jsp,/login,/noprivilige.jsp,.ico,.css,.png,.jpg,.js")
})
public class PermissionFilter implements Filter {

	public static String excludeString ;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		excludeString = filterConfig.getInitParameter("exclude");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest)request;
		HttpServletResponse httpServletResponse = (HttpServletResponse)response;
		Object user = httpServletRequest.getSession().getAttribute("user");
		String uri = httpServletRequest.getRequestURI();
		if(isExist(uri) || uri.equals(httpServletRequest.getContextPath()+"/")) {
			chain.doFilter(httpServletRequest, httpServletResponse);
		}else {
			if(user != null) {
				chain.doFilter(httpServletRequest, httpServletResponse);
			}else {
				httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/noprivilige.jsp");
			}
		}
	}
	
	public static boolean isExist(String uri) {
		//最后url的结尾与exclude匹配
		String[] arr = excludeString.split(",");
		boolean flag = false;
		for (String string : arr) {
			if(uri.endsWith(string)) {
				flag = true;
			}
		}
		return flag;
	}
	

	@Override
	public void destroy() {

	}

}
