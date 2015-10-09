package com.googosoft.commons;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public static String getDate(Date date,String templet){
		if(templet == null || templet.isEmpty()){
			templet="yyyy-MM-dd";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(templet);
		if(date != null){
			return sdf.format(date);
		}else{
			return sdf.format(new Date());
		}
	}
	/**
	 * 将时间字符串  按指定的时间格式 输出          如2013-05-14 10:01:59  按yyyy-MM-dd格式 
	 * 输出是：2013-05-14
	 * @param dateString   时间字符串
	 * @param format   时间格式  
	 * @return
	 */
	public static String getDate(String dateString,String format){

		DateFormat df = DateFormat.getDateInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = df.parse(dateString);
		} catch (ParseException e) {
			
			e.printStackTrace();
			System.out.println("时间格式解析错误！");
		}//

		if(date != null ){
			return sdf.format(date);
		}
		
		return null;
	}
}
