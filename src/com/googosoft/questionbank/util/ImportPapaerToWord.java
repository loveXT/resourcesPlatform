package com.googosoft.questionbank.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.DBFormatException;
import com.googosoft.exception.ManagerException;
import com.googosoft.questionbank.qsbasemanager.controller.CourseController;
import com.googosoft.questionbank.qsbasemanager.controller.MajorController;
import com.googosoft.questionbank.qsbasemanager.controller.PaperController;
import com.googosoft.questionbank.qsbasemanager.controller.QuestionController;
import com.googosoft.questionbank.qsbasemanager.controller.TxxxbController;
import com.googosoft.questionbank.qsbasemanager.paperManager.ChangeQuestionManager;
import com.googosoft.questionbank.qsbasemanager.paperManager.PaperManager;
import com.googosoft.questionbank.questionbank.XzxxbManager;

public class ImportPapaerToWord {

	public boolean getContent(String title, String filepath, String filename,
			String id) throws ManagerException, DBFormatException, DBException,
			IOException {
		String path = filepath;
		String file_h = filename;

		StringBuilder sb = new StringBuilder();
		sb.append("<html><head>" );
		sb.append("</head><body>");
		PaperController paperController = new PaperController();

		Map paperMap = paperController.findMapByPAPER_ID(id);
		// 用以获得专业名称
		MajorController majorController = new MajorController();
		Map majorMap = majorController.findMapByMAJOR_ID(paperMap
				.get("MAJOR_ID") + "");
		// 用来获得班级名称
		CourseController courseController = new CourseController();
		Map courseMap = courseController.findMapByCOURSE_ID(paperMap
				.get("COURSE_ID") + "");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dt = new Date();
		String today = sdf.format(dt);
		sb.append("<div style='text-align: center; font-weight: bolder; font-size: 20px;'>");
		sb.append(paperMap.get("PAPER_DATE") == null ? today : paperMap
				.get("PAPER_DATE"));
		sb.append("淄川学院 ");
		sb.append(majorMap.get("MAJOR_NAME") == null ? "_________" : majorMap
				.get("MAJOR_NAME"));
		sb.append("(专业)");
		sb.append(courseMap.get("COURSE_NAME") == null ? "_________"
				: courseMap.get("COURSE_NAME"));
		sb.append("(班)");
		sb.append(paperMap.get("PAPER_TITLE") == null ? "_________(测试标题)"
				: paperMap.get("PAPER_TITLE"));
		sb.append("</div>");
		sb.append("<div style='text-align: center; font-size: 16px;'>(考试时间 ");
		sb.append(paperMap.get("PAPER_TIME") == null ? "_____" : paperMap
				.get("PAPER_TIME"));
		sb.append(" 分钟,满分 ");
		sb.append(paperMap.get("PAPER_SCORE") == null ? "_____" : paperMap
				.get("PAPER_SCORE"));
		sb.append("分)<br>注意事项：用蓝、黑色钢笔答题。保持卷面整洁。</div><br>");

		// 查询试题的分数 9-25 16:00
		PaperManager paperManager = new PaperManager();
		List lis = paperManager.findQuestionInfoByType(id);

		QuestionController questionController = new QuestionController();
		// 获取题型List
		TxxxbController txxxbController = new TxxxbController();
		List typeList = txxxbController.findAllQuestionType();
		// 题型ID
		String question_jbtxbId = "";
		String titleNumber = "";
		// 定义题型名称
		String typeName;
		// 得到此时的题目id
		String nowQuestionId;
		// 答题指南
		String typePrompt;
		Map typeMap;
		Map xzxxbMaps;
		// 用做判断的list
		List judgeList;
		Map judgeMap;
		// 试题标题大写数组
		String[] titles = { "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
				"十一" };
		int num = -1;
		String content;

		String conditionContent = "";
		String conditionTypeId = "";
		String conditionScore = "";
		String conditionNum = "";
		String conditionSingleScore = "";
		Map conditionMap = null;
		
		
		for (int i = 0; i < typeList.size(); i++) {
			typeMap = (Map) typeList.get(i);
			// 获得题型名称
			typeName = typeMap.get("TXXXB_MC") + "";
			// 获得题型id
			question_jbtxbId = typeMap.get("TXXXB_ID") + "";

			conditionMap = paperManager.findScoreMapByPaperIdAndTypeId(id, question_jbtxbId);
			conditionScore = Validate
					.isNullToDefault(conditionMap.get("SUMSCORE"), "")
					.toString().trim();
			conditionNum = Validate
					.isNullToDefault(conditionMap.get("QUESTIONNUM"), "")
					.toString().trim();
			conditionContent = "(共" + conditionNum + "小题,共"
					+ conditionScore + "分)";

			typePrompt = typeMap.get("TXXXB_DAZN") + "";
			// 根据题型来判断在该题型下是否有题，如果没有则不显示
			judgeList = questionController.judgeByPaperidNndTypeid(id,
					question_jbtxbId);
			// judgeList里面包含有题型的questionid和题型内容，下面就有大用的了
			
			ChangeQuestionManager cqm = new ChangeQuestionManager();
			if (judgeList.size() > 0) {
				num++;
				// 题型显示编号
				titleNumber = titles[num];

				sb.append("<br>");
				sb.append("<div style='font-weight: bolder;font-size:16px;line-height:26px;'>");
				sb.append(titleNumber + ".  "
						+ Validate.isNullToDefault(typeMap.get("TXXXB_MC"), ""));
				sb.append("(" + typePrompt + ")");
				sb.append(conditionContent);
				sb.append("</div><br/>");
				for (int k = 0; k < judgeList.size(); k++) {
					judgeMap = (Map) judgeList.get(k);
					// 得到此时的题目id
					nowQuestionId = judgeMap.get("QUESTION_ID") + "";
					String score = cqm.findScore(id, nowQuestionId);
					content = Validate
							.isNullToDefault(judgeMap.get("QUESTION_CONTENT"),
									"").toString().trim();
					content = content.replace("<p>", "");
					content = content.replace("</p>", "<br/>&nbsp;");

					if ("单选题(四选一)".equals(typeName)||"单选题(五选一)".equals(typeName) || "多选题(四选多)".equals(typeName)||"多选题(五选多)".equals(typeName)) {
						sb.append("<div style='margin-left: 25px;'>");
						sb.append("<div style='font-size:14px;line-height:24px;'>");
						sb.append((k + 1) + ". " + content + " </div>");
						sb.append("</div>");
					} else if ("填空题".equals(typeName)) {
						// 为填空题
						sb.append("<div style='margin-left: 25px;'>");
						sb.append("<div style='font-size:14px;line-height:24px;'>");
						sb.append((k + 1) + "." + content + " </div>");
						sb.append("</div>");
					} else if ("判断题".equals(typeName)) {
						// 为判断题
						sb.append("<div style='margin-left: 25px;'>");
						sb.append("<div style='font-size:14px;line-height:24px;'>");
						sb.append((k + 1) + "." + content + "</div>");
						sb.append("</div>");
					} else if ("问答题".equals(typeName)) {
						// 为问答题
						sb.append("<div style='margin-left: 25px;'>");
						sb.append("<div style='font-size:14px;line-height:24px;'>");
						sb.append((k + 1) + "." + content+" ");
						sb.append("</div>");
						sb.append("</div><br/><br/><br/><br/>");
					}
				}
			}
		}
		sb.append("<br>");
		sb.append("<br>");
		sb.append("<div style='padding-left: 35px;font-weight: bolder;font-size:16px;' >试题答案：</div>");
		// 试题答案begin
		Map answerMap;
		String whichAnswer;
		String answerResolution;
		String score;

		num = -1;
		for (int i = 0; i < typeList.size(); i++) {
			typeMap = (Map) typeList.get(i);
			// 获得题型名称
			typeName = typeMap.get("TXXXB_MC") + "";
			// 获得题型id
			question_jbtxbId = typeMap.get("TXXXB_ID") + "";
			// 根据题型来判断在该题型下是否有题，如果没有则不显示
			judgeList = questionController.judgeByPaperidNndTypeid(id,
					question_jbtxbId);
			// judgeList里面包含有题型的questionid和题型内容，下面就有大用的了
			int ii = 0;
			ii++;
			if (judgeList.size() > 0) {
				num++;
				// 题型显示编号
				titleNumber = titles[num];
				String[] typeN_S = txxxbController.getTypeScoreAndNum(id,
						Validate.isNullToDefault(typeMap.get("TXXXB_ID"), "")
								.toString());

				
				sb.append("<div style='font-size:14px;font-weight: bolder;'>");
				sb.append(titleNumber + ".  "
						+ Validate.isNullToDefault(typeMap.get("TXXXB_MC"), ""));
				for (int o = 0; o < lis.size(); o++) {
					conditionMap = (Map) lis.get(o);
					conditionTypeId = Validate
							.isNullToDefault(conditionMap.get("typeId"), "")
							.toString().trim();
					conditionScore = Validate
							.isNullToDefault(conditionMap.get("score"), "")
							.toString().trim();
					conditionNum = Validate
							.isNullToDefault(conditionMap.get("num"), "")
							.toString().trim();
					conditionSingleScore = Validate
							.isNullToDefault(conditionMap.get("singleScore"),
									"").toString().trim();
					conditionContent = "(" + conditionSingleScore + "' *  "
							+ conditionNum + " = " + conditionScore + "')";
					question_jbtxbId = Validate
							.isNullToDefault(typeMap.get("TXXXB_ID"), "")
							.toString().trim();
					if (question_jbtxbId.equals(conditionTypeId)) {
						break;
					}
				}
				sb.append(conditionContent);
				sb.append("</div>");

				for (int k = 0; k < judgeList.size(); k++) {
					judgeMap = (Map) judgeList.get(k);
					// 得到此时的题目id
					nowQuestionId = judgeMap.get("QUESTION_ID") + "";
					content = Validate
							.isNullToDefault(judgeMap.get("QUESTION_CONTENT"),
									"").toString().trim();
					content = content.replace("<p>", "");
					content = content.replace("</p>", "<br/>&nbsp;");
					answerMap = questionController.getMap(nowQuestionId);
					// 获得选项信息
					whichAnswer = Validate.isNullToDefault(
							answerMap.get("ANSWER"), "").toString();
					// 获得答案解析
					answerResolution = Validate
							.isNullToDefault(answerMap.get("QUESTION_DAJX"), "")
							.toString().trim();
					//answerResolution = xzxxbManager.getString(answerResolution);
					// 分值
					score = Validate.isNullToDefault(
							answerMap.get("QUESTION_FZXX"), "").toString();
					if ("单选题(四选一)".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {
						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("选项：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					} else if ("单选题(五选一)".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {

						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("选项：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					}else if ("多选题(四选多)".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {

						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("选项：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					}else if ("多选题(五选多)".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {

						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("选项：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					} else if ("填空题".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {
						// 为填空题

						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("答案：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					} else if ("判断题".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {
						// 为判断题

						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("答案：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					} else if ("问答题".equals(typeName)
							&& conditionTypeId.equals(question_jbtxbId)) {
						// 为问答题

						sb.append("<div style='padding-left: 35px;font-size:14px;'>");
						sb.append((k + 1) + "." + content);
						sb.append("<br>");
						sb.append("答案：" + whichAnswer);
						sb.append("<br>");
						sb.append("答案解析：" + answerResolution);
						sb.append("</div>");

					}
				}
			}
		}
		sb.append("</body>");
		sb.append("</html>");
		System.out.println(sb.toString());
		byte strby[] = sb.toString().getBytes();
		FileOutputStream fos = new FileOutputStream(path + file_h);
		fos.write(strby, 0, strby.length);
		fos.close();

		File file = new File(path + file_h);
		System.out.println(file.exists() + "******************"
				+ FilenameUtils.getBaseName(file.getName()));
		FileInputStream fis = new FileInputStream(file);
		String destPaht = path + FilenameUtils.getBaseName(file.getName())
				+ ".doc";
		System.out.println(destPaht + "***************");
		FileOutputStream outStream = new FileOutputStream(destPaht);
		int data;
		while ((data = fis.read()) != -1) {
			outStream.write(data);
		}
		fis.close();
		file.deleteOnExit();
		outStream.close();
		return true;
	}
}
