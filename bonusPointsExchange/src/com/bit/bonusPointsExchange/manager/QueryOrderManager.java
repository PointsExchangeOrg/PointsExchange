package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bit.bonusPointsExchange.bean.Order;
import com.bit.bonusPointsExchange.bean.Shop;
import com.bit.bonusPointsExchange.utils.DBUtils;

//查询订单相关的数据库操作全部写在此处,改变订单的状态
public class QueryOrderManager {
	
	//1.根据用户名查询用户所有的订单信息，传入的是平台注册的用户名
	public List<Order> bingShopInfo(String userName){
		Connection conn=DBUtils.getConnection();
		List<Order> list = new ArrayList<Order>();
		Statement stmt=null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select *from bonusPointsExchange.order where userName='"+userName+"'");
								     
			while(rs.next()) {
				Order orderInfo = new Order();
				orderInfo.setOrderID(rs.getInt("orderID"));
				orderInfo.setUserName(userName);
				orderInfo.setShopName(rs.getString("shopName"));
				orderInfo.setPoint(rs.getInt("point"));
				orderInfo.setWantedShop(rs.getString("wantedShop"));
				orderInfo.setWantedPoint(rs.getInt("wantedPoint"));
				orderInfo.setExchangeUserName(rs.getString("exchangeUserName"));
				orderInfo.setUntilDate(rs.getString("untilDate"));
				orderInfo.setOrderDate(rs.getString("orderDate"));
				orderInfo.setOrderStatus(rs.getInt("orderStatus"));
				list.add(orderInfo);
				System.out.println("502");
				System.out.println(rs.getDate("untilDate"));
				System.out.println(rs.getDate("orderDate"));
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	//2.改变订单的状态
	public boolean changeOrderStatus(int orderID){
		Connection conn=DBUtils.getConnection();
		Statement stmt=null;
		try {
			stmt = conn.createStatement();
			String sql="update bonusPointsExchange.order set orderStatus=2 where orderID='"+orderID+"'";
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
