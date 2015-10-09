package com.googosoft.questionbank.template;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.Name;
import org.apache.poi.ss.util.CellRangeAddressList;

import com.googosoft.exception.ManagerException;

public abstract class SelectBoxExcel {
	/**
	 * 定义隐藏页的名称
	 */
	private final String hideSheetName = "hideSheet";
	private final String dataSheetName = "sheet1";
	private HSSFWorkbook workbook;
	private HSSFSheet dataSheet;

	public SelectBoxExcel(){
		workbook = new HSSFWorkbook();
	}
	/**
	 * 生成模板
	 * 
	 * @param outPathStr
	 *            输出路径
	 * @throws ManagerException
	 * @throws NameRepeatException
	 */
	final public void createExcelFile(String outPathStr) throws NameRepeatException {
		try {
			//创建工作表dataSheet
			dataSheet = workbook.createSheet(dataSheetName);
			setColumnsWidth(dataSheet);
			
			//创建隐藏的工作表 并添加名称
			HSSFSheet hideSheet = workbook.createSheet(hideSheetName);
			addNames(hideSheet);
			workbook.setSheetHidden(workbook.getSheetIndex(hideSheetName), true);
			
			//创建标题行
			HSSFRow row = dataSheet.createRow(0);
			creatTitleRow(workbook, row);
			
			//创建数据行
			for (int i = 1; i <= 10; i++) {
				row = dataSheet.createRow(i);
				creatDataRow(workbook, dataSheet, row);
			}

			//生成输入文件
			FileOutputStream out = new FileOutputStream(outPathStr);
			workbook.write(out);
			out.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	protected abstract void setColumnsWidth(HSSFSheet dataSheet);

	protected abstract void addNames(HSSFSheet hideSheet)
			throws NameRepeatException;

	protected abstract void creatTitleRow(HSSFWorkbook workbook, HSSFRow row);

	protected abstract void creatDataRow(HSSFWorkbook workbook,
			HSSFSheet sheet, HSSFRow row) throws NameRepeatException;

	/**
	 * 在workbook中生成一条名称，并关联好制定的位置(子类会继承)
	 * 
	 * @param nameName
	 * @param rowIndex
	 * @param length
	 * @throws NameRepeatException
	 */
	protected void createNameByRow(String nameName, int rowIndex, int length)
			throws NameRepeatException {
		Name name = workbook.createName();
		try {
			name.setNameName(nameName.replace(" ", ""));
			name.setRefersToFormula(this.getRegionExpression(rowIndex,
					rowIndex, 0, (length - 1)));
		} catch (java.lang.IllegalArgumentException e) {
			e.printStackTrace();
			throw new NameRepeatException("章节名称不唯一");
		}
	}
	
	/**
	 * 使用已定义的数据源方式设置一个数据验证
	 * 
	 * @param formulaString
	 * @param naturalRowIndex
	 * @param naturalColumnIndex
	 * @return
	 */
	protected DataValidation getDataValidationByFormula(String formulaString,
			int naturalRowIndex, int naturalColumnIndex) {
		// 加载下拉列表内容
		DVConstraint constraint = DVConstraint
				.createFormulaListConstraint(formulaString);
		// 设置数据有效性加载在哪个单元格上。
		// 四个参数分别是：起始行、终止行、起始列、终止列
		int firstRow = naturalRowIndex - 1;
		int lastRow = naturalRowIndex - 1;
		int firstCol = naturalColumnIndex - 1;
		int lastCol = naturalColumnIndex - 1;
		CellRangeAddressList regions = new CellRangeAddressList(firstRow,
				lastRow, firstCol, lastCol);
		// 数据有效性对象
		DataValidation data_validation_list = new HSSFDataValidation(regions,
				constraint);
		return data_validation_list;
	}

	/**
	 * 根据下标获取区域的表达式
	 * 
	 * @param rowStartIndex
	 * @param rowEndIndex
	 * @param colStartIndex
	 * @param colEndIndex
	 * @return
	 */
	private String getRegionExpression(int rowStartIndex, int rowEndIndex,
			int colStartIndex, int colEndIndex) {
		int rowStart = rowStartIndex + 1;
		int rowEnd = rowEndIndex + 1;
		int colStart = colStartIndex + 1;
		int colEnd = colEndIndex + 1;
		String exp = hideSheetName + "!$" + getcellColumnFlag(colStart) + "$"
				+ rowStart + ":$" + getcellColumnFlag(colEnd) + "$" + rowEnd;
		return exp;
	}

	/**
	 * 根据数据值确定单元格位置（比如：28-AB）
	 * 
	 * @param num
	 * @return
	 */
	private String getcellColumnFlag(int num) {
		String columFiled = "";
		int chuNum = 0;
		int yuNum = 0;
		if (num >= 1 && num <= 26) {
			columFiled = doHandle(num);
		} else {
			chuNum = num / 26;
			yuNum = num % 26;

			columFiled += doHandle(chuNum);
			columFiled += doHandle(yuNum);
		}
		return columFiled;
	}

	/**
	 * excel列下标和名称的映射
	 * 
	 * @param num
	 * @return
	 */
	private static String doHandle(int num) {
		String columnFlag = "";
		switch (num) {
		case 1:
			columnFlag = "A";
			break;
		case 2:
			columnFlag = "B";
			break;
		case 3:
			columnFlag = "C";
			break;
		case 4:
			columnFlag = "D";
			break;
		case 5:
			columnFlag = "E";
			break;
		case 6:
			columnFlag = "F";
			break;
		case 7:
			columnFlag = "G";
			break;
		case 8:
			columnFlag = "H";
			break;
		case 9:
			columnFlag = "I";
			break;
		case 10:
			columnFlag = "J";
			break;
		case 11:
			columnFlag = "K";
			break;
		case 12:
			columnFlag = "L";
			break;
		case 13:
			columnFlag = "M";
			break;
		case 14:
			columnFlag = "N";
			break;
		case 15:
			columnFlag = "O";
			break;
		case 16:
			columnFlag = "P";
			break;
		case 17:
			columnFlag = "Q";
			break;
		case 18:
			columnFlag = "R";
			break;
		case 19:
			columnFlag = "S";
			break;
		case 20:
			columnFlag = "T";
			break;
		case 21:
			columnFlag = "U";
			break;
		case 22:
			columnFlag = "V";
			break;
		case 23:
			columnFlag = "W";
			break;
		case 24:
			columnFlag = "X";
			break;
		case 25:
			columnFlag = "Y";
			break;
		case 26:
			columnFlag = "Z";
			break;
		}
		return columnFlag;
	}

}
