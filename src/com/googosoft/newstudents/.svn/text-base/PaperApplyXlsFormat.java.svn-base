package com.googosoft.newstudents;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;

public class PaperApplyXlsFormat {
	protected HSSFCellStyle titleStyle;
	protected HSSFCellStyle dataStyle;
	protected HSSFCellStyle firstThemeStyle;
	protected HSSFCellStyle secondThemeStyle;
	
	@SuppressWarnings("deprecation")
	public void newXLSForListPaper(HttpServletRequest request,HSSFSheet sheet, HSSFRow row, HSSFCell cell,
			List list,HSSFWorkbook workbook) {
		String flag = request.getParameter("flag");
		createFirstThemeCellStyle(workbook);
		createSecondThemeCellStyle(workbook);
		createDataCellStyle(workbook);
		createTitleCellStyle(workbook);
		// 第一行列头
		row = sheet.createRow(0);
		cell = row.createCell(0);
		
		short celln = 0;
		short celle = 5;
		sheet.addMergedRegion(new Region(0,celln,0,celle));
		row.setHeight((short) 500);//高度
		cell = row.createCell(0);
		cell.setCellValue("招生批次表"); // 跨单元格显示的数据
		
		cell.setCellStyle(firstThemeStyle);
		//第2行
		row = sheet.createRow(1);
//		row.setHeight((short) 500);//高度
		cell = row.createCell(0);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue("学生姓名");
		cell.setCellStyle(dataStyle);
		cell = row.createCell(1);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue("性别");
		cell.setCellStyle(dataStyle);
		cell = row.createCell(2);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue("学习专业");
		cell.setCellStyle(dataStyle);
		cell = row.createCell(3);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue("班级名称");
		cell.setCellStyle(dataStyle);
		cell = row.createCell(4);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue("毕业学校");
		cell.setCellStyle(dataStyle);
		cell = row.createCell(5);
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue("招生批次");
		cell.setCellStyle(dataStyle);
		 
		 //其他行(数据行)
			for (int i=0; i < list.size(); i++) {
			 Map map = (Map) list.get(i);
			// 第i+1行
				row = sheet.createRow(i + 2);
				//cell1
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String) map.get("XSXM"));
				cell.setCellStyle(dataStyle);
				//cell2
				String xb =null;
				if("01".equals(map.get("XB"))){xb="男";}
				if("02".equals(map.get("XB"))){xb="女";}
				cell = row.createCell(1);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(xb);
				cell.setCellStyle(dataStyle);
				//cell3
				cell = row.createCell(2);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String)map.get("ZYMC"));
				cell.setCellStyle(dataStyle);
				//cell4
				cell = row.createCell(3);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String)map.get("BJMC"));
				cell.setCellStyle(dataStyle);
				//cell5
				cell = row.createCell(4);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String)map.get("BYXX"));
				cell.setCellStyle(dataStyle);
				//cell6
				cell = row.createCell(5);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String)map.get("PCMC"));
				cell.setCellStyle(dataStyle);
			}
	}
	private String getNowDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(new Date());
	}
	private String getWeek(){
		String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());

        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;

        return weekDays[w];
	}
	private void createFirstThemeCellStyle(HSSFWorkbook workbook) {
		firstThemeStyle = workbook.createCellStyle();

		// 设置边框
		firstThemeStyle.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);
		firstThemeStyle.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);
		firstThemeStyle.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);
		firstThemeStyle.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);
		// // 设置背景色
		// titleStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		// titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置水平居中，垂直居中
		firstThemeStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		firstThemeStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 15); // 设置字体大小
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
		firstThemeStyle.setFont(font);// 选择需要用到的字体格式
		// 设置自动换行
		firstThemeStyle.setWrapText(true);
	}
	private void createSecondThemeCellStyle(HSSFWorkbook workbook) {
		secondThemeStyle = workbook.createCellStyle();

		// 设置边框
		secondThemeStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		secondThemeStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		secondThemeStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		secondThemeStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// // 设置背景色
//		 titleStyle.setFillBackgroundColor(HSSFColor.GREY_40_PERCENT.index);
//		 titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置水平居中，垂直靠下
		secondThemeStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		secondThemeStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_BOTTOM);
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 15); // 设置字体大小
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示 BOLDWEIGHT_NORMAL
		secondThemeStyle.setFont(font);// 选择需要用到的字体格式
		// 设置自动换行
		secondThemeStyle.setWrapText(true);
	}
	
	/**
	 * 列头单元格样式
	 * 
	 * @param workbook
	 * @param sheet
	 */
	private void createTitleCellStyle(HSSFWorkbook workbook) {
		titleStyle = workbook.createCellStyle();

		// 设置边框
		titleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// // 设置背景色
		// titleStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		// titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置居中
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 10); // 设置字体大小
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 粗体显示
		titleStyle.setFont(font);// 选择需要用到的字体格式
		// 设置自动换行
		titleStyle.setWrapText(true);
	}
	
	
	/**
	 * 数据单元格样式
	 * 
	 * @param workbook
	 * @param sheet
	 */
	private void createDataCellStyle(HSSFWorkbook workbook) {
		dataStyle = workbook.createCellStyle();

		// 设置边框
		dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// // 设置背景色
		// dataStyle.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		// dataStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// 设置居左
		dataStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 10); // 设置字体大小

		dataStyle.setFont(font);// 选择需要用到的字体格式
		// 设置自动换行
		dataStyle.setWrapText(true);
	}
}
