<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="DemandManager" scope="page" class="dbOperation.DemandManager" />

<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>commitRequisitionsInfo</title>
</head>
<% 
   String sopId=(String)session.getValue("OpId");
   String sTitle=request.getParameter("DEMAND_TITLE");
   
   String sVersionId=request.getParameter("VERSION_ID");
   String sProductId=request.getParameter("PRODUCT_ID");
   String sSubsysId=request.getParameter("select_subsys");
   String sModuleId=request.getParameter("MODULE_ID");
   
   String sRemark=request.getParameter("REMARK");
   String sFinishTime=request.getParameter("FINISHTIME");
   String sDemandType=request.getParameter("DEMAND_TYPE");
   String sLevelId=request.getParameter("LEVEL_ID");

   String sDemandId=request.getParameter("DEMAND_ID");
   String sStatus=request.getParameter("STATUS");

   
   String sDemandSrcId = request.getParameter("DEMAND_SRC_ID");
   String sSelectDevloper=request.getParameter("SELECT_DEVLOPER");
   String sSelectTester=request.getParameter("SELECT_TESTER");
   String sPlanDevBeginTime = request.getParameter("PLAN_DEV_BEGIN_TIME");
   String sPlanDevTime = request.getParameter("PLAN_DEV_TIME");
   String sRealDevTime = request.getParameter("REAL_DEV_TIME");
   String sRealTestTime = request.getParameter("REAL_TEST_TIME");

   //ArrayList paraList = new ArrayList();
   //paraList.add(sPlanDevBeginTime);
   
   HashMap paraMap = new HashMap();
   paraMap.put("sDemandSrcId", sDemandSrcId);
   paraMap.put("sSelectDevloper", sSelectDevloper);
   paraMap.put("sSelectTester", sSelectTester);
   paraMap.put("sPlanDevBeginTime", sPlanDevBeginTime);
   paraMap.put("sPlanDevTime", sPlanDevTime);
   paraMap.put("sRealDevTime", sRealDevTime);
   paraMap.put("sRealTestTime", sRealTestTime);
  
   
   

   
String sSlipsList="";
String sAssignmentList="";


	
/* 	out.print("sopId="+sopId);
	out.print("sTitle="+sTitle);
	out.print("<br>sProductId="+sProductId);
	out.print("<br>sSubsysId="+sSubsysId);
	out.print("<br>sModuleId="+sModuleId);
	out.print("<br>sVersionId="+sVersionId);
	out.print("<br>sSlipsList="+sSlipsList);
	out.print("<br>sAssignmentList="+sAssignmentList);
	out.print("<br>sRemark="+sRemark);
	out.print("<br>sFinishTime="+sFinishTime); */

   DemandManager.CommitDemand("1",sopId,sProductId,sSubsysId,sModuleId,sVersionId,sTitle,sRemark,sFinishTime,sDemandType,sLevelId,sDemandId,sStatus,paraMap);   
	
   if(sDemandId.equals("")||sDemandId == null){
   		response.sendRedirect("DemandManager.NewDemand.jsp?sFlag=1");
   }else{
		response.sendRedirect("DemandManager.DemandInfo.jsp");

   }


%>
<body>

</body>
</html>


