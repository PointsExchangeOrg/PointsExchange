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
  <div><span id="step-title1">STEP1:安全验证</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="step-title2">STEP2:重置密码</span></div>
    <div class="span5">
    <div id="step1">
      <form action="/bonusPointsExchange/actionServlet" method="post">
        <table>
          <tr>
            <td>账&nbsp;号：</td>
            <td><input name="userName" type="text" id="userName" maxlength="20"></td>
          </tr>
       <!--   <tr>
            <td>密&nbsp;码：</td>
            <td><input name="password" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>确认密码：</td>
            <td><input name="repassword" type="password" id="repassword" maxlength="20"></td>
          </tr>   ---->
          <tr>
            <td>邮&nbsp;箱：</td>
            <td><input name="email" type="text" id="email" maxlength="40"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="next" type="submit" class="submitBtn" id="next" value="提交" ></td>
          </tr> 
        </table>
        <input type="hidden" name="actionCode" value="findPasswd">
      </form>
      </div>
      <div id="step2">

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

</html>
