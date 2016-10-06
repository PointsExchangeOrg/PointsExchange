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
		
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");	
		
		String actionCode=request.getParameter("actionCode");	

		Action action = null;
		if(actionCode.equals("login")){//µÇÂ½
			action = new LoginAction();
		}else if(actionCode.equals("regist")){//×¢²á
			action = new RegistAction();
		}else if(actionCode.equals("user")){//ÓÃ»§Ä£¿é
			action = new UserAction();
		}else if(actionCode.equals("findPasswd")){//Íü¼ÇÃÜÂë
			action = new FindPasswdAction();
		}else if(actionCode.equals("resetPasswd")){//ÖØÖÃÃÜÂë
			action = new ResetPasswdAction();
		}else if(actionCode.equals("bindShop")){
			action = new BindShopAction();
		}else if(actionCode.equals("order")){//¶©µ¥Ä£¿é
			action = new OrderAction();
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
