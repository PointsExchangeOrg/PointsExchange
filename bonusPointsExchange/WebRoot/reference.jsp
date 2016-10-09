<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>参考价</title>
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
        <li><a href="index.jsp"> 主页</a></li>
        <li><a href="reference.jsp"> 参考价</a></li>
        <li><a href=#>最新交易</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops">发起交易</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info"><%=session.getAttribute("userName") %></a></li>
      </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="referenceOrder">
  <div>
    <p class="title">参考价<span class="title1">&nbsp;&nbsp;&nbsp;REFERENCE PRICE</span></p>
  </div>
  <div> &nbsp;	
 	 <form action="">
      	商家名称：<input name="search1"  type="text" id="search1" placeholder="请输入商家名称"> &nbsp;&nbsp;&nbsp;
      	目标商家名称：<input name="search2"  type="text" id="search2" placeholder="请输入商家名称"> &nbsp;&nbsp;&nbsp;
      	<input name="submit2" type="submit" class="submitBtn" id="submit2" value="搜索">
      </form>
  </div>
  <div class="referenceInfo">
    <table>
      <tr>
        <td rowspan="3" class="table-td-img"><img src="images/1.jpg"/><p>东航</p></td>
        <td>最新比例 3:5</td>
        <td rowspan="3" class="table-td-img"><img src="images/1.jpg"/><p>东航</p></td>
      </tr>
      <tr><td>1500---->2500</td></tr>
      <tr><td>平均比例 1:2</td></tr>
    </table>
  </div>
  <p>&nbsp;</p>
</div>
<!--这是bottom-->
<div class="footer">
  <div class="footer-content">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
  </div>
</div>
</body>
</html>
