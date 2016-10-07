package com.bit.bonusPointsExchange.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit.bonusPointsExchange.bean.User;
import com.bit.bonusPointsExchange.manager.UserManager;

/**
 * @author gmx
 * 重新设置密码（忘记密码后）
 */
public class ResetPasswdAction extends Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userName = request.getParameter("userName");  
        String newPassword = request.getParameter("newPassword");  
        String rePassword = request.getParameter("rePassword");  
        Map<String,String> errors = new HashMap<String, String>();  
        UserManager um = new UserManager();
        User user = new User();
        if (newPassword == null || "".equals(newPassword)) {  
            errors.put("newPassword", "新密码不能为空！");  
        }  
          
        if (rePassword == null || "".equals(rePassword)) {  
            errors.put("rePassword", "确认新密码不能为空！");  
        }  
          
        if (!newPassword.equals(rePassword)) {  
            errors.put("passwordError", "两次输入的密码不一致！");  
        }  
          
        if (!errors.isEmpty()) {  
            request.setAttribute("errors", errors);  
        }  else{
            user.setUserName(userName);
            user.setPasswd(newPassword);
            
            int result = um.alterUserPasswd(user);
            if(result ==1){
            	request.getRequestDispatcher("success.jsp").forward(request, response);  
                
            }else 
            	request.getRequestDispatcher("fail.jsp").forward(request, response);  
        }
          
     
	}

}
