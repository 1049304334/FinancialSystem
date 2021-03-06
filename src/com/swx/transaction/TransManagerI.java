package com.swx.transaction;


/**
 * 事务管理接口
 *
 */
public interface TransManagerI {
	//开启事务
	void beginTrans();
	
	//提交事务
	void commitTrans();
	
	//回滚事务
	void rollbackTrans();
}
