package com.bit.bonusPointsExchange.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bit.bonusPointsExchange.bean.User;
import com.bit.bonusPointsExchange.manager.LoginManager;

public class LoginAction extends Action{
	/*
	 * µÇÂ½
	 * */

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		String userName = request.getParameter("userName");
		String passwd = request.getParameter("passwd");	
		System.out.println(userName);
		System.out.println(passwd);
		
		LoginManager lm = new LoginManager();
		User user = new User();
		user.setUserName(userName);
		user.setPasswd(passwd);
		
		int result = lm.isValid(user);
			if(result==1){//success	
				System.out.println(result);
				session.setAttribute("userName", user.getUserName());
				System.out.println(session.getAttribute("userName"));
				request.getRequestDispatcher("index.jsp").forward(request, response);
			
			}else{//fail
				request.setAttribute("loginRes","N");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		
	}

}
