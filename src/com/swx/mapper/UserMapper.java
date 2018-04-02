package com.swx.mapper;

import java.sql.ResultSet;

import com.swx.po.User;

public class UserMapper implements RowMapper<User>{

	public User mapRow(ResultSet rs) throws Exception {
		String id = rs.getString(1);
		String trueName = rs.getString(2);
		String family = rs.getString(3);
		String userName = rs.getString(4);
		String password = rs.getString(5);
		return new User(id,trueName,family,userName,password);
	}

}
