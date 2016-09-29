package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.bean.User;
import com.bit.bonusPointsExchange.manager.RegistManager;
import com.bit.bonusPointsExchange.manager.UserManager;
import com.bit.bonusPointsExchange.utils.EmailUtils;


public class RegistAction extends Action{
	/*
	 * 注册
	 */
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8"); 
		PrintWriter out = response.getWriter();
		RegistManager rm = new RegistManager();
		User user = new User();		
		String userName = request.getParameter("userName");
		String passwd = request.getParameter("passwd");
		String passwd2 = request.getParameter("repassword");
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullName");
		String phone = request.getParameter("phone");
		
		Map<String, String> errors = new HashMap<String,String>();
		
		int regist=0;
		int count = rm.isRegist(userName);
/*		if (userName == null || "".equals(userName)) {  
            errors.put("userName", "用户名不能为空!");  
        } else if (userName != null && count==1) {  
            errors.put("userName", "该用户已注册!");  
        }  
          
        if (passwd == null || "".equals(passwd)) {  
            errors.put("password","密码不能为空!");  
        } else if (passwd != null && passwd.length() < 3) {  
            errors.put("password","密码长度不能低于3位!");  
        }  
          
        if (passwd2 == null || "".equals(passwd2)) {  
            errors.put("password2", "确认密码不能为空!");  
        } else if (passwd2 != null && !passwd2.equals(passwd)) {  
            errors.put("password2", "两次输入的密码不一致!");  
        }  
          
        if (email == null || "".equals(email)) {  
            errors.put("email", "email不能为空!");  
              
        } else if (email != null && !email.matches("[0-9a-zA-Z_-]+@[0-9a-zA-Z_-]+\\.[0-9a-zA-Z_-]+(\\.[0-9a-zA-Z_-])*")) {  
            errors.put("email", "email格式不正确!");  
        }  
          
        if (!errors.isEmpty()) {  
            request.setAttribute("errors", errors);             
            //request.getRequestDispatcher("/registerUI").forward(request, response);  
        }else{*/
            user.setUserName(userName);
    		user.setPasswd(passwd);
    		user.setEmail(email);
    		user.setFullName(fullName);
    		user.setPhone(phone);
    		//user.setActivated(false);
    		//user.setRandomCode(UUID.randomUUID().toString());
            regist = rm.registUser(user);
    		if(regist>0){			
    			//EmailUtils.sendAccountActivateEmail(user);// 注册成功后,发送帐户激活链接
    			request.setAttribute("registRes", "Y");//注册成功，跳转到登录页面进行注册，同时提示用户注册成功
    			request.getRequestDispatcher("login.jsp").forward(request, response);
    			//request.getRequestDispatcher("/login.jsp").forward(request, response);
    			//request.setAttribute("userName", userName);
    			//request.setAttribute("email", email);
    			//request.getRequestDispatcher("/registSuccess.jsp").forward(request, response);
    		}
    		else {
    			out.print("<script language='JavaScript'>alert('注册失败！请重新进行注册！');location.href='/bonusPointsExchange/regist.jsp';</script>");
			}
        
	}

}
