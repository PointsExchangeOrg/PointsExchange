<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String userChangeResult = (String)request.getAttribute("userChangeResult");  //获取修改商家信息是否成功
	if(userChangeResult == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("修改信息成功！");                                    // 弹出错误信息
	</script>	
<% } else if(userChangeResult == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("修改信息失败！");                                    
	</script>	
<% }%>

<%
	String pointTranRes = (String)request.getAttribute("pointTranRes"); 
	if(pointTranRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("成功将积分从商家转移到平台！您在平台拥有"+<%=request.getAttribute("userPoints")%>+"积分，在商家拥有"+<%=request.getAttribute("shopPoints")%>+"积分" );                                    // 弹出错误信息
	</script>	
<% } else if(pointTranRes == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("转移失败！");                                    
	</script>	
<% }%>



<%
	String pointToPshopRes = (String)request.getAttribute("pointToPshopRes"); 
	if(pointToPshopRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("成功将积分从平台转移到商家！您在平台拥有"+<%=request.getAttribute("userPoints")%>+"积分，在商家拥有"+<%=request.getAttribute("shopPoints")%>+"积分" );                                    // 弹出错误信息
	</script>	
<% } else if(pointToPshopRes == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("转移失败！");                                    
	</script>	
<% }%>





<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>个人中心</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/personal.css">
<link href="jQueryAssets/jquery.ui.core.min.css" rel="stylesheet" type="text/css">
<link href="jQueryAssets/jquery.ui.theme.min.css" rel="stylesheet" type="text/css">
<link href="jQueryAssets/jquery.ui.accordion.min.css" rel="stylesheet" type="text/css">
<link href="jQueryAssets/jquery.ui.button.min.css" rel="stylesheet" type="text/css">
<script src="jQueryAssets/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="jQueryAssets/jquery-ui-1.9.2.accordion.custom.min.js" type="text/javascript"></script>
<script src="jQueryAssets/jquery-ui-1.9.2.button.custom.min.js" type="text/javascript"></script>
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
        <li><a href=#><%=session.getAttribute("userName") %></a></li>
      </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="personal">
  <div class="span7">
    <div id="Accordion1" class="nav">
      <h3><a href="#">个人信息</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(1)">修改信息</a></p>
        <p><a href="javascript:showDiv(2)">修改密码</a></p>
      </div>
      <h3><a href="#">积分转移</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(3)">积分转移到平台</a></p>
        <p><a href="javascript:showDiv(4)">积分转移到商家</a></p>
      </div>
      <h3><a href="#">绑定商家</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(5)">显示已绑定商家</a></p>
        <p><a href="javascript:showDiv(6)">绑定新商家</a></p>
      </div>
    </div>
  </div>
  <div class="span8">
    <div id="div1">
      <p class="title">个人资料 <span class="title1">USER INFOMATION</span></p>
      <form action="/bonusPointsExchange/actionServlet" method="post">
        <table>
        <!--  <tr>
            <td>账&nbsp;号：</td>
            <td><input name="userName" type="text" id="userName" maxlength="40"></td>
          </tr>  -->
          <tr>
            <td>邮&nbsp;箱：</td>
            <td><input name="email" type="text" id="email" maxlength="40" value=<%=request.getAttribute("email") %>></td>
          </tr>
          <tr>
            <td>姓&nbsp;名：</td>
            <td><input name="fullName" type="text" id="name" maxlength="40" value=<%=request.getAttribute("fullName") %>></td>
          </tr>
          <tr>
            <td>电&nbsp;话：</td>
            <td><input name="phone" type="text" id="phone" maxlength="40" value=<%=request.getAttribute("phone") %>></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submit" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="user" >
  		<input type="hidden" name="methodCode" value="alter_user_info">
      </form>
    </div>
    <div id="div2">
      <p class="title">修改密码 <span class="title1">USER　PASSWORD</span></p>
      <form action="/bonusPointsExchange/actionServlet">
        <table>
          <tr>
            <td>旧密码：</td>
            <td><input name="oldPassword" type="password" id="oldPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>新密码：</td>
            <td><input name="newPassword" type="password" id="newPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>再次输入新密码：</td>
            <td><input name="reNewPassword" type="password" id="reNewPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submit" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="user">
        <input type="hidden" name="methodCode" value="alter_user_passwd">
      </form>
    </div>
    <div id="div3">
      <p class="title">积分转移到平台 <span class="title1">POINTS TRANSFER TO PLATFORM</span></p>
      <form action="/bonusPointsExchange/UserPointToplatformServlet"  method="post">
        <table>
          <tr>
            <td>选择商家：</td>
            <td><select  class="normal-font" name="shop" id="shop">
              <option>东航</option>
              <option>国航</option>
              </select></td>
          </tr>
          <tr>
            <td>商家积分：</td>
            <td><input name="points" type="text" value="" readonly id="points"> 
            </td>
          </tr>
          <tr>
            <td>转移积分：</td>
            <td><input name="transfer_points"  type="number" value="0" id="transfer_points">
            </td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submit" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div4">
      <p class="title">积分转移到商家 <span class="title1">POINTS TRANSFER TO SHOP</span></p>
      <form action="/bonusPointsExchange/PlatformToUserServlet"  method="post">
        <table>
          <tr>
            <td>选择商家：</td>
            <td><select  class="normal-font" name="shop" id="shop">
            <option>东航</option>
              <option>国航</option>
              </select></td>
          </tr>
          <tr>
            <td>平台积分：</td>
            <td><input name="platformPoints" type="text" value="" readonly id="platformPoints"></td>
          </tr>
          <tr>
            <td>转移积分：</td>
            <td><input name="transfer_points" type="number" value="0" id="transfer_points"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submit" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div5">
      <p class="title">商家绑定 <span class="title1">SHOP BIND</span></p>
      <form>
        <table>
          <tr>
            <td><img src="#" alt="商家商标"/> 东方航空</td>
            <td><input name="bind" type="button" id="bind" value="绑定"></td>
          </tr>
          <tr>
            <td><img src="#" alt="商家商标"/> 国航</td>
            <td><input name="bind" type="button" id="bind" value="绑定"></td>
          </tr>
          <tr>
            <td><img src="#" alt="商家商标"/> 美航</td>
            <td><input name="bind" type="button" id="bind" value="绑定"></td>
          </tr>
          <tr>
            <td><img src="#" alt="商家商标"/> 亚航</td>
            <td><input name="bind" type="button" id="bind" value="绑定"></td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div6">
      <p class="title">查看商家 <span class="title">BOUND　SHOP</span></p>
      <form>
        <table>
          <tr>
            <td><img src="#" alt="商家商标"/> 东方航空</td>
            <td><input name="points" type="text" id="points" value="0" maxlength="20"></td>
          </tr>
          <tr>
            <td><img src="#" alt="商家商标"/> 国航</td>
            <td><input name="points" type="text" id="points" value="0" maxlength="20"></td>
          </tr>
          <tr>
            <td><img src="#" alt="商家商标"/> 美航</td>
            <td><input name="points" type="text" id="points" value="0" maxlength="20"></td>
          </tr>
          <tr>
            <td><img src="#" alt="商家商标"/> 亚航</td>
            <td><input name="points" type="text" id="points" value="0" maxlength="20"></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<!--这是bottom-->
