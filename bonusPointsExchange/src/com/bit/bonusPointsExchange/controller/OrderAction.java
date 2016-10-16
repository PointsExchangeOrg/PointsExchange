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
import com.bit.bonusPointsExchange.bean.Point;
import com.bit.bonusPointsExchange.bean.ShowBindInfo;
import com.bit.bonusPointsExchange.json.GetJsonStr;
import com.bit.bonusPointsExchange.manager.BindShopManager;
import com.bit.bonusPointsExchange.manager.OrderManager;
import com.bit.bonusPointsExchange.manager.PointManager;
import com.bit.bonusPointsExchange.manager.QueryOrderManager;
import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;
import com.bit.bonusPointsExchange.utils.HttpUtils;
import com.bit.bonusPointsExchange.utils.TimeUtils;

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
		}else if(methodCode.equals("finsh_order")){//进行积分兑换，完成订单
			this.finishOrder(request, response);
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
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
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

	//比率优先
	public void	 findAllOrderByRate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		String userName = (String)request.getSession().getAttribute("userName");
		//System.out.println(shopName);
		//System.out.println(wantedShop);
		//查询数据库，调用按比率查询函数
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByRate(shopName, wantedShop,userName);
		request.setAttribute("AllOrderByRate", list);
		request.setAttribute("index", "3");
		request.setAttribute("selectID", "2");//设置界面上显示第几个select
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
		
	//时效优先
	public void	 findAllOrderByUntilDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		String userName = (String)request.getSession().getAttribute("userName");
		//System.out.println(shopName);
		//System.out.println(wantedShop);
		
		//查询数据库，调用按时效优先查询函数
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByUntilDate(shopName, wantedShop,userName);
		request.setAttribute("AllOrderByUntilDate", list);
		request.setAttribute("index", "3");
		request.setAttribute("selectID", "3");//设置界面上显示第几个select
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
	
	/*兑换积分,完成订单*/  /*检查是否在商家注册了账户*/
	public void finishOrder(HttpServletRequest request, HttpServletResponse response){
		OrderManager om = new OrderManager();
		PointManager pm = new PointManager();
		BindShopManager bsm = new BindShopManager();
		UserPointToplatfromManger uptm =new UserPointToplatfromManger();
		BindShopManager bindShopManger = new BindShopManager();
		
		int orderID = Integer.parseInt(request.getParameter("orderID"));
				
		String exchangeUserName = (String) request.getSession().getAttribute("userName");
					
	
		
		Point pointsFromRelease = new Point();//订单发布者的积分
		Point pointsFromReleaseWanted = new Point();//订单发布者想要交换的积分
		Point pointsFromExchange = new Point();//发起交易者的积分
		Point pointsFromExchangeWanted = new Point();//发起交易者想要交换的积分
		
		Order orderInfo = om.findOrderByID(orderID);
		
		boolean isBindWantedShop = bsm.isBindThisShop(exchangeUserName, orderInfo.getShopName());//验证发起交易者是否已绑定该商家
		boolean isBindShopName = bsm.isBindThisShop(exchangeUserName, orderInfo.getWantedShop());//验证发起交易者是否已绑定该商家
		
		request.setAttribute("index", 3);
		
		try {
			if(!isBindWantedShop){//验证发起交易者是否已绑定该商家
				
				request.setAttribute("isBindWantedShop", "false");
				request.getRequestDispatcher("order.jsp").forward(request, response);
				return;
			}
			if(!isBindShopName){//验证发起交易者是否已绑定该商家
				request.setAttribute("isBindShopName", "false");
				request.getRequestDispatcher("order.jsp").forward(request, response);
				return;
			}
			
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int pointsAtPlatByExchanger=uptm.ownPointsAtPlatform(exchangeUserName,orderInfo.getWantedShop());//查询交易发起者在商家的平台积分
		if(pointsAtPlatByExchanger<orderInfo.getWantedPoint()){//如果交易发起者在商家的平台积分小于订单发起者所期望商家的平台积分，返回交易页面显示交易发起者的积分不足
			request.setAttribute("isPointEnough", "no");
			try {
				request.getRequestDispatcher("order.jsp").forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
			
		}
		
		Point point1 = bindShopManger.findBindedShop(exchangeUserName, orderInfo.getWantedShop());//交易发起者在商家中的积分
		Point point2 = bindShopManger.findBindedShop(exchangeUserName, orderInfo.getShopName());//交易发起者在期望商家中的积分
		Point point3 = bindShopManger.findBindedShop(orderInfo.getUserName(), orderInfo.getShopName());//订单发布者在商家中的积分
		Point point4 = bindShopManger.findBindedShop(orderInfo.getUserName(), orderInfo.getWantedShop());//订单发布者在期望商家中的积分                                             
		
		String str1 ="{'jsonrpc': '2.0','method': 'invoke','params': {'type': 1,'chaincodeID':{'name':'6ef62a4eb59238a25fedcb50cc873f90f9d3fe0053888620f9011e25947fa85c9d411ac7193572732cf11987f2f8423d9a77d18332cf6f7dc4c2fa4821136099'},'ctorMsg': {'function':'invoke','args':['"+String.valueOf(point1.getPointID())+"','"+String.valueOf(point2.getPointID())+"','"+String.valueOf(orderInfo.getWantedPoint())+"','"+String.valueOf(orderInfo.getPoint())+"']}},'id': 3}";
		String str2 ="{'jsonrpc': '2.0','method': 'invoke','params': {'type': 1,'chaincodeID':{'name':'6ef62a4eb59238a25fedcb50cc873f90f9d3fe0053888620f9011e25947fa85c9d411ac7193572732cf11987f2f8423d9a77d18332cf6f7dc4c2fa4821136099'},'ctorMsg': {'function':'invoke','args':['"+String.valueOf(point3.getPointID())+"','"+String.valueOf(point4.getPointID())+"','"+String.valueOf(orderInfo.getPoint())+"','"+String.valueOf(orderInfo.getWantedPoint())+"']}},'id': 3}";
		System.out.println(str1);
		System.out.println(str2);
		HttpUtils httputils = new HttpUtils();
		String conRes = httputils.getHttpConnection();
		if(conRes.equals("开启请求连接成功")){
			GetJsonStr result1 = httputils.postJsonToBlockChain(str1);
			if(result1.getResult().getStatus().equals("OK")){
				HttpUtils httputils2 = new HttpUtils();
				httputils2.getHttpConnection();
				
			
			GetJsonStr result2 = httputils2.postJsonToBlockChain(str2);
			if(result2.getResult().getStatus().equals("OK")){
			//HttpUtils httputils2 = new HttpUtils();
			//httputils2.getHttpConnection();
			//	GetJsonStr result2 = httputils.postJsonToBlockChain(str2);
			//if(result2.getResult().getStatus().equals("OK")){
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
				int orderStatus = orderStatus_finished;//订单完成
			
				Order order = new Order();
				order.setOrderID(orderID);
				order.setExchangeUserName(exchangeUserName);
				order.setOrderDate(orderDate);
				order.setOrderStatus(orderStatus);
				int orderRes = om.finshOrder(order);//完成订单
			
				if(orderRes>0&&pointRes1>0&&pointRes2>0&&pointRes3>0&&pointRes4>0){
						request.setAttribute("exchangeRes", "true");
						request.setAttribute("shop", orderInfo.getWantedShop());
						request.setAttribute("wantedShop", orderInfo.getShopName());
						try {
							request.getRequestDispatcher("order.jsp").forward(request, response);
							
						} catch (ServletException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
							return;						
				}
			}
			
			}
		}else{						
			request.setAttribute("exchangeRes", "连接blockchain失败，请检查网络");
			try {
				request.getRequestDispatcher("order.jsp").forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		}

		
		request.setAttribute("exchangeRes", "false");
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
