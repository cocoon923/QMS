<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />

<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 6.0">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>commitplaninfo</title>
</head>
<% 
   String sOperType=request.getParameter("opertype");
   String sPlanId=request.getParameter("PLAN_ID");
   String sPlanName=request.getParameter("PLAN_NAME");
   String sStartTime=request.getParameter("START_TIME");
   String sEndTime=request.getParameter("END_TIME");
   String sPlanner=request.getParameter("PLANNER");
   String sflag="1";
   //out.print("sOperType="+sOperType+"\n sPlanId="+sPlanId);
   
   java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");    
   Calendar   currentTime=Calendar.getInstance();   
   
   if(currentTime.after(sStartTime.toString()) && currentTime.before(sEndTime.toString()))
   {
   		sflag="2";
   }
   else if(currentTime.before(sStartTime.toString()))
   {
   		sflag="1";
   }
   else if(currentTime.after(sEndTime.toString()))
   {
   		sflag="3";
   }
   
   if((sStartTime!=null)&&(sStartTime!=""))
    {
    	String time=sStartTime.replaceAll("-","");
    	time=time.substring(0,8);
    	sStartTime=time+"000000";
    }
    if((sEndTime!=null)&&(sEndTime!=""))
    {
    	String time=sEndTime.replaceAll("-","");
    	time=time.substring(0,8);
    	sEndTime=time+"000000";
    }
	
   PlanManager.operplaninfo(sOperType,sPlanId,sPlanName,sStartTime,sEndTime,sPlanner,"",sflag,"");
  
//   out.print("<script language='javascript'>alert('操作成功!');</script>");
   response.sendRedirect("PlanManager.NewPlan.jsp?PLAN_ID="+sPlanId+"&operflag=1");


%>
<body>

</body>
</html>


