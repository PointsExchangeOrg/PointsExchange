package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import com.bit.bonusPointsExchange.utils.DBUtils;

public class PlatformPointToUserManger {
	//更新平台的数据库
	public boolean updatePointsPlatform(String userName, String shopName, int wantTransfer_points ){
		Connection conn=DBUtils.getConnection();
		Statement stmt=null;
		//System.out.println(wantTransfer_points);
		//System.out.println(userName);
		//System.out.println(shopName);
		try {
			stmt = conn.createStatement();
			String sql="update point set platformPoint=platformPoint-'"+wantTransfer_points+"' where userName='"+userName+"' and shopName='"+shopName+"'";
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
		Statement stmt=null;
		/*
		System.out.println(wantTransfer_points);
		System.out.println(userName);
		System.out.println(shopName);*/
		try {
			stmt = conn.createStatement();
			String sql="update userpoint set userpoint=userpoint+'"+wantTransfer_points+"' where userName='"+userName+"' and shopName='"+shopName+"'";
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
