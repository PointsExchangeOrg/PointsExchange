<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>忘记密码</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">

</head>

<body>
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
<!--header -->
<!--header -->
<div class="retrieve">
  <p class="title">找回密码&nbsp;&nbsp;<span class="title1">RETRIEVE　PASSWORD</span> <span class="title1 right"><a href="#">立即登录</a>&nbsp;&nbsp;&nbsp;</span></p>
   <div><span id="step-title2">STEP2:重置密码</span></div>

      <div id="step2">
      <form action="/bonusPointsExchange/actionServlet" method="post">
      <table>
      	  <tr>
      	    <td>帐&nbsp;号：</td>
            <td><input name="userName" type="userName" id="userName" value="<%=request.getParameter("userName") %>" maxlength="20"></td>
          </tr>	
          <tr>
            <td>密&nbsp;码：</td>
            <td><input name="newPassword" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>确认密码：</td>
            <td><input name="rePassword" type="password" id="repassword" maxlength="20"></td>
          </tr> 
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="确认"></td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="resetPasswd">
        </form>
      </div>
    </div>
</div>
<!--footer -->
<div class="footer clear">
  <div class="footer-content">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
  </div>
</div>
</body>
<script type="text/javascript">
function nextStep(){
	document.getElementById('step1').style.display="none";
	document.getElementById('step-title1').style.color="grey";
	document.getElementById('step2').style.display="block";
	document.getElementById('step-title2').style.color="blue";
	}
</script>
</html>
