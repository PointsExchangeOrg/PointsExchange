<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% String userName =request.getParameter("userName");
	userName= new String(userName.getBytes("ISO-8859-1"),"utf-8");

	%> 
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>forget password</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//表单验证
function checkForm() {
	// alert("ada");
	var userName = document.getElementById("userName").value;
	if (userName == "" || userName == null) {
		alert("用户名不能为空！");
		return false;
	}
	
	var password = document.getElementById("password").value;
	if (password == "") {
		alert("密码不能为空！");
		return false;
	}
	
	var repassword = document.getElementById("repassword").value;
	if (repassword == "") {
		alert("确认密码不能为空！");
		return false;
	}
	if(password != repassword){
	    alert("两次密码输入不一致！");
	    return false;
	}
}
</script>
</head>

<body>
<!--header -->
	<%@ include file="header.jsp" %>
<!--header -->
<div class="repsw-form">
<div class="retrieve">
  <p class="title">RETRIEVE PASSWORD <span class="title1 right"><a href="login.jsp">Sign in</a>&nbsp;&nbsp;&nbsp;</span></p>
   <div><span id="step-title1" style="color:grey;">STEP1:Security verification</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="step-title2" style="color:blue;">STEP2:Reset password</span></div>
      <div id="step2">
      <form action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkForm();">
      <table>
      	  <tr>
      	    <td>Username：</td>
            <td><input name="userName" type="userName" id="userName" value="<%=userName %>" maxlength="20"></td>
          </tr>	
          <tr>
            <td>New password：</td>
            <td><input name="newPassword" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>Confirm password：</td>
            <td><input name="rePassword" type="password" id="repassword" maxlength="20"></td>
          </tr> 
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="resetPasswd">
        <input type="hidden" name="methodCode" value=<%=request.getParameter("method") %>>
        </form>
      </div>
    </div>
</div>
</
<!--footer -->
	<%@ include file="footer.jsp" %>
</body>
</html>
