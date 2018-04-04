package com.swx.util;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

public class JDBCUtil {
	
	private static DataSource ds;
	//定义二级缓存，用于存储链接
	private static ThreadLocal<Connection> local = new ThreadLocal<Connection>();
	
	//读取配置文件,将信息存入propeties对象
	static{
		try {
			Properties p = new Properties();
			p.load(JDBCUtil.class.getClassLoader().getResourceAsStream("com/swx/config/jdbc.properties"));
			ds=BasicDataSourceFactory.createDataSource(p);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	//采用二级缓存机制(ThreadLocal设计模式),懒汉式单例
	public static Connection getConnection(){
		//从二级缓存中取该链接
		Connection con=local.get();
		if(con==null){
			try {
				//通过数据源(类似于一级缓存)中取该链接
				con=ds.getConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			local.set(con);
		}
		return con;
	}
	public static void close(Connection con,PreparedStatement ps,ResultSet rs){
		try {
			if(rs!=null){
				rs.close();
			}
			if(ps!=null){
				ps.close();
			}
			if(con!=null){
				con.close();
				//从二级缓存中移除该链接
				local.remove();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(){
		try {
			//从二级缓存中获取该链接，再关闭，再移除
			local.get().close();
			local.remove();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void main(String[] args) {
		Connection con=JDBCUtil.getConnection();
		JDBCUtil.close(con, null, null);
	}

}
