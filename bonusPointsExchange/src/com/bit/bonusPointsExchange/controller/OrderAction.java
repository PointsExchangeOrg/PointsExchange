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
 * è®¢å•æ¨¡å—
 * @author gmx
 *
 */
public class OrderAction extends Action{
	
	private int orderStatus_unfinished_valid = 0;//0ä»£è¡¨æœªå®Œæˆä¸”æœªè¶…è¿‡æœ‰æ•ˆæœŸï¼ˆæœ‰æ•ˆï¼‰
	private int orderStatus_finished = 1;//1ä»£è¡¨å®Œæˆ
	private int orderStatus_cancel_invalid=2;//2ä»£è¡¨æ’¤é”€æˆ–è¶…è¿‡æœ‰æ•ˆæœŸï¼ˆæ— æ•ˆ)
	

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String methodCode = request.getParameter("methodCode");
		String sortMeans = request.getParameter("selectSort");
		if(methodCode.equals("release_order")){
			this.releaseOrder(request,response);
		}else if(methodCode.equals("findAllOrder")){
<<<<<<< HEAD
			if(sortMeans.equals("»ı·ÖÓÅÏÈ")){
				this.findAllOrderPriorityPoint(request, response);
			}else if(sortMeans.equals("±ÈÂÊÓÅÏÈ")){
				this.findAllOrderByRate(request,response);
			}else if(sortMeans.equals("Ê±Ğ§ÓÅÏÈ")){
=======
			if(sortMeans.equals("ç§¯åˆ†ä¼˜å…ˆ")){
				this.findAllOrderPriorityPoint(request, response);
			}else if(sortMeans.equals("æ¯”ç‡ä¼˜å…ˆ")){
				this.findAllOrderByRate(request,response);
			}else if(sortMeans.equals("æ—¶æ•ˆä¼˜å…ˆ")){
>>>>>>> develop
				this.findAllOrderByUntilDate(request,response);
			}
		}
	}
	
	/*å‘å¸ƒè®¢å•*/
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
			order.setOrderStatus(orderStatus_unfinished_valid);//è®¢å•æœªå®Œæˆä¸”æœ‰æ•ˆ
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
	
<<<<<<< HEAD
	/*»ı·ÖÓÅÏÈ²éÑ¯ËùÓĞ¶©µ¥*/
	public void findAllOrderPriorityPoint(HttpServletRequest request, HttpServletResponse response){//»ı·ÖÓÅÏÈ·½Ê½²éÕÒËùÓĞ¶©µ¥
=======
	/*ç§¯åˆ†ä¼˜å…ˆæŸ¥è¯¢æ‰€æœ‰è®¢å•*/
	public void findAllOrderPriorityPoint(HttpServletRequest request, HttpServletResponse response){//ç§¯åˆ†ä¼˜å…ˆæ–¹å¼æŸ¥æ‰¾æ‰€æœ‰è®¢å•
>>>>>>> develop
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

<<<<<<< HEAD
	//±ÈÂÊÓÅÏÈ
=======
	//æ¯”ç‡ä¼˜å…ˆ
>>>>>>> develop
	public void	 findAllOrderByRate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		
		//System.out.println(shopName);
		//System.out.println(wantedShop);
<<<<<<< HEAD
		//²éÑ¯Êı¾İ¿â£¬µ÷ÓÃ°´±ÈÂÊ²éÑ¯º¯Êı
=======
		//æŸ¥è¯¢æ•°æ®åº“ï¼Œè°ƒç”¨æŒ‰æ¯”ç‡æŸ¥è¯¢å‡½æ•°
>>>>>>> develop
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByRate(shopName, wantedShop);
		request.setAttribute("AllOrderByRate", list);
		request.setAttribute("index", "3");
<<<<<<< HEAD
		request.setAttribute("selectID", "2");//ÉèÖÃ½çÃæÉÏÏÔÊ¾µÚ¼¸¸öselect
=======
		request.setAttribute("selectID", "2");//è®¾ç½®ç•Œé¢ä¸Šæ˜¾ç¤ºç¬¬å‡ ä¸ªselect
>>>>>>> develop
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
		
<<<<<<< HEAD
	//Ê±Ğ§ÓÅÏÈ
=======
	//æ—¶æ•ˆä¼˜å…ˆ
>>>>>>> develop
	public void	 findAllOrderByUntilDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		
		//System.out.println(shopName);
		//System.out.println(wantedShop);
		
<<<<<<< HEAD
		//²éÑ¯Êı¾İ¿â£¬µ÷ÓÃ°´Ê±Ğ§ÓÅÏÈ²éÑ¯º¯Êı
=======
		//æŸ¥è¯¢æ•°æ®åº“ï¼Œè°ƒç”¨æŒ‰æ—¶æ•ˆä¼˜å…ˆæŸ¥è¯¢å‡½æ•°
>>>>>>> develop
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByUntilDate(shopName, wantedShop);
		request.setAttribute("AllOrderByUntilDate", list);
		request.setAttribute("index", "3");
<<<<<<< HEAD
		request.setAttribute("selectID", "3");//ÉèÖÃ½çÃæÉÏÏÔÊ¾µÚ¼¸¸öselect
=======
		request.setAttribute("selectID", "3");//è®¾ç½®ç•Œé¢ä¸Šæ˜¾ç¤ºç¬¬å‡ ä¸ªselect
>>>>>>> develop
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
	

}
