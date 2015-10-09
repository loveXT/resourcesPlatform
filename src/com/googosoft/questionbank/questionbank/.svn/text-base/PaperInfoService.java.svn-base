package com.googosoft.questionbank.questionbank;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import oracle.jdbc.OracleTypes;

import org.apache.log4j.Logger;

import com.googosoft.commons.ISessionContants;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.questionbank.framework.util.CodeHelper;
import com.googosoft.questionbank.util.ParamUtil;
import com.googosoft.zapi.DBHelper;

public class PaperInfoService {
	/**
	 * 保存组卷条件
	 * @param request
	 * @throws DBException
	 * @throws SQLException
	 */
	public void savePaperInfo(HttpServletRequest request) {
		String paperId=request.getParameter("P=PAPER-1=PAPER_ID=S=P");
		String chapterPointId=request.getParameter("chapterPointId");
		String sassid =(String) request.getSession().getAttribute(ISessionContants.SAAS);
		String[] chapterPointIds = chapterPointId.split(",");
		DBHelper dh = new DBHelper(); 
		if(chapterPointIds.length>0){
			for(int i=0;i<chapterPointIds.length;i++){
				String chapterId = chapterPointIds[i].substring(0,32);
				String pointId = chapterPointIds[i].substring(32);
				try {
					dh.execute("insert into chapter_point(item_id,paper_id,chapter_id,point_id,saas) values('"+CodeHelper.createUUID()+"','"+paperId+"','"+chapterId+"','"+pointId+"','"+sassid+"')");
				} catch (DBException e) {
					_log.error("更新失败，检查输入条件是否正确");
				} catch (SQLException e) {
					_log.error("更新失败，检查输入条件是否正确");
				}
			}
		}
		int type_amount = ParamUtil.getInt(request,"type_amount");
		for(int i=0;i<type_amount;i++){
			StringBuffer typeSb = new StringBuffer("insert into question_type(item_id,paper_id,type_id,question_score,question_amount) values('");
			String type_item_id = CodeHelper.createUUID();
			int question_amount =ParamUtil.getInt(request, "question_amount-"+i);
			int question_score  =ParamUtil.getInt(request,"question_score-"+i) ;
			String type_id =request.getParameter("type_id-"+i);
			if(question_amount<=0){
				continue ;
			}else{
				//增加难易程度
				float tempN = ParamUtil.getFloat(request,"complexity-"+i+"-n");
				float tempZ = ParamUtil.getFloat(request,"complexity-"+i+"-z");
				float tempY = ParamUtil.getFloat(request,"complexity-"+i+"-y");
				float nzy[]= null;
				if(tempN!=0||tempZ!=0||tempY!=0){
					//数组元素分别代表难中易比例
					nzy =new float[]{tempN/(tempN+tempZ+tempY),tempZ/(tempN+tempZ+tempY),tempY/(tempN+tempZ+tempY)};
				}else{
					return ;
				}
				String complexity[] ={"N","Z","Y"};
				int amount =question_amount-(int)(question_amount*nzy[0]+(int)question_amount*nzy[1]);
				typeSb.append(type_item_id+"','");
				typeSb.append(paperId+"','");
				typeSb.append(type_id+"',");
				typeSb.append(question_score+",");
				typeSb.append(question_amount+")");
				try {
					dh.execute(typeSb.toString());
				} catch (DBException e) {
					_log.error("更新失败，检查输入条件是否正确");
				} catch (SQLException e) {
					_log.error("更新失败，检查输入条件是否正确");
				}
				for(int j=0;j<nzy.length;j++){
					StringBuffer comSb  = new StringBuffer("INSERT INTO COMPLEXITY(ITEM_ID,TYPE_ITEM_ID,PERCENT,QUESTION_AMOUNT,COMPLEXITY,TYPE_ID,PAPER_ID) VALUES('");
					comSb.append(CodeHelper.createUUID()+"','");
					comSb.append(type_item_id+"',");
					comSb.append(nzy[j]+",");
					if(j<2){
						comSb.append((int)(nzy[j]*question_amount)+",'");

					}else{
						comSb.append(amount+",'");
					}
					comSb.append(complexity[j]+"','");
					comSb.append(type_id+"','");
					comSb.append(paperId+"')");
					try {
						dh.execute(comSb.toString());
					} catch (DBException e) {
						_log.error("更新失败，检查输入条件是否正确");
					} catch (SQLException e) {
						_log.error("更新失败，检查输入条件是否正确");
					}
				}
			}
		}
	}
	/**
	 * 删除组卷条件
	 * @param request
	 * @throws DBException
	 * @throws SQLException
	 */
	public void deletePaperInfo(HttpServletRequest request){
		String paperIds=request.getParameter("paperIds");
		String idArray[] = paperIds.split(",");
		DBHelper dh = new DBHelper();
		for(String paper_id:idArray){
			try {
				dh.execute("delete from complexity where paper_id='"+paper_id+"'");
			} catch (DBException e) {
				_log.error("更新失败，检查输入条件是否正确");
			} catch (SQLException e) {
				_log.error("更新失败，检查输入条件是否正确");

			}
			try {
				dh.execute("delete from question_type where paper_id='"+paper_id+"'");
			} catch (DBException e) {
				_log.error("更新失败，检查输入条件是否正确");
			} catch (SQLException e) {
				_log.error("更新失败，检查输入条件是否正确");

			}
			try {
				dh.execute("delete from chapter_point where paper_id='"+paper_id+"'");
			} catch (DBException e) {
				_log.error("更新失败，检查输入条件是否正确");
			} catch (SQLException e) {
				_log.error("更新失败，检查输入条件是否正确");
			}
			Map map = new HashMap();
				try {
					map=dh.queryForMap("select p.issuccess as issuccess  from paper p where paper_id='"+paper_id+"'");
					if("0".equals(map.get("ISSUCCESS").toString())){
						try {
							dh.execute("delete from paper where paper_id ='"+paper_id+"'");
						} catch (SQLException e) {
							_log.error("删除试卷信息失败");
						}
					}else{
						try {
							dh.execute("update  paper p set p.paper_status=0 where paper_id='"+paper_id+"'");
						} catch (SQLException e) {
							_log.error("更新失败，检查输入条件是否正确");
						}
					}
				} catch (DBException e1) {
			}
		}
	}
	/**
	 * 删除试卷具体信息
	 * @param paperIDs
	 * @return
	 */
	public boolean deletePaperConditionByPaperId(String paperIDs) {
		boolean bool = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM PAPERQUESTION WHERE PAPERID IN  ('"+paperIDs+"')");
		try {
			DBHelper dbHelper = new DBHelper();
			dbHelper.execute(sql.toString());
			bool = true;
		} catch (DBException e) {
			_log.error("删除试卷信息失败\n"+e);
			bool = false;
		} catch (SQLException e) {
			_log.error("删除试卷sql错误\n"+e);
			bool = false;
		}
		return bool;
	}

