package com.googosoft.questionbank.util;

import javax.servlet.http.HttpServletRequest;

public class ParamUtil {
	
	public static int getInt(HttpServletRequest request,String str){
		String value =request.getParameter(str).trim();
		if("".equals(value)||value==null){
			return 0;
		}else{
			return Integer.parseInt(value.trim());
		}
	}
	public  static float getFloat(HttpServletRequest request,String str){
		String str1 =request.getParameter(str);
		if("".equals(str1)||str1==null){
			return 0f;
		}else{
			return Float.parseFloat(str1);
		}
	}
	public static float getLong(HttpServletRequest request,String str){
		String str1 =request.getParameter(str);
		if("".equals(str1)||str1==null){
			return 0l;
		}else{
			return Long.parseLong(str1);
		}
	}
	public static String getString(HttpServletRequest request,String str){
		String str1 =request.getParameter(str);
		if("".equals(str1)||str1==null){
			return "";
		}else{
			return str1.trim();
		}
	}
}
