package com.googosoft.filesManager.fileManager;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;

import com.googosoft.common.util.StringPool;
import com.googosoft.common.util.Validator;
import com.googosoft.commons.IUploadImgContants;
import com.googosoft.filesManager.viewManager.StringConstant;

/**
 * 
 * @author lk
 * @since 1.5
 * 
 */
public class ProcessFileUtil {

	private static boolean firstStatus = false;

	private static boolean secondStatus = false;

	/**
	 * 由pdf转换为swf文件
	 * 
	 * @param path
	 */
	public boolean transpdfToSwf(final String path) {
		final String filetension = FilenameUtils.getExtension(path);
		Thread thread = new Thread(new Runnable() {
			public void run() {
				ConvertFileUtil convertFileUtil = new ConvertFileUtilImp();
				firstStatus = convertFileUtil.pdf2SWF(path, filetension);
			}
		});
		thread.start();
		return firstStatus;
	}
	/**
	 * 多文件转换共用一个线程
	 * @param path
	 */
	public static  void mutiFilesTransform(final String path[]) {
		Thread thread = new Thread(new Runnable() {
			public void run() {
				excuteTransFile(path);
			}
		});
		thread.start();
	}
	
	
	/**
	 * 多文件转换
	 * @param filePaths
	 */
	private static void excuteTransFile(String[] filePaths) {
		ProcessFileUtil fileUtil = new ProcessFileUtil();
		for (String path : filePaths) {
			// 如果文件路径时空的，直接跳出
			if (Validator.isNull(path)) {
				continue;
			}
			// 如果是pdf文件的话
			if (ProcessFileUtil.isPdfFile(path)) {
				fileUtil.transMutiPdfToSwf(path);
				// 如果是常用的文件(txt,doc,docx,ppt....)
			} else if (ProcessFileUtil.isCommonFile(path)) {
				fileUtil.mutilFileTrnasform(path);
			}
		}
	}
	/**
	 * 多任务转换
	 * 
	 * @param path
	 */
	public boolean transMutiPdfToSwf(String path) {
		String filetension = FilenameUtils.getExtension(path);
		ConvertFileUtil convertFileUtil = new ConvertFileUtilImp();
		return convertFileUtil.pdf2SWF(path, filetension);
	}

	/**
	 * 由原始文件转换为swf文件
	 * 
	 * @param Path
	 */
	public boolean transOreFileToSwf(final String Path) {
		final String filetension = FilenameUtils.getExtension(Path);
		Thread thread = new Thread(new Runnable() {
			public void run() {
				ConvertFileUtil convertFileUtil = new ConvertFileUtilImp();
				String pdfpath = convertFileUtil.doc2PDF(Path);
				secondStatus = convertFileUtil.pdf2SWF(pdfpath, filetension);
			}
		});
		thread.start();
		return secondStatus;
	}

	/**
	 * 多任务转换
	 * 
	 * @param Path
	 * @return
	 */
	public boolean mutilFileTrnasform(String Path) {
		String filetension = FilenameUtils.getExtension(Path);
		ConvertFileUtil convertFileUtil = new ConvertFileUtilImp();
		String pdfpath = convertFileUtil.doc2PDF(Path);
		return convertFileUtil.pdf2SWF(pdfpath, filetension);
	}
	
