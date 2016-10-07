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
import com.bit.bonusPointsExchange.manager.QueryOrderManager;

/**
 * 璁㈠崟妯″潡
 * @author gmx
 *
 */
public class OrderAction extends Action{
	
	private int orderStatus_unfinished_valid = 0;//0浠ｈ〃鏈畬鎴愪笖鏈秴杩囨湁鏁堟湡锛堟湁鏁堬級
	private int orderStatus_finished = 1;//1浠ｈ〃瀹屾垚
	private int orderStatus_cancel_invalid=2;//2浠ｈ〃鎾ら攢鎴栬秴杩囨湁鏁堟湡锛堟棤鏁�
	

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String methodCode = request.getParameter("methodCode");
		String sortMeans = request.getParameter("selectSort");
		if(methodCode.equals("release_order")){
			this.releaseOrder(request,response);
		}else if(methodCode.equals("findAllOrder")){
			if(sortMeans.equals("积分优先")){
				this.findAllOrderPriorityPoint(request, response);
			}else if(sortMeans.equals("比率优先")){
				this.findAllOrderByRate(request,response);
			}else if(sortMeans.equals("时效优先")){			
				this.findAllOrderByUntilDate(request,response);
			}
		}
	}
	
	/*鍙戝竷璁㈠崟*/
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
			order.setOrderStatus(orderStatus_unfinished_valid);//璁㈠崟鏈畬鎴愪笖鏈夋晥
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
		String userName = (String)request.getSession().getAttribute("userName");
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		OrderManager om = new OrderManager();
		Order order = new Order();
		order.setShopName(shopName);
		order.setWantedShop(wantedShop);
		List<Order> orders = om.findAllOrderPriorityPoint(userName,order);
		request.setAttribute("orders", orders);
		request.setAttribute("index", "3");
		request.setAttribute("findRes", "true");
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


	public void	 findAllOrderByRate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");


		//查询数据库，调用按比率查询函数

		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByRate(shopName, wantedShop);
		request.setAttribute("AllOrderByRate", list);
		request.setAttribute("index", "3");
		request.setAttribute("selectID", "2");//设置界面上显示第几个select
		request.setAttribute("selectID", "2");//璁剧疆鐣岄潰涓婃樉绀虹鍑犱釜select
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
		

	//时效优先
	public void	 findAllOrderByUntilDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");


		//查询数据库，调用按时效优先查询函数
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByUntilDate(shopName, wantedShop);
		request.setAttribute("AllOrderByUntilDate", list);
		request.setAttribute("index", "3");
		request.setAttribute("selectID", "3");//设置界面上显示第几个select
		request.setAttribute("selectID", "3");//璁剧疆鐣岄潰涓婃樉绀虹鍑犱釜select
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
	

}
