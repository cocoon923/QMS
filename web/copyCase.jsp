<%@include file="allcheck.jsp"%>
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>复制用例</title>
</head>
<body>
<%
    //需求或者故障编号如：R19255或者F19255
     String sRMId =request.getParameter("requirement");
     //out.print("用例名称"+sRMId);
     String sSecId =request.getParameter("caseId");
    // out.print("sSecId="+sSecId);
    String sFlag=request.getParameter("flag");
    if(sFlag==null)
    {
    	sFlag="";
    }
     String sSubRMId=sRMId.substring(1);
	 int iRMId=sRMId.indexOf("R");
	 if(iRMId==0)
		iRMId=1;
     else
		iRMId=2;  
	// out.print("sSubRMId="+sSubRMId);
	// out.print("iRMId="+iRMId);
	// out.print("sSecId="+sSecId);
	out.print("sRMId="+sRMId+";sSecId="+sSecId+";sFlag="+sFlag+";sSubRMId="+sSubRMId);
	
		 //String path=request.getRealPath("AICMS/upload");//qcs
		 String path=request.getRealPath("upload");//windows
		 String sLeftStr=path;
		 int iCount=0;
	     String sPath="";
	     while(sLeftStr.indexOf("\\")>=0)
	     {
	       iCount=sLeftStr.indexOf("\\");
	       sPath=sPath+sLeftStr.substring(0,iCount)+"\\"+"\\";
	       sLeftStr=sLeftStr.substring(iCount+1,sLeftStr.length());
	    }
	    sPath=sPath+sLeftStr;
	    
	   dataBean.copyCaseInfo(sSubRMId,iRMId,sSecId,sPath);
	   if(sFlag.equals("1"))
	   {
	   		response.sendRedirect("CaseManager.CaseRecord.jsp?requirement="+sRMId+"&copyCaseInfo=1");
	   }
	   else
	   {
	   		response.sendRedirect("casemanager.jsp?requirement="+sRMId+"&copyCaseInfo=1");
   	   }
%>

</body>
<html>

