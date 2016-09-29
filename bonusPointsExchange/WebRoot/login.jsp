<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String loginRes = (String)request.getAttribute("loginRes");  //获取商家注册是否成功
	if(loginRes == "N") {
%>
	<script type="text/javascript" language="javascript">
		alert("登录失败！请重新登录！");                            
	</script>	
<% } %>

<%
	String registRes = (String)request.getAttribute("registRes");  //获取商家注册是否成功
	if(registRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("注册成功！请登录！");                            
	</script>	
<% } %>

<%
	String userChangePasswd = (String)request.getAttribute("userChangePasswd");  //获取修改商家信息是否成功
	if(userChangePasswd == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("修改密码成功！请重新登录！");                                    
	</script>	
<% } else if(userChangePasswd == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("修改密码失败！");                                    
	</script>	
<% }%>


<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
<!--这是top-->
<div class="header">
  <div class="span1">
    <div class="logo"> <img src="images/logo.png" alt="积分兑换平台"/> </div>
  </div>
  <div class="span2">
    <div class="mainNav">
      <ul>
        <li><a href=#> 主页</a></li>
        <li><a href=#> 参考价</a></li>
        <li><a href=#>最新交易</a></li>
        <li><a href=#>发起交易</a></li>
        <li><a href=#>我的账户</a></li>
      </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="main line-bottom">
  <div class="login-frame">
    <div class="line-bottom">
      <p class="title">用户登录&nbsp;&nbsp;<span class="title1">USER LOGIN</span>&nbsp;&nbsp;<span class="title1"><a href="login_shop.jsp">商家登录</a></span></p>
    </div>
    <div class="span3">
      <div class="ad"> <img src="images/ad3.jpg" alt="广告"/> </div>
    </div>
    <div class="span4">
      <form name="form_login" class="login-form" action="/bonusPointsExchange/actionServlet" method="post">
        <table cellspacing="2">
          <tr>
            <td colspan="2">用户名：
              <input name="userName" type="text" id="userName" maxlength="20"></td>
          </tr>
          <tr>
            <td colspan="2">密&nbsp;码：
              <input name="passwd" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submit" id="submit" value="提交"></td>
            <td class="mid"><input name="reset" type="reset" id="reset" value="重置"></td>
          </tr>
        </table>
       <div class="mes"><a href="regist.jsp">免费注册&nbsp;&nbsp; </a><a href="/bonusPointsExchange/retrievePassword_1.jsp">忘记密码</a></div>
       <input type="hidden" name="actionCode" value="login"/>
      </form>
    </div>
  </div>
</div>
<!--这是bottom-->
<div class="footer">
  <div class="footer-content">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
  </div>
</div>
</body>
</html>
