<%@ page contentType="application/msexcel; charset=gb2312" import="java.util.*,java.io.*,java.sql.*"   language="java"%>

<jsp:useBean id="importRequirment" scope="page" class="dbOperation.ImportRequriment" />
<% 
  java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
  String sWordName="重点需求故障导出-"+sdf.format(date);
  
  request.setCharacterEncoding("gb2312");
  //response.setHeader("Content-disposition","attachment; filename=导出.xls");
  response.setHeader( "Content-Disposition", "attachment;filename="  + new String(sWordName.getBytes("gb2312"), "ISO8859-1" )+".xls" );
%>
<html>

<head>
<title>导出页面</title>
</head>
<%
   String demandTitle=request.getParameter("demandTitle");
   String QueryStartTime=request.getParameter("QueryStartTime");
   String QueryEndTime=request.getParameter("QueryEndTime");
   String QueryProduct=request.getParameter("QueryProduct");
   String QueryReq=request.getParameter("QueryReq");
   String QueryGu=request.getParameter("QueryGu");
   String sNewRid=request.getParameter("sNewRid");
   String sNewGid=request.getParameter("sNewGid");
   //String opId=(String)session.getValue("OpId");
   //,QueryEndTime,QueryProduct,QueryReq,QueryGu,sNewRid,sNewGid,opId
   // Vector vImportReq=importRequirment.getQueryImportRequirement(QueryStartTime,QueryEndTime,QueryProduct,QueryReq,QueryGu,sNewRid,sNewGid,opId);
%>
<body>

