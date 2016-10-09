<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bit.bonusPointsExchange.bean.Order"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	List<Order> latestOrderInfoList = (List<Order>)request.getAttribute("latestOrderInfo");//最新发布的订单
%>

<%
  String exchangeRes = (String)request.getAttribute("exchangeRes");  //获取积分兑换是否成功
  if(exchangeRes == "false") {
%>
  <script type="text/javascript" language="javascript">
    alert("积分兑换失败！");                            
  </script> 
<% } else if(exchangeRes == "true") {%>
  <script type="text/javascript" language="javascript">
    alert("积分兑换 成功！");                                      
  </script> 
<% }%>
<%
  String isBindShopName = (String)request.getAttribute("isBindShopName");  //获取商家是否绑定
  if(isBindShopName == "false") {
%>
  <script type="text/javascript" language="javascript">
    alert("您未绑定商家！");                            
  </script> 
<% }%>
<%
  String isBindWantedShop = (String)request.getAttribute("isBindWantedShop");  //获取目标商家是否绑定
  if(isBindWantedShop == "false") {
%>
  <script type="text/javascript" language="javascript">
    alert("您未绑定目标商家！");                            
  </script> 
<% }%>
<%
  String isPointEnough = (String)request.getAttribute("isPointEnough");  //获取商家积分是否足够用来交易
  if(isPointEnough == "no") {
%>
  <script type="text/javascript" language="javascript">
    alert("您在商家的积分不够！");                            
  </script> 
<% }%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>最新交易</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
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
        <li><a href="/bonusPointsExchange/QueryLatestOrder">最新发布</a></li>
        <li><a href=#>发起交易</a></li>
        <li><a href="regist.jsp">我的账户</a></li>
      </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="exchangeOrder">
    <p class="title">最新发布<span class="title1">&nbsp;&nbsp;&nbsp;REALEASE RECENTLY</span></p>
  <div id="order-list" class="clearfix"> 
    <!---- 事例1------>
    <div class="order-info clearfix">
     <% if(null != latestOrderInfoList) {
             //System.out.println(latestOrderInfoList.size());
            for(int i = 0; i < latestOrderInfoList.size(); i++) {
           	 Order orderInfo = (Order)latestOrderInfoList.get(i);
      %>
    <form action= "/bonusPointsExchange/FinishLatestOrder" method="post">
      <ul>
        <li class="shop-logo"><img src="images/1.jpg"/></li>
        <li class="info">
          <table>
            <tr>
              <td>商家：<%=orderInfo.getShopName()%></td>
              <td>目标商家：<%=orderInfo.getWantedShop()%></td>
            </tr>
            <tr>
              <td>积分数量：<%=orderInfo.getPoint()%></td>
              <td>目标积分数量：<%=orderInfo.getWantedPoint()%></td>
            </tr>
            <tr>
             <td>订单发布方：<%=orderInfo.getUserName() %></td>
              <td>截止日期：<%=orderInfo.getUntilDate()%></td>
              <td></td>
            </tr> 
          </table>
        </li>
        <li class="operate">
          <input name="exchange" type="submit" class="submitBtn"  id="exchange" value="交易">
        </li>
        <input type="hidden" name="orderID" value="<%=orderInfo.getOrderID()%>"/>
        <input type="hidden" name="actionCode" value="order"/>
      	<input type="hidden" name="methodCode" value="finsh_order"/>
      	
      </ul>
     </form>
    <%} %>
  <%} else {%>
       <br/><br/><br/><p align="center">  搜索结果为0！</p>
 <%} %>
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
