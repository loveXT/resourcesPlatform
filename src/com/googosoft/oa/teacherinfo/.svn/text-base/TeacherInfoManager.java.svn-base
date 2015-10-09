package com.googosoft.oa.teacherinfo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.exception.TreeException;
import com.googosoft.ggs.saasManager.SaasManager;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;
import com.googosoft.zapi.TreeHelper;

public class TeacherInfoManager {

	private static Logger logger = Logger.getLogger(TeacherInfoManager.class);

	/**
	 * @param args
	 * @throws CUMException
	 */
	public PageInfo findPageInfoByTEACHERSINFO(int nowPage, int pageSize,
			String splitByQuery, HttpServletRequest request,String status)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		String deptId = request.getParameter("deptId");
		String userid=request.getSession().getAttribute("USERIDBYLOGIN")+"";
		sql.append(" SELECT ");
		sql.append(" T.SFZJH AS SFZJH, ");// 身份证件号
		sql.append(" T.ZP AS ZP, ");// 照片
		sql.append(" T.ID AS ID, ");// 主键
		sql.append(" T.ORGANIZATIONID AS ORGANIZATIONID, ");// 部门ID
		sql.append(" D.UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ");// 部门
		sql.append(" T.LXRQ AS LXRQ, ");// 来校日期
		sql.append(" T.JZBM AS JZBM, ");// 兼职部门ID
		sql.append(" T.RKZKM AS RKZKM, ");// 现任学科
		sql.append(" T.BZLBM AS BZLBM, ");// 编制类别
		sql.append(" T.XBM AS XBM, ");// 性别
		sql.append(" T.ZZMMM AS ZZMMM, ");// 政治面貌
		sql.append(" T.JG AS JG, ");// 籍贯
		sql.append(" T.CREATETIME AS CREATETIME, ");// 创建时间
		sql.append(" T.CSRQ AS CSRQ, ");// 出生日期
		sql.append(" T.XM AS XM, ");// 姓名
		sql.append(" T.MZM AS MZM, ");// 民族
		sql.append(" T.ZGXLM AS ZGXLM, ");// 最高学历
		sql.append(" T.WHCDM AS WHCDM, ");// 文化程度
		sql.append(" T.JZGLBM AS JZGLBM, ");// 教职工类别
		sql.append(" T.CJGZNY AS CJGZNY, ");// 参加工作年月
		sql.append(" T.DABH AS DABH, ");// 档案编号
		sql.append(" T.CREATEACCOUNT AS CREATEACCOUNT, ");// 创建人
		sql.append(" T.APPENDADDRESS AS APPENDADDRESS, ");// 现住地址
		sql.append(" T.LXDH AS LXDH, ");// 联系电话
		sql.append(" T.HOMEADDRESS AS HOMEADDRESS, ");// 家庭地址
		sql.append(" T.CLASSLEADER AS CLASSLEADER, ");// 是否班主任
		sql.append(" T.EMAIL AS EMAIL, ");// Email
		sql.append(" T.WORKTIME AS WORKTIME, ");// 参加工作时间
		sql.append(" T.RDTIME AS RDTIME, ");// 入党时间
		sql.append(" T.BGDH AS BGDH, ");// 办公电话
		sql.append(" T.QQ AS QQ, ");// QQ
		sql.append(" T.ZGQK AS ZGQK, ");// 在岗情况
		sql.append(" T.CJGZDW AS CJGZDW, ");// 参加工作单位
		sql.append(" T.ZYJSZC AS ZYJSZC, ");// 现专业技术职称
		sql.append(" T.PDTIME AS PDTIME, ");// 评定时间
		sql.append(" T.SPTIME AS SPTIME, ");// 首聘现技术职务时间
		sql.append(" T.PRNX AS PRNX, ");// 聘任现技术职务年限
		sql.append(" T.JSJSP AS JSJSP, ");// 计算机水平
		sql.append(" T.FJSZGZ AS FJSZGZ, ");// 获得非教师系列职业资格证书情况
		sql.append(" T.WYSP AS WYSP, ");// 外语水平
		sql.append(" T.JSZGZLBBH AS JSZGZLBBH, ");// 教师资格证书专业类别及编号
		sql.append(" T.SHJZ AS SHJZ, ");//社会兼职
		sql.append(" T.SZDZB AS SZDZB, ");// 所在党支部
		sql.append(" T.STATUS AS STATUS, ");// 状态
		sql.append(" T.BRSF AS BRSF, ");// 本人身份
		sql.append(" T.SSJYZ AS SSJYZ, ");// 所属教研组
		sql.append(" T.XRZW AS XRZW, ");// 现任职务
		sql.append(" T.RJZY AS RJZY, ");// 任教专业
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME, ");// 任教专业
		sql.append(" T.JSZGZSLB AS JSZGZSLB, ");// 教师职格证书类别
		sql.append(" T.JSZGZSQDSJ AS JSZGZSQDSJ, ");// 教师职格证书取得时间
		sql.append(" T.JSZGZSBH AS JSZGZSBH, ");// 教师资格证书编号
		sql.append(" T.FJSZGZSMC AS FJSZGZSMC, ");// 非教师职业资格证书名称
		sql.append(" T.FJSZGZSQDSJ AS FJSZGZSQDSJ, ");// 非教师职业资格证书取得时间
		sql.append(" T.FJSZGZSBH AS FJSZGZSBH, ");// 非教师职业资格证书编号
		sql.append(" DE.UMDEPARTMENTNAME AS JZDEPARTMENTNAME ");
		sql.append(" FROM TEACHERSINFO T ");
		sql.append(" LEFT JOIN UMDEPARTMENT D ON D.UMDEPARTMENTID = T.ORGANIZATIONID ");
		sql.append(" LEFT JOIN UMDEPARTMENT DE ON DE.UMDEPARTMENTID = T.JZBM ");
		sql.append(" LEFT JOIN MAJOR M ON M.MAJOR_ID = T.RJZY ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND T.STATUS = '"+status+"' ");
		if("1".equals(status)){
		sql.append(" AND T.ORGANIZATIONID IN (SELECT UMDEPARTMENTID FROM UMUSERDEPARTMENT WHERE UMUSERID='"+userid+"') ");
		}
		if (Validate.noNull(deptId)) {
			sql.append(" AND T.ORGANIZATIONID='" + deptId + "' ");
		}
		PageInfo pageInfo = null;
		try {
			sql.append(new QueryHelper().getQuerySqlByRequset(splitByQuery,
					request));
			pageInfo = new PageHelper(nowPage, pageSize, sql.toString())
					.getPageInfo();
		} catch (QueryException e) {
			logger.error("组装查询语句where条件的and语句失败\n" + e);
			throw new ManagerException("组装查询语句where条件的and语句失败\n" + e);
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (PageException e) {
			logger.error("查询分页信息失败\n" + e);
			throw new ManagerException("查询分页信息失败\n" + e);
		}
		return pageInfo;
	}
    
