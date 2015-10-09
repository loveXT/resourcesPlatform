package com.googosoft.myFilesManager.shedule;

import java.util.List;

import com.googosoft.exception.DBException;
import com.googosoft.zapi.DBHelper;

public class SheduleManager {
	/**
	 * @return
	 * 查询最新的资源信息
	 */
	public List findByNewShedule(){
		StringBuffer sql = new StringBuffer();
		sql.append("select a.*,ROWNUM row_num FROM (select t.REALNAME as REALNAME,t.FILENAME as FILENAME, ");
		sql.append("t.CREATETIME as CREATETIME from FILES t where t.flag = '22' order by t.CREATETIME desc  ) a where ROWNUM<=5 ");
		List list=null;
		try {
			list=new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * @return
	 * 查询优秀资源
	 */
	public List findByGoodShedule(){
		StringBuffer sql=new StringBuffer();
		sql.append("select a.*,ROWNUM row_num FROM(select t.REALNAME as REALNAME, t.CREATETIME as CREATETIME,t.FILENAME as FILENAME ");
		sql.append("from FILES t where t.flag = '22'  and t.ISEXCELLENT = 'T' order by t.createtime desc)a WHERE ROWNUM<=5");
		List list=null;
		try {
			list = new DBHelper().queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
		}
		return list;
	}

}
