<%@include file="allcheck.jsp"%>
<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />
<%
  request.setCharacterEncoding("gb2312");
%>

<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>删除用例</title>
</head>
<body>
<%
     String sRMId =request.getParameter("requirement");
     out.print("用例名称"+sRMId);
     String sSecId =request.getParameter("caseId");
     out.print("sSecId="+sSecId);
     String sFlag=request.getParameter("flag");
     if(sFlag==null)
     {
     	sFlag="";
     }
    // String sSubRMId=sRMId.substring(1);
	// int iRMId=sRMId.indexOf("R");
	// if(iRMId==0)
	//	iRMId=1;
   //  else
	//	iRMId=2;  
	// out.print("用例名称"+sRMId);
	// out.print("需求还是故障="+iRMId);
	
	 //先删除附件
	 String sAccessory="";
	 int i;
	 Vector vProcess =CaseOpera.querycaseProcess(sSecId,"");
	 if(vProcess.size()>0)
	 {
	     for(i=0;i<vProcess.size();i++)
	     {
	     HashMap hash = (HashMap) vProcess.get(i);
         sAccessory = (String) hash.get("ACCESSORY");
         if(sAccessory!=null && !sAccessory.equals("")) //当附件存在的情况才删除文件
         {
            //String   path=request.getRealPath("AICMS/upload");//qcs
            String   path=request.getRealPath("upload");//windows
            path=path+"/"+sAccessory;
            out.print("<br>path="+path);
            java.io.File temp =new java.io.File(path);
            if(temp.isFile()) 
            {  
               temp.delete(); 
             }
          }
          }
       }
	
	 dataBean.deleteCaseInfo(sSecId);
	 if(sFlag.equals("1"))
	 {
	 	response.sendRedirect("CaseManager.CaseRecord.jsp?requirement="+sRMId+"&deleteInfo=1");
	 }
	 else
	 {
	 	response.sendRedirect("casemanager.jsp?requirement="+sRMId+"&deleteInfo=1");
	 }
	// response.sendRedirect("casemanager.jsp?requirement="+sRMId+"&deleteInfo=2");
%>
</body>
<html>

