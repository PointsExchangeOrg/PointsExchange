package com.bit.bonusPointsExchange.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;

public class UserPointToplatformServlet extends HttpServlet {

	//用于处理用户选择转移积分到平台
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserAction userAction = new UserAction();
		
		//有个前提，假设用户在商家注册的用户名和用户在平台注册的用户名相同，因为目前无法知道商家的数据库
		//完成转移积分数据库相关操作
		//System.out.println("UserPointToplatformServlet");
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8"); 
		//通过session获取平台用户名
		String userName =(String)request.getSession().getAttribute("userName");	
		//获取用户积分数量,
		String points = (String)request.getParameter("points");
		int point = Integer.parseInt(points);
		//获取用户想要转移的积分数量,并且转换整数
		String transfer_points = (String)request.getParameter("transfer_points");
		int wantTransfer_points = Integer.parseInt(transfer_points);
		//获取用户所在商家
		String shopName = request.getParameter("shop");
		//更新数据库
		UserPointToplatfromManger dbManger = new UserPointToplatfromManger();
		if(point == -1 || point == 0 || wantTransfer_points == 0 || wantTransfer_points > point) {
			request.setAttribute("pointTranRes", "N");
			userAction.queryUserInfo(request, response);
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
				request.setAttribute("pointTranRes", "Y");
				//request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
				userAction.queryUserInfo(request, response);
			}
			else 
			{
				request.setAttribute("pointTranRes", "N");
				userAction.queryUserInfo(request, response);
			}
		}
	}
}
