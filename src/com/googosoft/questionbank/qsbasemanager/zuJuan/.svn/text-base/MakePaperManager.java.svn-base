package com.googosoft.questionbank.qsbasemanager.zuJuan;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.log4j.Logger;

import com.googosoft.commons.CodeHelper;
import com.googosoft.commons.Validate;
import com.googosoft.exception.CUDException;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBHelper;

public class MakePaperManager {
	private Logger logger = Logger.getLogger(MakePaperManager.class.getName());
	DBHelper dbHelper = new DBHelper();
	Map paperConditionMap = null;// 组卷条件的信息
	List questionList = null;// 组卷章节或组卷知识点下的所有试题
	String[] courseContents;// 组卷条件的章节点或知识点
	List courseconSubjectList = null;// 组卷类型临时存储list-存放准备抽取
	List courseContentList = null;// 获取组卷章节或知识点临时存储list
	List subjectRateList = null;// 获取组卷需要抽出难度等级临时存储list
	Map tempMap = null;
	String CONDITIONTYPE = null;// 章节或知识点标记位
	List resultList = new ArrayList();// 存放执行成功的list
	Map subjectMap = new HashMap();// 每个类型的题的分数
	String conditionType = null;

	/**
	 * 组卷算法
	 * 
	 * @param id
	 *            组卷条件id
	 * @return 失败返回原因，成功进行保存，并返回null
	 * @throws ManagerException
	 */
	public String makePaper(String id) throws ManagerException {
		init(id);
		String result = filterQuestion();
		if (result == null) {
			logger.info("进行保存…………");
			String paperId = CodeHelper.createUUID();
			Map cudMap = new HashMap();
			cudMap.put("OPERATETYPE", "C");
			cudMap.put("P=PAPER-1=PAPER_ID=S=P", paperId);
			cudMap.put("P=PAPER-1=PAPER_TITLE=S=C", paperConditionMap
					.get("CONDITIONTITLE"));
			cudMap.put("P=PAPER-1=PAPER_TIME=S=C", paperConditionMap
					.get("CONDITIONTIME"));
			cudMap.put("P=PAPER-1=MAJOR_ID=S=C", paperConditionMap
					.get("CONDITIONMARGOR"));
			cudMap.put("P=PAPER-1=COURSE_ID=S=C", paperConditionMap
					.get("CONDITIONCOURSE"));
			cudMap.put("P=PAPER-1=PAPER_SCORE=S=C", paperConditionMap
					.get("CONDITIONSCORE"));
			cudMap.put("P=PAPER-1=PAPER_DATE=D=C", paperConditionMap
					.get("CONDITIONDATE"));
			cudMap.put("P=PAPER-1=CREATETIME=D=C", null);
			cudMap.put("P=PAPER-1=SAAS=S=C", paperConditionMap.get("SAAS"));
			cudMap.put("P=PAPER-1=USERIDBYLOGIN=S=C", paperConditionMap
					.get("USERIDBYLOGIN"));
					
			cudMap.put("P=PAPER-1=COURSECONTENT=S=C", paperConditionMap
					.get("COURSECONTENT"));
			cudMap.put("P=PAPER-1=SUBJECTRATE=S=C", paperConditionMap
					.get("SUBJECTRATE"));
			cudMap.put("P=PAPER-1=COURSECONSUBJECT=S=C", paperConditionMap
					.get("COURSECONSUBJECT"));
			
			cudMap.put("P=PAPER-1=REMARK=S=C", null);
			cudMap.put("P=PAPER-1=PAPERCONDITIONID=S=C", id);
			// xin:试题按类型排序
			String lastTypeId = "";
			String typeId = "";
			int m = 1;
			for (int i = 0; i < resultList.size(); i++) {
				tempMap = (Map) resultList.get(i);
				typeId = Validate.isNullToDefault(tempMap.get("TYPE_ID"), "")
						.toString().trim();
				if ("".equals(lastTypeId) || !typeId.equals(lastTypeId)) {
					lastTypeId = typeId;
					m = 1;
				}
				cudMap.put("P=PAPERQUESTION-" + i + "=PAPERID=S=C", paperId);
				cudMap.put("P=PAPERQUESTION-" + i + "=QUESTIONID=S=C", tempMap
						.get("QUESTION_ID"));
				cudMap.put("P=PAPERQUESTION-" + i + "=QUESTIONNUM=S=C", m);
				cudMap.put("P=PAPERQUESTION-" + i + "=QUESTIONFRACTION=S=C",
						subjectMap.get(tempMap.get("TYPE_ID")));
				cudMap.put("P=PAPERQUESTION-" + i + "=TYPE_ID=S=C", tempMap
						.get("TYPE_ID"));
				m++;
			}
			try {
				new CUDHelper(cudMap, "=", "-").execute();
			} catch (CUDException e) {
				logger.error("试卷生成后，保存失败");
				throw new ManagerException(e);
			}
			return null;
		} else {
			return result;
		}
	}

