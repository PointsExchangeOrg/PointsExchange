package com.bit.bonusPointsExchange.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.manager.PlatformPointToUserManger;
import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;

public class PlatformToUserServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		UserAction userAction = new UserAction();
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8"); 
		//通过session获取平台用户名
		String userName =(String)request.getSession().getAttribute("userName");	
		//获取用户在平台积分数量
		String points = (String)request.getParameter("platformPoints");
		int point = Integer.parseInt(points);
		//获取用户想要转移的积分数量,并且转换整数
		String transfer_points = (String)request.getParameter("transfer_points");
		int wantTransfer_points = Integer.parseInt(transfer_points);
		
		//System.out.println(point);
		//System.out.println(wantTransfer_points);
		
		//获取用户所在商家
		String shopName = request.getParameter("shop");
		//更新数据库
		PlatformPointToUserManger dbManger = new PlatformPointToUserManger();
		if(point == -1 || point == 0 || wantTransfer_points == 0 || wantTransfer_points > point) {
			request.setAttribute("pointToPshopRes", "N");
			request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
			}
		else {
			//执行相关操作
			//1.平台数据库中增加积分
			boolean res1 = dbManger.updatePointsPlatform(userName, shopName, wantTransfer_points);
			//2.商家数据库中减少积分
			boolean res2 = dbManger.updatePointsShop(userName, shopName, wantTransfer_points);
			if (res1&& res2) 
			{
				UserPointToplatfromManger pointToplatfromManger = new UserPointToplatfromManger();
				int userPoints1 =  pointToplatfromManger.ownPointsAtPlatform(userName, shopName);//用户在平台的积分
				int shopPoints1 = pointToplatfromManger.ownPoints(userName, shopName);//用户在商家的积分
				String userPoints = String.valueOf(userPoints1);
				String shopPoints = String.valueOf(shopPoints1);
				request.setAttribute("userPoints", userPoints);
				request.setAttribute("shopPoints", shopPoints);
				//request.setAttribute("userName", userName);
				request.setAttribute("pointToPshopRes", "Y");
				//request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
				userAction.queryUserInfo(request, response);
				//request.getRequestDispatcher("success.jsp").forward(request, response);
			}
			else {
				request.setAttribute("pointToPshopRes", "N");
				request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
			}
		}
		
	}

}
