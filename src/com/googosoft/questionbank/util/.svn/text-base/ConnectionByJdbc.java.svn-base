package com.googosoft.questionbank.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.googosoft.exception.DBException;
import com.googosoft.exception.PropertiesException;
import com.googosoft.properties.jdbc.JdbcPropertiesBean;
import com.googosoft.properties.jdbc.JdbcPropertiesManager;

public class ConnectionByJdbc {

	public static Connection getConnection() throws DBException{
		JdbcPropertiesBean bean;
		try {
			bean = JdbcPropertiesManager.getInstance().getJdbcPropertiesBean();
			String username=bean.getJdbcUserName();			
			String password=bean.getJdbcPassword();			
			String url=bean.getJdbcUrl();			
			String driver=bean.getJdbcDriver();		
			Class.forName(driver);
			return DriverManager.getConnection(url, username, password);
		} catch (PropertiesException e1) {
			log.error(e1.getMessage());
			throw new DBException(e1);
		} catch (SQLException e) {
			log.error(e.getMessage());
			throw new DBException(e);
		} catch (ClassNotFoundException e) {
			log.error(e.getMessage());
			throw new DBException(e);
		}
		
	}
	private static Logger log =Logger.getLogger(ConnectionByJdbc.class);
}
