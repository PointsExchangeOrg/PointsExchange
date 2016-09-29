<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
        <li><a href=#>最新交易</a></li>
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
      <ul >
        <li class="shop-logo"><img src="images/1.jpg"/></li>
        <li class="info">
          <table>
            <tr>
              <td>商家：东方航空</td>
              <td>目标商家：厦门航空</td>
            </tr>
            <tr>
              <td>积分数量：100</td>
              <td>目标积分数量：120</td>
            </tr>
            <tr>
              <td>截止日期：2016-11-20</td>
              <td></td>
            </tr>
          </table>
        </li>
        <li class="operate">
          <input name="exchange" type="button"  id="exchange" value="交易">
        </li>
      </ul>
    </div>
          <!-----事例2------>
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/1.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>商家：东方航空</td>
                <td>目标商家：厦门航空</td>
              </tr>
              <tr>
                <td>积分数量：100</td>
                <td>目标积分数量：120</td>
              </tr>
              <tr>
                <td>截止日期：2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="交易">
          </li>
        </ul>
      </div>
      <!------事例3------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/1.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>商家：东方航空</td>
                <td>目标商家：厦门航空</td>
              </tr>
              <tr>
                <td>积分数量：100</td>
                <td>目标积分数量：120</td>
              </tr>
              <tr>
                <td>截止日期：2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="交易">
          </li>
        </ul>
      </div>
            <!------事例4------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/1.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>商家：东方航空</td>
                <td>目标商家：厦门航空</td>
              </tr>
              <tr>
                <td>积分数量：100</td>
                <td>目标积分数量：120</td>
              </tr>
              <tr>
                <td>截止日期：2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="交易">
          </li>
        </ul>
      </div>
            <!-----事例2------>
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/1.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>商家：东方航空</td>
                <td>目标商家：厦门航空</td>
              </tr>
              <tr>
                <td>积分数量：100</td>
                <td>目标积分数量：120</td>
              </tr>
              <tr>
                <td>截止日期：2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="交易">
          </li>
        </ul>
      </div>

      <!------>
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