<div class="footer">
  <div class="footer-content">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
  </div>
</div>
<script type="text/javascript">
$(function() {
	$( "#Accordion1" ).accordion(); 
});
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
//=================================================//
//查询用户在商家那里有多少积分
function queryUserPoints() {
	//alert("sasdad");//调试代码
	var shopName = document.getElementById("shop").value;//此处应该是用户所属商家，后面可能要改代码
	var url = "/bonusPointsExchange/QueryUserPoints?shop="+encodeURI(encodeURI(shopName));
	createXMLHttp();
	xmlHttp.onreadystatechange = queryUserPointsBack;
	xmlHttp.open("get", url, true);
	xmlHttp.send(null);
}
// 回调函数,处理服务器返回结果
function queryUserPointsBack() {
	// alert(xmlHttp.readyState);
	// 响应已完成
	if (xmlHttp.readyState == 4) {
		// 服务器正常的响应
		// alert(xmlHttp.status);
		if (xmlHttp.status == 200) {
			var returnMsg = xmlHttp.responseText; // 收取服务器端的响应信息(String)
			//alert(returnMsg);
			document.getElementById("points").value = returnMsg;
		}
	}
}

//=================================================//
//查询用户在品台数据库有多少积分
function queryPointsAtPlatform() {
	//alert("sasdad");//调试代码
	var shopName = document.getElementById("shop").value;
	var url = "/bonusPointsExchange/QueryPointsAtPlatform?shop="+encodeURI(encodeURI(shopName));
	createXMLHttp();
	xmlHttp.onreadystatechange = queryPointsAtPlatformBack;
	xmlHttp.open("get", url, true);
	xmlHttp.send(null);
}
// 回调函数,处理服务器返回结果
function queryPointsAtPlatformBack() {
	// alert(xmlHttp.readyState);
	// 响应已完成
	if (xmlHttp.readyState == 4) {
		// 服务器正常的响应
		// alert(xmlHttp.status);
		if (xmlHttp.status == 200) {
			var returnMsg = xmlHttp.responseText; // 收取服务器端的响应信息(String)
			//alert(returnMsg);
			document.getElementById("platformPoints").value = returnMsg;
		}
	}
}
function showDiv(index){   
var show=parseInt(index);
for(i=1;i<=6;i++){
	document.getElementById('div'+i).style.display = "none";}
	document.getElementById('div'+index).style.display = "block";
	if(show == 3) {
		queryUserPoints();
	}
	if(show == 4) {
		queryPointsAtPlatform();
	}


} 
</script>
</body>
</html>