	public List findTreeByTEACHERSINFO(HttpServletRequest request)
			throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.YJFX AS YJFX, ");
		sql.append(" T.SFZJQYRQ AS SFZJQYRQ, ");
		sql.append(" T.SFZJH AS SFZJH, ");
		sql.append(" T.ZC AS ZC, ");
		sql.append(" T.YJXKM AS YJXKM, ");
		sql.append(" T.ZP AS ZP, ");
		sql.append(" T.XQH AS XQH, ");
		sql.append(" T.ZJXYM AS ZJXYM, ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.GJDQM AS GJDQM, ");
		sql.append(" T.ORGANIZATIONID AS ORGANIZATIONID, ");
		sql.append(" T.LXRQ AS LXRQ, ");
		sql.append(" T.SFZJLXM AS SFZJLXM, ");
		sql.append(" T.RKZKM AS RKZKM, ");
		sql.append(" T.XXM AS XXM, ");
		sql.append(" T.BZLBM AS BZLBM, ");
		sql.append(" T.GATQWM AS GATQWM, ");
		sql.append(" T.SFZJYXQ AS SFZJYXQ, ");
		sql.append(" T.SFZJTYRQ AS SFZJTYRQ, ");
		sql.append(" T.XBM AS XBM, ");
		sql.append(" T.DELETEFLAG AS DELETEFLAG, ");
		sql.append(" T.ZZMMM AS ZZMMM, ");
		sql.append(" T.CSDM AS CSDM, ");
		sql.append(" T.DAWB AS DAWB, ");
		sql.append(" T.JG AS JG, ");
		sql.append(" T.QXRQ AS QXRQ, ");
		sql.append(" T.YWXM AS YWXM, ");
		sql.append(" T.CREATEORGANIZATION AS CREATEORGANIZATION, ");
		sql.append(" T.CREATETIME AS CREATETIME, ");
		sql.append(" T.CSRQ AS CSRQ, ");
		sql.append(" T.XM AS XM, ");
		sql.append(" T.MZM AS MZM, ");
		sql.append(" T.EDITTIME AS EDITTIME, ");
		sql.append(" T.ZGXLM AS ZGXLM, ");
		sql.append(" T.WHCDM AS WHCDM, ");
		sql.append(" T.JKZKM AS JKZKM, ");
		sql.append(" T.DQZTM AS DQZTM, ");
		sql.append(" T.JZGLBM AS JZGLBM, ");
		sql.append(" T.TC AS TC, ");
		sql.append(" T.XKLBM AS XKLBM, ");
		sql.append(" T.CYM AS CYM, ");
		sql.append(" T.XMPY AS XMPY, ");
		sql.append(" T.CJGZNY AS CJGZNY, ");
		sql.append(" T.DABH AS DABH, ");
		sql.append(" T.EJXKM AS EJXKM, ");
		sql.append(" T.CJNY AS CJNY, ");
		sql.append(" T.CREATEACCOUNT AS CREATEACCOUNT, ");
		sql.append(" T.HYZKM AS HYZKM, ");
		sql.append(" T.GH AS GH, ");
		sql.append(" T.APPENDADDRESS AS APPENDADDRESS, ");
		sql.append(" T.LXDH AS LXDH, ");
		sql.append(" T.HOMEADDRESS AS HOMEADDRESS, ");
		sql.append(" T.VERIFY AS VERIFY, ");
		sql.append(" T.JOB AS JOB, ");
		sql.append(" T.GRADUATION AS GRADUATION, ");
		sql.append(" T.CLASSLEADER AS CLASSLEADER, ");
		sql.append(" T.EMAIL AS EMAIL, ");
		sql.append(" T.WORKTIME AS WORKTIME, ");
		sql.append(" T.SORTVALUE AS SORTVALUE, ");
		sql.append(" T.FILESIZE AS FILESIZE ");
		sql.append(" FROM TEACHERSINFO T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		TreeHelper treeHelper = new TreeHelper();
		List list = null;
		try {
			sql.append(SaasManager.getDataSqlByInitSql("T", request));
			list = dbHelper.queryForList(sql.toString());
			treeHelper.addTreeList(list, "ID", "PARENTID", "NAME");
			list = treeHelper.getTreeList();
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		} catch (TreeException e) {
			logger.error("组装树失败\n" + e);
			throw new ManagerException("组装树失败\n" + e);
		}
		return list;
	}

