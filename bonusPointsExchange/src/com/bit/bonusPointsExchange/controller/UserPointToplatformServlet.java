package com.bit.bonusPointsExchange.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;

public class UserPointToplatformServlet extends HttpServlet {

	//���ڴ����û�ѡ��ת�ƻ��ֵ�ƽ̨
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserAction userAction = new UserAction();
		
		//�и�ǰ�ᣬ�����û����̼�ע����û������û���ƽ̨ע����û�����ͬ����ΪĿǰ�޷�֪���̼ҵ����ݿ�
		//���ת�ƻ������ݿ���ز���
		//System.out.println("UserPointToplatformServlet");
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8"); 
		//ͨ��session��ȡƽ̨�û���
		String userName =(String)request.getSession().getAttribute("userName");	
		//��ȡ�û���������,
		String points = (String)request.getParameter("points");
		int point = Integer.parseInt(points);
		//��ȡ�û���Ҫת�ƵĻ�������,����ת������
		String transfer_points = (String)request.getParameter("transfer_points");
		int wantTransfer_points = Integer.parseInt(transfer_points);
		//��ȡ�û������̼�
		String shopName = request.getParameter("shop");
		//�������ݿ�
		UserPointToplatfromManger dbManger = new UserPointToplatfromManger();
		if(point == -1 || point == 0 || wantTransfer_points == 0 || wantTransfer_points > point) {
			request.setAttribute("pointTranRes", "N");
			userAction.queryUserInfo(request, response);
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
