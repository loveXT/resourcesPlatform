package com.googosoft.party.util;

import com.googosoft.zapi.DBHelper;

public class SaveExcel {

	public boolean save(Excel e) throws Exception {
		boolean flag = true;
		String sql = "insert into member (MEMBERID,NAME,SEX,BIRTHDAY,CARDID,NATION,VOCATION,POLITICAL,CULTURE,EMAIL,MOBILE,TEL,NATIVEPLACE,ADDRESS,INTRODUCER,INPARTYDATE,JOB,SAAS,USERIDBYLOGIN,COMMITTEEID,TEACHERID,CREATETIME,MARK)"
				+ " values('"
				+ e.getMemberId()
				+ "','"
				+ e.getName()
				+ "','"
				+ e.getSex()
				+ "',"
				+ e.getBirthday()
				+ ",'"
				+ e.getCardId()
				+ "','"
				+ e.getNation()
				+ "','"
				+ e.getVocation()
				+ "','"
				+ e.getPolitical()
				+ "','"
				+ e.getCulture()
				+ "','"
				+ e.getEmail()
				+ "','"
				+ e.getMobile()
				+ "','"
				+ e.getTel()
				+ "','"
				+ e.getNativePlace()
				+ "','"
				+ e.getAddress()
				+ "','"
				+ e.getIntroducer()
				+ "',"
				+ e.getInPartyDate()
				+ ",'"
				+ e.getJob()
				+ "','"
				+ e.getSaas()
				+ "','"
				+ e.getUserIdByLogin()
				+ "','"
				+ e.getCommitteeId()
				+ "','"
				+ e.getTeacherId()
				+ "',"
				+ e.getCreateTime()
				+ ",'"
				+ e.getMark() + "')";

		DBHelper db = new DBHelper();

		db.execute(sql);

		return flag;
	}
}
