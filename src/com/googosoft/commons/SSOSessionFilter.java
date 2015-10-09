package com.googosoft.commons;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.ggs.homeManager.LoginManager;
import com.googosoft.zapi.DBHelper;

/**
 * Servlet Filter implementation class SessionFilter
 */
public class SSOSessionFilter implements Filter, ISessionContants {
	private Logger logger = Logger.getLogger(SSOSessionFilter.class.getName());

	/**
	 * Default constructor.
	 */
	public SSOSessionFilter() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpSession session = httpServletRequest.getSession();
		// 放入登陆信息
		Boolean bool = true;
		if (session.getAttribute("USERIDBYLOGIN") == null) {
			String loginName = session.getAttribute("LOGINNAME").toString();
			LoginManager loginManager = new LoginManager();
			bool = loginManager.loginUser(loginName, null, httpServletRequest);
		}
		// 放入资源信息
		String url = httpServletRequest.getServletPath();
		try {
			Object resourceId = getResourceIdByResourceUrl(url.substring(1));
			if (resourceId != null) {
				session.setAttribute("RESOURCEID", resourceId);
			}
		} catch (DBException e) {
			e.printStackTrace();
		}
		if (bool) {
			chain.doFilter(request, response);
		} else {
			request.setAttribute("loginRemark", "登录失败");
			request.getRequestDispatcher("login.jsp")
					.forward(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	private Object getResourceIdByResourceUrl(String resourceUrl)
			throws DBException {
		String sql = " SELECT ";
		sql += " UMRESOURCEID AS UMRESOURCEID ";
		sql += " FROM umresource t ";
		sql += " WHERE t.UMRESOURCEURL= '" + resourceUrl + "' ";
		DBHelper dbHelper = new DBHelper();
		return dbHelper.queryForSingleValue(sql);
	}
}
