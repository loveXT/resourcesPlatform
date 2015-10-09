package com.googosoft.questionbank.excel;

public class Replace {
	/**
	 * @author liuhe
	 * @param strSource 要修改字符串
	 * @param strFrom 要修改的内容
	 * @param strTo 修改后的内容
	 * @return
	 */
	public  static  java.lang.String  replace(java.lang.String  strSource,java.lang.String  strFrom,java.lang.String  strTo){
		java.lang.String  strDest  =  "";
		int  intFromLen  =  strFrom.length();
		int  intPos;

		while((intPos=strSource.indexOf(strFrom))!=-1){
		strDest  =  strDest  +  strSource.substring(0,intPos);
		strDest  =  strDest  +  strTo;
		strSource  =  strSource.substring(intPos+intFromLen);
		}
		strDest  =  strDest  +  strSource;

		return  strDest;
		}
}