<table x:str border="0" cellpadding="0" cellspacing="0" width="1076" style="border-collapse:
 collapse;width:808pt" id="table1">
	<colgroup>
		<col width="72" span="5" style="width:54pt">
		<col width="173" style="width: 130pt">
		<col width="188" style="width: 141pt">
		<col width="72" span="2" style="width:54pt">
		<col width="113" style="width: 85pt">
		<col width="98" style="width: 74pt">
	</colgroup>
	<tr height="21" style="height:15.75pt">
		<td colspan="11" height="21" width="1076" style="height: 15.75pt; width: 808pt; color: black; font-size: 11.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: left; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: 1.0pt solid silver; border-bottom: 1.0pt solid white; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		重点需求故障列表</td>
	</tr>
	<tr height="32" style="height:24.0pt">
		<td height="32" width="72" style="height: 24.0pt; width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		ID</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		产品</td>
		<td width="188" style="width: 141pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		名称</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		省份</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		状态</td>
		<td width="98" style="width: 74pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		开发人员</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		测试人员</td>
		<td  width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		计划开发提交时间</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		实际开发提交时间</td>
		<td width="113" style="width: 85pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		计划测试完成时间</td>
		<td width="173" style="width: 130pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: medium none; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		备注</td>
	</tr>
    <%
	    //Vector vImportReq=importRequirment.getQueryImportRequirement(QueryStartTime,QueryEndTime,QueryProduct,QueryReq,QueryGu,sNewRid,sNewGid,"","1");
 		Vector vDemandRequest = importRequirment.getRequirementList(demandTitle,QueryStartTime,QueryEndTime,QueryProduct,QueryReq);

    	if(vDemandRequest.size()>0)
        {
		  for(int i=0;i<vDemandRequest.size();i++)
		  {
			 HashMap ImportReqMap=(HashMap) vDemandRequest.get(i);
			 String PRODUCT=(String)ImportReqMap.get("PRODUCT");
			 String NAME=(String)ImportReqMap.get("NAME");
			 String DEMAND_PROV=(String)ImportReqMap.get("DEMAND_PROV");
			 String STATE=(String)ImportReqMap.get("STATE");
			 String STATE_NAME=(String)ImportReqMap.get("STATE_NAME");
			 String PLAN_DEV_TIME=(String)ImportReqMap.get("PLAN_DEV_TIME");
	         String REAL_DEV_TIME=(String)ImportReqMap.get("REAL_DEV_TIME");
	         String DEV_NAME=(String)ImportReqMap.get("DEV_NAME");
	         String TESTER_NAME=(String)ImportReqMap.get("TESTER_NAME");
	         String PLAN_TEST_TIME=(String)ImportReqMap.get("PLAN_TEST_TIME");
	         String REAL_TEST_TIME=(String)ImportReqMap.get("REAL_TEST_TIME");
	         String REMARK = (String)ImportReqMap.get("REMARK");
	         String TYPE=(String)ImportReqMap.get("TYPE");
	         String VALUE=(String)ImportReqMap.get("VALUE");
	         if(PRODUCT==null) PRODUCT="";
	         if(NAME==null) NAME="";
	         if(DEMAND_PROV==null) DEMAND_PROV="&nbsp;";
	         if(STATE==null) STATE="&nbsp;";
	         if(STATE_NAME==null) STATE_NAME="&nbsp;";
	         if(PLAN_DEV_TIME==null) PLAN_DEV_TIME="&nbsp;";
	         if(REAL_DEV_TIME==null) REAL_DEV_TIME="&nbsp;";
	         if(DEV_NAME==null) DEV_NAME="&nbsp;";
	         if(TESTER_NAME==null) TESTER_NAME="&nbsp;";
	         if(PLAN_TEST_TIME==null) PLAN_TEST_TIME="&nbsp;";
	         if(REAL_TEST_TIME==null) REAL_TEST_TIME="&nbsp;";
	         if(REMARK==null) REMARK="&nbsp;";
	         if(TYPE==null) TYPE="";
	         if(VALUE==null) VALUE="";
	%>
	<tr height="49" style="height:36.75pt">
		<td height="49" width="72" style="height: 36.75pt; width: 54pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white" x:num u1:num>
		<%=i+1%></td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white">
		<%=PRODUCT%></td>
		<td width="188" style="width: 141pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white"><a href="<%
		if(TYPE.equals("1")) //需求
		{
			out.print("http://aiqcs.asiainfo.com/demand/query/demd_query_detail.jsp?op_id="+VALUE);
		}
		else if(TYPE.equals("2")) //故障
		{
			out.print("http://aiqcs.asiainfo.com/project/query/proj_query_result.jsp?op_id="+VALUE);
		}
		else
		{
			out.print("error");
		}%>"><%=NAME%></td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white">
		<%=DEMAND_PROV%></td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white" u1:num>
		<%=STATE_NAME%></td>
		<td width="98" style="width: 74pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white">
		<%=DEV_NAME%></td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white">
		<%=TESTER_NAME%></td>
		<td  width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white" x:num="39808" u1:num="39808">
		<%=PLAN_DEV_TIME%></td>
		<td width="72" style="width: 54pt;  color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white" x:num="39812.605543981481" u1:num="39812.605543981481">
		<%=REAL_DEV_TIME%></td>
		<td width="113" style="width: 85pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white" x:num="39773" u1:num="39773">
		<%=PLAN_TEST_TIME%></td>
		<td width="173" style="width: 130pt; color: gray; font-size: 9.0pt; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-weight: 400; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: medium none; border-bottom: 1.0pt solid silver; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: white" x:num="39822.478078703702" u1:num="39822.478078703702">
		<%=REMARK%></td>
	</tr>
	<%
	     }
	   }  
	 %>
	<tr height="32" style="height:24.0pt">
		<td height="32" width="72" style="height: 24.0pt; width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid silver; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		ID</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		产品</td>
		<td width="188" style="width: 141pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		名称</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		省份</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		状态</td>
		<td width="98" style="width: 74pt;  color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		开发人员</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		测试人员</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		计划开发提交时间</td>
		<td width="72" style="width: 54pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		实际开发提交时间</td>
		<td width="113" style="width: 85pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		计划测试完成时间</td>
		<td width="173" style="width: 130pt; color: gray; font-size: 9.0pt; font-weight: 700; font-family: Arial, sans-serif; text-align: center; vertical-align: bottom; white-space: normal; font-style: normal; text-decoration: none; border-left: 1.0pt solid white; border-right: medium none; border-top: 1.0pt solid white; border-bottom: medium none; padding-left: 1px; padding-right: 1px; padding-top: 1px; background: silver">
		备注</td>
	</tr>
</table>

</body>

</html>