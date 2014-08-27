<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="Approval" scope="page" class="dbOperation.Approval" />

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
   String sVersionId=request.getParameter("VERSION_ID");
   String sProductId=request.getParameter("PRODUCT_ID");
   String sSubsysId=request.getParameter("select_subsys");
   String sModuleId=request.getParameter("MODULE_ID");
   String sOBD=request.getParameter("OBD");
   if(sOBD==null) sOBD="0";
   if (sOBD.equals("on"))
   {
   		sOBD="1";
   }
   else 
   {
   		sOBD="0";
   }
   String sDB=request.getParameter("DB");
   if(sDB==null) sDB="0";
   if (sDB.equals("on"))
   {
   		sDB="1";
   }
   else 
   {
   		sDB="0";
   }
   String sRemark=request.getParameter("REMARK");
   //String sSlips="";
   //String sAssignment="";
   
String[] sList=request.getParameterValues("taskid");
String sSlipsList="";
String sAssignmentList="";

if(sList != null)
{
if(sList.length>0)
{
for(int k=0;k<sList.length;k++)
{
	String sSlipsListTemp="";
	String sAssignmentListTemp="";
	String sListType="";
	
	//out.print("<h1>" + sList[k] + "</h1>");
	sListType = sList[k].substring(0,sList[k].indexOf('|'));
	if(sListType.equals("1"))//选择的是任务单
	{
		sAssignmentListTemp=','+ sList[k].substring(sList[k].indexOf("|")+1,sList[k].length());
		sAssignmentList = sAssignmentList + sAssignmentListTemp; 
	}
	else if (sListType.equals("2"))//选择的是bug单
	{
		sSlipsListTemp=','+ sList[k].substring(sList[k].indexOf("|")+1,sList[k].length());
		sSlipsList = sSlipsList + sSlipsListTemp; 
	}		
}
   if(!sAssignmentList.equals(""))
   {
      sAssignmentList = sAssignmentList.substring(1,sAssignmentList.length()); //去掉第一位逗号,用于拼sql用
   }
   if(!sSlipsList.equals(""))
   {
      sSlipsList = sSlipsList.substring(1,sSlipsList.length()); //去掉第一位逗号,用于拼sql用
   }
}
}
	
	out.print("sopId="+sopId);
	out.print("<br>sProductId="+sProductId);
	out.print("<br>sSubsysId="+sSubsysId);
	out.print("<br>sModuleId="+sModuleId);
	out.print("<br>sVersionId="+sVersionId);
	out.print("<br>sSlipsList="+sSlipsList);
	out.print("<br>sAssignmentList="+sAssignmentList);
	out.print("<br>sRemark="+sRemark);
	out.print("<br>sOBD="+sOBD);
	out.print("<br>sDB="+sDB);
	
   Approval.CommitApplicationRecord("1",sopId,sProductId,sSubsysId,sModuleId,sVersionId,sSlipsList,sAssignmentList,sRemark,sOBD,sDB);   

   response.sendRedirect("Approval.Requisitions.jsp?sFlag=1");


%>
<body>

</body>
</html>


