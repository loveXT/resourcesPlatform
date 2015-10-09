package com.googosoft.mess.menu;

import com.googosoft.exception.CUMException;
import com.googosoft.zapi.CUMHelper;

public class test {
	public static void main(String[] args) throws CUMException {
		CUMHelper cumHelper = new CUMHelper("MEALDAY","MEALDAYID");
//		cumHelper.getManagerToPrintByDb();
//		cumHelper.getCreateToPrintByDB();
		cumHelper.getUpdateToPrintByDB();
	}
}