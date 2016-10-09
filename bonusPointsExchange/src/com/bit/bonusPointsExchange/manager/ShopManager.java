package com.bit.bonusPointsExchange.manager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.bit.bonusPointsExchange.bean.Shop;
import com.bit.bonusPointsExchange.utils.DBUtils;

public class ShopManager {
	private Connection conn = null;
	private Statement stmt = null;
	private String sql = null; 
	private ResultSet rs = null;
	

	public int queryShopByNameAndEmail(Shop shop){ //
		int count = 0;
		conn=DBUtils.getConnection();
		try {
			stmt=conn.createStatement();
			sql="select * from shop where shopName='"+shop.getShopName()+"' and email='"+shop.getEmail()+"'";
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next())
				count = 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
		
	}
	
	public int alterShopPasswd(Shop shop){  //–ﬁ∏ƒ…Ãº“√‹¬Î		
		conn=DBUtils.getConnection();
		int result = 0;
		try {
			stmt=conn.createStatement();
			sql="update shop set password='"+shop.getPassword()+"' where shopName='"+shop.getShopName()+"'";
			result = stmt.executeUpdate(sql);			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBUtils.close(rs, stmt, conn);
		}
		return result;
	}
}
