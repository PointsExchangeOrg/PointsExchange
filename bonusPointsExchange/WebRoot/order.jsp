<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bit.bonusPointsExchange.bean.Order"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.bit.bonusPointsExchange.bean.ShowBindInfo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%List<ShowBindInfo> bindShops = (List<ShowBindInfo>)request.getAttribute("bindShops"); %>
<!-- 显示查询到的订单信息 -->
<% 

	List<Order> list = (List<Order>)request.getAttribute("orderInfo");//个人订单信息
	 List<Order> orders = (List<Order>)request.getAttribute("orders");//按积分优先查询到的订单信息
	List<Order> AllOrderByRateList = (List<Order>)request.getAttribute("AllOrderByRate");//按比率优先查询到的订单信息
	List<Order> AllOrderByUntilDate = (List<Order>)request.getAttribute("AllOrderByUntilDate");//按时效优先查询到的订单信息
 %>
<%
  String releaseOrderRes = (String)request.getAttribute("releaseOrderResult");  //获取发布订单是否成功
  if(releaseOrderRes == "N") {
%>
  <script type="text/javascript" language="javascript">
    alert("发布订单失败！");                            
  </script> 
<% } else if(releaseOrderRes == "Y") {%>
  <script type="text/javascript" language="javascript">
    alert("发布订单 成功！");                                      
  </script> 
<% }%>

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
<title>发布订单</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
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
        <li><a href="index.jsp"> 主页</a></li>
        <li><a href="reference.jsp"> 参考价</a></li>
        <li><a href="exchange.jsp">最新发布</a></li>
        <li><a href=#>订单中心</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info"><%=session.getAttribute("userName") %></a></li>
      </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="main">
  <div id="orderNav">
    <h3>订单中心</h3>
    <p><a href="javascript:showDiv(1)">发布新订单</a> </p>
    <p><a href="javascript:showDiv(2)">查看个人订单</a></p>
    <p><a href="javascript:showDiv(3)">搜索所有订单</a></p>
  </div>
  <div id="orderContent">
    <div id="div1">
      <div class="releaseOrder">
        <p class="title">发布新订单<span class="title1">&nbsp;&nbsp;REALEASE ORDER</span><span class="title1 right"><a href="reference.jsp">前往参考价</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
        <form action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkShop()&&checkPoint()&&checkNull();">
          <table>
            <tr>
              <td>选择商家：</td>
              <td><select  class="normal-font" name="shopName" id="shopName" onchange="queryPointsAtPlatform()" >
                  <option selected="selected">请选择-------</option>
                  <c:forEach items="${bindShops}" var="bindShops">
                    <option>${bindShops.shopName}</option>               
                  </c:forEach>
                </select></td>
            </tr>
             <tr>
              <td>平台积分数量：</td>
              <td><input name="platPoint" type="number" readonly id="platPoint"></td>
              <td><label id="tip1"></label></td>        
            </tr>
            <tr>
              <td>积分数量：</td>
              <td><input name="points" type="number"  id="points" min="0" value="0" onblur="checkPoint()"></td>
            </tr>
            <tr>
              <td>选择目标商家：</td>
              <td><select name="wantedShop"  class="normal-font" id="wantedShop" >
                  <option selected="selected">请选择-------</option>
                   <c:forEach items="${bindShops}" var="bindShops">
                    <option>${bindShops.shopName}</option>               
                  </c:forEach>
                </select></td>
            </tr>
            <tr>
              <td>目标积分数量：</td>
              <td><input name="wantedPoint" type="number"  id="wantedPoint" min="0" value="0"></td>
            </tr>
            <tr>
              <td>截止日期：</td>
              <td><div id="utilDate" name="utilDate" runat="server"></td>
              <input id="utilDate2" name="utilDate2" type="hidden">
             <!--  <div id="utilDate" name="utilDate" RUNAT=SERVER>
              <input name="utilDate" id="utilDate" type="text"> -->
            </tr>
            <tr class="mid">
              <td><input name="submit" type="submit" id="submit" value="提交" ></td>
              <td><input name="reset" type="reset" id="reset" value="重置"></td>
            </tr>
          </table>
          <input type="hidden" name="actionCode" value="order"/>
          <input type="hidden" name="methodCode" value="release_order"/>
        </form>
      </div>
    </div>
    <!-----个人订单--------->
    <div id="div2">
      <p class="title">查看个人订单<span class="title1">&nbsp;&nbsp;PERSONAL ORDER</span></p>
      <div id="order-list" class="clearfix"> 
        <!---- 事例1------>        <div class="order-info clearfix">
          <ul >
          <% if(null != list) {
              System.out.println(list.size());
            for(int i = 0; i < list.size(); i++) {
              Order orderInfo = (Order)list.get(i);
          %>
            <li class="shop-logo"><img src="images/1.jpg"/></li>
            <li class="info">
              <table>
            <tr>                  <td>商家：<%=orderInfo.getShopName() %></td>
                  <td>目标商家：<%=orderInfo.getWantedShop() %></td>
              </tr>
                <tr>
                  <td>积分数量：<%=orderInfo.getPoint() %></td>
                  <td>目标积分数量：<%=orderInfo.getWantedPoint() %></td>
                </tr>
                <tr>
                  <td>截止日期：<%=orderInfo.getUntilDate() %></td>
                  <td></td>
                </tr>              </table>
            </li>
            <%if(orderInfo.getOrderStatus() == 0) { %>
            <li class="operate">
              <input name="exchange" onclick="changOrderStatus(<%=orderInfo.getOrderID() %>)" type="button" class="submitBtn" id="exchange" value="取消">
            </li>
            <%} else if(orderInfo.getOrderStatus() == 1) {%>
             <li class="operate">
              <input name="exchange" type="button" class="submitBtn"  style="background:#EDEDED;" disabled="disabled" id="exchange" value="已完成">
            </li>
            <%} else if(orderInfo.getOrderStatus() == 2) {%>             <li class="operate" >
              <input name="exchange" type="button" class="submitBtn" style="background:#EDEDED;" disabled="disabled" id="exchange" value="已失效">
            </li>
            <%} %>         <%}
       }%>
          </ul>
        </div>
      </div>    </div>    <!----------- 搜索订单------------------------------>
    <div id="div3">      <p class="title">查看所有订单<span class="title1">&nbsp;&nbsp;ALL ORDER</span></p>
      <div id="search">
      <form action="/bonusPointsExchange/actionServlet" method="post">
        <table>
          <tr>
            <td>商&nbsp;家：&nbsp;</td><td><input name="shop" type="text" value="${shop }" id="shop"></td>
          </tr>
          <tr>            <td>目标商家：</td><td><input name="targetShop" type="text" value="${wantedShop }" id="targetShop"></td>
            <td colspan="2" ><input name="submit" type="submit" class="submitBtn" id="submit" value="搜索"></td>          </tr>
        </table>             选择排序方式：
      <select name="selectSort"  id="selectSort">
    <c:if test="${selectID==null}">  
       <option selected="selected">积分优先</option>               
        <option>比率优先</option>
         <option>时效优先</option>
     </c:if>
      <c:if test="${selectID=='2'}">  
       <option>积分优先</option>               
        <option selected="selected">比率优先</option>
         <option>时效优先</option>     </c:if>
     <c:if test="${selectID=='3'}">    
    	 <option>积分优先</option>              
     	 <option>比率优先</option>
       	 <option selected="selected">时效优先</option>
     </c:if>
      </select>
      <input type="hidden" name="actionCode" value="order"/>
          <input type="hidden" name="methodCode" value="findAllOrder"/>
        </form>
      </div>      <div id="search-result">
      <table>
       <% if(null != AllOrderByRateList) {
             System.out.println(AllOrderByRateList.size());
            for(int i = 0; i < AllOrderByRateList.size(); i++) {
             Order orderInfo = (Order)AllOrderByRateList.get(i);
        %>
      <tr><form action="/bonusPointsExchange/actionServlet" method="post">
      <td><input type="hidden" name="orderID" value="<%=orderInfo.getOrderID()%>"/></td>
      <!--头像问题待解决，点击兑换之后的操作待解决-->
      <td> <img src="images/1.jpg"/> <p><%=orderInfo.getWantedShop()%></p></td>
      <td><%=orderInfo.getWantedPoint() %> <img src="images/2.png"/><%=orderInfo.getPoint() %></td>      
      <td><img src="images/1.jpg"/> <p><%=orderInfo.getShopName() %></p></td>      
      <td><p>订单发布方：<%=orderInfo.getUserName() %></p>
      <p>交易有效期：<%=orderInfo.getUntilDate() %></p></td>
      <td><input name="submit" type="submit" class="submitBtn" id="submit" value="兑换"></td>
      <input type="hidden" name="actionCode" value="order"/>
      <input type="hidden" name="methodCode" value="finsh_order"/>
      </form>
      </tr>
         <%} %>
      <%} else if(null != AllOrderByUntilDate) {
            System.out.println(AllOrderByUntilDate.size());
            for(int i = 0; i < AllOrderByUntilDate.size(); i++) {
            Order orderInfo = (Order)AllOrderByUntilDate.get(i);
      %>
      <tr><form action="/bonusPointsExchange/actionServlet" method="post">
      <!--头像问题待解决，点击兑换之后的操作待解决-->
      <td><input type="hidden" name="orderID" value="<%=orderInfo.getOrderID()%>"/></td>
      <td> <img src="images/1.jpg"/> <p><%=orderInfo.getWantedShop() %></p></td>
      <td><%=orderInfo.getWantedPoint() %> <img src="images/2.png"/><%=orderInfo.getPoint() %></td>
      <td><img src="images/1.jpg"/> <p><%=orderInfo.getShopName() %></p></td>
      <td><p>订单发布方：<%=orderInfo.getUserName() %></p>
      <p>交易有效期：<%=orderInfo.getUntilDate() %></p></td>
      <td><input name="submit" type="submit" class="submitBtn" id="submit" value="兑换"></td>
      <input type="hidden" name="actionCode" value="order"/>
      <input type="hidden" name="methodCode" value="finsh_order"/>
      </form>
      </tr>
       <%}%>
     <%} %>
	  <%
		String findRes = (String)request.getAttribute("findRes");
      	if(orders!=null&&orders.size()>0){ %>

      <c:forEach items="${orders}" var="order">
      <tr><form action="/bonusPointsExchange/actionServlet" method="post">
      		<td><input type="hidden" name="orderID" value="${order.orderID}"/></td>
        	<td> <img src="images/1.jpg"/> <p>${order.wantedShop}</p></td>
        	<td>${order.wantedPoint} <img src="images/2.png"/>${order.point}</td>
        	<td><img src="images/1.jpg"/> <p>${order.shopName}</p></td>
        	<td><p>订单发布方：${order.userName}</p>
        	<p>交易有效期：${order.untilDate}</p></td>
        	<td><input name="submit" type="submit" class="submitBtn" id="submit" value="兑换"></td>
			<input type="hidden" name="actionCode" value="order"/>
         	<input type="hidden" name="methodCode" value="finsh_order"/>
      	</form>
      </tr>
       </c:forEach>
       <%}else if(findRes=="true"){%> 
     		<br/><br/><br/><p align="center">  搜索结果为0！</p>
        <%} %>		                    
      </table>     
        </form>
      </div>
    </div>
  </div>
