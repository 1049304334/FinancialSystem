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
}
