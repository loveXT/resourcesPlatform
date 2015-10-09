package com.googosoft.party.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDataFormatter;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFDataValidationHelper;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;

public class ExcelReader {
	private static final SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd");
	private HSSFWorkbook wb = null;
	private HSSFSheet sheet = null;
	private HSSFRow row = null;
	private int sheetNum = 0;
	private int rowNum = 0;
	private FileInputStream fis = null;
	private File file = null;

	public ExcelReader() {

	}

	public ExcelReader(File file) {
		this.file = file;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	public void setSheetNum(int sheetNum) {
		this.sheetNum = sheetNum;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public void open() throws IOException {

		fis = new FileInputStream(file);
		
		wb = new HSSFWorkbook(new POIFSFileSystem(fis));
		
		fis.close();
	}

	public int getSheetCount() {
		
		int sheetCount = -1;
		
		sheetCount = wb.getNumberOfSheets();
		
		return sheetCount;
	}

	public int getRowCount() {

		if (wb == null) {
			return -1;
		}

		HSSFSheet sheet = wb.getSheetAt(this.sheetNum);

		int rowCount = -1;

		rowCount = sheet.getLastRowNum();

		return rowCount;

	}

	public int getRowCount(int sheetNum) {

		HSSFSheet sheet = wb.getSheetAt(sheetNum);

		int rowCount = -1;

		rowCount = sheet.getLastRowNum();

		return rowCount;

	}

	public String[] readExcelLine(int lineNum) {

		return readExcelLine(this.sheetNum, lineNum);

	}

	public String[] readExcelLine(int sheetNum, int lineNum) {

		if (sheetNum < 0 || lineNum < 0)

			return null;

		String[] strExcelLine = null;

		try {

			sheet = wb.getSheetAt(sheetNum);

			row = sheet.getRow(lineNum);

			int cellCount = row.getLastCellNum();

			strExcelLine = new String[cellCount + 1];

			for (int i = 0; i <= cellCount; i++) {

				strExcelLine[i] = readStringExcelCell(lineNum, i);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return strExcelLine;

	}

	public String readStringExcelCell(int cellNum) {

		return readStringExcelCell(this.rowNum, cellNum);

	}

	public String readStringExcelCell(int rowNum, int cellNum) {

		return readStringExcelCell(this.sheetNum, rowNum, cellNum);

	}

	public String readStringExcelCell(int sheetNum, int rowNum, int cellNum) {

		if (sheetNum < 0 || rowNum < 0)

			return "";

		String strExcelCell = "";

		try {

			sheet = wb.getSheetAt(sheetNum);

			row = sheet.getRow(rowNum);

			if (row.getCell((short) cellNum) != null) { // add this condition

				// judge

				switch (row.getCell((short) cellNum).getCellType()) {

					case HSSFCell.CELL_TYPE_FORMULA:strExcelCell = "FORMULA ";
	
						break;
	
					case HSSFCell.CELL_TYPE_NUMERIC: {
						Cell ce =row.getCell((short) cellNum);
	
						if(HSSFDateUtil.isCellDateFormatted(ce)){
							strExcelCell = sdf.format(ce.getDateCellValue());
						}else{
							strExcelCell = String.valueOf(row.getCell((short) cellNum).getNumericCellValue());

						}
	
					}
						break;
	
					case HSSFCell.CELL_TYPE_STRING:strExcelCell = row.getCell((short) cellNum).getStringCellValue();
	
						break;
	
					case HSSFCell.CELL_TYPE_BLANK:strExcelCell = "";
	
						break;
	
					default:
						strExcelCell = "";
	
						break;

				}

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return strExcelCell;

	}

	public static void main(String args[]) {

		File file = new File("D:\\test.xls");

		ExcelReader readExcel = new ExcelReader(file);

		try {

			readExcel.open();

		} catch (IOException e) {

			e.printStackTrace();

		}

		readExcel.setSheetNum(0);

		int count = readExcel.getRowCount();

		for (int i = 0; i <= count; i++) {

			String[] rows = readExcel.readExcelLine(i);
			for (int j = 0; j < rows.length; j++) {
				System.out.print(rows[j] + " ");
			}
			System.out.print("\n");
		}

	}
}
