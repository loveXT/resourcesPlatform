package com.googosoft.questionbank.util;

import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;


public class WordTest {

	public WordTest() {
		
	}

	public static boolean writeWordFile(String path, String content) {
		boolean w = false;
		try {

			// byte b[] = content.getBytes("ISO-8859-1");
			byte b[] = content.getBytes();

			ByteArrayInputStream bais = new ByteArrayInputStream(b);

			POIFSFileSystem fs = new POIFSFileSystem();
			DirectoryEntry directory = fs.getRoot();

			DocumentEntry de = directory.createDocument("WordDocument", bais);

			FileOutputStream ostream = new FileOutputStream(path);

			fs.writeFilesystem(ostream);

			bais.close();
			ostream.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return w;
	}

	public static void main(String[] args) {
		boolean b = writeWordFile("E://test.doc", "hello world!");
	}
}
