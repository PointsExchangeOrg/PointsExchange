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
 * ����ģ��
 * @author gmx
 *
 */
public class OrderAction extends Action{
	
	private int orderStatus_unfinished_valid = 0;//0����δ�����δ������Ч�ڣ���Ч��
	private int orderStatus_finished = 1;//1�������
	private int orderStatus_cancel_invalid=2;//2�������򳬹���Ч�ڣ���Ч)
	

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String methodCode = request.getParameter("methodCode");
		String sortMeans = request.getParameter("selectSort");
		if(methodCode.equals("release_order")){
			this.releaseOrder(request,response);
		}else if(methodCode.equals("findAllOrder")){
			if(sortMeans.equals("��������")){
				this.findAllOrderPriorityPoint(request, response);
			}else if(sortMeans.equals("��������")){
				this.findAllOrderByRate(request,response);
			}else if(sortMeans.equals("ʱЧ����")){
				this.findAllOrderByUntilDate(request,response);
			}
		}else if(methodCode.equals("finsh_order")){//���л��ֶһ�����ɶ���
			this.finishOrder(request, response);
		}
	}
	
	/*��������*/
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
			order.setOrderStatus(orderStatus_unfinished_valid);//����δ�������Ч
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
	
	/*�������Ȳ�ѯ���ж���*/
	public void findAllOrderPriorityPoint(HttpServletRequest request, HttpServletResponse response){//�������ȷ�ʽ�������ж���
		String userName = (String)request.getSession().getAttribute("userName");
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		String point = request.getParameter("point");
		int points= Integer.parseInt(point);//��������
		String wantedPoint = request.getParameter("wantedPoint2");
		int wantedPoints = Integer.parseInt(wantedPoint);//Ŀ���������
		OrderManager om = new OrderManager();
		Order order = new Order();
		order.setShopName(shopName);
		order.setPoint(points);
		order.setWantedShop(wantedShop);
		order.setWantedPoint(wantedPoints);
		List<Order> orders = om.findAllOrderPriorityPoint(userName,order);
		request.setAttribute("orders", orders);
		request.setAttribute("index", "3");
		request.setAttribute("findRes", "true");
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.setAttribute("point", point);
		request.setAttribute("wantedPoint", wantedPoint);
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

	//��������
	public void	 findAllOrderByRate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		String userName = (String)request.getSession().getAttribute("userName");
		String point = request.getParameter("point");
		int points= Integer.parseInt(point);//��������
		String wantedPoint = request.getParameter("wantedPoint2");
		int wantedPoints = Integer.parseInt(wantedPoint);//Ŀ���������
		//��ѯ���ݿ⣬���ð����ʲ�ѯ����
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByRate(shopName, wantedShop,userName,points,wantedPoints);
		request.setAttribute("AllOrderByRate", list);
		request.setAttribute("index", "3");
		request.setAttribute("selectID", "2");//���ý�������ʾ�ڼ���select
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.setAttribute("point", point);
		request.setAttribute("wantedPoint", wantedPoint);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
		
	//ʱЧ����
	public void	 findAllOrderByUntilDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String shopName = request.getParameter("shop");
		String wantedShop = request.getParameter("targetShop");
		String userName = (String)request.getSession().getAttribute("userName");
		String point = request.getParameter("point");
		int points= Integer.parseInt(point);//��������
		String wantedPoint = request.getParameter("wantedPoint2");
		int wantedPoints = Integer.parseInt(wantedPoint);//Ŀ���������
		//��ѯ���ݿ⣬���ð�ʱЧ���Ȳ�ѯ����
		QueryOrderManager manager = new QueryOrderManager();
		List<Order> list = manager.findAllOrderByUntilDate(shopName, wantedShop,userName,points,wantedPoints);
		request.setAttribute("AllOrderByUntilDate", list);
		request.setAttribute("index", "3");
		request.setAttribute("selectID", "3");//���ý�������ʾ�ڼ���select
		request.setAttribute("shop", shopName);
		request.setAttribute("wantedShop", wantedShop);
		request.setAttribute("point", point);
		request.setAttribute("wantedPoint", wantedPoint);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}
	
	/*�һ�����,��ɶ���*/  /*����Ƿ����̼�ע�����˻�*/
	public void finishOrder(HttpServletRequest request, HttpServletResponse response){
		OrderManager om = new OrderManager();
		PointManager pm = new PointManager();
		BindShopManager bsm = new BindShopManager();
		UserPointToplatfromManger uptm =new UserPointToplatfromManger();
		BindShopManager bindShopManger = new BindShopManager();
		
		int orderID = Integer.parseInt(request.getParameter("orderID"));
				
		String exchangeUserName = (String) request.getSession().getAttribute("userName");
					
	
		
		Point pointsFromRelease = new Point();//���������ߵĻ���
		Point pointsFromReleaseWanted = new Point();//������������Ҫ�����Ļ���
		Point pointsFromExchange = new Point();//�������ߵĻ���
		Point pointsFromExchangeWanted = new Point();//����������Ҫ�����Ļ���
		
		Order orderInfo = om.findOrderByID(orderID);
		
		boolean isBindWantedShop = bsm.isBindThisShop(exchangeUserName, orderInfo.getShopName());//��֤���������Ƿ��Ѱ󶨸��̼�
		boolean isBindShopName = bsm.isBindThisShop(exchangeUserName, orderInfo.getWantedShop());//��֤���������Ƿ��Ѱ󶨸��̼�
		
		request.setAttribute("index", 3);
		
		try {
			if(!isBindWantedShop){//��֤���������Ƿ��Ѱ󶨸��̼�
				
				request.setAttribute("isBindWantedShop", "false");
				request.getRequestDispatcher("order.jsp").forward(request, response);
				return;
			}
			if(!isBindShopName){//��֤���������Ƿ��Ѱ󶨸��̼�
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
		
		int pointsAtPlatByExchanger=uptm.ownPointsAtPlatform(exchangeUserName,orderInfo.getWantedShop());//��ѯ���׷��������̼ҵ�ƽ̨����
		if(pointsAtPlatByExchanger<orderInfo.getWantedPoint()){//������׷��������̼ҵ�ƽ̨����С�ڶ����������������̼ҵ�ƽ̨���֣����ؽ���ҳ����ʾ���׷����ߵĻ��ֲ���
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
		
		Point point1 = bindShopManger.findBindedShop(exchangeUserName, orderInfo.getWantedShop());//���׷��������̼��еĻ���
		Point point2 = bindShopManger.findBindedShop(exchangeUserName, orderInfo.getShopName());//���׷������������̼��еĻ���
		Point point3 = bindShopManger.findBindedShop(orderInfo.getUserName(), orderInfo.getShopName());//�������������̼��еĻ���
		Point point4 = bindShopManger.findBindedShop(orderInfo.getUserName(), orderInfo.getWantedShop());//�����������������̼��еĻ���                                             
		
		String str1 ="{'jsonrpc': '2.0','method': 'invoke','params': {'type': 1,'chaincodeID':{'name':'6ef62a4eb59238a25fedcb50cc873f90f9d3fe0053888620f9011e25947fa85c9d411ac7193572732cf11987f2f8423d9a77d18332cf6f7dc4c2fa4821136099'},'ctorMsg': {'function':'invoke','args':['"+String.valueOf(point1.getPointID())+"','"+String.valueOf(point2.getPointID())+"','"+String.valueOf(orderInfo.getWantedPoint())+"','"+String.valueOf(orderInfo.getPoint())+"']}},'id': 3}";
		String str2 ="{'jsonrpc': '2.0','method': 'invoke','params': {'type': 1,'chaincodeID':{'name':'6ef62a4eb59238a25fedcb50cc873f90f9d3fe0053888620f9011e25947fa85c9d411ac7193572732cf11987f2f8423d9a77d18332cf6f7dc4c2fa4821136099'},'ctorMsg': {'function':'invoke','args':['"+String.valueOf(point3.getPointID())+"','"+String.valueOf(point4.getPointID())+"','"+String.valueOf(orderInfo.getPoint())+"','"+String.valueOf(orderInfo.getWantedPoint())+"']}},'id': 3}";
		System.out.println(str1);
		System.out.println(str2);
		HttpUtils httputils = new HttpUtils();
		String conRes = httputils.getHttpConnection();
		if(conRes.equals("�����������ӳɹ�")){
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
				/*���������ߵĻ���*/
				pointsFromRelease.setUserName(orderInfo.getUserName());
				pointsFromRelease.setShopName(orderInfo.getShopName());
				pointsFromRelease.setPlatformPoint(pm.findPointByUserName(pointsFromRelease)-orderInfo.getPoint());
			
				/*/������������Ҫ�����Ļ���*/
				pointsFromReleaseWanted.setUserName(orderInfo.getUserName());
				pointsFromReleaseWanted.setShopName(orderInfo.getWantedShop());
				pointsFromReleaseWanted.setPlatformPoint(pm.findPointByUserName(pointsFromReleaseWanted)+orderInfo.getWantedPoint());
			
				/*�������ߵĻ���*/
				pointsFromExchange.setUserName(exchangeUserName);
				pointsFromExchange.setShopName(orderInfo.getWantedShop());
				pointsFromExchange.setPlatformPoint(pm.findPointByUserName(pointsFromExchange)-orderInfo.getWantedPoint());
			
				/*����������Ҫ�����Ļ���*/
				pointsFromExchangeWanted.setUserName(exchangeUserName);
				pointsFromExchangeWanted.setShopName(orderInfo.getShopName());
				pointsFromExchangeWanted.setPlatformPoint(pm.findPointByUserName(pointsFromExchangeWanted)+orderInfo.getPoint());
								
				int pointRes1 = pm.updatePoint(pointsFromRelease);
				int pointRes2 = pm.updatePoint(pointsFromReleaseWanted);
				int pointRes3 = pm.updatePoint(pointsFromExchange);
				int pointRes4 = pm.updatePoint(pointsFromExchangeWanted);
				
				String orderDate = TimeUtils.getNowTime();
				int orderStatus = orderStatus_finished;//�������
			
				Order order = new Order();
				order.setOrderID(orderID);
				order.setExchangeUserName(exchangeUserName);
				order.setOrderDate(orderDate);
				order.setOrderStatus(orderStatus);
				int orderRes = om.finshOrder(order);//��ɶ���
			
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
			request.setAttribute("exchangeRes", "����blockchainʧ�ܣ���������");
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
