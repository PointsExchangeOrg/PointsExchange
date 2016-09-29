<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户注册</title>
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
<div class="regist-frame">
  <p class="title">用户注册&nbsp;&nbsp;<span class="title1">USER REGISTER</span></p>
  <div>
    <div class="span5">
      <form name="form_regist" action="/bonusPointsExchange/actionServlet" method="post">
        <table>
          <tr>
            <td>账&nbsp;号：</td>
            <td><input name="userName" type="text" id="userName" maxlength="20"></td>
          </tr>
          <tr>
            <td>密&nbsp;码：</td>
            <td><input name="passwd" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>确认密码：</td>
            <td><input name="repassword" type="password" id="repassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>邮&nbsp;箱：</td>
            <td><input name="email" type="text" id="email" maxlength="40"></td>
          </tr>
          <tr>
            <td>姓&nbsp;名：</td>
            <td><input name="fullName" type="text" id="name" maxlength="20"></td>
          </tr>
          <tr>
            <td>电&nbsp;话：</td>
            <td><input name="phone" type="text" id="phone" maxlength="20"></td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submit" id="submit" value="提交"></td>
            <td class="mid"><input name="reset" type="reset" id="reset" value="重置"></td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="regist">
       
      </form>
    </div>
    <div class="span6">
      <div class="tips">
        <p class="tips-font1">注册即享受</p>
        积分自由兑换
        <br/><br/>
        <p class="tips-font1">已经拥有账号了？</p>
        立即登录即可体验积分交易！ <a href="login.jsp"> 立即登录 </a></div>
    </div>
  </div>
</div>

<!--footer -->
<div class="footer">
  <div class="footer-content">
    <p>Copyright (C) 2015-2016  积分兑换平台</p>
  </div>
</div>
</body>
</html>
