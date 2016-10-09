package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.bean.Order;
import com.bit.bonusPointsExchange.bean.Point;
import com.bit.bonusPointsExchange.manager.BindShopManager;
import com.bit.bonusPointsExchange.manager.OrderManager;
import com.bit.bonusPointsExchange.manager.PointManager;
import com.bit.bonusPointsExchange.manager.QueryOrderManager;
import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;
import com.bit.bonusPointsExchange.utils.TimeUtils;

public class FinishLatestOrder extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8"); 
		OrderManager om = new OrderManager();
		PointManager pm = new PointManager();
		BindShopManager bsm = new BindShopManager();
		UserPointToplatfromManger uptm =new UserPointToplatfromManger();
		
		int orderID = Integer.parseInt(request.getParameter("orderID"));
				
		String exchangeUserName = (String) request.getSession().getAttribute("userName");
					
		
		Point pointsFromRelease = new Point();//订单发布者的积分
		Point pointsFromReleaseWanted = new Point();//订单发布者想要交换的积分
		Point pointsFromExchange = new Point();//发起交易者的积分
		Point pointsFromExchangeWanted = new Point();//发起交易者想要交换的积分
		
		Order orderInfo = om.findOrderByID(orderID);
		
		boolean isBindWantedShop = bsm.isBindThisShop(exchangeUserName, orderInfo.getShopName());
		boolean isBindShopName = bsm.isBindThisShop(exchangeUserName, orderInfo.getWantedShop());
		
		
		
		try {
			if(!isBindWantedShop){
				//数据库查询最新订单
				
				request.setAttribute("isBindWantedShop", "false");
				QueryOrderManager manager = new QueryOrderManager();
				List<Order> list = manager.QueryLatestOrder(exchangeUserName);
				request.setAttribute("latestOrderInfo", list);
				request.getRequestDispatcher("exchange.jsp").forward(request, response);
	
			}
			if(!isBindShopName){
				request.setAttribute("isBindShopName", "false");
				QueryOrderManager manager = new QueryOrderManager();
				List<Order> list = manager.QueryLatestOrder(exchangeUserName);
				request.setAttribute("latestOrderInfo", list);
				request.getRequestDispatcher("exchange.jsp").forward(request, response);
	
			}
			
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int pointsAtPlatform=uptm.ownPointsAtPlatform(exchangeUserName,orderInfo.getWantedShop());
		if(pointsAtPlatform<orderInfo.getWantedPoint()){
			request.setAttribute("isPointEnough", "no");
			try {
				QueryOrderManager manager = new QueryOrderManager();
				List<Order> list = manager.QueryLatestOrder(exchangeUserName);
				request.setAttribute("latestOrderInfo", list);
				request.getRequestDispatcher("exchange.jsp").forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		/*订单发布者的积分*/
		pointsFromRelease.setUserName(orderInfo.getUserName());
		pointsFromRelease.setShopName(orderInfo.getShopName());
		pointsFromRelease.setPlatformPoint(pm.findPointByUserName(pointsFromRelease)-orderInfo.getPoint());
		
		/*/订单发布者想要交换的积分*/
		pointsFromReleaseWanted.setUserName(orderInfo.getUserName());
		pointsFromReleaseWanted.setShopName(orderInfo.getWantedShop());
		pointsFromReleaseWanted.setPlatformPoint(pm.findPointByUserName(pointsFromReleaseWanted)+orderInfo.getWantedPoint());
		
		/*发起交易者的积分*/
		pointsFromExchange.setUserName(exchangeUserName);
		pointsFromExchange.setShopName(orderInfo.getWantedShop());
		pointsFromExchange.setPlatformPoint(pm.findPointByUserName(pointsFromExchange)-orderInfo.getWantedPoint());
		
		/*发起交易者想要交换的积分*/
		pointsFromExchangeWanted.setUserName(exchangeUserName);
		pointsFromExchangeWanted.setShopName(orderInfo.getShopName());
		pointsFromExchangeWanted.setPlatformPoint(pm.findPointByUserName(pointsFromExchangeWanted)+orderInfo.getPoint());
		
		int pointRes1 = pm.updatePoint(pointsFromRelease);
		int pointRes2 = pm.updatePoint(pointsFromReleaseWanted);
		int pointRes3 = pm.updatePoint(pointsFromExchange);
		int pointRes4 = pm.updatePoint(pointsFromExchangeWanted);
		
		String orderDate = TimeUtils.getNowTime();
		int orderStatus = 1;//订单完成
		
		Order order = new Order();
		order.setOrderID(orderID);
		order.setExchangeUserName(exchangeUserName);
		order.setOrderDate(orderDate);
		order.setOrderStatus(orderStatus);
		int orderRes = om.finshOrder(order);//完成订单
		
		if(orderRes>0&&pointRes1>0&&pointRes2>0&&pointRes3>0&&pointRes4>0){
			request.setAttribute("exchangeRes", "true");
		}else
			request.setAttribute("exchangeRes", "false");
			try {
				QueryOrderManager manager = new QueryOrderManager();
				List<Order> list = manager.QueryLatestOrder(exchangeUserName);
				request.setAttribute("latestOrderInfo", list);
				request.getRequestDispatcher("exchange.jsp").forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

}
