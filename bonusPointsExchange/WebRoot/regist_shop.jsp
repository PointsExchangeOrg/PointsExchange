<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Shop register</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@ include file="header.jsp" %>
<!--header -->
<div style="min-height:500px;">
<div class="regist-frame">
<p class="title">USER REGISTER<span class="title1 right"><a href="regist.jsp">Go to user register</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
  <div>
    <div class="span5">
      <form onsubmit="return checkForm();" method="post" action="/bonusPointsExchange/RegistShopServlet">
        <table>
          <tr>
            <td>Shop：</td>
            <td><input name="shopName" type="text" id="shopName" maxlength="20"  onblur="checkShopName();"></td>
            <td><span id="hint" style="color:#FF0000; font-size:12px;" >&nbsp;&nbsp;&nbsp;</span></td>
          </tr>
          <tr>
            <td>Password：</td>
            <td><input name="password" type="password" id="password" maxlength="20"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Confirm password：</td>
            <td><input name="repassword" type="password" id="repassword" maxlength="20"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Email：</td>
            <td><input name="email" type="text" id="email" maxlength="40"></td>
            <td><span id="hint" style="color:#FF0000">&nbsp;</span></td>
          </tr>
          <tr>
            <td>Shop filing number：</td>
            <td><input name="number" type="text" id="number" maxlength="40"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
            <td class="mid"><input name="reset" type="reset" class="submitBtn" id="reset" value="Reset"></td>
          </tr>
        </table>
      </form>
    </div>
    <div class="span6">
      <div class="tips">
        <p class="tips-font1">Register to exchange points!</p>
        <br/><br/>
        <p class="tips-font1">Already have username？</p><a href="login.jsp"> Sign now </a></div>
    </div>
  </div>
</div>
</div>
<!--footer -->
	<%@ include file="footer.jsp" %>

<!--js代码====================================================-->
<script type="text/javascript">

//邮箱格式校验
function checkEmail(email) {
	var str = email;
	var expression = /^[a-zA-Z0-9_-]+(\.([a-zA-Z0-9_-])+)*@[a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+([.][a-zA-Z0-9_-]+)*$/;
	var objExp = new RegExp(expression);
	if(objExp.test(str)) {
		return true;
	}
	else {
		return false;
	}
}

//表单验证
function checkForm() {
	// alert("ada");
	var shopName = document.getElementById("shopName").value;
	if (shopName == "") {
		alert("商家名不能为空！");
		return false;
	}
	
	var password = document.getElementById("password").value;
	if (password == "") {
		alert("密码不能为空！");
		return false;
	}
	
	//密码需在6位以上，只能为数字和字母的组合
	var Reg=/^[0-9A-Za-z]{6,}$/;
  	if(password!=""&&!Reg.test(password)){
     alert("密码只能是字母或者数字,长度6位及以上！");
     return false;
	}
	
	var repassword = document.getElementById("repassword").value;
	if (repassword == "") {
		alert("确认密码不能为空！");
		return false;
	}

	if (password != repassword) {
		alert("两次密码不一致！");
		return false;
	}
	
	var email = document.getElementById("email").value;
	if(!checkEmail(email)) {
		alert("邮箱格式不正确！");
		return false;
	}
	//备案号问题待解决
	var number = document.getElementById("number").value;
	if (number == "") {
		alert("备案号不能为空！");
		return false;
	}
	return true;
}


var xmlHttp;
function createXmlHttp() {
	 //alert("dasdasd");//调试代码
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	} else {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
}
function checkShopName() {
	createXmlHttp();
	var shopName;
	shopName = document.getElementById("shopName").value;
	//alert(shopName);//调试代码
	// 发送请求，设置属性，请求返回时交给回调函数处理
	//alert(userName);
	xmlHttp.open("post","/bonusPointsExchange/CheckShopName?shopName="+encodeURI(encodeURI(shopName)));
	//alert(userName);
	xmlHttp.onreadystatechange = checkShopNameBack;
	xmlHttp.send(null);
	
} 
function checkShopNameBack() {
	// 具体处理
	// 数据返回完毕
	if(xmlHttp.readyState == 4) {
		//alert(xmlHttp.status);
		// HTTP操作正常
		if(xmlHttp.status == 200) {
			//alert("正常");
			var text = xmlHttp.responseText;
			if(text == "Y") {
				document.getElementById("hint").innerHTML = "";	
				document.getElementById("submit").disabled = "";
			}
			if(text == "N") {
				document.getElementById("hint").innerHTML = "账号已存在";	
				document.getElementById("submit").disabled = "disabled";
			}
		}
		
	}
}
</script>
</body>
</html>

