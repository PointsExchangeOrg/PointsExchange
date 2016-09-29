<%@page import="com.bit.bonusPointsExchange.manager.UploadHeadIconManger"%>
<%@page import="java.io.File"%>
<%@page import="org.lxh.smart.SmartUpload"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page  import="com.bit.bonusPointsExchange.utils.IpTimeStamp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>


<html>
  <head>
  <meta charset="utf-8">
  </head>
  <body>
   <%
		//上传操作
		SmartUpload smart = new SmartUpload();
		smart.initialize(pageContext); // 初始化上传操作
		smart.upload(); // 上传准备
		IpTimeStamp its = new IpTimeStamp(request.getRemoteAddr());//获取请求的主机的ip
		String ext = smart.getFiles().getFile(0).getFileExt();//取得文件后缀
		String fileName = its.getIPTimeRand() + "." + ext;//拼凑新的名称
		String fielPath = this.getServletContext().getRealPath("/");
		//fielPath.replaceAll("\\\\", "\\\\\\\\");
		//fuck，路径存储到Mysql数据库中，路径中的斜杠消失，不知道为什么replaceAll函数不管用，只有自己拼凑路径了
		String str =  "WEB-INF\\\\headIcon" + "\\\\" + fileName;
		String []str1 =  fielPath.split("\\\\");
		fielPath = str1[0] + "\\\\" + str1[1] + "\\\\" + str1[2] + "\\\\" + str1[3] + "\\\\" + str;
		//for(int i = 0 ; i < str1.length; i++)
			//System.out.println(str1[i]);					
		System.out.println(fielPath);//打印文件存储路径
		
		if (fileName.matches("^\\w+\\.(jpg|gif|png|bmp)$")) { //检查文件类型是否符合要求
			//上传到文件夹中
			smart.getFiles()
					.getFile(0)
					.saveAs(fielPath);// 文件保存
					
			//若用户已经上传过头像，需要将先前上传的头像删除，防止用户多次上传，占用硬盘资源
			String shopName = (String)request.getSession().getAttribute("shopName");// 获取登录的商家的名称
			String imageURL = UploadHeadIconManger.queryImgURL(shopName);//原先数据库中的图片的地址，还要判断其是否和默认地址一样
			//若一样则不能删除，否则删除,默认图标为defaultIcon.jpg
			if(!("F:\\apache-tomcat-7.0.70\\webapps\\bonusPointsExchange\\WEB-INF\\headIcon\\defaultIcon.jpg".equals(imageURL))) {
				// 删除文件夹中的图片
				File imgFile = new File(imageURL);
				//System.out.println(path);
				if (imgFile.exists()) {
					imgFile.delete();
				}
			}
			//更新数据库,将文件存储的路径保存到数据库中
			boolean ret = UploadHeadIconManger.updateImgURL(fielPath, shopName);//更新数据库
			if (ret == false) {
				out.print("<script language='JavaScript'>alert('上传头像失败');location.href='/bonusPointsExchange/uploadBox.jsp';</script>");
				return;
			}
			out.print("<script language='JavaScript'>alert('成功上传头像，请关闭上传对话框！');location.href='/bonusPointsExchange/uploadBox.jsp';</script>");
		} else {
			response.setContentType("text/html;charset=utf-8");
			out.print("<script language='JavaScript'>alert('只能上传jpg、png、gif、bmp类型的图片');location.href='/bonusPointsExchange/uploadBox.jsp';</script>");
		}
	%>
  </body>
</html>
