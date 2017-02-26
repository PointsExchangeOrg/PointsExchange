<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	String shopChangePwdResult = (String)request.getAttribute("shopChangePwdResult");  //获取修改商家mima是否成功
	if(shopChangePwdResult == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("修改密码成功！请重新登录！");   
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
	String resetPasswdMeg =  (String)request.getAttribute("resetPasswdMeg");//忘记密码重置密码
	if(resetPasswdMeg == "success") {
%>
	<script type="text/javascript" language="javascript">
		alert("重置密码成功，请重新登录");                            
	</script>	
<% } %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Shop Login</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/main.css">
<link href="<%=basePath%>css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/login.css">
</head>
<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div style="min-height:500px;">
  <div class="login-frame">
    <div>
      <p class="title">SHOP LOGIN<span class="title1 right"><a href="login.jsp">Go to user login</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
    </div>
    <div class="span3">
      <div class="ad"> <img src="images/point.jpg" alt="advertisment"/> </div>
    </div>
    <div class="span4">
      <form class="login-form" action="/bonusPointsExchange/ShopLoginServlet" method="post" onsubmit="return checkForm();">
        <table cellspacing="2">
          <tr>
            <td style="text-indent:1em; font-size:18px;">Username：</td>
            <td><input name="userName" type="text" id="userName" maxlength="20"></td>
          </tr>
          <tr>
            <td style="text-indent:1em; font-size:18px;">Password：</td>
            <td><input name="password" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
            <td class="mid"><input name="reset" type="reset" class="submitBtn" id="reset" value="Reset"></td>
          </tr>
        </table>
        <div class="mes" style="font-size:15px;"><a href="regist_shop.jsp">Sign up for free </a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/bonusPointsExchange/retrievePassword_1.jsp?method=forgetPasswd_shop">Forgot password?</a>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</div>
      </form>
    </div>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>

<script type="text/javascript">

//表单验证
function checkForm() {
	// alert("ada");
	var userName = document.getElementById("userName").value;
	if (userName == "") {
		alert("用户名不能为空！");
		return false;
	}
	
	var password = document.getElementById("password").value;
	if (password == "") {
		alert("密码不能为空！");
		return false;
	}
}
</script>
</body>
</html>