</div>
<!--这是bottom-->
<div class="footer clear">
  <div class="footer-content">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
  </div>
</div>

<!-- 根据返回的index显示div -->
<script type="text/javascript" language="javascript">
  var index = ${index};
  //alert(index);
  var show=parseInt(index);
  //alert(show);
  for(i=1;i<=3;i++){
    document.getElementById('div'+i).style.display = "none";
  }
  document.getElementById('div'+index).style.display = "block";
</script>


<script type="text/javascript">
function showDiv(index){   
  var show=parseInt(index);

  for(i=1;i<=3;i++){
  document.getElementById('div'+i).style.display = "none";}
  document.getElementById('div'+index).style.display = "block";
  if(show == 1) {//查询绑定的商家
    location.href ="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops";
  }
  if(show == 2) {
    //查询用户相关的订单信息
    location.href = "/bonusPointsExchange/QueryOrderInfo";
  }
}
//改变订单状态
function changOrderStatus(orderID) {
  //alert(orderID);
  location.href = "/bonusPointsExchange/ChangeOrderStaServlet?orderID="+orderID;
}
/*
function setValue(){
  var oTip = document.getElementById("tip1"); 
  var selected_val = document.getElementById("shopName").value;
  var bindShops = ${bindShops};
  var shops = [];
  var array = new Array();
  alert(bindShops.length);
  <c:forEach items="${bindShops}" var="shop"> 
      array.push(${shop}); //生成如 array.push(123)的字符串 这样前台拿到后就是js 
  </c:forEach> 

  var point =0; 
   for(var i=0;i<bindShops.length;i++){
      var shop ={};
      shop.shopName = list[i].shopName;
      shop.platfromPoint = list[i].platfromPoint;
      shops.push(shop);
  } 
  alert("der");
  for(var i=0;i<shops.length;i++){
    if(shops[i].shopName.equals(selected_val)){
      point=shops[i].platfromPoint;
    }
    break;
  } 
  alert(point);
  if(obj.value>point){
    oTip.innerHTML="输入的积分数已超过您在平台的积分数";
  }else{
    oTip.innerHTML="";
  } 
}
*/
var xmlHttp;
// 对象的创建
function createXMLHttp() {
  //alert("sasdad");//调试代码
  if (window.XMLHttpRequest) { // firefox
    xmlHttp = new XMLHttpRequest();
  } else { // ie
    xmlHttp = new ActiveXObject("microsoft.XMLHTTP");
  }
}
//查询用户在平台数据库有多少积分
function queryPointsAtPlatform() {
  var shopName = document.getElementById("shopName").value;
  //alert(shopName);//调试代码
  var url = "/bonusPointsExchange/QueryPointsAtPlatform?shop="+encodeURI(encodeURI(shopName));
  createXMLHttp();
  xmlHttp.onreadystatechange = queryPointsAtPlatformBack;
  xmlHttp.open("get", url, true);
  xmlHttp.send(null);
}
// 回调函数,处理服务器返回结果
function queryPointsAtPlatformBack() {
  //alert("aaaaaa");
  // 响应已完成
  if (xmlHttp.readyState == 4) {
    // 服务器正常的响应
    // alert(xmlHttp.status);
    if (xmlHttp.status == 200) {
      var returnMsg = xmlHttp.responseText; // 收取服务器端的响应信息(String)
      //alert(returnMsg);
      document.getElementById("platPoint").value = returnMsg;
    }
  }
}

