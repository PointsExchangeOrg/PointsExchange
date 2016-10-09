<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
<meta charset="utf-8">
 </head>
  <body>
	<form action="smartUpload.jsp" method="post"
		enctype="multipart/form-data">
		<div style="width:320px; margin-left:40px; margin-top:100px;">
			<input type="text" readonly="readonly" class="file" id="f_file" /><input type="button"
				value="上传图片" class="file" onclick="t_file.click()" /> <input
				name="upload" type="file" id="t_file"
				onchange="f_file.value=this.value" style="display:none" /> <input
				type="submit" value="上传" />
		</div>
		<div style="margin-left:40px; color: red;">上传头像完成后请关闭该对话框</div>
	</form>
</body>

</html>
