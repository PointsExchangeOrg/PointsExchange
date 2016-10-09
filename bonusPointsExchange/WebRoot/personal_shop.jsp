<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
//商家需登录之后才能修改xiangguan信息
String oldShopName = (String)request.getSession().getAttribute("shopName");	
if(oldShopName == null) { %>
	<script type="text/javascript" language="javascript">
		alert("您还没有登录！请登录！");    // 弹出错误信息
		window.location.href="/bonusPointsExchange/login_shop.jsp" ;                             
	</script>	
<% }%>


<%
	String shopChangeResult = (String)request.getAttribute("shopChangeResult");  //获取修改商家信息是否成功
	if(shopChangeResult == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("修改信息成功！");                                    // 弹出错误信息
	</script>	
<% } else if(shopChangeResult == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("修改信息失败！");                                    
	</script>	
<% }%>

<%
String shopChangePwdResult = (String)request.getAttribute("shopChangePwdResult");  //获取修改商家密码是否成功
if(shopChangePwdResult == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("修改密码失败！");                                    
	</script>	
<% }%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>商家中心</title>
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
        <li><a href=#>我的账户</a></li>
      </ul>
    </div>
  </div>
</div>
<!--这是main_page-->
<div class="personal">
  <div class="span7">
    <div id="Accordion1" class="nav" style="height:200px;">
      <h3><a href="#">商家信息</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(1)">修改信息</a></p>
        <p><a href="javascript:showDiv(2)">修改密码</a></p>
      </div>
 <!--
      <h3><a href="#">商业化</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(3)">添加广告</a></p>
        <p><a href="javascript:showDiv(4)">积分商城</a></p>
      </div>
-->
      <h3><a href="#">智能分析</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(3)">用户量分析</a></p>
        <p><a href="javascript:showDiv(4)">积分变化分析</a></p>
      </div>
    </div>
  </div>
  <div class="span8">
    <div id="div1">
      <p class="title">商家资料 <span class="title1">USER INFOMATION</span></p>
      <form onsubmit="return checkForm();" action="/bonusPointsExchange/ShopChangeInfo" method="post">
        <table>
          <tr>
            <td>商家名称：</td>
            <td><input name="name" readonly="readonly"  type="text" id="name" value="<%=session.getAttribute("shopName")%>" maxlength="40">
					</td>
          </tr>
           <tr>
            <td>商家图标：</td>
            <td class="mid">
            <img alt="头像" src="<%=request.getAttribute("imageURL")%>"/>
            <input type="button" value="上传" onclick="openwindow()" class="file" /> 
			</td>
			<!--<td> <img alt="头像" src="<%=request.getAttribute("imageURL")%>"/></td>-->
          </tr>
          <tr>
            <td>邮&nbsp;箱：</td>
            <td><input name="email" type="text" id="email" value="<%=request.getAttribute("email")%>" maxlength="40"></td>
          </tr>
          <tr>
            <td>电&nbsp;话：</td>
            <td><input name="phone" type="text" id="phone" value="<%=request.getAttribute("telephone")%>" maxlength="40"></td>
          </tr>
          <tr>
            <td>简&nbsp;介：</td>
            <td><input name="description" type="text" id="description" value="<%=request.getAttribute("shopDec")%>" maxlength="40"></td>
          </tr>
          <tr>
            <td colspan="2"><input name="submit" type="submit" class="submitBtn" id="submit" value="提交"></td   
          ></tr>
        </table>
      </form>
    </div>
    <div id="div2">
      <p class="title">修改密码 <span class="title1">SHOP　PASSWORD</span></p>
      <form onsubmit="return changePawcheckFrom();" method="post" action="/bonusPointsExchange/ShopChangePwdServlet">
        <table>
          <tr>
            <td>账&nbsp;号：</td>
            <td><input name="userName" type="text" class="no-border" id="userName" value="<%=session.getAttribute("shopName")%>" maxlength="20" readonly></td>
          </tr>
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
            <td colspan="2" ><input name="submit" type="submit" class="submitBtn" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
