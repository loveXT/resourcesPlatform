/*
 * 下午02:50:15
 */
package com.googosoft.ggs.dataManager.normCode;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.googosoft.commons.CacheHelper;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.zapi.DBHelper;

/**
 * author:xuanly
 * 
 */
public class Dict {
	private Logger logger = Logger.getLogger(Dict.class.getName());
	private DBHelper dbHelper = new DBHelper();
	private final String normCode = " SELECT * FROM NORMCODE T LEFT JOIN NORMCODETYPE N ON  T.DMLXID = N.ID WHERE N.DMLXBM = (''{0}'') ORDER BY T.DM ";

	/**
	 * 获取字典分类项分组信息
	 * 
	 * @param name
	 *            字典分类名称
	 * @return 所属该字典分类的列表
	 * @throws DBException
	 */
	public List getDict(String name) throws DBException {
		// 1 验证输入
		if (Validate.isNull(name)) {
			return null;
		}
		// 2 在缓存中提取
		List list = null;
		list = (List) CacheHelper.getCache(name);
		// 2.1 缓存中为空时，进行加载
		if (Validate.isNull(list)) {
			String normCodeSql = MessageFormat.format(normCode, name);
			List normCodeList = null;
			try {
				normCodeList = dbHelper.queryForList(normCodeSql);
			} catch (DBException e) {
				logger.error("加载缓存项失败" + e);
				throw new DBException("加载缓存项失败" + e);
			}
			// 2.1.1 加载数据库为空，赋值为空集合
			if (Validate.isNull(normCodeList)) {
				normCodeList = new ArrayList();
			}
			// 2.1.2 存入缓存
			CacheHelper.setCache(name, normCodeList);
		}
		// 2.2 在缓存中重新提取
		list = (List) CacheHelper.getCache(name);
		return list;
	}

	/**
	 * 获取字典项的值
	 * 
	 * @param parentName
	 *            字典项类别名称
	 * @param childName
	 *            字典项名称
	 * @return 字典项值
	 * @throws DBException
	 */
	public String getDict(String parentName, String childName)
			throws DBException {
		// 1 验证输入
		if (Validate.isNull(parentName) || Validate.isNull(childName)) {
			return null;
		}
		// 2 加载字典项
		getDict(parentName);
		// 3 在缓存中获取字典类别集合
		List list = (List) CacheHelper.getCache(parentName);
		// 4 遍历字典项类别集合，获取字典项值进行返回
		Map map = null;
		for (int i = 0; i < list.size(); i++) {
			map = (Map) list.get(i);
			if (childName.equals(map.get("DM"))) {
				return Validate.isNullToDefault(map.get("MC"), "").toString();
			}
		}
		// 5 不存在字典项名称，则返回null
		return null;
	}
}
