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
import com.bit.bonusPointsExchange.manager.PlatformPointToUserManger;
import com.bit.bonusPointsExchange.manager.UserPointToplatfromManger;

public class PlatformToUserServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
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
		//��ȡ�û����̼�ע����û���
		String userNameAtShop = (String)request.getParameter("userName");
		//��ȡ�û������̼�
		String shopName = request.getParameter("shop2");
		//�������ݿ�
		PlatformPointToUserManger dbManger = new PlatformPointToUserManger();
		if(point == 0 || wantTransfer_points == 0 || wantTransfer_points > point) {
			request.setAttribute("pointToPshopRes", "N");
			request.setAttribute("userPoints", point);
			}
		else {
			//ִ����ز���
			//1.ƽ̨���ݿ��м��ٻ���
			boolean res1 = dbManger.updatePointsPlatform(userName, shopName, wantTransfer_points);
			//2.�̼����ݿ������ӻ���
			boolean res2 = dbManger.updatePointsShop(userNameAtShop, shopName, wantTransfer_points);
			UserPointToplatfromManger pointToplatfromManger = new UserPointToplatfromManger();
			//��ѯpointID
			int pointID = dbManger.queryPointID(userName, shopName);
			//��transfer���м�¼��ʽ���
			Transfer transfer = new Transfer(pointID, 1, wantTransfer_points);
			int res3 = dbManger.insertTransfer(transfer);
			if (res1 && res2 && (0 != res3)) ////�������߼�������ģ�����������ݿ����ʧ��һ������Ҫ�����ݿ�ع���û�и��µ�״̬��Ҫ�ֱ�ȥ�жϣ������ع��ĸ����ݿ�
			{
				int userPoints1 =  pointToplatfromManger.ownPointsAtPlatform(userName, shopName);//�û���ƽ̨�Ļ���
				int shopPoints1 = pointToplatfromManger.ownPoints(userNameAtShop, shopName);//�û����̼ҵĻ���
				String userPoints = String.valueOf(userPoints1);
				String shopPoints = String.valueOf(shopPoints1);
				request.setAttribute("userPoints", userPoints);
				request.setAttribute("shopPoints", shopPoints);
				request.setAttribute("pointToPshopRes", "Y");	
			}
			else {
				request.setAttribute("userPoints", point);
				request.setAttribute("pointTranRes", "N"); 
				
			}
		}
		//��ѯ�û��󶨵��̼���Ϣ����ʾ��select��
		BindShopManger bindShopManger = new BindShopManger();
		List< ShowBindInfo> list = bindShopManger.bingShopInfo(userName);
		request.setAttribute("bindInfo", list);
		request.setAttribute("index", "4");
		request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
		
	}

}
