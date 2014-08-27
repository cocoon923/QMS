<jsp:useBean id="dataBean" scope="page" class="dbOperation.requirementInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%
  request.setCharacterEncoding("gb2312");
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'testGetResult.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <%
  // Vector ver=dataBean.getRequirementInfoAll();
  //  for (int i = 0; i < ver.size(); i++) {
    //  for(int i=ver.size()-1;i>=0;i--){
 //   HashMap hash = (HashMap) ver.get(i);
 //   String case_id = (String) hash.get("CASE_ID");
 //   String case_desc = (String) hash.get("CASE_DESC");
 //   out.println(case_id+"   "+case_desc);
   //  }
    %>
   
   <br>
  </body>
</html>