<!--
    <div id="div3">
      <p class="title">添加广告<span class="title1">ADD ADVERTISEMENT</span></p>
      <form>
        <table>
          <tr>
            <td>广告标题：</td>
            <td><input name="adName" type="text" class="adName" id="adName"  maxlength="40"></td>
          </tr>
          <tr>
            <td>广告图片&nbsp;：</td>
            <td class="mid"><input name="selectImage" type="submit" class="submitBtn" id="selectImage" value="选择"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div4">
      <p class="title">积分商城<span class="title1">POINTS SHOP</span></p>
      <form>
        <table>
          <tr>
            <td>商城网址:</td>
            <td><input name="url" type="text" class="inputUrl" id="url"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
-->
    <div id="div3">
      <p class="title">用户量分析<span class="title1">USER AMOUNT ANALYSIS</span></p>
      <h3 style="text-align: center">一星期用户变化折线图</h3>

    </div>
    <div id="div4">
      <p class="title">积分变化分析<span class="title1">POINTS ANALYSIS</span></p>
      <table>
          <td>今日入积分：</td>
          <td><input name="inPoint" type="text" id="inPoint" class="no-border" value="0" maxlength="40" readonly></td>
        </tr>
        <tr>
          <td>今日出积分：</td>
          <td><input name="outPoint" type="text" id="outPoint" class="no-border" value="0" maxlength="40" readonly></td>
        </tr>
      </table>
      <h3 style="text-align: center">积分变化表</h3>
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
/****
$(function() {
	$( "#Accordion1" ).accordion(); 
});
***/
function showDiv(index){   
var show=parseInt(index);
for(i=1;i<=4;i++){
	document.getElementById('div'+i).style.display = "none";}
	document.getElementById('div'+index).style.display = "block";
} 

//修改密码的表单验证
function changePawcheckFrom() {
	
	var oldPassword = document.getElementById("oldPassword").value;
	if (oldPassword == "") {
		alert("旧密码不能为空！");
		return false;
	}
	
	
	var newPassword = document.getElementById("newPassword").value;
	if (newPassword == "") {
		alert("新密码不能为空！");
		return false;
	}
	//密码需在6位以上，只能为数字和字母的组合
	var Reg=/^[0-9A-Za-z]{6,}$/;
  	if(newPassword!=""&&!Reg.test(newPassword)){
     alert("密码只能输入是字母或者数字,长度6位及以上！");
     return false;
	}
	
	var reNewPassword = document.getElementById("reNewPassword").value;
	if (reNewPassword == "") {
		alert("确认密码不能为空！");
		return false;
	}

	if (newPassword != reNewPassword) {
		alert("两次密码必须一样！");
		return false;
	}
	return true;
}



//修改商家信息的表单验证
function checkForm() {
	
	//商家名不能空
	var shopName = document.getElementById("name").value;
	//alert(shopName);
	if (shopName == "") {
		alert("商家名不能为空！");
		return false;
	}
	//邮箱格式要正确
	var email = document.getElementById("email").value;
	//alert(email);
	var expression = /^[a-zA-Z0-9_-]+(\.([a-zA-Z0-9_-])+)*@[a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+([.][a-zA-Z0-9_-]+)*$/;
	var objExp = new RegExp(expression);
	if(!objExp.test(email)) {
		alert("邮箱格式不正确！");
		return false;
	}
	//电话号码格式要正确
	/*验证固定电话号码
 	 0\d{2,3}   代表区号   
 	 [0\+]\d{2,3}   代表国际区号
	 \d{7,8} 代表7－8位数字(表示电话号码)
 	正确格式：区号-电话号码-分机号(全写|只写电话号码)
	*/
	var reg=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/; 
	var telephone = document.getElementById("phone").value;
	//alert(telephone);
	if(telephone != ""&&!reg.test(telephone)){
 		alert('电话号码格式输入错误！');
 		return false;
	}
	return true;
}
//弹出一个网页，以对话框的形式弹出
function openwindow(){ 
        window.showModalDialog("uploadBox.jsp",window,"dialogWidth:360px;dialogHeight:200px");
      }     
</script>
</body>
</html>

