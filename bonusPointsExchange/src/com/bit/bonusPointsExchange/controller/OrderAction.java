package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.bean.Order;
import com.bit.bonusPointsExchange.bean.ShowBindInfo;
import com.bit.bonusPointsExchange.manager.BindShopManager;
import com.bit.bonusPointsExchange.manager.OrderManager;

/**
 * 订单模块
 * @author gmx
 *
 */
public class OrderAction extends Action{
	
	private int orderStatus_unfinished_valid = 0;//0代表未完成且未超过有效期（有效）
	private int orderStatus_finished = 1;//1代表完成
	private int orderStatus_cancel_invalid=2;//2代表撤销或超过有效期（无效)
	

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String methodCode = request.getParameter("methodCode");
		String sortMeans = request.getParameter("selectSort");
		if(methodCode.equals("release_order")){//发布订单
			this.releaseOrder(request,response);
		}else if(methodCode.equals("findAllOrder")){//查找所有订单
			if(sortMeans.equals("积分优先")){//积分优先查找所有订单
				this.findAllOrderPriorityPoint(request, response);
			}			
			
		}
		
	}
	
	/*发布订单*/
	public void releaseOrder(HttpServletRequest request, HttpServletResponse response){
		String shopName = request.getParameter("shopName");
		int point = Integer.parseInt(request.getParameter("points"));
		String wantedShop = request.getParameter("wantedShop");
		int wantedPoint = Integer.parseInt(request.getParameter("wantedPoint"));
		String userName = (String) request.getSession().getAttribute("userName");
		String untilDate = request.getParameter("utilDate2");
		try {
			OrderManager om = new OrderManager();
			Order order = new Order();
			order.setShopName(shopName);
			order.setPoint(point);
			order.setWantedShop(wantedShop);
			order.setWantedPoint(wantedPoint);
			order.setUserName(userName);
			order.setOrderStatus(orderStatus_unfinished_valid);//订单未完成且有效
			order.setUntilDate(untilDate);
			
			int result = om.addOrder(order);
			if(result>0){
				BindShopManager bindShopManager = new BindShopManager();
				List<ShowBindInfo> shops = bindShopManager.bingShopInfo(userName);
				request.setAttribute("bindShops", shops);
				request.setAttribute("releaseOrderResult", "Y");
				request.getRequestDispatcher("order.jsp").forward(request, response);
		
			}else{
				request.setAttribute("releaseOrderResult", "N");
				request.getRequestDispatcher("order.jsp").forward(request, response);
			}
			
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
		
	/*积分优先查询所有订单*/
	public void findAllOrderPriorityPoint(HttpServletRequest request, HttpServletResponse response){//积分优先方式查找所有订单
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		OrderManager om = new OrderManager();
		Order order = new Order();
		order.setShopName(shopName);
		order.setWantedShop(wantedShop);
		List<Order> orders = om.findAllOrderPriorityPoint(order);
		request.setAttribute("ordersPriorityPoint", orders);
		request.setAttribute("index", "3");
		try {
			request.getRequestDispatcher("order.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
		
		
		
	

}
