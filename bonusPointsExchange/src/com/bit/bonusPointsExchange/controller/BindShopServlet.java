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
//执行绑定商家的相关操作
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		//获取用户填写的他在商家的用户名和密码
		String userName = (String) request.getParameter("userName");//在商家的用户名
		String password = (String) request.getParameter("password");//在商家的密码
		String shopName = (String)request.getParameter("ShopName");//商家名称
		//String password = Encode.MD5Encode(passwd);//加密
		//System.out.println(shopName);
		//查询商家数据库userpoint比对,查询该用户在他所选的商家是否注册
		//绑定条件：1.选择的商家必须在我们平台注册才能被绑定
		//2.用户必须在我们平台登录
		//3.选定的商家该用户没有绑定
		//4.用户在他所选的商家必须注册
		BindShopManger bindShopManger = new BindShopManger();
		int res = bindShopManger.isValid(userName, password,shopName);
		if(res == 1) {//存在，更新point表，插入一项，表示用户的绑定信息，如绑定的商家的名称，自己的名称，绑定的商家自己转移到平台的积分
			//在插入数据库之前应该判断是否已经绑定了该商家
			String user =(String)request.getSession().getAttribute("userName");	
			boolean re = bindShopManger.isBindThisShop(user, shopName);
			if(!re) {
				int count = bindShopManger.insertBindInfoToPoint(user, shopName);
				if(count == 1) {//插入成功，在point表中查询该用户绑定的商家
					request.setAttribute("index", "5");//设置显示第几个div
					//设置相关属性，转发到页面进行显示
					request.setAttribute("bindRes", "Y");
					request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
					return;
				}
			}
		}
		//不存在
		//提示绑定失败，停留在原页面，重新进行绑定
		request.setAttribute("shopName", shopName);
		request.setAttribute("bindRes", "N");
		request.setAttribute("index", "5");//设置显示第几个div
		//out.print("<script language='JavaScript'>alert('绑定失败！请重新进行绑定！');location.href='/bonusPointsExchange/bindShop.jsp';</script>");
		request.getRequestDispatcher("personalv1.0.jsp").forward(request, response);
		
	}

}
