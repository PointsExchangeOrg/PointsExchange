package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bit.bonusPointsExchange.bean.Order;
import com.bit.bonusPointsExchange.bean.User;
import com.bit.bonusPointsExchange.utils.DBUtils;

/**
 * �������ݿ����
 * @author gmx
 *
 */
public class OrderManager {

	private Connection conn = null;
	private Statement stmt = null;
	private String sql = null; 
	private ResultSet rs = null;
	private User user = null;
	
	public int addOrder(Order order){// ��Ӷ���
		
		int result = 0;		
		conn = DBUtils.getConnection();
		try {
			stmt = conn.createStatement();
			sql = "insert into bonusPointsExchange.order(point,wantedShop,wantedPoint,untilDate,orderStatus,userName,shopName) values('"+order.getPoint()+"','"+order.getWantedShop()+"','"+order.getWantedPoint()+"','"+order.getUntilDate()+"','"+order.getOrderStatus()+"','"+order.getUserName()+"','"+order.getShopName()+"')";
			result = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBUtils.close(rs, stmt, conn);
		}
		return result;
	}
	
	public List<Order> findAllOrderPriorityPoint(String userName,Order order){//�������Ȳ�ѯ���ж���
		List<Order> orders = new ArrayList<Order>();
		conn = DBUtils.getConnection();
		try {
			stmt = conn.createStatement();
			sql="select orderID,userName,shopName,wantedShop,point,wantedPoint,untilDate from bonusPointsExchange.order where userName!='"+userName+"' and orderStatus=0 and shopName='"+order.getWantedShop()+"' and wantedShop='"+order.getShopName()+"' order by point desc";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				Order ordertmp = new Order();
				ordertmp.setOrderID(rs.getInt("orderID"));
				ordertmp.setUserName(rs.getString("userName"));
				ordertmp.setShopName(rs.getString("shopName"));
				ordertmp.setWantedShop(rs.getString("wantedShop"));
				ordertmp.setPoint(rs.getInt("point"));
				ordertmp.setWantedPoint(rs.getInt("wantedPoint"));
				ordertmp.setUntilDate(rs.getString("untilDate"));
				orders.add(ordertmp);		
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return orders;
	}
	
	public int finshOrder(Order order){//��ɶ���������
		int result =0;
		conn = DBUtils.getConnection();
		try {
			stmt = conn.createStatement();
			sql = "update bonusPointsExchange.order set exchangeUserName='"+order.getExchangeUserName()+"',orderDate='"+order.getOrderDate()+"',orderStatus='"+order.getOrderStatus()+"' where orderID="+order.getOrderID();
			result = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return result;
		
	}
	
	/*ͨ�������Ų�ѯ����*/
	public Order findOrderByID(int orderID){
		Connection conn=DBUtils.getConnection();
		Order orderInfo = new Order();
		Statement stmt=null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from bonusPointsExchange.order where orderID='"+orderID+"'");
								     
			if(rs.next()) {
				orderInfo.setOrderID(rs.getInt("orderID"));
				orderInfo.setUserName(rs.getString("userName"));
				orderInfo.setShopName(rs.getString("shopName"));
				orderInfo.setPoint(rs.getInt("point"));
				orderInfo.setWantedShop(rs.getString("wantedShop"));
				orderInfo.setWantedPoint(rs.getInt("wantedPoint"));
				orderInfo.setExchangeUserName(rs.getString("exchangeUserName"));
				orderInfo.setUntilDate(rs.getString("untilDate"));
				orderInfo.setOrderDate(rs.getString("orderDate"));
				orderInfo.setOrderStatus(rs.getInt("orderStatus"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderInfo;
	}
	 
}