	/**
	 * 删除试卷
	 * @param request
	 * @throws DBException
	 * @throws SQLException
	 */
	public boolean deletePaperInfoByPaperId(String paperIDs) {
		boolean bool = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from paper where PAPER_ID in ('"+paperIDs+"')");
		try {
			DBHelper dbHelper = new DBHelper();
			dbHelper.execute(sql.toString());
			bool = true;
		} catch (DBException e) {
			_log.error("删除试卷信息失败\n"+e);
			bool = false;
		} catch (SQLException e) {
			_log.error("删除试卷sql错误\n"+e);
			bool = false;
		}
		return bool;
//		String paperIds=request.getParameter("paperIds");
//		String idArray[] = paperIds.split(",");
//		DBHelper dh = new DBHelper();
//		for(String paper_id:idArray){
//			Map map = new HashMap();
//			try {
//				map=dh.queryForMap("select p.paper_status as paper_status  from paper p where paper_id='"+paper_id+"'");
//				if("0".equals(map.get("PAPER_STATUS").toString())){
//					try {
//						dh.execute("delete from paper where paper_id ='"+paper_id+"'");
//					} catch (SQLException e) {
//						_log.error("删除试卷信息失败");
//					}
//				}else{
//					try {
//						dh.execute("update paper p set p.paper_content='',p.issuccess=0 where paper_id='"+paper_id+"'");
//					} catch (DBException e) {
//						_log.error("更新失败，检查输入条件是否正确");
//					} catch (SQLException e) {
//						_log.error("更新失败，检查输入条件是否正确");
//					}
//				}
//			} catch (DBException e1) {
//				_log.error("查询失败，请检查sql语句是否正确");
//			}
//			
//		}
	}
	/**
	 * 修改组卷条件相关信息
	 * @param request
	 */
	public void updatePaperinfo(HttpServletRequest request){
		String paperId=request.getParameter("P=PAPER-1=PAPER_ID=S=WU");
		String chapterPointId=request.getParameter("chapterPointId");
		String sassid =(String) request.getSession().getAttribute(ISessionContants.SAAS);
		String[] chapterPointIds = chapterPointId.split(",");
		DBHelper dh = new DBHelper(); 
		try {
			dh.execute("delete from chapter_point where paper_id='"+paperId+"'");
		} catch (DBException e2) {
			_log.error("删除章节失败");
		} catch (SQLException e2) {
			_log.error("删除章节失败");
		}
		try {
			dh.execute("delete from complexity where paper_id='"+paperId+"'");
		} catch (DBException e2) {
			_log.error("删除难易程度失败");
		} catch (SQLException e2) {
			_log.error("删除难易程度失败");
		}
		try {
			dh.execute("delete from question_type where paper_id='"+paperId+"'");
		} catch (DBException e3) {
			_log.error("试卷中试题类型失败");
		} catch (SQLException e3) {
			_log.error("试卷中试题类型失败");
		}
		if(chapterPointIds.length>0){
			for(int i=0;i<chapterPointIds.length;i++){
				String chapterId = chapterPointIds[i].substring(0,32);
				String pointId = chapterPointIds[i].substring(32);
					try {
						dh.execute("insert into chapter_point(item_id,paper_id,chapter_id,point_id,saas) values('"+CodeHelper.createUUID()+"','"+paperId+"','"+chapterId+"','"+pointId+"','"+sassid+"')");
					} catch (DBException e) {
						_log.error("更新失败，检查输入条件是否正确");
					} catch (SQLException e) {
						_log.error("更新失败，检查输入条件是否正确");
					}
			}
		}
		int type_amount = ParamUtil.getInt(request,"type_amount");
		for(int i=0;i<type_amount;i++){
			StringBuffer typeSb = new StringBuffer("insert into question_type(item_id,paper_id,type_id,question_score,question_amount) values('");
			String type_item_id = CodeHelper.createUUID();
			int question_amount =ParamUtil.getInt(request, "question_amount-"+i);
			int question_score  =ParamUtil.getInt(request,"question_score-"+i) ;
			String type_id =request.getParameter("type_id-"+i);
			if(question_amount<=0){
				continue ;
			}else{
				float tempN = ParamUtil.getFloat(request,"complexity-"+i+"-n");
				float tempZ = ParamUtil.getFloat(request,"complexity-"+i+"-z");
				float tempY = ParamUtil.getFloat(request,"complexity-"+i+"-y");
				float nzy[]= null;
				if(tempN!=0||tempZ!=0||tempY!=0){
					nzy =new float[]{tempN/(tempN+tempZ+tempY),tempZ/(tempN+tempZ+tempY),tempY/(tempN+tempZ+tempY)};
				}else{
					return ;
				}
				String complexity[] ={"N","Z","Y"};
				int amount =question_amount-(int)(question_amount*nzy[0]+(int)question_amount*nzy[1]);
				typeSb.append(type_item_id+"','");
				typeSb.append(paperId+"','");
				typeSb.append(type_id+"',");
				typeSb.append(question_score+",");
				typeSb.append(question_amount+")");
				try {
					dh.execute(typeSb.toString());
				} catch (DBException e) {
					_log.error("更新失败，检查输入条件是否正确");
				} catch (SQLException e) {
					_log.error("更新失败，检查输入条件是否正确");
				}
				for(int j=0;j<nzy.length;j++){
					StringBuffer comSb  = new StringBuffer("INSERT INTO COMPLEXITY(ITEM_ID,TYPE_ITEM_ID,PERCENT,QUESTION_AMOUNT,COMPLEXITY,TYPE_ID,PAPER_ID) VALUES('");
					comSb.append(CodeHelper.createUUID()+"','");
					comSb.append(type_item_id+"',");
					comSb.append(nzy[j]+",");
					if(j<2){
						comSb.append((int)(nzy[j]*question_amount)+",'");

					}else{
						comSb.append(amount+",'");
					}
					comSb.append(complexity[j]+"','");
					comSb.append(type_id+"','");
					comSb.append(paperId+"')");
					try {
						dh.execute(comSb.toString());
					} catch (DBException e) {
						_log.error("更新失败，检查输入条件是否正确");
					} catch (SQLException e) {
						_log.error("更新失败，检查输入条件是否正确");
					}
				}
			}
		}
	}
	/**
	 *	查询试卷的章节知识点信息，试卷中题目的类型信息
	 * @param paper_id
	 * @return
	 * @throws DBException
	 */
	public Object[] findChapter_ponitInfo(String paper_id) throws DBException{
		DBHelper dh  = new DBHelper();
		dh.setProcedureName("getCK(?,?,?,?,?,?)");
		dh.addInForProcedure(paper_id);
		dh.addOutForProcedure(Types.VARCHAR);
		dh.addOutForProcedure(Types.VARCHAR);
		dh.addOutForProcedure(Types.VARCHAR);
		dh.addOutForProcedure(Types.VARCHAR);
		dh.addOutForProcedure(OracleTypes.CURSOR);
		dh.excuteByProcedure();
		String chapter_ids = Validate.isNullToDefault(dh.getValueByProcedure(0),"").toString();
		String chapter_names = Validate.isNullToDefault(dh.getValueByProcedure(1),"").toString();
		String point_names = Validate.isNullToDefault(dh.getValueByProcedure(2),"").toString();
		String point_ids = Validate.isNullToDefault(dh.getValueByProcedure(3),"").toString();
		List<Map> clist= dh.queryForListByProcedure((ResultSet) dh.getValueByProcedure(4));
		return new Object[]{chapter_ids,chapter_names,point_ids,point_names,clist};
	}
	/**
	 * 根据试卷编号查询试题难易程度相关信息
	 * @param paper_id
	 * @param type_item_id
	 * @return
	 * @throws DBException
	 */
	public List<Map> findComplexityInfos(String paper_id,String type_item_id) throws DBException{
		String sql = "select (c.percent*10) as percent from complexity c where paper_id ='"+paper_id+"' and c.type_item_id='"+type_item_id+"' order by item_id";
		DBHelper dh  = new DBHelper();
		List<Map> comList=dh.queryForList(sql);
		return comList;
	}
	private static Logger _log = Logger.getLogger(PaperInfoService.class);
}
