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
<title>home</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/main.css">
<link href="<%=basePath%>css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/index.css">
</head>
<body>

<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="index clearfix">
  <div class="index1">
    <ul>
      <li>Bank</li>
      <li>Airline</li>
      <li>Supermarket</li>
      <li>Restaurant</li>
      <li style="border:none">other</li>
    </ul>
  </div>
  <div class="index2">
    <div>
      <p class="title">Shop<span class="more title1"></span></p>
    </div>
    <div id="shop-list"  class="clearfix">
      <ul>
        <li><img src="images/shopLogo/beifanghangkong.jpg"/>
          <p class="shopName">Northern Airlines</p>
          </li>
        <li><img src="images/shopLogo/changanhangkong.jpg"/>
          <p class="shopName">Changan Airlines</p>
          </li>
        <li><img src="images/shopLogo/changchenghangkong.jpg"/>
          <p class="shopName">The Great Wall Airlines</p>
          </li>
        <li><img src="images/shopLogo/dongfanghangkong.jpg"/>
          <p class="shopName">Eastern Airlines</p>
          </li>
        <li><img src="images/shopLogo/shanghaihangkong.jpg"/>
          <p class="shopName">Shanghai Airlines</p>
          </li>
        <li><img src="images/shopLogo/shenzhenhangkong.jpg"/>
          <p class="shopName">Shenzhen Airlines</p>
          </li>
        <li><img src="images/shopLogo/sichuanhangkong.jpg"/>
          <p class="shopName">Sichuan Airlines</p>
          </li>
        <li><img src="images/shopLogo/wuhanhangkong.jpg"/>
          <p class="shopName">Wuhan Airlines</p>
          </li>
        <li><img src="images/shopLogo/xiamenhangkong.jpg"/>
          <p class="shopName">Xiamen Airlines</p>
          </li>
        <li><img src="images/shopLogo/zhongguoguoji.jpg"/>
          <p class="shopName">Air China </p>
          </li>
      </ul>
    </div>
    <div><p></p></div>
    <div>
      <p class="title">Latest release</p>
    </div>
    <div id="order-list" class="clearfix"> 
      <!---- 事例1------>
      <div class="order-info">
        <ul >
          <li class="shop-logo"><img src="images/shopLogo/dongfanghangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Shop name：Wal-Mart</td>
                <td>Wanted shop：Alibaba</td>
              </tr>
              <tr>
                <td>Points：100</td>
                <td>Wanted points：120</td>
              </tr>
              <tr>
                <td>Valid date：2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="Submit">
          </li>
        </ul>
      </div>
      <!-----事例2------>
      <div class="order-info" >
        <ul>
          <li class="shop-logo"><img src="images/shopLogo/changanhangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Shop name: Eastern Airlines</td>
                <td>Wanted shop: Xiamen Airlines</td>
              </tr>
              <tr>
                <td>Points：100</td>
                <td>Wanted points：120</td>
              </tr>
              <tr>
                <td>Deadline：2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="Submit">
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
</body>
</html>
