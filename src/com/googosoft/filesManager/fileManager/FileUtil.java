package com.googosoft.filesManager.fileManager;

public class FileUtil {

	public static String getFileExtension(String str) {
		int position = str.lastIndexOf(".");
		if (position != -1) {
			str = str.substring(position + 1);
			return str;
		} else {
			return "";
		}

	}
}
