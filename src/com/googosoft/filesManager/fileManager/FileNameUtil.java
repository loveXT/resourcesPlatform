package com.googosoft.filesManager.fileManager;

import com.googosoft.filesManager.viewManager.StringConstant;

public class FileNameUtil {
	/**
	 * 
	 * @param extension
	 * @return
	 */
	public static  boolean isVideoFile(String extension){
		String[] extensionArray = StringConstant.extensionArray;
		for(int i=0;i<extensionArray.length;i++){
			if(extensionArray[i].equals(extension)){
				return true;
			}
		}
		return false;
	}

}
