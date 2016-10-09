package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import com.bit.bonusPointsExchange.bean.Shop;
import com.bit.bonusPointsExchange.bean.ShowBindInfo;
import com.bit.bonusPointsExchange.bean.User;
import com.bit.bonusPointsExchange.utils.DBUtils;
import com.sun.org.apache.xpath.internal.operations.And;


public class BindShopManager {
	public int isValid(String userName, String password,String shopName){
		//���û��ڸ��̼��Ƿ��Ѿ�ע��
		Connection conn=DBUtils.getConnection();
		int result = 0;					
		Statement stmt=null;
		//System.out.println(shop.getShopName());
		//System.out.println(shop.getPassword());
		try {
			String sql ="select *from userpoint where userName='"+userName+"' and password='"+password+"' and shopName='"+shopName+"'";
			stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			//System.out.println(sql);
			if(rs.next())
				result = 1;  	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(result);
		return result;
	}
	
	//��ѯ�û��Ƿ��Ѿ��󶨸��̼�
	public boolean isBindThisShop(String userName, String shopName){
		Connection conn=DBUtils.getConnection();
		boolean res = false;
		Statement stmt=null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select *from point where userName='"+userName+"'and shopName='"+shopName+"'");
			if(rs.next()) {
				res = true;
				rs.close();
				return res;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
		
	//����ƽ̨��point����¼�û��󶨵������Ϣ
	public int insertBindInfoToPoint(String userName,String shopName){
		int count =0;//bangding�Ƿ�ɹ���־�� 0Ϊʧ��
		Connection conn=DBUtils.getConnection();
		Statement stmt=null;
		try {
			stmt=conn.createStatement();
			String sql="insert into point(userName,shopName) values ('"+userName+"','"+shopName+"')";
			count=stmt.executeUpdate(sql);//ִ�в�����䣬�����ز������ݵĸ���	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBUtils.close(null, stmt, conn);
		}
		return count;			
	}
	
	
	//����ѯ�û��󶨵��̼���Ϣ,����������û�������ƽ̨ע�������
	public List<ShowBindInfo> bingShopInfo(String userName){
		Connection conn=DBUtils.getConnection();
		List<ShowBindInfo> list = new ArrayList<ShowBindInfo>();
		Statement stmt=null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select shop.imageURL, point.shopName, point.platformPoint from shop, point where point.userName ='"+userName+"' and point.shopName = shop.shopName");
			while(rs.next()) {
				ShowBindInfo bindInfo = new ShowBindInfo();
				bindInfo.setImgURL(rs.getString("imageURL"));
				bindInfo.setPlatformPoints(rs.getString("platformPoint"));
				bindInfo.setShopName(rs.getString("shopName"));
				list.add(bindInfo);
				System.out.println(rs.getString("imageURL"));
				System.out.println(rs.getString("platformPoint"));
				System.out.println(rs.getString("shopName"));
				//System.out.println("502");
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}