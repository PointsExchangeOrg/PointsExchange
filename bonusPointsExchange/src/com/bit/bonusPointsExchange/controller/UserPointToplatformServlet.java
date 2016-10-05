package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.bean.ShowBindInfo;
import com.bit.bonusPointsExchange.bean.Transfer;
import com.bit.bonusPointsExchange.manager.BindShopManger;
import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;

public class UserPointToplatformServlet extends HttpServlet {

	//���ڴ����û�ѡ��ת�ƻ��ֵ�ƽ̨
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//�и�ǰ�ᣬ�����û����̼�ע����û������û���ƽ̨ע����û�����ͬ����ΪĿǰ�޷�֪���̼ҵ����ݿ�
		//�����������Ҫ�û������̼ҵ����ƺ����루�������
		//���ת�ƻ������ݿ���ز���
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8"); 
		//ͨ��session��ȡƽ̨�û���
		//���ﻹӦ�û�ȡ�û����̼ҵ��û������˺ţ������жϣ���������������������ƽ̨�û������̼��û�����ͬ����Ȼ�ⲻ��ѧF��
		String userName =(String)request.getSession().getAttribute("userName");	
		//��ȡ�û���������
		String points = (String)request.getParameter("points");
		int point = Integer.parseInt(points);
		//��ȡ�û����̼�ע����û���
		String userNameAtShop = (String)request.getParameter("userName");
		//System.out.println(userNameAtShop);
		//��ȡ�û���Ҫת�ƵĻ�������,����ת������
		String transfer_points = (String)request.getParameter("transfer_points");
		int wantTransfer_points = Integer.parseInt(transfer_points);
		//��ȡ�û�ѡ����̼ң��û�ѡ����̼ұ���������ƽ̨���й�ע�ᣨ�������
		String shopName = request.getParameter("shop");
		//�������ݿ�
		UserPointToplatfromManger dbManger = new UserPointToplatfromManger();
		if(point == 0 || wantTransfer_points == 0 || wantTransfer_points > point) {
			request.setAttribute("pointTranRes", "N"); 
			request.setAttribute("shopPoints", point);
		}
		else {
			//ִ����ز���
			//1.ƽ̨���ݿ������ӻ���
			boolean res1 = dbManger.updatePointsPlatform(userName, shopName, wantTransfer_points);
			//��ѯpointID
			int pointID = dbManger.queryPointID(userName, shopName);
			//2.�̼����ݿ��м��ٻ���
			boolean res2 = dbManger.updatePointsShop(userNameAtShop, shopName, wantTransfer_points);
			//��transfer���м�¼��ʽ���
			Transfer transfer = new Transfer(pointID, 0, wantTransfer_points);
			int res3 = dbManger.insertTransfer(transfer);
			
			if (res1 && res2 && (0 != res3)) {//�������߼�������ģ�����������ݿ����ʧ��һ������Ҫ�����ݿ�ع���û�и��µ�״̬����ʱ�����
				int userPoints1 =  dbManger.ownPointsAtPlatform(userName, shopName);//�û���ƽ̨�Ļ���
				int shopPoints1 = dbManger.ownPoints(userNameAtShop, shopName);//�û����̼ҵĻ���
				String userPoints = String.valueOf(userPoints1);
				String shopPoints = String.valueOf(shopPoints1);
				request.setAttribute("userPoints", userPoints);//������ʾ
				request.setAttribute("shopPoints", shopPoints);//������ʾ
				request.setAttribute("pointTranRes", "Y"); 
			}
			else {
				request.setAttribute("shopPoints", point);
				request.setAttribute("pointTranRes", "N"); 
			}
		}
		
		//��ѯ�û��󶨵��̼���Ϣ����ʾ��select��
		BindShopManger bindShopManger = new BindShopManger();
		List< ShowBindInfo> list = bindShopManger.bingShopInfo(userName);
		request.setAttribute("bindInfo", list);
		request.setAttribute("index", "3");
		request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
	}
}
