package com.googosoft.filesManager.fileManager;
/**
 * 
 * @author Administrator
 * @see com.liferay.portlet.documentlibrary.util
 */

public  interface  ConvertFileUtil {
	
	
	/**
	 * 功能：根据doc文档的路径，实现doc转换pdf
	 * @param docFile
	 * @return 
	 */
	public  String doc2PDF(String docFile);
	/**
	 * 功能：根据doc转换到pdf
	 * @param docFile
	 * @param pdfFile
	 */
	public String doc2PDF(String docFile,String pdfFile);
	/**
	 * 功能：实现pdf到swf文件的转换
	 * @param pdfFile
	 */
	public boolean  pdf2SWF(String pdfFile,String extension);
	/**
	 * 功能：实现pdf到swf文件的转换
	 * @param pdfFile
	 * @param swfFile
	 */
	public boolean pdf2SWF(String pdfFile,String swfFile,String extension);
	
}
