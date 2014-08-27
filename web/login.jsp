<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  session.invalidate();
  request.setCharacterEncoding("UTF-8");
  String msg = request.getParameter("msg");
  String name=request.getParameter("name");
  String sCheck=request.getParameter("sCheck");
  String sClose=request.getParameter("sClose");
  
 // if(name==null)
 //   name=" ";
  if(name==null)
     name="";
  if(sClose=="1")
    out.print("<script language='javascript'> top.window.Close();</script> ");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <base href="<%=basePath%>">
    
    <title>登 陆</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script language="javascript">
  function a1(form1)
  {   
      var a=form1.username.value;
      var b=form1.password.value;
      if(a=="")
      {
         alert("请输入用户名");
         form1.username.focus();
        
      }
      else if(b=="")
      {
         alert("请输入密码");
         form1.password.focus();
      }
      else
        form1.submit();
  }
  
if (top.location != self.location)
{   
    top.location=self.location;   
}
</script>
</head>
  
 <!-------  <body>
    This is my JSP page. <br>
  </body>
  -->
<center>
<body bgcolor="#E8F9F4" background="背景图片/130.jpg" style="background-attachment: fixed">

<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<div style="position: absolute; width: 400px; height: 256px; z-index: 1; left: 104px; top: 102px; border-style: solid; border-width: 1px; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px" id="layer1">
	<font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</font>
    <form method="POST" action="checkLogin.jsp">
	<p><font face="微软雅黑">&nbsp;&nbsp;&nbsp; <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</b>&nbsp; <font size="5">系 统 登 录</font></font></p>
	<p><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	帐号：</font><input type="text" name="username"  size="20" tabindex="1" value="<%=name%>"></p>
	<p><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	密码：</font><input type="password" name="password" size="21" tabindex="2" onkeydown="if(event.keyCode==13) a1(this.form);"></p>
	<p>　</p>
		<!--webbot bot="SaveResults" U-File="D:\Work\case系统\FrontPage\_private\form_results.csv" S-Format="TEXT/CSV" S-Label-Fields="TRUE" -->
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="B3" value="登  录" tabindex="3" style="font-family: 微软雅黑; font-size: 10pt" onClick="a1(this.form);">
		<!-- 
		<input type="button" name="B3" value="登  录" src="images/admin_03.gif"  onClick="a1(this.form);">
		<input type="button" value="登  录" name="B3" tabindex="3" style="font-family: 微软雅黑; font-size: 10pt" onclick="FP_goToURL(/*href*/'主页.htm')">
		 -->
		</p>
	</form>
	<p>　</div>
<% 
  if(msg!=null)
    out.print("<script language='javascript'>alert('用户名或者密码错误!');</script>");
  if(sCheck!=null)
    out.print("<script language='javascript'>alert('请登陆!');</script>");
  
%>
</body>
</center>
</html>
