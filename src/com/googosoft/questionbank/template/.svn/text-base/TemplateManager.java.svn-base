package com.googosoft.questionbank.template;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.formula.FormulaParseException;

import com.googosoft.commons.Validate;
import com.googosoft.exception.ManagerException;
import com.googosoft.filesManager.fileManager.SelectFilesManager;
import com.googosoft.questionbank.questionbank.PointManager;

class TemplateManager extends SelectBoxExcel {
	private String major = "default major";
	private String course = "default course";
	private String courseId = "default courseId";

	public TemplateManager(){
		super();
	}
	public void setMajorAndCourse(String major, String courseName,
			String courseId) {
		this.major = major.replace(" ", "").trim();
		this.course = courseName.replace(" ", "").trim();
		this.courseId = courseId;
	}

	/**
	 * 创建一列应用列头
	 * 
	 * @param userinfosheet1
	 * @param userName
	 */
	@Override
	public void creatTitleRow(HSSFWorkbook workbook, HSSFRow row) {
		HSSFCellStyle titleStyle = this.createTitleCellStyle(workbook);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("所属专业");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(1);
		cell.setCellValue("所属课程");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(2);
		cell.setCellValue("所属章节");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(3);
		cell.setCellValue("试题类型");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(4);
		cell.setCellValue("难易程度");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(5);
		cell.setCellValue("试题内容");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(6);
		cell.setCellValue("答案");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(7);
		cell.setCellValue("分值");
		cell.setCellStyle(titleStyle);

		cell = row.createCell(8);
		cell.setCellValue("答案解析");
		cell.setCellStyle(titleStyle);

	}

	/**
	 * 创建一列应用数据
	 * 
	 * @param userinfosheet1
	 * @param userName
	 * @throws NameRepeatException
	 */
	public void creatDataRow(HSSFWorkbook workbook, HSSFSheet sheet, HSSFRow row)
			throws NameRepeatException {
		HSSFCellStyle dataStyle = this.createDataCellStyle(workbook);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue(major);
		cell.setCellStyle(dataStyle);

		cell = row.createCell(1);
		cell.setCellValue(course);
		cell.setCellStyle(dataStyle);

		cell = row.createCell(2);
		cell.setCellValue("请选择");
		cell.setCellStyle(dataStyle);

		cell = row.createCell(3);
		cell.setCellValue("请选择");
		cell.setCellStyle(dataStyle);

		cell = row.createCell(4);
		cell.setCellValue("请选择");
		cell.setCellStyle(dataStyle);

		cell = row.createCell(5);
		cell.setCellValue("");
		cell.setCellStyle(dataStyle);

		cell = row.createCell(6);
		cell.setCellValue("");
		cell.setCellStyle(dataStyle);

		cell = row.createCell(7);
		cell.setCellValue("");
		cell.setCellStyle(dataStyle);

		cell = row.createCell(8);
		cell.setCellValue("");
		cell.setCellStyle(dataStyle);
		try {
			int rowIndex = row.getRowNum() + 1;
			sheet.addValidationData(this.getDataValidationByFormula("chapter",
					rowIndex, 3));
			sheet.addValidationData(this.getDataValidationByFormula("type",
					rowIndex, 4));
			sheet.addValidationData(this.getDataValidationByFormula("hard",
					rowIndex, 5));
			sheet.addValidationData(this.getDataValidationByFormula(
					"INDIRECT($C$" + rowIndex + ")", rowIndex, 4));
		} catch (FormulaParseException e) {
			throw new NameRepeatException("名称不存在");
		}
	}

	@Override
	public void addNames(HSSFSheet hideSheet) throws NameRepeatException {
		try {
			this.creatQuestionTypeNames(hideSheet, 0);
			this.creatQuestionHardNames(hideSheet, 1);
			this.creatChapterAndCourseNames(hideSheet, 2);
		} catch (Exception e) {
			e.printStackTrace();
			throw new NameRepeatException();
		}

	}

	/**
	 * 该方法查询所有的难易度并生成名称
	 * 
	 * @param rowIndex
	 * @throws ManagerException
	 * @throws NameRepeatException
	 */
	private void creatQuestionHardNames(HSSFSheet hideSheet, int rowIndex)
			throws ManagerException, NameRepeatException {
		List hardList = new QuestionBankManager().findQuestionHardList();
		HSSFRow hardRow = hideSheet.createRow(rowIndex);
		if (Validate.noNull(hardList) && hardList.size() > 0) {
			int length = hardList.size();
			for (int colIndex = 0; colIndex < length; colIndex++) {
				Map hardMap = (Map) hardList.get(colIndex);
				String hardName = hardMap.get("NDXXB_NYCD") + "";
				hardRow.createCell(colIndex).setCellValue(hardName);
			}
			this.createNameByRow("hard", rowIndex, length);
		}
	}

