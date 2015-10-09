package com.googosoft.party.partyManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;

import com.googosoft.commons.CodeHelper;
import com.googosoft.commons.Validate;
import com.googosoft.exception.DBException;
import com.googosoft.exception.ManagerException;
import com.googosoft.exception.PageException;
import com.googosoft.exception.QueryException;
import com.googosoft.page.PageInfo;
import com.googosoft.zapi.DBHelper;
import com.googosoft.zapi.PageHelper;
import com.googosoft.zapi.QueryHelper;

public class MemberImportUtil {

	private Logger logger = Logger.getLogger(MemberImportUtil.class.getName());

	/**
	 * 该方法读取文件，并验证该文件的格式是否符合要求，符合要求则返回一个workBook 否则，抛出IOException异常
	 * 
	 * @param directory
	 * @return
	 * @throws IOException
	 */
	public HSSFWorkbook validateFile(String directory) throws IOException {
		// 读取文件
		logger.info("读取临时文件......");
		System.out.println(directory);
		FileInputStream in;
		HSSFWorkbook workBook = null;
		in = new FileInputStream(new File(directory));
		workBook = new HSSFWorkbook(in);
		return workBook;
	}

	/**
	 * 该方法的作用是读取一个workBook对象将正确信息保存到rightRecords中
	 * 将错误信息保存到errorRecords中，若errorRecords中有记录则返回errorRecords
	 * 否则说明该workBook中全是正确信息，则返回rightRecords
	 * 
	 * @param workBook
	 * @throws ManagerException 
	 */
	public List readRecords(HSSFWorkbook workBook) throws ManagerException {
		List<Map> rightRecords = new ArrayList<Map>();
		List<String> errorRecords = new ArrayList<String>();
		// 读取工作表
		logger.info("读取sheetAt(0)数据......");
		HSSFSheet sheet = workBook.getSheetAt(0);
		String sheetName = sheet.getSheetName();

		int rows = sheet.getLastRowNum();
		logger.info("获取到" + (rows + 1) + "行");

		for (int j = 1; j < rows + 1; j++) {

			// 循环获取行数
			HSSFRow row = sheet.getRow(j);

			// 如果改行为空行，则跳过此行
			if (Validate.isNull(row)) {
				continue;
			}

			// 不为空行，则分别获取单元格
			Map map = new HashMap<String, String>();
			String id = CodeHelper.createUUID();
			map.put("id", id);
			
			// 1 姓名
			Cell cell1 = row.getCell(0);
			boolean b1 = Validate.noNull(cell1);
			if (b1) {
				if (cell1.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String memberName = cell1.getStringCellValue();
					if (memberName.length() < 20) {
						map.put("memberName", memberName);
					} else {
						errorRecords.add("第" + (j + 1) + "行第1列数据过大");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第1列数据格式错误");
					logger.info("第" + (j + 1) + "行第1列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第1列为空");
				logger.info("第" + (j + 1) + "行第1列为空");
			}
			
			// 2 性别
			Cell cell2 = row.getCell(1);
			boolean b2 = Validate.noNull(cell2);
			if (b2) {
				if (cell2.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String memberSex = cell2.getStringCellValue();
					System.out.println(memberSex.length());
					if ("男".equals(memberSex)) {
						map.put("memberSex", "0");
					} else if("女".equals(memberSex)){
						map.put("memberSex", "1");
					} else {
						errorRecords.add("第" + (j + 1) + "行第2列的值不符合规范");
						logger.info("第" + (j + 1) + "行第2列的值不符合规范");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第2列数据格式错误");
					logger.info("第" + (j + 1) + "行第2列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第2列为空");
				logger.info("第" + (j + 1) + "行第2列为空");
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			// 3 出生年月
			Cell cell3 = row.getCell(2);
			boolean b3 = Validate.noNull(cell3);
			String date = "";
			if (b3) {
				if (cell3.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					date = cell3.getStringCellValue();
					if(date.length()==7){
						map.put("date", date);
					}else{
						errorRecords.add("第" + (j + 1) + "行第3列数据不是日期类型");
						logger.info("第" + (j + 1) + "行第3列数据不是日期类型");
					}
				} else {
					errorRecords.add("第" + (j + 1) + "行第3列数据格式错误");
					logger.info("第" + (j + 1) + "行第3列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第3列为空");
				logger.info("第" + (j + 1) + "行第3列为空");
			}
			
			// 4 身份证
			Cell cell4 = row.getCell(3);
			boolean b4 = Validate.noNull(cell4);
			if (b4) {
				if (cell4.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String IDNumber = cell4.getStringCellValue();
					if (IDNumber.length() == 18 || IDNumber.length() == 15) {
						map.put("IDNumber", IDNumber);
					} else {
						errorRecords.add("第" + (j + 1) + "行第4列数据长度不对");
						logger.info("第" + (j + 1) + "行第4列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第4列数据格式错误");
					logger.info("第" + (j + 1) + "行第4列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第4列为空");
				logger.info("第" + (j + 1) + "行第4列为空");
			}
			
			// 5 民族
			Cell cell5 = row.getCell(4);
			boolean b5 = Validate.noNull(cell5);
			if (b5) {
				if (cell5.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String memberNation = cell5.getStringCellValue();
					if (memberNation.length() < 20) {
						map.put("memberNation", memberNation);
					} else {
						errorRecords.add("第" + (j + 1) + "行第5列数据长度不对");
						logger.info("第" + (j + 1) + "行第5列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第5列数据格式错误");
					logger.info("第" + (j + 1) + "行第5列数据格式错误");
				}
			} else {
				map.put("memberNation", "");
			}
			
			// 6 年龄
			Cell cell6 = row.getCell(5);
			boolean b6 = Validate.noNull(cell6);
			if (b6) {
				if (cell6.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String age = cell6.getStringCellValue();
					if (age.length()==2) {
						map.put("age", age);
					} else {
						errorRecords.add("第" + (j + 1) + "行第6列数据不对");
						logger.info("第" + (j + 1) + "行第6列数据过大");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第6列数据格式错误");
					logger.info("第" + (j + 1) + "行第6列数据格式错误");
				}
			} else {
				map.put("age", "");
			}
			
			// 7 第一次申请入党时间
			Cell cell7 = row.getCell(6);
			boolean b7 = Validate.noNull(cell7);
			String joinDang = "";
			if (b7) {
				if (cell7.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					joinDang = cell7.getStringCellValue();
					try {
						sdf.parse(joinDang);
						map.put("joinDang", joinDang);
					} catch (Exception e) {
						errorRecords.add("第" + (j + 1) + "行第7列数据不是日期类型");
						logger.info("第" + (j + 1) + "行第7列数据不是日期类型");
						b7 = false;
					}
				} else if (cell7.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
					errorRecords.add("第" + (j + 1) + "行第7列数据格式错误");
					logger.info("第" + (j + 1) + "行第7列数据格式错误");
				} else {
					joinDang = sdf.format(cell7.getDateCellValue());
					map.put("joinDang", joinDang);
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第7列为空");
				logger.info("第" + (j + 1) + "行第7列为空");
			}
			
			// 8 入党介绍人
			Cell cell8 = row.getCell(7);
			boolean b8 = Validate.noNull(cell8);
			if (b8) {
				if (cell8.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String introduter = cell8.getStringCellValue();
					if (introduter.length() < 20) {
						map.put("introduter", introduter);
					} else {
						errorRecords.add("第" + (j + 1) + "行第8列数据长度不对");
						logger.info("第" + (j + 1) + "行第8列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第8列数据格式错误");
					logger.info("第" + (j + 1) + "行第8列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第8列为空");
				logger.info("第" + (j + 1) + "行第8列为空");
			}
			
			// 9 电话
			Cell cell9 = row.getCell(8);
			boolean b9 = Validate.noNull(cell9);
			String memberTel = "";
			if (b9) {
				if (cell9.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					memberTel = cell9.getStringCellValue();
					if (memberTel.length() <= 11 && memberTel.length() >= 7) {
						map.put("memberTel", memberTel);
					} else {
						errorRecords.add("第" + (j + 1) + "行第9列数据长度不对");
						logger.info("第" + (j + 1) + "行第9列数据不对");
					}
				} else {
					errorRecords.add("第" + (j + 1) + "行第10列数据格式错误");
					logger.info("第" + (j + 1) + "行第10列数据格式错误");
				}
			} else {
				map.put("memberTel", "");
			}
			
			// 10 籍贯
			Cell cell10 = row.getCell(9);
			boolean b10 = Validate.noNull(cell10);
			if (b10) {
				if (cell10.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String nativePlace = cell10.getStringCellValue();
					if (nativePlace.length() < 20) {
						map.put("nativePlace", nativePlace);
					} else {
						errorRecords.add("第" + (j + 1) + "行第10列数据长度不对");
						logger.info("第" + (j + 1) + "行第10列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第10列数据格式错误");
					logger.info("第" + (j + 1) + "行第10列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第10列为空");
				logger.info("第" + (j + 1) + "行第10列为空");
			}
			
			// 11 出生地
			Cell cell11 = row.getCell(10);
			boolean b11 = Validate.noNull(cell11);
			if (b11) {
				if (cell11.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String chushengdi = cell10.getStringCellValue();
					if (chushengdi.length() < 20) {
						map.put("chushengdi", chushengdi);
					} else {
						errorRecords.add("第" + (j + 1) + "行第11列数据长度不对");
						logger.info("第" + (j + 1) + "行第11列数据长度不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第11列数据格式错误");
					logger.info("第" + (j + 1) + "行第11列数据格式错误");
				}
			} else {
				map.put("chushengdi", "");
			}
			
			// 12 家庭住址
			Cell cell12 = row.getCell(11);
			boolean b12 = Validate.noNull(cell12);
			if (b12) {
				if (cell12.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String address = cell10.getStringCellValue();
					if (address.length() < 20) {
						map.put("address", address);
					} else {
						errorRecords.add("第" + (j + 1) + "行第10列数据长度不对");
						logger.info("第" + (j + 1) + "行第10列数据长度不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第12列数据格式错误");
					logger.info("第" + (j + 1) + "行第12列数据格式错误");
				}
			} else {
				map.put("address", "");
			}
			
			// 13 隶属支部
			Cell cell13 = row.getCell(12);
			boolean b13 = Validate.noNull(cell13);
			if (b13) {
				if (cell13.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String dangzuzhi = cell13.getStringCellValue();
					if (dangzuzhi.length() < 40) {
						List list = findListByDangzuzhi(dangzuzhi);
						if (list.size()==1){
							Map mm = (Map)list.get(0);
							map.put("committeeId", (String)mm.get("COMMITTEEID"));
							map.put("committeeName", (String)mm.get("COMMITTEENAME"));
						} else {
							errorRecords.add("第" + (j + 1) + "行第13列店铺名称不存在或者不唯一");
							logger.info("第" + (j + 1) + "行第13列店铺名称不存在或者不唯一");
						}
					} else {
						errorRecords.add("第" + (j + 1) + "行第13列数据长度过大");
						logger.info("第" + (j + 1) + "行第13列数据过过大");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第13列数据格式错误");
					logger.info("第" + (j + 1) + "行第13列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第13列为空");
				logger.info("第" + (j + 1) + "行第13列为空");
			}
			
			// 14 在岗情况
			Cell cell14 = row.getCell(13);
			boolean b14 = Validate.noNull(cell14);
			if (b14) {
				if (cell14.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String isJob = cell14.getStringCellValue();
					if ("在职".equals(isJob)) {
						map.put("isJob", "1");
					} else if("退休".equals(isJob)){
						map.put("isJob", "0");
					} else {
						errorRecords.add("第" + (j + 1) + "行第14列的值不符合规范");
						logger.info("第" + (j + 1) + "行第14列的值不符合规范");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第14列数据格式错误");
					logger.info("第" + (j + 1) + "行第14列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第14列为空");
				logger.info("第" + (j + 1) + "行第14列为空");
			}
			
			// 15 列为积极分子时间
			Cell cell15 = row.getCell(14);
			boolean b15 = Validate.noNull(cell15);
			String isjjfzDate = "";
			if (b15) {
				if (cell15.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					isjjfzDate = cell15.getStringCellValue();
					try {
						sdf.parse(isjjfzDate);
						map.put("isjjfzDate", isjjfzDate);
					} catch (Exception e) {
						errorRecords.add("第" + (j + 1) + "行第15列数据不是日期类型");
						logger.info("第" + (j + 1) + "行第15列数据不是日期类型");
						b15 = false;
					}
				} else if (cell15.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
					errorRecords.add("第" + (j + 1) + "行第15列数据格式错误");
					logger.info("第" + (j + 1) + "行第15列数据格式错误");
				} else {
					isjjfzDate = sdf.format(cell15.getDateCellValue());
					map.put("isjjfzDate", isjjfzDate);
				}
			} else {
				map.put("isjjfzDate", "");
			}
			
			// 16 职务
			Cell cell16 = row.getCell(15);
			boolean b16 = Validate.noNull(cell16);
			if (b16) {
				if (cell16.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String job = cell16.getStringCellValue();
					if (job.length() < 20) {
						map.put("job", job);
					} else {
						errorRecords.add("第" + (j + 1) + "行第16列数据长度不对");
						logger.info("第" + (j + 1) + "行第16列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第16列数据格式错误");
					logger.info("第" + (j + 1) + "行第16列数据格式错误");
				}
			} else {
				map.put("job", "");
			}
			
			// 17 任命时间
			Cell cell17 = row.getCell(16);
			boolean b17 = Validate.noNull(cell17);
			String jobDate = "";
			if (b17) {
				if (cell17.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					jobDate = cell17.getStringCellValue();
					try {
						sdf.parse(jobDate);
						map.put("jobDate", jobDate);
					} catch (Exception e) {
						errorRecords.add("第" + (j + 1) + "行第17列数据不是日期类型");
						logger.info("第" + (j + 1) + "行第17列数据不是日期类型");
						b17 = false;
					}
				} else if (cell17.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
					errorRecords.add("第" + (j + 1) + "行第17列数据格式错误");
					logger.info("第" + (j + 1) + "行第17列数据格式错误");
				} else {
					jobDate = sdf.format(cell17.getDateCellValue());
					map.put("jobDate", jobDate);
				}
			} else {
				map.put("jobDate", "");
			}
			
			// 18 学历专业
			Cell cell18 = row.getCell(17);
			boolean b18 = Validate.noNull(cell18);
			if (b18) {
				if (cell18.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String eduCation = cell18.getStringCellValue();
					if (eduCation.length() < 20) {
						map.put("eduCation", eduCation);
					} else {
						errorRecords.add("第" + (j + 1) + "行第18列数据长度不对");
						logger.info("第" + (j + 1) + "行第18列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第18列数据格式错误");
					logger.info("第" + (j + 1) + "行第18列数据格式错误");
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第18列为空");
				logger.info("第" + (j + 1) + "行第18列为空");
			}
			
			// 19 取得时间
			Cell cell19 = row.getCell(18);
			boolean b19 = Validate.noNull(cell19);
			String culdate = "";
			if (b19) {
				if (cell19.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					culdate = cell19.getStringCellValue();
					try {
						sdf.parse(culdate);
						map.put("culdate", culdate);
					} catch (Exception e) {
						errorRecords.add("第" + (j + 1) + "行第19列数据不是日期类型");
						logger.info("第" + (j + 1) + "行第19列数据不是日期类型");
						b19 = false;
					}
				} else if (cell19.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
					errorRecords.add("第" + (j + 1) + "行第19列数据格式错误");
					logger.info("第" + (j + 1) + "行第19列数据格式错误");
				} else {
					joinDang = sdf.format(cell19.getDateCellValue());
					map.put("culdate", culdate);
				}
			} else {
				errorRecords.add("第" + (j + 1) + "行第19列为空");
				logger.info("第" + (j + 1) + "行第19列为空");
			}
			
			// 20 职称
			Cell cell20 = row.getCell(19);
			boolean b20 = Validate.noNull(cell20);
			if (b20) {
				if (cell20.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String vocation = cell20.getStringCellValue();
					if (vocation.length() < 20) {
						map.put("vocation", vocation);
					} else {
						errorRecords.add("第" + (j + 1) + "行第20列数据长度不对");
						logger.info("第" + (j + 1) + "行第20列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第20列数据格式错误");
					logger.info("第" + (j + 1) + "行第20列数据格式错误");
				}
			} else {
				map.put("vocation", "");
			}
			
			// 21 评审时间
			Cell cell21 = row.getCell(20);
			boolean b21 = Validate.noNull(cell21);
			String vocationDate = "";
			if (b21) {
				if (cell21.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					vocationDate = cell21.getStringCellValue();
					try {
						sdf.parse(vocationDate);
						map.put("vocationDate", vocationDate);
					} catch (Exception e) {
						errorRecords.add("第" + (j + 1) + "行第21列数据不是日期类型");
						logger.info("第" + (j + 1) + "行第21列数据不是日期类型");
						b21 = false;
					}
				} else if (cell21.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
					errorRecords.add("第" + (j + 1) + "行第21列数据格式错误");
					logger.info("第" + (j + 1) + "行第21列数据格式错误");
				} else {
					joinDang = sdf.format(cell21.getDateCellValue());
					map.put("vocationDate", vocationDate);
				}
			} else {
				map.put("vocationDate", "");
			}
			
			// 22 备注
			Cell cell22 = row.getCell(21);
			boolean b22 = Validate.noNull(cell22);
			if (b22) {
				if (cell22.getCellType() == HSSFCell.CELL_TYPE_STRING) {
					String remark = cell22.getStringCellValue();
					if (remark.length() < 400) {
						map.put("remark", remark);
					} else {
						errorRecords.add("第" + (j + 1) + "行第22列数据长度不对");
						logger.info("第" + (j + 1) + "行第22列数据不对");
					}
				}else{
					errorRecords.add("第" + (j + 1) + "行第22列数据格式错误");
					logger.info("第" + (j + 1) + "行第22列数据格式错误");
				}
			} else {
				map.put("remark", "");
			}
			
			// 如果13列均不为空，则将数据放入list中
			System.out.println("第" + j + "行数据：" + map);
			if (b1 && b2 && b3 && b4 && b7 && b8 && b10 && b13 && b14 && b18 && b19) {
				rightRecords.add(map);
			}
		}

		if (errorRecords.size() > 0) {
			return errorRecords;
		} else {
			return rightRecords;
		}
	}

	/**
	 * 导入rightRecords集合到数据库
	 * 
	 * @param sheet
	 * @throws SQLException
	 * @throws DBException
	 * @throws ImportException
	 */
	public boolean importExcel(List<Map> rightRecords,String saas,String userId) {
		
		try {
			for (int i = 0; i < rightRecords.size(); i++) {
				Map map = rightRecords.get(i);
				StringBuffer sql = new StringBuffer();
				sql.append("INSERT INTO MEMBER(MEMBERID,NAME,SEX,BIRTHDAY,CARDID,NATION,AGE," +
						"INPARTYDATE,INTRODUCER,TEL,NATIVEPLACE,CHUSHENGDI,ADDRESS," +
						"FORCOMMITTEE,COMMITTEEID,ISJOB,ISJJFZDATE,JOB,JOBDATE,CULTURE," +
						"CULDATE,VOCATION,VOCATIONDATE,REMARK,MARK,CREATETIME,USERIDBYLOGIN,SAAS)");
				sql.append("VALUES(");

				String id = (String) map.get("id");
				sql.append("'" + id + "',");

				// 1 姓名
				String memberName = (String)map.get("memberName");
				sql.append("'" + memberName + "',");

				// 2 性别
				String memberSex = (String)map.get("memberSex");
				sql.append("'" + memberSex + "',");

				// 3 出生年月
				String date = (String)map.get("date");
				sql.append("'" + date + "',");

				// 4 身份证
				String IDNumber = (String) map.get("IDNumber");
				sql.append("'" + IDNumber + "',");

				// 5 民族
				String memberNation = (String) map.get("memberNation");
				sql.append("'" + memberNation + "',");

				// 6 年龄
				String age = (String) map.get("age");
				sql.append("'" + age + "',");

				// 7 第一次申请入团时间
				String joinTuan = (String) map.get("joinDang");
//				sql.append("'" + joinTuan + "',");
				sql.append("to_date('" + joinTuan + "','yyyy-MM-dd'),");

				// 8 入党介绍人
				String introduter = (String) map.get("introduter");
				sql.append("'" + introduter + "',");

				// 9 电话
				String memberTel = (String) map.get("memberTel");
				sql.append("'" + memberTel + "',");

				// 10 籍贯
				String nativePlace = (String) map.get("nativePlace");
				sql.append("'" + nativePlace + "',");

				// 11 出生地
				String chushengdi = (String) map.get("chushengdi");
				sql.append("'" + chushengdi + "',");

				// 12 家庭住址
				String address = (String) map.get("address");
				sql.append("'" + address + "',");

				// 13 隶属支部
				String committeeId = (String) map.get("committeeId");
				String committeeName = (String) map.get("committeeName");
				sql.append("'" +committeeName+ "','"+committeeId +"',");

				// 14 在岗情况
				String isJob = (String) map.get("isJob");
				sql.append("'" + isJob + "',");

				// 15 列为积极分子时间
				String isjjfzDate = (String) map.get("isjjfzDate");
				sql.append("'" + isjjfzDate + "',");

				// 16 职务
				String job = (String) map.get("job");
				sql.append("'" + job + "',");

				// 17 任命时间
				String jobDate = (String) map.get("jobDate");
				sql.append("'" + jobDate + "',");

				// 18 学历专业
				String eduCation = (String) map.get("eduCation");
				sql.append("'" + eduCation + "',");

				// 19 取得时间
				String culdate = (String) map.get("culdate");
				sql.append("'" + culdate + "',");

				// 20 职称
				String vocation = (String) map.get("vocation");
				sql.append("'" + vocation + "',");

				// 21 评审时间
				String vocationDate = (String) map.get("vocationDate");
				sql.append("'" + vocationDate + "',");

				// 22 备注
				String remark = (String) map.get("remark");
				sql.append("'" + remark + "',1,sysdate,'"+userId+"','"+saas+"')");

				logger.info("向数据库插入数据......");
				new DBHelper().execute(sql.toString());

			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 根据团组织名称查找团组织
	 * @param tuanzuzhi
	 * @return
	 * @throws ManagerException
	 */
	public List findListByDangzuzhi(String dangzuzhi) throws ManagerException {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT * FROM COMMITTEE T ");
		sql.append(" WHERE 1 = 1 ");
		sql.append(" AND COMMITTEENAME='"+dangzuzhi+"' ");
		DBHelper dbHelper=new DBHelper();
		List list=null;
		try {
			list=dbHelper.queryForList(sql.toString());
		} catch (DBException e) {
			logger.error("查询数据库失败\n" + e);
			throw new ManagerException("查询数据库失败\n" + e);
		}
		return list;
	}
	
	/**
	 * Excel导出
	 * @param directory
	 * @param idSet
	 */
	public void exportExcel(String directory,String idSet) {
		FileOutputStream fOut;
		try {
			logger.info("查询数据库......");
			List list = new DBHelper().queryForList("select * from MEMBER where MEMBERID in('"+idSet+"')");
			logger.info("生成EXCEL表格......");
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("sheet1");
			HSSFRow row = null;
			HSSFCell cell = null;

			// 第一行
			row = sheet.createRow(0);
			cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("党员基本信息表");
			// 第二行
			row = sheet.createRow(1);
			cell = row.createCell(0);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("姓名");
			cell = row.createCell(1);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("性别");
			cell = row.createCell(2);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("出生年月");
			cell = row.createCell(3);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("身份证号");
			cell = row.createCell(4);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("民族");
			cell = row.createCell(5);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("年龄");
			cell = row.createCell(6);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("第一次申请入党时间");
			cell = row.createCell(7);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("入党介绍人");
			cell = row.createCell(8);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("电话");
			cell = row.createCell(9);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("籍贯");
			cell = row.createCell(10);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("出生地");
			cell = row.createCell(11);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("家庭住址");
			cell = row.createCell(12);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("隶属支部");

			cell = row.createCell(13);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("在岗情况");
			cell = row.createCell(14);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("列为积极分子时间");
			cell = row.createCell(15);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("职务");
			cell = row.createCell(16);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("任命时间");
			cell = row.createCell(17);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("学历专业");
			cell = row.createCell(18);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("取得时间");
			cell = row.createCell(19);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("职称");
			cell = row.createCell(20);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("评审时间");
			cell = row.createCell(21);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("备注");

			SimpleDateFormat dateSDF = new SimpleDateFormat("yyyy-MM-dd");
			// 其他行
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map) list.get(i);
				// 第i+2行
				row = sheet.createRow(i + 2);
				
				//姓名
				cell = row.createCell(0);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String) map.get("NAME"));
				
				//性别
				cell = row.createCell(1);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if("1".equals(map.get("SEX").toString())){
					cell.setCellValue("女");
				}else{
					cell.setCellValue("男");
				}
				
				//出生日期
				cell = row.createCell(2);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(map.get("BIRTHDAY").toString());

				//省份证号
				cell = row.createCell(3);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((String)map.get("CARDID"));

				//民族
				cell = row.createCell(4);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("NATION"))){
					cell.setCellValue((String)map.get("NATION"));
				}

				//年龄
				cell = row.createCell(5);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("AGE"))){
					cell.setCellValue((String)map.get("AGE"));
				}

				//第一次申请入党时间
				cell = row.createCell(6);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(map.get("INPARTYDATE").toString());
				
				//入党介绍人
				cell = row.createCell(7);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(map.get("INTRODUCER").toString());

				//电话
				cell = row.createCell(8);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("TEL"))){
					cell.setCellValue((String)map.get("TEL"));
				}
				
				//籍贯
				cell = row.createCell(9);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("NATIVEPLACE"))){
					cell.setCellValue((String)map.get("NATIVEPLACE"));
				}

				//出生地
				cell = row.createCell(10);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("CHUSHENGDI"))){
					cell.setCellValue((String)map.get("CHUSHENGDI"));
				}
				
				//家庭住址
				cell = row.createCell(11);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("ADDRESS"))){
					cell.setCellValue((String)map.get("ADDRESS"));
				}

				//隶属党支部
				cell = row.createCell(12);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("FORCOMMITTEE"))){
					cell.setCellValue((String)map.get("FORCOMMITTEE"));
				}

				//在岗情况
				cell = row.createCell(13);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if("0".equals(map.get("ISJOB"))){
					cell.setCellValue("退休");
				}else{
					cell.setCellValue("在职");
				}

				//列为积极分子时间
				cell = row.createCell(14);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("ISJJFZDATE"))){
					cell.setCellValue((String)map.get("ISJJFZDATE"));
				}

				//职务
				cell = row.createCell(15);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("JOB"))){
					cell.setCellValue((String)map.get("JOB"));
				}

				//任命时间
				cell = row.createCell(16);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("JOBDATE"))){
					cell.setCellValue((String)map.get("JOBDATE"));
				}

				//学历专业
				cell = row.createCell(17);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("CULTURE"))){
					cell.setCellValue((String)map.get("CULTURE"));
				}

				//取得时间
				cell = row.createCell(18);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("CULDATE"))){
					cell.setCellValue((String)map.get("CULDATE"));
				}

				//职称
				cell = row.createCell(19);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("VOCATION"))){
					cell.setCellValue((String)map.get("VOCATION"));
				}

				//评审时间
				cell = row.createCell(20);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("VOCATIONDATE"))){
					cell.setCellValue((String)map.get("VOCATIONDATE"));
				}

				//备注
				cell = row.createCell(21);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				if(validateNotNull(map.get("REMARK"))){
					cell.setCellValue((String)map.get("REMARK"));
				}

			}
			logger.info("写入到临时文件" + directory);
			fOut = new FileOutputStream(new File(directory));
			workbook.write(fOut);
			fOut.flush();
			fOut.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	public boolean validateNotNull(Object obj){
		if(obj==null){
			return false;
		}else if(obj.toString().length()==0){
			return false;
		}else if("".equals(obj) || "null".equals(obj)){
			return false;
		}else{
			return true;
		}
	}
}