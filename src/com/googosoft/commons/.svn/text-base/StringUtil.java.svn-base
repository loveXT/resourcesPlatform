/*
 * StringUtil.java  2013-1-10 下午04:56:27 
 *
 */
package com.googosoft.commons;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.apache.log4j.Logger;

/**
 * 字符串工具类。
 * 
 * @author songshipeng
 * @since 1.6
 * @version 0.1
 * 
 */
public class StringUtil {

	private static Logger logger = Logger.getLogger(StringUtil.class.getName());
	
	/**
	 * 移除指定字符串的开头字符字串。
	 * 
	 * @param longString 
	 * 			被移除的字符串。
	 * @param array 
	 * 			需要移除的字符串数组。
	 * @return String
	 * 			移除后的字符串。
	 */
	public static String removeStringHead(String longString, String[] array){
		
		if(array==null || longString == null || longString.length() < 1){
			logger.error("被移除的字符串 或者 需要移除的字符串为空！");
			return null;
		}
		for(int i = 0 ; i < array.length ; i++ ){
			longString = removeString(longString, array[i]);
		}
		return longString.trim();
	}
	
	/**
	 * 移除指定字符串的开头字符字串。
	 * 
	 * @param longString
	 * 			被移除的字符串。
	 * @param subString
	 * 			需要移除的字符串。
	 * @return
	 * 			移除后的字符串。
	 */
	public static String removeStringHead(String longString, String subString){
		if(subString==null || longString == null ){
			logger.error("被移除的字符串 或者 需要移除的字符串为空！");
			return null;
		}
		return removeString(longString,subString);
	}
	
	private static String removeString(String longString, String subString){
		int index = longString.trim().indexOf(subString);
		if(index==0){
			return longString.substring(subString.length());
		}
		
		return longString;
	}
	
	/**
	 * 获得32位UUID。
	 * @return String
	 */
	public static String getID(){
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * 是否为空。判断的值将以字符串的形式进行判断。
	 * 
	 * @param obj
	 * 			待判断的值。
	 * @return
	 * 			如果为空返回true；如果不为空返回false。
	 */
	public static boolean isNull(Object obj) {
		if (obj == null || obj.equals("null") || (obj.toString()).trim().length() <= 0)
			return true;
		return false;
	}
	
	/**
	 * 是否不为空。判断的值将以字符串的形式进行判断。
	 * 
	 * @param obj
	 * 			待判断的值。
	 * @return
	 * 			如果不为空返回true；如果为空返回false。
	 */
	public static boolean isNotNull(Object obj){
		return !isNull(obj);
	}
	
	/**
	 * <b>方法作用：</b> 判断object变量是否为数字。
	 * <br><br>
	 * <b>详细说明：</b> 是数字返回true，不是数字返回false。
	 * <br><br>
	 * <b>举例说明：</b> StringUtil.isNumber(obj); 
	 *
	 * <br><br>
	 * @param obj 待判断的object变量。
	 * @return boolean
	 */
	public static boolean isNumber(Object obj){
		if(isNotNull(obj)){
			try {
				Integer.parseInt(obj.toString());
				return true;
			} catch (Exception e) {
				return false;
			}
		}
		return false;
	}
	
	/**
	 * <b>方法作用：</b> 返回object变量的数字。
	 * <br><br>
	 * <b>详细说明：</b> 如果是数字返回对应数字，如果不是返回0。
	 * <br><br>
	 * <b>举例说明：</b> StringUtil.isNumber(obj); 
	 *
	 * <br><br>
	 * @param obj 待判断的object变量。
	 * @return boolean
	 */
	public static int objToInteger(Object obj){
		if(isNumber(obj)){
			return Integer.parseInt(obj.toString());
		}else{
			return 0;
		}
	}
	
	public static int objToInteger(Object obj, int rs){
		if(isNumber(obj)){
			return Integer.parseInt(obj.toString());
		}else{
			return rs;
		}
	}
	
	/**
	 * 把object变量转换成字符串。如果为空，则返回空字符串。
	 * 
	 * @param obj
	 * @return
	 */
	public static String objToString(Object obj){
		return objToString(obj, "");
	}
	
	/**
	 * 把object变量转换成字符串。如果为空，则返回指定字符串。
	 * 
	 * @param obj
	 * @return
	 */
	public static String objToString(Object obj, String tmp){
		if(!isNull(obj)){
			return obj.toString();
		}else{
			return tmp;
		}
	}
	
	/**
	 * 获取格式化时间<br>
	 * 
	 * @param style
	 * 			-时间格式<br>例：yyyy-MM-dd HH:mm:ss
	 * @return
	 * 			{@link String}
	 */
	public static String getTime(String style){
		return new SimpleDateFormat(style).format(new Date());
	}
	
	/**
	 * 把时间字符串进行格式化
	 * @param time
	 * 			-时间字符串<br>例：yyyy-MM-dd HH:mm:ss
	 * @param style
	 * 			-时间格式<br>例：yyyy年MM月dd日HH:mm:ss
	 * @return
	 */
	public static String StringDateSimple(String time, String style){
		// 对时间字符串进行分解
		String[] timea = time.trim().split(" ");
		try {
			Date date = new Date();
			// 如果长度为1，只判断年月日
			if(timea.length == 1){
				String[] times = timea[0].split("-");
				// 如果长度大于0，判断年
				if(times.length > 0){
					date.setYear(Integer.parseInt(times[0])-1900);
				}
				// 如果长度大于1，判断月
				if(times.length > 1){
					date.setMonth(Integer.parseInt(times[1])-1);
				}
				// 如果长度大于2，判断日
				if(times.length > 2){
					date.setDate(Integer.parseInt(times[2]));
				}
			}
			// 如果长度为2，继续判断时分秒
			if(timea.length == 2){
				String[] timed = timea[1].split(":");
				// 如果长度大于0，判断时
				if(timed.length > 0){
					date.setHours(Integer.parseInt(timed[0]));
				}
				// 如果长度大于1，判断分
				if(timed.length > 1){
					date.setMinutes(Integer.parseInt(timed[1]));
				}
				// 如果长度大于2，判断秒
				if(timed.length > 2){
					date.setSeconds(Integer.parseInt(timed[2]));
				}
			}
			return new SimpleDateFormat(style).format(date);
		} catch (Exception e) {
			
		}
		return null;
	}
	
	/**
	 * 分页object变量转换成数字
	 * @param nulls
	 * @return {@link Integer}
	 */
	public static int changePage(Object nulls){
		return ( nulls == null || "null".equals(nulls) || "".equals(nulls) ? 0 : Integer.parseInt(nulls.toString().trim()));
	}
	
}
