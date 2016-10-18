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
<% }else if(exchangeRes == "连接blockchain失败，请检查网络") {%>
  <script type="text/javascript" language="javascript">
    alert("连接blockchain失败，请检查网络！");                                      
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

<%
//用户和商家需登录之后才能查看最新发布
String userName = (String)request.getSession().getAttribute("userName");
String shopName = (String)request.getSession().getAttribute("shopName");	
if(userName == null && shopName == null) { %>
	<script type="text/javascript" language="javascript">
		alert("您还没有登录！请登录！");    // 弹出错误信息
		window.location.href="/bonusPointsExchange/login.jsp" ;                             
	</script>	
<% } %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>智能推荐</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="exchangeOrder">
    <p class="title">系统推荐订单<span class="title1">&nbsp;&nbsp;&nbsp;RECOMMEND ORDER</span><span class="title1 right"><a href="order.jsp">返回订单中心</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
  <div id="order-list" class="clearfix"> 
    <!---- 事例1------>
    <div class="order-info clearfix">
    <!-- 每次需要获得两个订单的详细信息-->
     <% if(null != latestOrderInfoList) {
             //System.out.println(latestOrderInfoList.size());
            for(int i = 0; i < latestOrderInfoList.size(); i++) {
           	 Order orderInfo = (Order)latestOrderInfoList.get(i);
      %>
      <!-- 以上需要修改 -->
    <form action= "/bonusPointsExchange/FinishLatestOrder" method="post" onsubmit="return checkShop();">
      <ul class="clearfix">
        <li class="shop-logo"><img src="images/shopLogo/<%=orderInfo1.getShopLogo()%>"/></li>
        <li class="exchangeOrder-info">
        <!-- table 中是用户最终交易需要的积分-->
          <table>
            <tr>
              <td>商家：<%=orderInfo1.getShopName()%></td>
            </tr>
            <tr>
              <td>积分数量：<%=orderInfo1.getPoint()%></td>
            </tr>
            <tr>
             <td>订单交易方：3方</td>
            </tr> 
          </table>
        </li>  
        <li><img src="images/2.png"/></li>
        <li>&nbsp;&nbsp;</li>
        <li class="shop-logo" rowspan="3"><img src="images/shopLogo/<%=orderInfo2.getWantedShopLogo() %>"/></li>
        <li class="exchangeOrder-info">
        <!-- table 中是用户最终交易获得的积分-->
          <table>
            <tr>
              <td>目标商家：<%=orderInfo2.getWantedShop()%></td>
            </tr>
            <tr>
              <td>目标积分数量：<%=orderInfo2.getWantedPoint()%></td>
            </tr>
            <tr>
              <td>截止日期：<%=orderInfo2.getUntilDate()%></td>
            </tr> 
          </table>
        </li>        
        <%if(orderInfo.getUserName().equals(isUserLogin)) { %>
        <li class="operate">
          <input name="exchange" type="button" style="background:#EDEDED;" disabled="disabled" class="submitBtn"  id="exchange" value="交易">
        </li>
        <%} else {%>
         <li class="operate">
          <input name="exchange" type="submit" class="submitBtn"  id="exchange" value="交易">
        </li>
        <%} %>
        <input type="hidden" name="orderID1" value="<%=orderInfo1.getOrderID()%>"/>
        <input type="hidden" name="orderID2" value="<%=orderInfo2.getOrderID()%>"/>
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
   <input type="hidden" name="session" id="session" value="<%=session.getAttribute("shopName") %>"/>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
</body>

<script type="text/javascript">
function checkShop() {
	var shop = document.getElementById("session").value;
	if (shop != "null") {
		alert("商家类型账号不能交易，请更换用户类型账号登录！");
		return false;
	}
}
</script>
-->
</html>
