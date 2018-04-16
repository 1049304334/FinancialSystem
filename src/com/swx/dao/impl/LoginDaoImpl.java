package com.swx.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.swx.dao.LoginDao;
import com.swx.factory.ObjectFactory;
import com.swx.mapper.FamilyMapper;
import com.swx.mapper.RowMapper;
import com.swx.mapper.UserMapper;
import com.swx.po.Family;
import com.swx.po.User;
import com.swx.util.JDBCTemplate;


public class LoginDaoImpl implements LoginDao{

	JDBCTemplate template = null;
	RowMapper<User> userMapper = new UserMapper();
	RowMapper<Family> familyMapper = new FamilyMapper();
	
	public List<HashMap<String,Object>> loginCheck(Map<String,Object> map) {
		
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select * from t_user where user_name = ? and password = ?";
		return template.query(sql, map.get("userName"),map.get("password"));
	}

	@Override
	public List<HashMap<String,Object>> regeditChek(String userName) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select * from t_user where user_name = ?";
		return template.query(sql,userName);
	}

	@Override
	public void createFamily(Family family) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "insert into t_family values (?,?,?)";
		template.save(sql,family.getFamilyId(),family.getFamilyName(),family.getAdminId());
	}

	@Override
	public void createUser(User user) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "insert into t_user (id,true_name,family_id,user_name,password) values (?,?,?,?,?)";
		template.save(sql,user.getId(),user.getTrueName(),user.getFamilyId(),user.getUserName(),user.getPassword());
	}

	@Override
	public List<HashMap<String,Object>> getFamilyInfo(String familyId) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select * from t_family where family_id = ?";
		List<HashMap<String,Object>> familyList = template.query(sql,familyId);
		return familyList;
	}

	@Override
	public List getUserInfo(String userId) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select u.id,u.true_name,u.user_name,u.password,f.family_name from t_user u,t_family f where u.id = ? and u.family_id = f.family_id";
		return template.query(sql,userId);
	}

	@Override
	public List getRecentIncome(HashMap map) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select sum(amount) as totalIncome from t_income where family_id = ? and income_date > ?";
		return template.query(sql,map.get("familyId"),map.get("limitDate"));
	}

	@Override
	public List getRecentExpand(HashMap map) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select sum(amount) as totalExpand from t_outcome where family_id = ? and outcome_date > ?";
		return template.query(sql,map.get("familyId"),map.get("limitDate"));
	}

	@Override
	public List getRecentCreditNum(HashMap map) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select count(1) as num from t_creditor where family_id = ? and balance != 0";
		return template.query(sql,map.get("familyId"));
	}

	@Override
	public List getRecentDebtNum(HashMap map) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select count(1) as num from t_debt where family_id = ? and balance != 0";
		return template.query(sql,map.get("familyId"));
	}

	@Override
	public List getRecentNoteNum(HashMap map) {
		template = (JDBCTemplate) ObjectFactory.getObject("jdbcTemplate");
		String sql = "select count(1) as num from t_notes where family_id = ? and tip_time > (select now())";
		return template.query(sql,map.get("familyId"));
	}
}
