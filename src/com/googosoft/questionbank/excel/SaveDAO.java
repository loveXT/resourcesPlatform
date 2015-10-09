package com.googosoft.questionbank.excel;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.zapi.CUDHelper;
import com.googosoft.zapi.DBHelper;

public class SaveDAO {
	public synchronized boolean save(List questionList)throws Exception{
		Excel e = null;
		Map cudMap = new HashMap();
		cudMap.put("OPERATETYPE", "C");
		int maxCode = findMaxCode();
		for(int i = 0;i<questionList.size();i++){
			e = replaceExcel((Excel) questionList.get(i));
			cudMap.put("P=QUESTION-"+(i+1)+"=QUESTION_CODE=S=C", maxCode);
			cudMap.put("P=QUESTION-"+(i+1)+"=COMPLEXITY=S=C", e.getComplexity());
			cudMap.put("P=QUESTION-"+(i+1)+"=QUESTION_ID=S=C", e.getQuestion_id());
			cudMap.put("P=QUESTION-"+(i+1)+"=POINT_ID=S=C", e.getPoint_id());
			cudMap.put("P=QUESTION-"+(i+1)+"=COURSE_ID=S=C", e.getCourse_id());
			cudMap.put("P=QUESTION-"+(i+1)+"=MAJOR_ID=S=C", e.getMajor_id());
			cudMap.put("P=QUESTION-"+(i+1)+"=QUESTION_CONTENT=S=C", e.getQuestion_content());
			cudMap.put("P=QUESTION-"+(i+1)+"=CHAPTER_ID=S=C", e.getChapter_id());
			cudMap.put("P=QUESTION-"+(i+1)+"=TYPE_ID=S=C", e.getType_id());
			cudMap.put("P=QUESTION-"+(i+1)+"=SAAS=S=C", e.getSaas());
			cudMap.put("P=QUESTION-"+(i+1)+"=USERIDBYLOGIN=S=C", e.getUseridbylogin());
			cudMap.put("P=QUESTION-"+(i+1)+"=ANSWER=S=C", e.getanswer());
			cudMap.put("P=QUESTION-"+(i+1)+"=QUESTION_FZXX=S=C", e.getQuestion_fzxx());
			cudMap.put("P=QUESTION-"+(i+1)+"=QUESTION_DAJX=S=C", e.getQuestion_dajx());
			maxCode++;
		}
		return new CUDHelper(cudMap, "=", "-").execute();
		}
	/**获取最大编号
	 * @return
	 * @throws ManagerException
	 */
	private int findMaxCode()throws ManagerException{
		String sql = "select nvl(max(to_number(t.question_code))+1,1) from QUESTION t";
		DBHelper dbHelper = new DBHelper();
		try {
			return Integer.parseInt(Validate.isNullToDefault(dbHelper.queryForSingleValue(sql), "0").toString());
		} catch (NumberFormatException e) {
			throw new ManagerException("数据类型转换失败：\n"+e.getMessage());
		} catch (DBException e) {
			throw new ManagerException("查询数据库失败：\n"+e.getMessage());
		}
	}
	/**将试题中的题干和答案中的单引号换成两个单引号
	 * @param excel
	 * @return
	 */
	private Excel replaceExcel(Excel excel){
		String content = excel.getQuestion_content();
		String answer = excel.getanswer();
		content = content.replaceAll("'", "''");
		answer = answer.replaceAll("'", "''");
		excel.setQuestion_content(content);
		excel.setanswer(answer);
		return excel;
	}
}
