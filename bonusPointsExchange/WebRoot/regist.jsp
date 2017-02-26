<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>User register</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//表单验证
function checkForm() {
	// alert("ada");
	var userName = document.getElementById("userName").value;
	if (userName == "") {
		alert("用户名不能为空！");
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
	if(password !=repassword){
	    alert("两次密码输入不一致");
	    return false;
	}
	
	var email = document.getElementById("email").value;
	if (email == "") {
		alert("邮箱不能为空！");
		return false;
	}
	if(!checkEmail(email)) {
		alert("邮箱格式不正确！");
		return false;
	}
	
	var fullName = document.getElementById("fullName").value;
	if (fullName == "") {
		alert("姓名不能为空！");
		return false;
	}
	
	var phone = document.getElementById("phone").value;
	if (phone == "") {
		alert("电话不能为空！");
		return false;
	}
	
}
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
</script>
</head>

<body>
	<%@ include file="header.jsp" %>
<!--header -->
<div style="min-height:500px;">
<div class="regist-frame">
  <p class="title">USER REGISTER<span class="title1 right"><a href="regist_shop.jsp">Go to shop register</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
  <div>
    <div class="span5">
      <form name="form_regist" action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkForm();">
        <table>
          <tr>
            <td>Username：</td>
            <td><input name="userName" type="text" id="userName" maxlength="20"></td>
          </tr>
          <tr>
            <td>Password：</td>
            <td><input name="passwd" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>Confirm password：</td>
            <td><input name="repassword" type="password" id="repassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>Email：</td>
            <td><input name="email" type="text" id="email" maxlength="40"></td>
          </tr>
          <tr>
            <td>Real name：</td>
            <td><input name="fullName" type="text" id="fullName" maxlength="20"></td>
          </tr>
          <tr>
            <td>Phone number：</td>
            <td><input name="phone" type="text" id="phone" maxlength="20"></td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
            <td class="mid"><input name="reset" type="reset" class="submitBtn" id="reset" value="Reset"></td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="regist">
       
      </form>
    </div>
    <div class="span6">
      <div class="tips">
        <p class="tips-font1">Register to exchange points!</p>
        <br/><br/>
        <p class="tips-font1">Already have username？&nbsp;&nbsp;<span  style="font-color:#000"><a href="login.jsp"> Sign in now </a></span></p></div>
    </div>
  </div>
</div>
</div>
<!--footer -->
	<%@ include file="footer.jsp" %>
</body>
</html>