	/***
	 * 多文件转换
	 * @param paths
	 */
	@Deprecated
	public static void transMutiFile(String[] paths){
		ConvertThread  convertThread  = new ConvertThread(paths);
		convertThread.start();
	}
	/**
	 * 检测文件是否存在
	 * 
	 * @param path
	 * @return
	 */
	public static boolean checkFileExists(String filename,
			HttpServletRequest request) {
		String sp = File.separator;
		String toPath = request.getRealPath(sp) + IUploadImgContants.IMGPATH;
		toPath = toPath.replace(sp, sp + sp);
		File file = new File(toPath + filename);
		if (file.exists())
			return true;
		return false;
	}
	/**
	 * 检测验收文件
	 * 
	 * @param path
	 * @return
	 */
	public static boolean checkDataResourceExists(String filename,
			HttpServletRequest request) {
		String sp = File.separator;
		String toPath = request.getRealPath(sp) + "dataResource"+sp;
		toPath = toPath.replace(sp, sp + sp);
		File file = new File(toPath + filename);
		if (file.exists())
			return true;
		return false;
	}
	/**
	 * 检测资源管理文件是否存在
	 * 
	 * @param path
	 * @return
	 */
	public static boolean checkTeachFileExists(String filename,
			HttpServletRequest request) {
		String sp = File.separator;
		String toPath = request.getRealPath(sp) +"dataResource"+sp;
		toPath = toPath.replace(sp, sp + sp);
		File file = new File(toPath + filename);
		if (file.exists())
			return true;
		return false;
	}
	/**
	 * 检测附件预览文件是否存在
	 * 
	 * @param filename
	 * @param request
	 * @return
	 */
	public static boolean checkAttchExists(String path) {
		File file = new File(path);
		System.out.println(path);
		if (file.exists())
			return true;
		return false;
	}

	/**
	 * 检测文件是否是office相关文件
	 * 
	 * @param filename
	 * @param request
	 * @return
	 */
	public static boolean isCommonFile(Object extendName) {
		if (Validator.isNull(extendName)) {
			return false;
		}
		if (extendName instanceof String) {
			List<String> extendList = Arrays
					.asList(StringConstant.AVALIABLETRANSFILES);
			return extendList.contains(extendName);
		} else {
			return false;
		}
	}

	/**
	 * 检测文件是否是视频
	 * 
	 * @param extendName
	 * @return
	 */
	public static boolean isVideoFile(Object extendName) {
		if (Validator.isNull(extendName)) {
			return false;
		} else if (extendName instanceof String) {
			List<String> extendList = Arrays
					.asList(StringConstant.extensionArray);
			return extendList.contains(extendName);
		} else {
			return false;
		}

	}

	/**
	 * 检测文件是否是pdf文件
	 * 
	 * @param extendname
	 * @return
	 */

	public static boolean isPdfFile(Object extendname) {
		if (Validator.isNull(extendname)) {
			return false;
		} else if (extendname instanceof String) {

			return ".pdf".equals(((String) extendname).toLowerCase());
		} else {
			return false;
		}
	}

	/**
	 * 用于检测非视频文件是否可以预览
	 * 
	 * @param extendname
	 * @return
	 */
	public static boolean isPriviewNoVideo(Object extendname) {

		return isPdfFile(extendname) || isCommonFile(extendname);
	}

	/**
	 * 根据文件的实际路径来检测文件是否是常用的文件格式(txt,doc,docx.....)
	 * 
	 * @param path
	 * @return
	 */
	public static boolean isCommonFile(String path) {
		if (Validator.isNull(path)) {
			return false;
		}
		String fileExtension = path.substring(
				path.lastIndexOf(StringPool.PERIOD), path.length());
		List<String> extendList = Arrays
				.asList(StringConstant.AVALIABLETRANSFILES);
		return extendList.contains(fileExtension);
	}

	/**
	 * 根据文件路径判断是否是pdf文件
	 * 
	 * @param path
	 * @return
	 */
	public static boolean isPdfFile(String path) {
		if (Validator.isNull(path)) {
			return false;
		}
		return path.toLowerCase().indexOf("pdf") < 0 ? false : true;
	}
}

class ConvertThread extends Thread {

	private String[] paths;

	public ConvertThread(String[] paths) {
		this.paths = paths;
	}

	@Override
	public void run() {
		excuteTransFile(paths);
	}
	private void excuteTransFile(String[] filePaths) {
		ProcessFileUtil fileUtil = new ProcessFileUtil();
		for (String path : filePaths) {
			// 如果文件路径时空的，直接跳出
			if (Validator.isNull(path)) {
				continue;
			}
			// 如果是pdf文件的话
			if (ProcessFileUtil.isPdfFile(path)) {
				fileUtil.transMutiPdfToSwf(path);
				// 如果是常用的文件(txt,doc,docx,ppt....)
			} else if (ProcessFileUtil.isCommonFile(path)) {
				fileUtil.mutilFileTrnasform(path);
			}
		}
	}

}