	public Map findMapByID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.SFZJH AS SFZJH, ");// 身份证件号
		sql.append(" T.ZP AS ZP, ");// 照片
		sql.append(" T.ID AS ID, ");// 主键
		sql.append(" T.ORGANIZATIONID AS ORGANIZATIONID, ");// 部门ID
		sql.append(" D.UMDEPARTMENTNAME AS UMDEPARTMENTNAME, ");// 部门
		sql.append(" T.LXRQ AS LXRQ, ");// 来校日期
		sql.append(" T.JZBM AS JZBM, ");// 兼职部门ID
		sql.append(" T.RKZKM AS RKZKM, ");// 现任学科
		sql.append(" T.BZLBM AS BZLBM, ");// 编制类别
		sql.append(" T.XBM AS XBM, ");// 性别
		sql.append(" T.ZZMMM AS ZZMMM, ");// 政治面貌
		sql.append(" T.JG AS JG, ");// 籍贯
		sql.append(" T.CREATETIME AS CREATETIME, ");// 创建时间
		sql.append(" T.CSRQ AS CSRQ, ");// 出生日期
		sql.append(" T.XM AS XM, ");// 姓名
		sql.append(" T.MZM AS MZM, ");// 民族
		sql.append(" T.ZGXLM AS ZGXLM, ");// 最高学历
		sql.append(" T.WHCDM AS WHCDM, ");// 文化程度
		sql.append(" T.JZGLBM AS JZGLBM, ");// 教职工类别
		sql.append(" T.CJGZNY AS CJGZNY, ");// 参加工作年月
		sql.append(" T.DABH AS DABH, ");// 档案编号
		sql.append(" T.CREATEACCOUNT AS CREATEACCOUNT, ");// 创建人
		sql.append(" T.APPENDADDRESS AS APPENDADDRESS, ");// 现住地址
		sql.append(" T.LXDH AS LXDH, ");// 联系电话
		sql.append(" T.HOMEADDRESS AS HOMEADDRESS, ");// 家庭地址
		sql.append(" T.CLASSLEADER AS CLASSLEADER, ");// 是否班主任
		sql.append(" T.EMAIL AS EMAIL, ");// Email
		sql.append(" T.WORKTIME AS WORKTIME, ");// 参加工作时间
		sql.append(" T.RDTIME AS RDTIME, ");// 入党时间
		sql.append(" T.BGDH AS BGDH, ");// 办公电话
		sql.append(" T.QQ AS QQ, ");// QQ
		sql.append(" T.ZGQK AS ZGQK, ");// 在岗情况
		sql.append(" T.CJGZDW AS CJGZDW, ");// 参加工作单位
		sql.append(" T.ZYJSZC AS ZYJSZC, ");// 现专业技术职称
		sql.append(" T.PDTIME AS PDTIME, ");// 评定时间
		sql.append(" T.SPTIME AS SPTIME, ");// 首聘现技术职务时间
		sql.append(" T.PRNX AS PRNX, ");// 聘任现技术职务年限
		sql.append(" T.JSJSP AS JSJSP, ");// 计算机水平
		sql.append(" T.FJSZGZ AS FJSZGZ, ");// 获得非教师系列职业资格证书情况
		sql.append(" T.WYSP AS WYSP, ");// 外语水平
		sql.append(" T.JSZGZLBBH AS JSZGZLBBH, ");// 教师资格证书专业类别及编号
		sql.append(" T.SHJZ AS SHJZ, ");//社会兼职
		sql.append(" T.SZDZB AS SZDZB, ");// 所在党支部
		sql.append(" T.STATUS AS STATUS, ");// 审核状态
		sql.append(" T.BRSF AS BRSF, ");// 本人身份
		sql.append(" T.SSJYZ AS SSJYZ, ");// 所属教研组
		sql.append(" T.XRZW AS XRZW, ");// 现任职务
		sql.append(" T.RJZY AS RJZY, ");// 任教专业
		sql.append(" M.MAJOR_NAME AS MAJOR_NAME, ");// 任教专业
		sql.append(" T.JSZGZSLB AS JSZGZSLB, ");// 教师职格证书类别
		sql.append(" T.JSZGZSQDSJ AS JSZGZSQDSJ, ");// 教师职格证书取得时间
		sql.append(" T.JSZGZSBH AS JSZGZSBH, ");// 教师资格证书编号
		sql.append(" T.FJSZGZSMC AS FJSZGZSMC, ");// 非教师职业资格证书名称
		sql.append(" T.FJSZGZSQDSJ AS FJSZGZSQDSJ, ");// 非教师职业资格证书取得时间
		sql.append(" T.FJSZGZSBH AS FJSZGZSBH, ");// 非教师职业资格证书编号
		sql.append(" DE.UMDEPARTMENTNAME AS JZDEPARTMENTNAME ");
		sql.append(" FROM TEACHERSINFO T ");
		sql.append(" LEFT JOIN UMDEPARTMENT D ON D.UMDEPARTMENTID = T.ORGANIZATIONID ");
		sql.append(" LEFT JOIN UMDEPARTMENT DE ON DE.UMDEPARTMENTID = T.JZBM ");
		sql.append(" LEFT JOIN MAJOR M ON M.MAJOR_ID = T.RJZY ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND t.ID= '" + ID + "' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	/**
	 * 
	 * @param Id
	 * @return
	 */
	public boolean IdIn(String Id){
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) count from teachersinfo t where t.id = '"+Id+"'");
		try {
			String obj = (String)new DBHelper().queryForSingleValue(sql.toString());
			int count = Integer.parseInt(obj);
			if(count>=1){
				return true;
			}else{
				return false;
			}
		} catch (DBException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List findListByMAJOR(){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.MAJOR_ID AS MAJOR_ID, ");
		sql.append(" T.MAJOR_NAME AS MAJOR_NAME ");
		sql.append(" FROM MAJOR T ");
		sql.append(" WHERE 1 = 1 ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return list;
	}
	
	public Map findMapByGID(String ID) throws ManagerException {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT T.GID AS GID," +
				"T.GH AS GH," +
				"T.XM AS XM," +
				"T.CSRQ AS CSRQ," +
				"T.XBM AS XBM," +
				"T.MZM AS MZM," +
				"T.LXRQ AS LXRQ," +
				"T.JG AS JG," +
				"T.CJGZNY AS CJGZNY," +
				"T.SFZH AS SFZH," +
				"T.LXDH AS LXDH," +
				"T.EMAIL AS EMAIL," +
				"T.ZZMM AS ZZMM," +
				"T.ORGANIZATION_ID AS ORGANIZATION_ID" +
				" FROM TEACHERINFO T WHERE T.GID = '"+ID+"' ");
		DBHelper dbHelper = new DBHelper();
		Map map = null;
		try {
			map = dbHelper.queryForMap(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return map;
	}
	//查询字典表
	public List findMapByNormCode(String bm){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" T.ID AS ID, ");
		sql.append(" T.DMLXBM AS DMLXBM, ");
		sql.append(" N.DM AS DM, ");
		sql.append(" N.ID AS DMID, ");
		sql.append(" N.MC AS MC ");
		sql.append(" FROM NORMCODETYPE T ");
		sql.append(" LEFT JOIN NORMCODE N ON N.DMLXID = T.ID ");
		sql.append(" WHERE 1=1 ");
		sql.append(" AND T.DMLXBM ='"+bm+"' ");
		sql.append(" ORDER BY N.DM ");
		DBHelper dbHelper = new DBHelper();
		List list = null;
		try {
			list = dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			e.printStackTrace();
			logger.error("查询失败!", e);
		}
		return list;
	}
	
	//查询字典表
		public Map findMapByNormCode(String bm,String DM){
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			sql.append(" T.ID AS ID, ");
			sql.append(" T.DMLXBM AS DMLXBM, ");
			sql.append(" N.DM AS DM, ");
			sql.append(" N.ID AS DMID, ");
			sql.append(" N.MC AS MC ");
			sql.append(" FROM NORMCODETYPE T ");
			sql.append(" LEFT JOIN NORMCODE N ON N.DMLXID = T.ID ");
			sql.append(" WHERE 1=1 ");
			sql.append(" AND T.DMLXBM ='"+bm+"' ");
			sql.append(" AND N.DM='"+DM+"' ");
			DBHelper dbHelper = new DBHelper();
			Map map = null;
			try {
				map = dbHelper.queryForMap(sql.toString());
			} catch (DBException e) {
				e.printStackTrace();
				logger.error("查询失败!", e);
			}
			return map;
		}
	
}
