<%@include file="allcheck.jsp"%>
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />

<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>operplaninfo</title>
</head>
<% 
   String sRMId=request.getParameter("requirement");   
   String sRemark1=request.getParameter("ORIDEMANDINFO");
   String sRemark2=request.getParameter("DEMANDSOLUTION");
   String sRemark3=request.getParameter("DEMANDCHGINFO"); 
   String sRemark4=request.getParameter("REMARK1");
   String sRemark5=request.getParameter("REMARK2");
   String sRemark6=request.getParameter("REMARK3");
   String sRemark7=request.getParameter("REMARK4");
   String sRemark8=request.getParameter("REMARK5");
   String sRemark9=request.getParameter("REMARK6"); 
   String sIsRecord=request.getParameter("isrecord"); 
   if(sIsRecord==null) sIsRecord="0";
   String sSubRMId=sRMId.substring(1);
   int iRMId=sRMId.indexOf("R");
   if(iRMId>=0)
	  iRMId=1;
   else
      iRMId=2;  
   dataBean.updateDemandInfo(sSubRMId,iRMId,sRemark1,sRemark2,sRemark3,sRemark4,sRemark5,sRemark6,sRemark7,sRemark8,sRemark9);
  //out.print("requirement"+sRMId);
  // out.print("sRemark1"+sRemark1);
  // out.print("sRemark2"+sRemark2);
  // out.print("sRemark3"+sRemark3);
  // out.print("sRemark4"+sRemark4);
  // out.print("sRemark5"+sRemark5);
  // out.print("sRemark6"+sRemark6);
  // out.print("sRemark7"+sRemark7);
  // out.print("sRemark8"+sRemark8);
  if(sIsRecord.equals("1"))
  {
  	response.sendRedirect("CaseManager.CaseRecord.jsp?requirement="+sRMId+"&updateInfo=1");
  }
  else
  {
  	response.sendRedirect("casemanager.jsp?requirement="+sRMId+"&updateInfo=1");
  }
%>
<body>
<table width="560" cellpadding="0" cellspacing="0" border="0" align="center">

</table>
</body>
</html>


