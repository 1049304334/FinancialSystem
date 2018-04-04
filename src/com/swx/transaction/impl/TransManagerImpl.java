package com.swx.transaction.impl;

import java.sql.Connection;
import java.sql.SQLException;

import com.swx.transaction.TransManagerI;
import com.swx.util.JDBCUtil;

/**
 * 事务管理的实现类
 *
 */
public class TransManagerImpl implements TransManagerI {

	public void beginTrans(){
		try {
			Connection con = JDBCUtil.getConnection();
			con.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void commitTrans() {
		Connection con = null;
		try {
			con = JDBCUtil.getConnection();
			con.commit();
			con.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(con, null, null);
		}
	}

	public void rollbackTrans(){
		Connection con = null;
		try {
			con = JDBCUtil.getConnection();
			con.rollback();
			con.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			System.out.println("出现异常，事务已被回滚！");
			JDBCUtil.close(con, null, null);
		}
	}

}
