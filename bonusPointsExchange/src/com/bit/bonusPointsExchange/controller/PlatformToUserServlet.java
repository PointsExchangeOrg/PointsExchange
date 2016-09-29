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
		//ͨ��session��ȡƽ̨�û���
		String userName =(String)request.getSession().getAttribute("userName");	
		//��ȡ�û���ƽ̨��������
		String points = (String)request.getParameter("platformPoints");
		int point = Integer.parseInt(points);
		//��ȡ�û���Ҫת�ƵĻ�������,����ת������
		String transfer_points = (String)request.getParameter("transfer_points");
		int wantTransfer_points = Integer.parseInt(transfer_points);
		
		//System.out.println(point);
		//System.out.println(wantTransfer_points);
		
		//��ȡ�û������̼�
		String shopName = request.getParameter("shop");
		//�������ݿ�
		PlatformPointToUserManger dbManger = new PlatformPointToUserManger();
		if(point == -1 || point == 0 || wantTransfer_points == 0 || wantTransfer_points > point) {
			request.setAttribute("pointToPshopRes", "N");
			request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
			}
		else {
			//ִ����ز���
			//1.ƽ̨���ݿ������ӻ���
			boolean res1 = dbManger.updatePointsPlatform(userName, shopName, wantTransfer_points);
			//2.�̼����ݿ��м��ٻ���
			boolean res2 = dbManger.updatePointsShop(userName, shopName, wantTransfer_points);
			if (res1&& res2) 
			{
				UserPointToplatfromManger pointToplatfromManger = new UserPointToplatfromManger();
				int userPoints1 =  pointToplatfromManger.ownPointsAtPlatform(userName, shopName);//�û���ƽ̨�Ļ���
				int shopPoints1 = pointToplatfromManger.ownPoints(userName, shopName);//�û����̼ҵĻ���
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
