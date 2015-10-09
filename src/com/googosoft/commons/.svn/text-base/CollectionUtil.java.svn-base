/*
 * CollectionUtil.java 2013-3-20 上午08:29:58 <br>
 * Project : CUD 0.1<br>
 * Copyright (c) 2013 GoogoSoft Digital Technology Ltd.
 * (http://www.googosoft.com) All Rights Reserved. This software is the
 * confidential and proprietary information of GoogoSoft Digital Technology
 * Ltd.("Confidential Information"). You shall not disclose such Confidential
 * Information and shall user it only in accordance with the terms of the
 * license agreement you entered into with GoogoSoft.
 * 
 */

package com.googosoft.commons;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import com.googosoft.exception.ManagerException;
import com.googosoft.oa.message.classes.UserManager;

/**
 * 集合工具类。
 * 
 * @since 1.5
 * @version 0.1
 * 
 */
public class CollectionUtil {

	public static boolean listIsNull(List list){
		if(list == null || list.size() < 1){
			return true;
		}else{
			return false;
		}
		
	}
	
	public static boolean listIsNotNull(List list){
		return !listIsNull(list);
	}
	
	public static boolean mapIsNull(Map map){
		if(map == null || map.size() < 1){
			return true;
		}else{
			return false;
		}
	}
	
	public static boolean mapIsNotNull(Map map){
		return !mapIsNull(map);
	}
	
	/**
	 * 移除集合中的空值。
	 * 
	 * @param maps 
	 * 			list集合
	 */
	public static void listRemoveNull(List<Map<String, Object>> maps ){
		if(CollectionUtil.listIsNull(maps)){
			return;
		}
		for (int i = 0; i < maps.size(); i++) {
			Map<String, Object> map = maps.get(i);
			mapRemoveNull(map);
		}
	}
	
	/**
	 * 移除集合中的空值。
	 * 
	 * @param map
	 * 			map集合
	 */
	public static void mapRemoveNull(Map<String, Object> map){
		Entry<String, Object> entry;
		if(CollectionUtil.mapIsNull(map)){
			return;
		}
		Iterator<Entry<String, Object>> entrys = map.entrySet().iterator();
		while(entrys.hasNext()){
			entry = entrys.next();
			Object value = entry.getValue();
			if(value == null || "null".equals(value) || value.toString().trim().length() < 1){
				map.put(entry.getKey(), "");
			}
		}
	}
	

	/**
	 * <b>方法作用：</b> 将list转化成map。
	 * <br><br>
	 * <b>详细说明：</b> 将其中的指定值作为key，要获取的值作为value。
	 * <br><br>
	 * <b>举例说明：</b> StringUtil.listForMap(List< Map< String, Object>>, String, String);
	 *
	 * <br><br>
	 * @param classes
	 * 			待转换的集合
	 * @param id 
	 * 			集合list中的map的一个key值作为id，从该key值获得的value作为转换后的map的key
	 * @param name 
	 * 			集合list中的map的一个key值作为name，从该key值获得的value作为转换后的map的value
	 * @return Map<String,Object>
	 */
	public static Map<String, Object> listForMap(List<Map<String, Object>> classes, String id, String name) {
		
		listRemoveNull(classes);
		
		Map<String, Object> condition = new HashMap<String, Object>();
		Iterator<Map<String, Object>> iterator = classes.iterator();
		while(iterator.hasNext()){
			Map<String, Object> next = iterator.next();
			Object idValue = next.get(id);
			if(StringUtil.isNull(idValue)){
				continue;
			}
			if(StringUtil.isNull(condition.get(idValue))){
				condition.put(idValue.toString(), next.get(name));
			}else{
				condition.put(idValue.toString(), condition.get(idValue) + "|" + next.get(name));
			}
		}
		return condition;
	}
	

	
	/**
	 * 获得人员map集合。<br>
	 * key为人员id，value为人员名。
	 * 
	 * @return
	 */
	public static Map<String, Object> getUserMap(){
		UserManager userManager = new UserManager();
		List<Map<String, Object>> usersList = userManager.findUser();
		return listForMap(usersList, "USERID", "USERNAME");
	}
	
	
	
	
	/**
	 * 根据角色ids，和角色集合，查询对应角色的名称，
	 * @param ids
	 * 			角色ids。
	 * @param listNames
	 * 			
	 * @return
	 * 			角色名，中间用","隔开。
	 */
	public static String getRoleNames(String ids, List<Map<String, Object>> listNames){
		return getNames(ids, listNames, "ROLEID", "ROLENAME");
	}
	
	/**
	 * 根据ids在指定的listNames的指定的columnName中查找，获得columnName1中的值。
	 * 
	 * @param ids
	 * 			待查询的ids。
	 * @param listNames
	 * 			ids查询的集合。
	 * @param columnName
	 * 			ids存在的key。
	 * @param columnName1
	 * 			id对应值所在key。
	 * @return
	 * 			columnName1的值，中间用","隔开。
	 */
	public static String getNames(String ids, List<Map<String, Object>> listNames, String columnName, String columnName1){
		if(StringUtil.isNull(ids) || listNames == null || listNames.size() < 1 || StringUtil.isNull(columnName)){
			return "";
		}
		String[] idArray = ids.split(",");
		String name = "";
		// 遍历id字符串。
		for(int i = 0 ; i < idArray.length ; i++ ){
			String id = idArray[i];
			// 遍历是否有匹配的id，返回名称。
			Iterator<Map<String, Object>> listIterator = listNames.iterator();
			while(listIterator.hasNext()){
				Map<String, Object> names = listIterator.next();
				Object value = names.get(columnName);
				if(StringUtil.isNotNull(value) && value.equals(id)){
					name += "," + StringUtil.objToString(names.get(columnName1));
					break;
				}
			}
		}
		if(name.trim().length() > 1){
			return name.trim().substring(1);
		}else{
			return "";
		}
	}
	
	/**
	 * 把字符串数组转换成指定分隔符的字符串。
	 * 
	 * @param strArray
	 * @param split
	 * @return
	 */
	public static String arrayToString(String[] strArray, String split){
		if(strArray==null || strArray.length < 1){
			return "";
		}
		
		StringBuffer str = new StringBuffer();
		for (int i = 0; i < strArray.length; i++) {
			String sub = strArray[i];
			if(StringUtil.isNotNull(sub)){
				if(StringUtil.isNotNull(str)){
					str.append(split);
				}
				str.append(sub);
			}
		}
		
		return str.toString();
	}
}
