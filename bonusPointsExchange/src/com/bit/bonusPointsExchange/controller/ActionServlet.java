package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionServlet extends HttpServlet {


	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doPost(request,response);

	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String actionCode=request.getParameter("actionCode");	
		System.out.println(actionCode);
		
		Action action = null;
		if(actionCode.equals("login")){
			action = new LoginAction();
		}else if(actionCode.equals("regist")){
			action = new RegistAction();
		}else if(actionCode.equals("user")){
			action = new UserAction();
		}else if(actionCode.equals("findPasswd")){
			action = new FindPasswdAction();
		}else if(actionCode.equals("resetPasswd")){
			action = new ResetPasswdAction();
		}
		action.execute(request, response);

	}
	
	/**
	 * Constructor of the object.
	 */
	public ActionServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	@Override
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}


	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	@Override
	public void init() throws ServletException {
		// Put your code here
	}

}