	private void init(String id) throws ManagerException {
		try {
			// 根据组件条件id获取此条组卷条件的信息
			String sqlPaperCondition = "select * from PAPERCONDITION where conditionid = '"
					+ id + "' ";
			paperConditionMap = dbHelper.queryForMap(sqlPaperCondition);
			// 获取组卷条件是到章还是到知识点
			conditionType = paperConditionMap.get("CONDITIONTYPE") + "";
			// 获取组卷条件的章节点或知识点
			courseContents = (paperConditionMap.get("COURSECONTENT") + "")
					.split(",");
			StringBuffer courseContentBF = new StringBuffer("'");
			for (int i = 0; i < courseContents.length; i++) {
				courseContentBF.append(courseContents[i].split("_")[0]);
				if (i < courseContents.length - 1) {
					courseContentBF.append("','");
				} else {
					courseContentBF.append("'");
				}
			}
			// 组装查询问题的sql
			StringBuffer question = new StringBuffer();
			question.append(" select * from QUESTION t where ");
			if ("1".equals(conditionType)) {
				CONDITIONTYPE = "point_id";
			} else {
				CONDITIONTYPE = "chapter_id";
			}
			question.append(" " + CONDITIONTYPE + " in ("
					+ courseContentBF.toString() + ") ");
			// 获取组卷章节或组卷知识点下的所有试题
			questionList = dbHelper.queryForList(question.toString());
		} catch (Exception e) {
			logger.error(e);
			throw new ManagerException("组装试卷失败");
		}

	}

