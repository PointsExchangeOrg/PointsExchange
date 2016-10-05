<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.bit.bonusPointsExchange.bean.ShowBindInfo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%List<ShowBindInfo> bindShops = (List<ShowBindInfo>)request.getAttribute("bindShops"); %>
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
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>发布订单</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
<script type="text/javascript">
function showDiv(index){   
	var show=parseInt(index);

	for(i=1;i<=3;i++){
	document.getElementById('div'+i).style.display = "none";}
	document.getElementById('div'+index).style.display = "block";
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
window.onload=function(){
	window.setInterval("realSysTime(utilDate)");
}

function checkNull(){
	var shopName = document.getElementById("shopName").value;
	var points = document.getElementById("points").value;
	var wantedShop= document.getElementById("wantedShop").value;
	var wantedPoint = document.getElementById("wantedPoint").value;
	if(shopName=="请选择-------"){
		alert("商家不能为空");
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
        <li><a href=#><%=session.getAttribute("userName") %></a></li>
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
                  <td>t</td>
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
    <!----------- 搜索订单------------------------------>
    <div id="div3">
      <p class="title">查看所有订单<span class="title1">&nbsp;&nbsp;ALL ORDER</span></p>
      <div id="search">
      <form>
        <table>
          <tr>
            <td>商&nbsp;家：&nbsp;</td><td><input name="shop" type="text" id="shop"></td>
            <td>积分数：&nbsp;&nbsp;</td><td><input name="point" type="number" id="point"></td>
          </tr>
          <tr>
            <td>目标商家：</td><td><input name="targetShop" type="text" id="targetShop"></td>
            <td>目标积分数：</td><td><input name="targetPoint" type="number" id="targetPoint"></td>
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
</body>
</html>
