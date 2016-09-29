package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.manager.BindShopManger;
import com.bit.bonusPointsExchange.utils.Encode;

public class BindShopServlet extends HttpServlet {
//ִ�а��̼ҵ���ز���
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		//��ȡ�û���д�������̼ҵ��û���������
		String userName = (String) request.getParameter("userName");//���̼ҵ��û���
		String password = (String) request.getParameter("password");//���̼ҵ�����
		String shopName = (String)request.getParameter("ShopName");//�̼�����
		//String password = Encode.MD5Encode(passwd);//����
		//System.out.println(shopName);
		//��ѯ�̼����ݿ�userpoint�ȶ�,��ѯ���û�������ѡ���̼��Ƿ�ע��
		//��������1.ѡ����̼ұ���������ƽ̨ע����ܱ���
		//2.�û�����������ƽ̨��¼
		//3.ѡ�����̼Ҹ��û�û�а�
		//4.�û�������ѡ���̼ұ���ע��
		BindShopManger bindShopManger = new BindShopManger();
		int res = bindShopManger.isValid(userName, password,shopName);
		if(res == 1) {//���ڣ�����point������һ���ʾ�û��İ���Ϣ����󶨵��̼ҵ����ƣ��Լ������ƣ��󶨵��̼��Լ�ת�Ƶ�ƽ̨�Ļ���
			//�ڲ������ݿ�֮ǰӦ���ж��Ƿ��Ѿ����˸��̼�
			String user =(String)request.getSession().getAttribute("userName");	
			boolean re = bindShopManger.isBindThisShop(user, shopName);
			if(!re) {
				int count = bindShopManger.insertBindInfoToPoint(user, shopName);
				if(count == 1) {//����ɹ�����point���в�ѯ���û��󶨵��̼�
					request.setAttribute("index", "5");//������ʾ�ڼ���div
					//����������ԣ�ת����ҳ�������ʾ
					request.setAttribute("bindRes", "Y");
					request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
					return;
				}
			}
		}
		//������
		//��ʾ��ʧ�ܣ�ͣ����ԭҳ�棬���½��а�
		request.setAttribute("shopName", shopName);
		request.setAttribute("bindRes", "N");
		request.setAttribute("index", "5");//������ʾ�ڼ���div
		//out.print("<script language='JavaScript'>alert('��ʧ�ܣ������½��а󶨣�');location.href='/bonusPointsExchange/bindShop.jsp';</script>");
		request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
		
	}

}
