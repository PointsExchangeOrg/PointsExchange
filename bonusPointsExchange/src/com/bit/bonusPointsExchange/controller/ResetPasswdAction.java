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
 * �����������루���������
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
            errors.put("newPassword", "�����벻��Ϊ�գ�");  
        }  
          
        if (rePassword == null || "".equals(rePassword)) {  
            errors.put("rePassword", "ȷ�������벻��Ϊ�գ�");  
        }  
          
        if (!newPassword.equals(rePassword)) {  
            errors.put("passwordError", "������������벻һ�£�");  
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
