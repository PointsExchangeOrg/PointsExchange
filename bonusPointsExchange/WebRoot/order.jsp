<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.bit.bonusPointsExchange.bean.Order"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 显示查询到的订单信息 -->
<% 
	List<Order> list = (List<Order>)request.getAttribute("orderInfo");
 %>
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
        <li><a href=#> 主页</a></li>
        <li><a href=#> 参考价</a></li>
        <li><a href=#>最新交易</a></li>
        <li><a href=#>订单中心</a></li>
        <li><a href=#>我的账户</a></li>
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
        <p class="title">发布新订单<span class="title1">&nbsp;&nbsp;REALEASE ORDER</span><span class="title1 right"><a href="reference.html">前往参考价</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
        <form>
          <table>
            <tr>
              <td>选择商家：</td>
              <td><select  class="normal-font" name="shop" id="shop">
                  <option>东航</option>
                  <option>国航</option>
                </select></td>
            </tr>
            <tr>
              <td>积分数量：</td>
              <td><input name="points" type="number"  id="points" min="0" value="0"></td>
            </tr>
            <tr>
              <td>选择目标商家：</td>
              <td><select name="shop"  class="normal-font" id="shop">
                  <option>东航</option>
                  <option>国航</option>
                </select></td>
            </tr>
            <tr>
              <td>目标积分数量：</td>
              <td><input name="points" type="number"  id="points" min="0" value="0"></td>
            </tr>
            <tr>
              <td>截止日期：</td>
              <td><input type="date" class="no-border"   readonly ></td>
            </tr>
            <tr class="mid">
              <td><input name="submit" type="submit" id="submit" value="提交"></td>
              <td><input name="reset" type="reset" id="reset" value="重置"></td>
            </tr>
          </table>
        </form>
      </div>
    </div>
    <!-----个人订单--------->
    <div id="div2">
      <p class="title">查看个人订单<span class="title1">&nbsp;&nbsp;PERSONAL ORDER</span></p>
      <div id="order-list" class="clearfix"> 
        <!---- 事例1------>
        <div class="order-info clearfix">
          <ul >
          <% if(null != list) {
             	System.out.println(list.size());
        		for(int i = 0; i < list.size(); i++) {
        			Order orderInfo = (Order)list.get(i);
      		%>
            <li class="shop-logo"><img src="images/1.jpg"/></li>
            <li class="info">
              <table>
      			<tr>
                  <td>商家：<%=orderInfo.getShopName() %></td>
                  <td>目标商家：<%=orderInfo.getWantedShop() %></td>
             	</tr>
                <tr>
                  <td>积分数量：<%=orderInfo.getPoint() %></td>
                  <td>目标积分数量：<%=orderInfo.getWantedPoint() %></td>
                </tr>
                <tr>
                  <td>截止日期：<%=orderInfo.getUntilDate() %></td>
                  <td></td>
                </tr>
              </table>
            </li>
            <%if(orderInfo.getOrderStatus() == 0) { %>
            <li class="operate">
              <input name="exchange" onclick="changOrderStatus(<%=orderInfo.getOrderID() %>)" type="button" class="submitBtn" id="exchange" value="取消">
            </li>
            <%} else if(orderInfo.getOrderStatus() == 1) {%>
             <li class="operate">
              <input name="exchange" type="button" class="submitBtn"  style="background:#EDEDED;" disabled="disabled" id="exchange" value="已完成">
            </li>
            <%} else if(orderInfo.getOrderStatus() == 2) {%>
             <li class="operate" >
              <input name="exchange" type="button" class="submitBtn" style="background:#EDEDED;" disabled="disabled" id="exchange" value="已失效">
            </li>
            <%} %>
         <%}
       }%>
          </ul>
        </div>
      </div>
    </div>
    <!----------- 搜索订单------------------------------>
    <div id="div3">
      <p class="title">查看所有订单<span class="title1">&nbsp;&nbsp;ALL ORDER</span></p>
      <div id="search">
      <form>
        <table>
          <tr>
            <td>商&nbsp;家：&nbsp;</td><td><input name="shop" type="text" id="shop"></td>
          </tr>
          <tr>
            <td>目标商家：</td><td><input name="targetShop" type="text" id="targetShop"></td>
            <td colspan="2" ><input name="submit" type="button" class="submitBtn" id="submit" value="搜索"></td>
          </tr>
        </table>
        </form>
      </div>
      <div id="search-result">
      选择排序方式：
      <select>
        <option>积分优先</option>
        <option>比率优先</option>
        <option>时效优先</option>
      </select>
      <table><tr>
      <td> <img src="images/1.jpg"/> <p>东方航空</p></td>
      <td>100 <img src="images/2.png"/>120</td>
      <td><img src="images/1.jpg"/> <p>厦门航空</p></td>
      <td><p>涉及交易方：2</p>
      <p>交易有效期：2016.12.30</p></td>
      <td><input name="submit" type="button" class="submitBtn" id="submit" value="兑换"></td>
      </tr></table>
      
      <table><tr>
      <td> <img src="images/1.jpg"/> <p>东方航空</p></td>
      <td>100 <img src="images/2.png"/>120</td>
      <td><img src="images/1.jpg"/> <p>厦门航空</p></td>
      <td><p>涉及交易方：2</p>
      <p>交易有效期：2016.12.30</p></td>
      <td><input name="submit" type="button" class="submitBtn" id="submit" value="兑换"></td>
      </tr></table>
      
      <table><tr>
      <td> <img src="images/1.jpg"/> <p>东方航空</p></td>
      <td>100 <img src="images/2.png"/>120</td>
      <td><img src="images/1.jpg"/> <p>厦门航空</p></td>
      <td><p>涉及交易方：2</p>
      <p>交易有效期：2016.12.30</p></td>
      <td><input name="submit" type="button" class="submitBtn" id="submit" value="兑换"></td>
      </tr></table>
      
      <table><tr>
      <td> <img src="images/1.jpg"/> <p>东方航空</p></td>
      <td>100 <img src="images/2.png"/>120</td>
      <td><img src="images/1.jpg"/> <p>厦门航空</p></td>
      <td><p>涉及交易方：2</p>
      <p>交易有效期：2016.12.30</p></td>
      <td><input name="submit" type="button" class="submitBtn" id="submit" value="兑换"></td>
      </tr></table>
      
      <table><tr>
      <td> <img src="images/1.jpg"/> <p>东方航空</p></td>
      <td>100 <img src="images/2.png"/>120</td>
      <td><img src="images/1.jpg"/> <p>厦门航空</p></td>
      <td><p>涉及交易方：2</p>
      <p>交易有效期：2016.12.30</p></td>
      <td><input name="submit" type="button" class="submitBtn" id="submit" value="兑换"></td>
      </tr></table>
      </div>
    </div>
    
    <!--------------> 
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
</script>
</body>
</html>
