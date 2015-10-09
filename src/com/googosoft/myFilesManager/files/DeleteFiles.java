package com.googosoft.myFilesManager.files;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.googosoft.commons.IUploadImgContants;
import com.googosoft.exception.DBException;
import com.googosoft.zapi.DBHelper;


public class DeleteFiles {
	
	public boolean deleteFiles(HttpServletRequest request,String userid) throws DBException{
		String realPath =request.getRealPath("/")+IUploadImgContants.MYFILEPATH+userid;
		String ids = request.getParameter("P_MYFILE_FILEID_S_WD");
		ids=StringUtils.replace(ids, "'", "");
		for(String id:ids.split(",")){
			String sql = "SELECT T.REALNAME FROM MYFILE T WHERE T.FILEID = '"+id+"' AND USERID='"+userid+"'";
			DBHelper dh =new com.googosoft.zapi.DBHelper();
			Map map =dh.queryForMap(sql);
			String realName = String.valueOf(map.get("REALNAME"));
			System.out.println(realPath+realName);
			File file = new File(realPath+File.separator+realName);
			if(file.exists()){
				file.delete();
				return true;
			}else{
				return false;
			}
		}
		return false;
	}
}
