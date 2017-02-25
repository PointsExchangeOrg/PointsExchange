<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  String newOrder = (String)request.getAttribute("newOrder");  //是否有最新完成的一笔交易
  if(newOrder == "N") {
%>
  <script type="text/javascript" language="javascript">
    alert("您选择的商家现在没有最新的交易记录！");                            
  </script> 
<% }%>

<%
//用户和商家需登录之后才能查看最新发布
String userName = (String)request.getSession().getAttribute("userName");
String shopName = (String)request.getSession().getAttribute("shopName");	
if(userName == null && shopName == null) { %>
	<script type="text/javascript" language="javascript">
		alert("您还没有登录！请登录！");    // 弹出错误信息
		window.location.href="/bonusPointsExchange/login.jsp" ;                             
	</script>	
<% }%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Reference price</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="referenceOrder">
  <div>
    <p class="title">REFERENCE PRICE</p>
  </div>
  <%if(request.getAttribute("shopName") == null) { %>
  <div> &nbsp;	
 	 <form action="/bonusPointsExchange/ReferencePriceServlet" method="post" onsubmit="return checkForm();">
      	Shop name：<input name="search1" value="" type="text" id="search1" placeholder="Please enter shop name"> &nbsp;&nbsp;&nbsp;
      	Wanted shop：<input name="search2" value="${wantedShop }" type="text" id="search2" placeholder="Please enter shop name"> &nbsp;&nbsp;&nbsp;
      	<input name="submit2" type="submit" class="submitBtn" id="submit2" value="Search">
      </form>
  </div>
  <% } else {%>
  <div> &nbsp;	
 	 <form action="/bonusPointsExchange/ReferencePriceServlet" method="post">
      	Shop name：<input name="search1" value="${shopName }" type="text" id="search1" placeholder="Please enter shop name"> &nbsp;&nbsp;&nbsp;
      	Wanted shop：<input name="search2" value="${wantedShop }" type="text" id="search2" placeholder="Please enter shop name"> &nbsp;&nbsp;&nbsp;
      	<input name="submit2" type="submit" class="submitBtn" id="submit2" value="Search">
      </form>
  </div>
  <%} %>
    <%
	  String shopName1 = request.getParameter("search1");
	  String wantedShop1 = request.getParameter("search2");
	  System.out.println(shopName);
	  if(shopName1 != null && wantedShop1 !=null && newOrder != "N") {%>
  <div class="referenceInfo">
    <table>
      <tr>
        <td rowspan="3" class="table-td-img"><img src="images/shopLogo/${ShopImgURL }"/><p>${shopName }</p></td>
        <td>newest ratio ： ${latestRate }</td>
        <td rowspan="3" class="table-td-img"><img src="images/shopLogo/${wantedShopImgURL }"/><p>${wantedShop }</p></td>
      </tr>
      <tr><td>Provided points：  ${point }<img src="images/2.png"/> transfer points： ${wantedPoint }</td></tr>
      <tr><td>Average proportion： ${averageRate }</td></tr>
    </table>
     <%}%>
  </div>
  <p>&nbsp;</p>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
	
<script type="text/javascript">
function checkForm() {
	//商家名不能空
	var shopName = document.getElementById("search1").value;
	//alert(shopName);
	if (shopName == "") {
		alert("商家名不能为空！");
		return false;
	}
	
	var wantedShop = document.getElementById("search2").value;
	if (wantedShop == "") {
		alert("目标商家名不能为空！");
		return false;
	}
 }
</script>
</body>
</html>
