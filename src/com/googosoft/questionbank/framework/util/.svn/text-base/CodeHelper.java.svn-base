package com.googosoft.questionbank.framework.util;

import java.text.DecimalFormat;
import java.util.UUID;

import com.googosoft.questionbank.framework.exception.CRUDException;

public class CodeHelper {
	
	/**
	 * 閮ㄩ棬缂栧彿鐨勬瘡涓�垎娈甸暱搴︼紝濡備负4鍒檆ode灏嗙被浼�234-5678
	 */
	public static int CODE_LENGTH = 4;
	
	public static String createUUID(){
		return String.valueOf(UUID.randomUUID()).replaceAll("-", "");
	}
	
	/**
	 * 鑾峰緱涓嬩竴涓猚ode
	 * @param map map鍖呭惈鐨刱ey鏈�涓細鈥渃ode鈥濆拰鈥減arentCode鈥�
	 * @return
	 * @throws CRUDException
	 */
	public static String getNextCode(String selfCode, String parentCode) throws CRUDException{
		String nextCode = "";
		DecimalFormat df = new DecimalFormat("0000");
		
		
		if(parentCode != null && !parentCode.equals("")){
			if(selfCode == null || selfCode.equals("")){//绗竴娆℃坊鍔犻儴闂ㄧ殑瀛愰儴闂�
				nextCode = parentCode + "-0001";
			}else{
				int beginIndex = selfCode.lastIndexOf("-");
				
				int lastNum = Integer.parseInt(selfCode.substring(beginIndex+1))+1;
				
				nextCode = selfCode.substring(0,beginIndex+1)+df.format(lastNum);
			}
		}else{
			if(selfCode == null || selfCode.equals("")){
				nextCode = "0001";
			}else{
				
				int lastNum = Integer.parseInt(selfCode)+1;
				
				nextCode = df.format(lastNum);
				
			}
		}
			
		return nextCode;
	}
}
