package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bit.bonusPointsExchange.utils.DBUtils;


//�û����ֵ�ƽ̨���ݿ⴦��
public class UserPointToplatfromManger {
	//��ѯ�û���ƽ̨���ݿ��еĻ���
	public int ownPointsAtPlatform(String userName, String shopName){
		Connection conn=DBUtils.getConnection();
		int points = 0;//�û�ʵ��ӵ�еĻ���,����0��ʾû�л���
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
	//��ѯ�û����̼ҵ����ݿ��еĻ���
	public int ownPoints(String userName, String shopName){
		Connection conn=DBUtils.getConnection();
		int points = 0;//�û�ʵ��ӵ�еĻ���,����0��ʾû�л���
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
	//����ƽ̨�����ݿ�
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
	//�����̼ҵ����ݿ⣨ģ�⣩
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
