package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bit.bonusPointsExchange.bean.Order;
import com.bit.bonusPointsExchange.bean.User;
import com.bit.bonusPointsExchange.utils.DBUtils;

public class OrderManager {

	private Connection conn = null;
	private Statement stmt = null;
	private String sql = null; 
	private ResultSet rs = null;
	private User user = null;
	
	public int addOrder(Order order){
		
		int result = 0;		
		conn = DBUtils.getConnection();
		try {
			stmt = conn.createStatement();
			sql = "insert into bonusPointsExchange.order(point,wantedShop,wantedPoint,untilDate,orderStatus,userName,shopName) values('"+order.getPoint()+"','"+order.getWantedShop()+"','"+order.getWantedPoint()+"','"+order.getUntilDate()+"','"+order.getOrderStatus()+"','"+order.getUserName()+"','"+order.getShopName()+"')";
			result = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
