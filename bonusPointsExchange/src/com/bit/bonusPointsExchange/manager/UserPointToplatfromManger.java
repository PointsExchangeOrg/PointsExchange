package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bit.bonusPointsExchange.utils.DBUtils;


//用户积分到平台数据库处理
public class UserPointToplatfromManger {
	//查询用户在平台数据库中的积分
	public int ownPointsAtPlatform(String userName, String shopName){
		Connection conn=DBUtils.getConnection();
		int points = 0;//用户实际拥有的积分,返回0表示没有积分
		Statement stmt=null;
		//System.out.println(userName);
		//System.out.println(shopName);
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select platformPoint from point where userName='"+userName+"'and shopName='"+shopName+"'");
			if(rs.next()) {
				//System.out.println(rs.getString("userPoint"));
				points = Integer.parseInt(rs.getString("platformPoint"));
				rs.close();
				return points;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return points;
	}
	//查询用户在商家的数据库中的积分
	public int ownPoints(String userName, String shopName){
		Connection conn=DBUtils.getConnection();
		int points = 0;//用户实际拥有的积分,返回0表示没有积分
		Statement stmt=null;
		//System.out.println(userName);
		//System.out.println(shopName);
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select userPoint from userpoint where userName='"+userName+"'and shopName='"+shopName+"'");
			if(rs.next()) {
				//System.out.println(rs.getString("userPoint"));
				points = Integer.parseInt(rs.getString("userPoint"));
				rs.close();
				return points;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return points;
	}
	//更新平台的数据库
	public boolean updatePointsPlatform(String userName, String shopName, int wantTransfer_points ){
		Connection conn=DBUtils.getConnection();
		Statement stmt=null;
		/*
		System.out.println(wantTransfer_points);
		System.out.println(userName);
		System.out.println(shopName);*/
		try {
			stmt = conn.createStatement();
			String sql="update point set platformPoint=platformPoint+'"+wantTransfer_points+"' where userName='"+userName+"' and shopName='"+shopName+"'";
			//System.out.println(sql);
			int res = stmt.executeUpdate(sql);
			if(res != 0) 
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	//更新商家的数据库（模拟）
	public boolean updatePointsShop(String userName, String shopName,int wantTransfer_points){
		Connection conn=DBUtils.getConnection();
		Statement stmt=null;/*
		System.out.println(wantTransfer_points);
		System.out.println(userName);
		System.out.println(shopName);*/
		try {
			stmt = conn.createStatement();
			String sql="update userpoint set userpoint=userpoint-'"+wantTransfer_points+"' where userName='"+userName+"' and shopName='"+shopName+"'";
			//System.out.println(sql);
			int res = stmt.executeUpdate(sql);
			if(res != 0) 
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
