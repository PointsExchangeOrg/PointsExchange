<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--这是top-->
<div style="background-color:#FCFCFC; margin-top:0px;">
<div class="header">
  <div class="span1">
    <div class="logo"><img src="images/logo.png" alt="积分兑换平台"/></div>
  </div>
  <div class="span2">
    <div class="mainNav">
      <ul>
        <li><a href="index.jsp">主页</a></li>
        <li><a href="reference.jsp">参考价</a></li>
        <li><a href="/bonusPointsExchange/QueryLatestOrder">最新发布</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops">发起交易</a></li>
    <%
	String isUserLogin = (String)session.getAttribute("userName"); 
	String isShopLogin = (String)session.getAttribute("shopName"); 
	if(isUserLogin == null && isShopLogin == null) {
	%>
	<li><a href="login.jsp">登录</a> </li>
<% } else if(isUserLogin != null && isShopLogin == null){%>
	 <li  style="font-size:30px;">
	<a href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info"><%=session.getAttribute("userName") %></a>|<a href="/bonusPointsExchange/actionServlet?actionCode=log&methodCode=logout&logType=user"><span style="font-size:18px;">注销</span></a></li>	
	 <% } else if(isShopLogin != null && isUserLogin == null){%>
	 <li style="font-size:30px;">
	<a href="/bonusPointsExchange/QueryShopInfoServlet"><%=session.getAttribute("shopName") %></a>|<a href="/bonusPointsExchange/actionServlet?actionCode=log&methodCode=logout&logType=shop"><span style="font-size:18px;">注销</span></a></li>	
<% }%>

     </ul>
    </div>
  </div>
</div>
<hr  style="background-color:#EBEBEB; height:1px;"/>
</div>