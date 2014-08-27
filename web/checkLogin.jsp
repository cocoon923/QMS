<html>
<jsp:useBean id="dataBean" scope="page" class="dbOperation.checkLogin" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%
  request.setCharacterEncoding("gb2312");
%>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta http-equiv="refresh" content="0;url=admin.jsp">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>验证</title>
<style type="text/css">
<!--
    A:link {text-decoration: none; color: #000000}
    A:visited {text-decoration: none; color: #000000}
    A:hover {text-decoration: underline; color: #0000ff}
    A.bb01:link {text-decoration: none; color: #333333}
    A.bb01:visited {text-decoration: none; color: #333333}
    A.bb01:hover {text-decoration: underline; color: #00ffcc}
	A.bb02:link {text-decoration: none; color: #cc3300}
    A.bb02:visited {text-decoration: none; color: #cc3300}
    A.bb02:hover {text-decoration: underline; color: #cc3300}	
body {
	font-family: "宋体";
	font-size: 12px;
	line-height:20px;
	background-color: #1e8dff;
}
td {font-family: "宋体"; font-size: 12px;line-height:20px}
select {font-family: "宋体"; font-size: 12px}
input{font-family: "宋体"; font-size: 12px}
A.style4:link {text-decoration: none; color: #186CB3;}
A.style4:visited {text-decoration: none; color: #186CB3;}
A.style4:hover {text-decoration: underline; color: #186CB3;}


-->
</style>
<link href="css/style.css" rel=stylesheet type=text/css>
</head>
<%
    String  name = request.getParameter("username");
	String  pass = request.getParameter("password");
   // boolean panduan = false;
    
    String sOpName=dataBean.getOpName(name,pass);
    String sOpId=dataBean.getOpId(name,pass);
   // panduan=dataBean.checkUserLogin(name,pass);
   // dataBean.setall(name1,pass1);
   // panduan =dataBean.getall();


	//if(panduan==true)
	if((sOpName != null ) &&  !(sOpName.equals("")))
	{
	  session.setAttribute("loginName",name);
	  session.setAttribute("OpName",sOpName);
	  session.setAttribute("OpId",sOpId);
	  session.setAttribute("EntityFlag","1");
	  String ok = "true";
	  session.setAttribute("admin",ok);
	  session.setMaxInactiveInterval(43200);
	//  out.print("<a href=index.jsp>登陆成功</a>");
	 
	 %>
	 <body>
<table width="560" cellpadding="0" cellspacing="0" border="0" align="center">
 <!--  
 <tr>
  <th align="center"><a href=admin.jsp>登录成功，3秒后将自动跳转到主页面……</a></th>
 </tr>
 -->
</table>
</body>
</html>
	 <%
	 }
	  else
	  {
	              String msg="error!";
				   response.sendRedirect("login.jsp?msg="+msg+"&name="+name);
	  
	  }
	 // out.print("<a href=login.html>登陆失败,请返回</a>");
	  
%>
