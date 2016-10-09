<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%	String LaunchTranscationRes = (String)request.getAttribute("LaunchTranscationRes"); 
 	 if(LaunchTranscationRes=="unBindShop"){
 %>
	<script type="text/javascript" language="javascript">
		alert("您还未绑定商家，请先去绑定商家！");                            
	</script>
<%	} %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>主页</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
<!--这是top-->
<div class="header">
  <div class="span1">
    <div class="logo"><img src="images/logo.png" alt="积分兑换平台"/></div>
  </div>
  <div class="span2">
    <div class="mainNav">
      <ul>
        <li><a href="index.jsp">主页</a></li>
        <li><a href="reference.jsp">参考价</a></li>
        <li><a href="exchange.jsp">最新发布</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops">发起交易</a></li>
    <%
	String isUserLogin = (String)session.getAttribute("userName"); 
	String isShopLogin = (String)session.getAttribute("shopName"); 
	if(isUserLogin == null && isShopLogin == null) {
	%>
	<li><a href="login.jsp">我的账户</a> </li>
<% } else if(isUserLogin != null && isShopLogin == null){%>
	 <li>
	<a href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info"><%=session.getAttribute("userName") %></a>
	 </li>	
	 <% } else if(isShopLogin != null && isUserLogin != null){%>
	 <li>
	<a href="/bonusPointsExchange/QueryShopInfoServlet"><%=session.getAttribute("shopName") %></a>
	 </li>	
<% }%>

     </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="index clearfix">
  <div class="index1">
    <ul>
      <li>银行</li>
      <li>航空公司</li>
      <li>超市</li>
      <li>餐饮</li>
      <li>商场</li>
      <li style="border:none">其他</li>
    </ul>
  </div>
  <div class="index2">
    <div>
      <p class="title">商家<span class="more title1"><a href="#">更多</a></span></p>
    </div>
    <div id="shop-list"  class="clearfix">
      <ul>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行1</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行2</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行3</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行4</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行5</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行6</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行7</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行8</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行9</p>
          </a></li>
        <li><a><img src="images/1.jpg"/>
          <p class="shopName">银行10</p>
          </a></li>
      </ul>
    </div>
    <div>
      <p class="title">最新发布<span class="more title1"><a href="#">更多</a></span></p>
    </div>
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
      <!------事例3------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="#"/></li>
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
          <li class="shop-logo"><img src="#"/></li>
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
            <!------事例5------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="#"/></li>
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
    </div>
  </div>
</div>
<!--这是bottom-->
<div class="footer">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
</div>
<body>
</body>
</html>
