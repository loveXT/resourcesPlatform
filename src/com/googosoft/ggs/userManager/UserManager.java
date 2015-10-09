package com.googosoft.ggs.userManager;

/**
 * 备份usermanager
 */
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

public class UserManager
/**
 * 反编译更新
 */
{
  private Logger logger = Logger.getLogger(UserManager.class.getName());
  
  public List findPageInfoByUmUser(String departmentId)
    throws ManagerException
  {
    StringBuffer sql = new StringBuffer(" SELECT ");
    sql.append(" t.USERID AS USERID, ");
    sql.append(" t.USERNAME AS USERNAME, ");
    sql.append(" t.LOGINNAME AS LOGINNAME, ");
    //改动处:添加pxxh查询字段
    sql.append(" t.PXXH AS PXXH, ");
    
    sql.append(" t.LOGINPASSWORD AS LOGINPASSWORD ");
    sql.append(" FROM UmUser t ");
    sql.append(" left join umuserdepartment d on d.UMUSERID = t.USERID ");
    sql.append(" where t.USERNAME != 'saas' ");
    if (Validate.noNull(departmentId)) {
      sql.append(" and d.UMDEPARTMENTID = '" + departmentId + "' ");
    }
    sql.append(" ORDER BY t.PXXH ");//更改排序依据
    DBHelper db = new DBHelper();
    List list = null;
    try {
    	list = db.queryForList(sql.toString());
    } catch (DBException e) {
      this.logger.error("查询数据库信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    }
    return list;
  }

  public PageInfo findPageInfoByUmUser(int nowPage, int pageSize, String splitByQuery, HttpServletRequest request, String departmentId) throws ManagerException
  {
    StringBuffer sql = new StringBuffer(" SELECT ");
    sql.append(" t.USERID AS USERID, ");
    sql.append(" t.USERNAME AS USERNAME, ");
    sql.append(" t.LOGINNAME AS LOGINNAME, ");
    //改动处:添加pxxh查询字段
    sql.append(" t.PXXH AS PXXH, ");
    
    sql.append(" t.LOGINPASSWORD AS LOGINPASSWORD ");
    sql.append(" FROM UmUser t ");
    sql.append(" left join umuserdepartment d on d.UMUSERID = t.USERID ");
    sql.append(" where t.USERNAME != 'saas' ");
    if (Validate.noNull(departmentId)) {
      sql.append(" and d.UMDEPARTMENTID = '" + departmentId + "' ");
    }
    PageInfo pageInfo = null;
    try {
      sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
      sql.append(" ORDER BY t.PXXH ");//更改排序依据
      pageInfo = new PageHelper(nowPage, pageSize, sql.toString()).getPageInfo();
    } catch (DBException e) {
      this.logger.error("查询数据库信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    } catch (PageException e) {
      this.logger.error("查询分页信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    } catch (QueryException e) {
      e.printStackTrace();
    }
    return pageInfo;
  }

  public Map findMapByuserId(String userId)
    throws ManagerException
  {
    StringBuffer sql = new StringBuffer(" SELECT * ");
    sql.append(" FROM UmUser t ");
    sql.append(" WHERE t.USERID= '" + userId + "' ");
    DBHelper dbHelper = new DBHelper();
    Map map = null;
    try {
      map = dbHelper.queryForMap(sql.toString());
    } catch (DBException e) {
      this.logger.error("查询数据库信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    }
    return map;
  }

  public boolean validateByLoginName(String loginName) throws ManagerException
  {
    try
    {
      loginName = loginName.trim();
      StringBuffer sb = new StringBuffer();
      sb.append(" select count(*) from UmUser t where t.LOGINNAME = '" + 
        loginName + "' ");
      DBHelper dbHelper = new DBHelper();
      int c = Integer.valueOf(dbHelper.queryForSingleValue(sb.toString())
        .toString()).intValue();

      return (c == 0);
    } catch (NumberFormatException e) {
      this.logger.error("数字转换失败");
      e.printStackTrace();
      throw new ManagerException("数字转换失败" + e);
    } catch (DBException e) {
      this.logger.error("查询数据库信息失败");
      e.printStackTrace();
      throw new ManagerException("查询数据库信息失败" + e);
    }
  }

  public PageInfo findPageInfoBygrouping(int nowPage, int pageSize, String splitByQuery, HttpServletRequest request, String parentId)
    throws ManagerException
  {
    StringBuffer sql = new StringBuffer(" select * from umuser where umuser.userid not in (");
    sql.append("  SELECT  T.USERID AS USERID  ");
    sql.append(" FROM ZCMESSAGECLASSES T  LEFT JOIN UMUSER UU ON T.USERID=UU.USERID  WHERE 1 = 1   ");
    sql.append("  AND T.PARENTID= '" + parentId + "' AND T.PARENTID != T.ID");
    sql.append(")");

    PageInfo pageInfo = null;
    try {
      sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery, request));
      pageInfo = new PageHelper(nowPage, pageSize, sql.toString()).getPageInfo();
    } catch (DBException e) {
      this.logger.error("查询数据库信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    } catch (PageException e) {
      this.logger.error("查询分页信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    } catch (QueryException e) {
      e.printStackTrace();
    }
    return pageInfo;
  }

  public Map findUserInfoById(String userId)
    throws ManagerException
  {
    StringBuffer sql = new StringBuffer();
    sql.append(" SELECT ");
    sql.append(" T.USERID AS USERID, ");
    sql.append(" T.USERNAME AS USERNAME, ");
    sql.append(" T.LOGINNAME AS LOGINNAME, ");
    sql.append(" T.LOGINPASSWORD AS LOGINPASSWORD, ");
    sql.append(" T.SAAS AS SAAS, ");
    sql.append(" T.UTYPE AS UTYPE, ");
    sql.append(" T.PERSONID AS PERSONID, ");
    sql.append(" T.RELATETABLE AS RELATETABLE, ");
    sql.append(" T.RELATEID AS RELATEID, ");
    sql.append(" T.USFZH AS USFZH, ");
    sql.append(" T.PHONE AS PHONE, ");
    sql.append(" DP.UMDEPARTMENTNAME AS UMDEPARTMENTNAME ");
    sql.append(" FROM UmUser t ");
    sql.append(" LEFT JOIN UMUSERDEPARTMENT AP ON t.USERID=AP.UMUSERID");
    sql.append(" LEFT JOIN UMDEPARTMENT DP ON AP.UMDEPARTMENTID=DP.UMDEPARTMENTID");
    sql.append(" WHERE t.USERID= '" + userId + "' ");
    DBHelper dbHelper = new DBHelper();
    Map map = null;
    try {
      map = dbHelper.queryForMap(sql.toString());
    } catch (DBException e) {
      this.logger.error("查询数据库信息失败");
      e.printStackTrace();
      throw new ManagerException(e);
    }
    return map;
  }
}