	/**
	 * 该方法查询所有的试题类型并生成名称
	 * 
	 * @param rowIndex
	 * @throws ManagerException
	 * @throws NameRepeatException
	 */
	private void creatQuestionTypeNames(HSSFSheet hideSheet, int rowIndex)
			throws ManagerException, NameRepeatException {
		List typeList = new QuestionBankManager()
				.findNotChoiceQuestionTypeList();
		HSSFRow typeRow = hideSheet.createRow(rowIndex);
		if (Validate.noNull(typeList) && typeList.size() > 0) {
			int length = typeList.size();
			for (int colIndex = 0; colIndex < length; colIndex++) {
				Map typeMap = (Map) typeList.get(colIndex);
				String typeName = typeMap.get("TXXXB_MC") + "";
				typeRow.createCell(colIndex).setCellValue(typeName);
			}
			this.createNameByRow("type", rowIndex, length);
		}
	}

	/**
	 * 该方法首先根据courseId查询所有的章节
	 * 然后将所有章节生成一行记录，同时根据每个id查询所有知识点，然后依次为每个id生成的知识点生成一行记录和名称 最后为该行生成一个名称
	 * 
	 * @param rowIndex
	 * @throws ManagerException
	 * @throws NameRepeatException
	 */
	private void creatChapterAndCourseNames(HSSFSheet hideSheet, int rowIndex)
			throws ManagerException, NameRepeatException {
		List chapterList = new SelectFilesManager()
				.findChapterByCourseId(courseId);
		HSSFRow chapterRow = hideSheet.createRow(rowIndex);
		if (Validate.noNull(chapterList) && chapterList.size() > 0) {
			int length = chapterList.size();
			for (int colIndex = 0; colIndex < length; colIndex++) {
				Map chapterMap = (Map) chapterList.get(colIndex);
				String chapterName = chapterMap.get("CHAPTER_NAME") + "";
				String chapterId = chapterMap.get("CHAPTER_ID") + "";
				chapterRow.createCell(colIndex).setCellValue(
						chapterName.replaceAll(" ", ""));
				/*this.createCourseNames(hideSheet, (rowIndex + colIndex + 1),
						chapterId, chapterName);*/
			}
			this.createNameByRow("chapter", rowIndex, length);
		}
	}

	/**
	 * 列头单元格样式
	 * 
	 * @param workbook
	 * @param sheet
	 */
	private HSSFCellStyle createTitleCellStyle(HSSFWorkbook workbook) {
		HSSFCellStyle titleStyle = workbook.createCellStyle();

		// 设置边框
		titleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// 设置背景色
		titleStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置居中
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 11); // 设置字体大小
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
		titleStyle.setFont(font);// 选择需要用到的字体格式
		// 设置自动换行
		titleStyle.setWrapText(true);
		return titleStyle;
	}

	/**
	 * 数据单元格样式
	 * 
	 * @param workbook
	 * @param sheet
	 */
	private HSSFCellStyle createDataCellStyle(HSSFWorkbook workbook) {
		HSSFCellStyle dataStyle = workbook.createCellStyle();

		// 设置边框
		dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// 设置背景色
		dataStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		dataStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置居中
		dataStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 10); // 设置字体大小
		dataStyle.setFont(font);// 选择需要用到的字体格式
		// 设置自动换行
		dataStyle.setWrapText(false);
		return dataStyle;
	}

	@Override
	protected void setColumnsWidth(HSSFSheet sheet) {
		// TODO Auto-generated method stub
		sheet.setColumnWidth(0, 4000);
		sheet.setColumnWidth(1, 4000);
		sheet.setColumnWidth(2, 4000);
		sheet.setColumnWidth(3, 4000);
		sheet.setColumnWidth(4, 3000);
		sheet.setColumnWidth(5, 10000);
		sheet.setColumnWidth(6, 2000);
		sheet.setColumnWidth(7, 2000);
		sheet.setColumnWidth(8, 10000);
	}

}
