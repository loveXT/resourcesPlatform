package com.googosoft.filesManager.fileManager;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import com.liferay.counter.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.FileUtil;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.util.SystemProperties;
import cn.googosoft.portlet.service.GImagesLocalServiceUtil;

import cn.googosoft.portlet.model.GImages;

public class ProcessImageUtil {
	
	public  static final String _ROOT_DIR = SystemProperties.get(PropsKeys.LIFERAY_HOME)+"/data/resoucefiles/";

	public void saveImage(GImages image,File file){
		try {
			image.setImageId(CounterLocalServiceUtil.increment());
		} catch (SystemException e) {
			image.setImageId(0);
		}
		InputStream is = null;
		try {
			is = new FileInputStream(file);
		} catch (FileNotFoundException e) {
		}
		File destFile = new File(_ROOT_DIR+image.getImageId()+StringPool.PERIOD+FileUtil.getExtension(file.getName()));
		try {
			FileUtil.write(destFile, is);
		} catch (IOException e) {
			
		}
		String imageUrl=destFile.getAbsolutePath();
		String smallImageUrl=imageUrl.substring(0,imageUrl.lastIndexOf("."))+"1"+StringPool.PERIOD+FileUtil.getExtension(file.getName());
		JpegTool j = new JpegTool();
		try {
			j.SetScale(0.6);
			j.SetSmallHeight(200);
			j.doFinal(destFile.getAbsolutePath(),smallImageUrl);
		
		}catch (JpegToolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		image.setImageURL(imageUrl);
		image.setSmallURL(smallImageUrl);
		GImagesLocalServiceUtil.saveImages(image);

		
	}
	public void updateImage(GImages image,File file){
		InputStream is = null;
		try {
			is = new FileInputStream(file);
		} catch (FileNotFoundException e) {
		}
		File destFile = new File(_ROOT_DIR+image.getImageId()+StringPool.PERIOD+FileUtil.getExtension(file.getName()));
		try {
			FileUtil.write(destFile, is);
		} catch (IOException e) {
			
		}
		String imageUrl=destFile.getAbsolutePath();
		String smallImageUrl=imageUrl.substring(0,imageUrl.lastIndexOf("."))+"1"+StringPool.PERIOD+FileUtil.getExtension(file.getName());
		JpegTool j = new JpegTool();
		try {
			//j.SetScale(0.6);
			j.SetSmallWidth(200);
			j.SetSmallHeight(200);
			j.doFinal(destFile.getAbsolutePath(),smallImageUrl);
		
		}catch (JpegToolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		image.setImageURL(imageUrl);
		image.setSmallURL(smallImageUrl);
		GImagesLocalServiceUtil.updateImages(image);
		
	}
}	