	private String filterQuestion() {
		String[] courseconSubjects;// 组卷需要的类型
		String courseconSubjectId;// 组卷类型id
		int courseconSubjectNum;// 组卷类型num
		int courseconSubjectSum;// 组卷类型总分数
		String courseContentId;// 组卷章节或知识点id
		int courseContentNum;// 组卷章节或知识点num
		String[] subjectRates;// 组卷等级
		String subjectRateId;// 组卷等级id
		int subjectRateNum;// 组卷等级num
		List courseContentResultList;// 储存每个题型的题目，已备抽出题数多余要组题数时，再次进行筛选。
		// 获取组卷需要的类型
		courseconSubjects = (paperConditionMap.get("COURSECONSUBJECT") + "")
				.split(",");
		// 获取组卷需要的等级
		subjectRates = (paperConditionMap.get("SUBJECTRATE") + "").split(",");
		for (int i = 0; i < courseconSubjects.length; i++) {
			// 1.1.1 获取组卷类型的id
			courseconSubjectId = courseconSubjects[i].split("_")[0];
			// 1.2.1 获取组卷类型临时存储list-存放准备抽取
			courseconSubjectList = new ArrayList();
			// 1.2.2 获取组卷类型临时存储list-存放结果
			courseContentResultList = new ArrayList();
			// 1.2.3 获取预备题目中的此组卷类型的全部题目
			for (int j = 0; j < questionList.size(); j++) {
				tempMap = (Map) questionList.get(j);
				if (courseconSubjectId.equals(tempMap.get("TYPE_ID") + "")) {
					courseconSubjectList.add(tempMap);
				}
			}
			// 1.3.1 获取组卷类型需要试题的个数
			courseconSubjectNum = Integer.valueOf(courseconSubjects[i]
					.split("_")[2]);
			courseconSubjectSum = Integer.valueOf(courseconSubjects[i]
					.split("_")[1]);
			if (courseconSubjectNum <= 0) {
				continue;
			}
			if (courseconSubjectList.size() < courseconSubjectNum) {
				// return "题型" + courseconSubjectId + "题目数量不足";
			}
			subjectMap.put(courseconSubjectId, courseconSubjectSum
					/ courseconSubjectNum);
			// 1.3.2 每种组卷题型下的章节或知识点需要抽出的题目数量
			for (int j = 0; j < courseContents.length
					&& courseconSubjectNum > 0; j++) {
				// 2.1.1 章节或知识点id
				courseContentId = courseContents[j].split("_")[0];
				// 2.2.1 获取组卷章节或知识点临时存储list
				courseContentList = new ArrayList();
				// 2.2.2 获取预备题目中的此章节或知识点的全部题目
				for (int k = 0; k < courseconSubjectList.size(); k++) {
					tempMap = (Map) courseconSubjectList.get(k);
					if (courseContentId.equals(tempMap.get(CONDITIONTYPE
							.toUpperCase())
							+ "")) {
						courseContentList.add(tempMap);
					}
				}
				// 2.3.1 章节或知识点id对应的要抽出的题数
				courseContentNum = Integer
						.valueOf(courseContents[j].split("_")[1])
						* courseconSubjectNum / 100;
				// 2.3.2 若不被整除，则加1
				if (Integer.valueOf(courseContents[j].split("_")[1])
						* courseconSubjectNum % 100 > 0) {
					courseContentNum++;
				}
				if (courseContentList.size() < courseContentNum) {
					// return "题型" + courseconSubjectId + "，章节或知识点"
					// + courseContentId + "题目数量不足";
				}
				// 2.3.2 每种组卷题型下的章节或知识点下的不同难度需要抽出的数量
				for (int k = 0; k < subjectRates.length && courseContentNum > 0; k++) {
					// 3.1.1 组卷等级id
					subjectRateId = subjectRates[k].split("_")[0];
					// 3.2.1 获取组卷需要抽出难度等级临时存储list
					subjectRateList = new ArrayList();
					// 3.2.2 获取预备题目中的此难度等级的全部题目
					for (int l = 0; l < courseContentList.size(); l++) {
						tempMap = (Map) courseContentList.get(l);
						if (subjectRateId
								.equals(tempMap.get("COMPLEXITY") + "")) {
							subjectRateList.add(tempMap);
						}
					}
					// 3.3.1 组卷等级num
					subjectRateNum = Integer
							.valueOf(subjectRates[k].split("_")[1])
							* courseContentNum / 100;
					// 3.3.2 若不被整除，则加1
					if (Integer.valueOf(subjectRates[k].split("_")[1])
							* courseContentNum % 100 > 0) {
						subjectRateNum++;
					}
					if (subjectRateList.size() < subjectRateNum) {
						try {
							Object courseconSubjectName = dbHelper
									.queryForSingleValue("select t.txxxb_mc from QUESTION_TXXXB t where t.txxxb_id = '"
											+ courseconSubjectId + "'");
							Object courseContentName = null;
							if ("0".equals(conditionType)) {
								courseContentName = "章节 "
										+ dbHelper
												.queryForSingleValue("select t.chapter_name from CHAPTER t where t.chapter_id = '"
														+ courseContentId + "'");
							} else {
								courseContentName = "知识点 "
										+ dbHelper
												.queryForSingleValue("select t.point_name from KNOWLEDGE_POINT t where t.point_id = '"
														+ courseContentId + "'");
							}
							Object subjectRateName = dbHelper
									.queryForSingleValue("SELECT t.ndxxb_nycd  FROM question_ndxxb T WHERE t.ndxxb_id = '"
											+ subjectRateId + "'");
							return "题型 " + courseconSubjectName + "，"
									+ courseContentName + "，难度等级 "
									+ subjectRateName + "，题目数量差"
									+ (subjectRateNum - subjectRateList.size())
									+ "个";
						} catch (DBException e) {
							return "组卷失败";
						}
					} else if (subjectRateList.size() > 0) {
						logger.info(courseconSubjectId + " " + courseContentId
								+ " " + subjectRateId + "进行抽题，抽取"
								+ subjectRateNum + "个");
						getQuestion(subjectRateList, subjectRateNum,
								courseContentResultList);
					}
				}
			}
			getQuestion(courseContentResultList, courseconSubjectNum,
					resultList);
		}
		return null;
	}

	private List getQuestion(List list, int num, List result) {
		if (list.size() <= 0) {
			return new ArrayList();
		}
		int random = new Random().nextInt(list.size());
		result.add(list.get(random));
		list.remove(random);
		num--;
		if (num <= 0) {
			return result;
		} else {
			getQuestion(list, num, result);
		}
		return new ArrayList();
	}
}
