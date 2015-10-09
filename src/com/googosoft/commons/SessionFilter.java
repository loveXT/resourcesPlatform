package com.googosoft.commons;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

/**
 * Servlet Filter implementation class SessionFilter
 */
public class SessionFilter implements Filter, ISessionContants {
	private Logger logger = Logger.getLogger(SessionFilter.class.getName());
	private String error;
	private List successFileList;
	private List successFolderList;

	/**
	 * Default constructor.
	 */
	public SessionFilter() {
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
		String url = httpServletRequest.getServletPath();
		HttpSession session = httpServletRequest.getSession();
		if (isSuccess(url)
				|| (session.getAttribute(USERIDBYLOGIN) != null && !session
						.isNew())) {
			chain.doFilter(request, response);
		} else {
			logger.warn("[session失效，重新登录]");
			RequestDispatcher rd = request.getRequestDispatcher(error);
			rd.forward(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		error = filterConfig.getInitParameter("ERROR");
		String successFiles = filterConfig.getInitParameter("SUCCESSFILES");
		String successFolders = filterConfig.getInitParameter("SUCCESSFOLDERS");
		successFiles = successFiles == null ? "" : successFiles
				.replace(" ", "");
		successFolders = successFolders == null ? "" : successFolders.replace(
				" ", "");
		successFileList = Arrays.asList(successFiles.split(","));
		successFolderList = Arrays.asList(successFolders.split(","));
	}

	private boolean isSuccess(String url) {
		String successFolder = null;
		for (int i = 0; i < successFolderList.size(); i++) {
			successFolder = successFolderList.get(i).toString();
			if (url.startsWith(successFolder) && successFolder != null
					&& !"".equals(successFolder)) {
				logger.info("[安全地址集：" + successFolder + "]");
				return true;
			}
		}
		if (successFileList.contains(url)) {
			logger.info("[安全地址：" + url + "]");
			return true;
		}
		return false;
	}
}