function checkPoint(){//判断用户输入积分数是否超过用户在平台的积分数
  var platPoint = document.getElementById("platPoint").value;
  var points = document.getElementById("points").value;
  
  if(Number(points)>Number(platPoint)){
    alert("您输入的积分数量已超出您在平台的积分数量！");
    return false;
  }else return true;
}
function checkShop(){//判断积分所属商家与期望兑换商家是否相同
  var shopName = document.getElementById("shopName").value;
  var wantedShop = document.getElementById("wantedShop").value;
  if(shopName==wantedShop){
    alert("积分所属商家与期望兑换商家不能相同");
    return false;
  }
  else return true;
}
function realSysTime(utilDate){//设置订单有效期
  var now = new Date();//创建Date对象
  var year = now.getFullYear();//获取年份
  var month = now.getMonth();//获取月份
  var date = now.getDate();//获取日期
  month=month+2;
  if(month>12){
    month=1;
    year=year+1;
  }
  if(month<=9){
    month="0"+month;
      
  }
  if(date<=9){
    date="0"+date;
  }
  var time = year+"-"+month+"-"+date;//显示时间
  utilDate.innerHTML=time;
  document.getElementById("utilDate2").value=time;
}
window.onload=function(){//页面载入时执行
  window.setInterval("realSysTime(utilDate)");
  
}

function checkNull(){
  var shopName = document.getElementById("shopName").value;
  var platPoint =document.getElementById("platPoint").value;
  var points = document.getElementById("points").value;
  var wantedShop= document.getElementById("wantedShop").value;
  var wantedPoint = document.getElementById("wantedPoint").value;
  if(shopName=="请选择-------"){
    alert("商家不能为空");
    return false;
  }else if(Number(platPoint)==0){
    alert("您选的商家积分为0，请先将积分转移到平台！");
    return false;
  }else if(Number(points)<=0){
    alert("积分数量必须大于0");
    return false;
  }else if(wantedShop=="请选择-------"){
    alert("目标商家不能为空");
    return false;
  }else if(Number(wantedPoint)<=0){
    alert("目标积分数量必须大于0");
    return false;
  }else return true;
}
</script>

<body></body>
</html>