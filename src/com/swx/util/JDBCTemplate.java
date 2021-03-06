package com.swx.util;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;





public class JDBCTemplate {
	
	public Object save(String sql,Object... params){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		Object pk=null;
		try {
			//获得Connection
			conn=JDBCUtil.getConnection();
			ps=conn.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);
		    for(int i=0;i<params.length;i++){
		    	ps.setObject(i+1,params[i]);
		    }
			System.out.println("SQL"+ps.toString().substring(ps.toString().indexOf(":"),ps.toString().length()));
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()){
				pk = rs.getObject(1);
			}
		} 
		catch(SQLException e){
			e.printStackTrace();
		}
		finally {
			//释放资源ResultSet, Statement,Connection
			JDBCUtil.close(null, ps, rs);
		}				
		return pk;
	}
	
	public void update(String sql,Object... params){
		Connection conn = null;
		PreparedStatement ps=null;
		try {
			//获得Connection
			conn=JDBCUtil.getConnection();
			ps=conn.prepareStatement(sql);
		    for(int i=0;i<params.length;i++){
		    	ps.setObject(i+1,params[i]);
		    }
			System.out.println("SQL"+ps.toString().substring(ps.toString().indexOf(":"),ps.toString().length()));
			ps.executeUpdate();			
		} 
		catch(SQLException e){
			e.printStackTrace();
		}
		finally {
			//释放资源ResultSet, Statement,Connection
			JDBCUtil.close(null, ps, null);
		}				
	
	}
	
	public void delete(String sql,Object... params){
		Connection conn = null;
		PreparedStatement ps=null;
		try {
			//获得Connection
			conn=JDBCUtil.getConnection();
			ps=conn.prepareStatement(sql);
		    for(int i=0;i<params.length;i++){
		    	ps.setObject(i+1,params[i]);
		    }
			System.out.println("SQL"+ps.toString().substring(ps.toString().indexOf(":"),ps.toString().length()));
			ps.executeUpdate();			
		} 
		catch(SQLException e){
			e.printStackTrace();
		}
		finally {
			//释放资源ResultSet, Statement,Connection
			JDBCUtil.close(null, ps, null);
		}				
	
	}
	
	public List query(String sql,Object... params){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
	    List list = new ArrayList();
		try {
			//获得Connection
			conn=JDBCUtil.getConnection();
			ps=conn.prepareStatement(sql);
		    for(int i=0;i<params.length;i++){
		    	ps.setObject(i+1,params[i]);
		    }
		    System.out.println("SQL"+ps.toString().substring(ps.toString().indexOf(":"),ps.toString().length()));
			rs=ps.executeQuery();
			list = ResultSetToMap.resultSetToMap(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally {
			//释放资源ResultSet, Statement,Connection
			JDBCUtil.close(null, ps, rs);
		}				
	    return list;
	}

	public int queryForInt(String sql){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		try {
			//获得Connection
			conn=JDBCUtil.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			rs.next();
			return rs.getInt(1) ;
		} 
		catch(Exception e){
			e.printStackTrace();
		}
		finally {
			//释放资源ResultSet, Statement,Connection
			JDBCUtil.close(null, ps, rs);
		}
		return 0;				
	}
	

}
