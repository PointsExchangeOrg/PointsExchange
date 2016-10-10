<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    String shopName = request.getParameter("shopName"); 
    if(null != shopName) 
   		shopName = new String(shopName.getBytes("ISO-8859-1"),"utf-8"); 
   	else 
   		shopName = (String)request.getAttribute("shopName");	
%>



<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>绑定商家</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/personal.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!-- 
<div class="header">
  <div class="span1">
    <div class="logo"> <img src="images/logo.png" alt="积分兑换平台"/> </div>
  </div>
  <div class="span2">
    <div class="mainNav">
      <ul>
       <li><a href="index.jsp"> 主页</a></li>
        <li><a href="reference.jsp"> 参考价</a></li>
        <li><a href="/bonusPointsExchange/QueryLatestOrder">最新发布</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops">发起交易</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info"><%=session.getAttribute("userName") %></a></li>
      </ul>
    </div>
  </div>
</div>
-->
<!--这是main_page-->
<div class="main">
  <div class="bind-form">
    <p class="title">绑定商家&nbsp;&nbsp;<span class="title1">BIND SHOP</span></p>
    <form action="/bonusPointsExchange/BindShopServlet" method="post">
      <table cellspacing="2">
        <tr>
          <td>商家名：</td>
          <td><input name="ShopName" type="text" id="ShopName" class="no-border" value="<%=shopName %>" maxlength="20" readonly ></td>
        </tr>
        <tr>
          <td>用户名：</td>
          <td><input name="userName" type="text" id="userName" maxlength="20"></td>
        </tr>
        <tr>
          <td>密&nbsp;码：</td>
          <td><input name="password" type="password" id="password" maxlength="20"></td>
        </tr>
        <tr>
          <td class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" onsubmit="checkForm()" value="提交"></td>
          <td class="mid"><input name="reset" type="reset" class="submitBtn" id="reset" value="重置"></td>
        </tr>
      </table>
    </form>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
</body>


<script type="text/javascript">
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
</html>


