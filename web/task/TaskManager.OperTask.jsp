<!--modify by huyf  -->
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<jsp:useBean id="TaskManager" scope="page" class="dbOperation.TaskManager" />

<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta name="GENERATOR" content="Microsoft">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>commitTaskInfo</title>
</head>
<% 
String sopId=(String)session.getValue("OpId");
if(sopId==null) sopId="";
//��ȡҳ����������
String sTaskId=request.getParameter("TaskId");
if(sTaskId==null) sTaskId="";
String sDemandTitle=request.getParameter("DEMAND_NAME");
if(sDemandTitle==null) sDemandTitle="";
String sDemandID=request.getParameter("DEMAND_ID");
if(sDemandID==null) sDemandID="";
String sDeveloper=request.getParameter("SLECT_DEVLOPER");
if(sDeveloper==null) sDeveloper="";
String sTester=request.getParameter("SLECT_TESTER");
if(sTester==null) sTester="";

String sTaskDesc=request.getParameter("TaskDesc");
if(sTaskDesc==null) sTaskDesc="";
String sDevFinishTime=request.getParameter("DEV_FINISH_TIME");
if(sDevFinishTime==null) sDevFinishTime="";
String sTestFinishTime=request.getParameter("TEST_FINISH_TIME");
if(sTestFinishTime==null) sTestFinishTime="";
//�������񵥲���
if(sTaskId==""){
	//��������
	sTaskId=TaskManager.getNewTaskSeq();
	if(TaskManager.isAllowAddTaskInfo(sDeveloper,sDemandID)){
	TaskManager.addTaskInfo(sTaskId,sDemandTitle,sopId,sDeveloper,"1",sDemandID,sTaskDesc,sDevFinishTime,sTestFinishTime,sTester);
	System.out.print("��������ɹ���");
	response.sendRedirect("TaskManager.NewTask.jsp?TaskId="+sTaskId+"&taskOperflag=1&demandID="+sDemandID);
	}else{
		response.sendRedirect("TaskManager.NewTask.jsp?TaskId="+sTaskId+"&taskOperflag=2&demandID="+sDemandID);
	}
}else{//�޸����񵥲���
	response.sendRedirect("TaskManager.NewTask.jsp?TaskId="+sTaskId+"&taskOperflag=1&demandID="+sDemandID);
	
}
	
%>
<script language="JavaScript">
	alert("��������ɹ���");
<body><br><br></body>
</html>


