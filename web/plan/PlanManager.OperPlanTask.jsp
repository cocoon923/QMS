<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%@ page import="com.jspsmart.upload.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>OperCaseStep</title>
</head>
<script language="JavaScript" type="text/JavaScript">
</script>
<% 
   out.print("�ύ������...��ȴ�... \n");
   String sOperType=request.getParameter("opertype");//����������2��ɾ��
   String sType=request.getParameter("type");//��������2������;3:�з����ܵ�����
   String sPLANID=request.getParameter("planid");
   String sRemark=request.getParameter("remark");
   String sOpId=request.getParameter("OpId"); //��ȡ��¼����Ա
   if(sOpId==null) sOpId="";
   String sPlanner="";
   String stype="";
   String sisLog="";
   boolean flag=false;
   Vector vPlanInfo=new Vector();
   vPlanInfo=PlanManager.queryplaninfo(sPLANID,"","","","","","","","","");
   if(vPlanInfo.size()>0)
   {
   	  HashMap hash = (HashMap) vPlanInfo.get(0);
   	  sPlanner=(String) hash.get("PLANNER");
   }
   if(!sOpId.equals(sPlanner)) //�жϼƻ��ı�д���Ƿ���������ƻ�����Ĳ�����
   {
   		sisLog="1";   //д������¼��־��
   }
   else
   {
   		sisLog="2";  //��д������־��¼��
   }
   
   if(sOperType.equals("1")) //����
   {
	   String sPLANSTARTTIME=request.getParameter("taskstarttime");
	   if(sOperType==null)
	   {
	   		sOperType="";
	   }
	   if(sPLANID==null)
	   {
	   		sPLANID="";
	   }
	   if(sPLANSTARTTIME==null ||sPLANSTARTTIME.equals(""))
	   {
	   		sPLANSTARTTIME="";
	   }
	   else
	   {
	   		sPLANSTARTTIME=sPLANSTARTTIME.replaceAll("-","");
	   }
	   
	   String sPLANENDTIME=request.getParameter("taskendtime");
	   if(sPLANENDTIME==null || sPLANENDTIME.equals(""))
	   {
	   		sPLANENDTIME="";
	   }
	   else
	   {
	   		sPLANENDTIME=sPLANENDTIME.replaceAll("-","");
	   }
	   
	
	//��ȡ����ѡ��checkbox��ֵ��ƴ���ַ���
	String[] sCheckValue =(String[])request.getParameterValues("checkbox");
	
	String sCheckData="";
	if(sCheckValue!=null)    //����ѡcheckbox,��ֵ��Ϊnull
	{	
	   for(int k=0;k<sCheckValue.length;k++)
	   {
	     sCheckData=sCheckValue[k] + "," + sCheckData;
	   }
	}   
	   out.print("<br>sOperType="+sOperType+";<br> sPLANID="+sPLANID+";<br> sDEMANDID="+sCheckData+"<br> sPLANSTARTTIME="+sPLANSTARTTIME+"<br> sPLANENDTIME="+sPLANENDTIME); 
	   out.print("<br> sType="+sType);
	   out.print("<br>sisLog="+sisLog);
	   out.print("<br>sCheckData="+sCheckData);
	   out.print("<br>sOpId="+sOpId);
	   flag=PlanManager.PrcaddPlanTaskInfo(sType,sCheckData,sPLANID,sPLANSTARTTIME,sPLANENDTIME,"0",sisLog,sOpId,sRemark);
	  
	out.print("<script language='javascript'>alert('�����ɹ�!');</script>");
	response.sendRedirect("PlanManager.QueryTask.jsp?planid="+sPLANID+"&operflag=1");
   } 
   else if(sOperType.equals("2"))   //ɾ��
   {
   		String[] sDeleteData =(String[])request.getParameterValues("checkbox");
	
		String sDeleteDataValue="";
		if(sDeleteData!=null)    //����ѡcheckbox,��ֵ��Ϊnull
		{	
		  
		   for(int k=0;k<sDeleteData.length;k++)
		   {
		      if(sDeleteData[k].substring(0,1).equals("R"))
		   	  {
		   		stype="1";
		      }
		   	  else if(sDeleteData[k].substring(0,1).equals("F"))
		      {
		   		stype="2";
		       }
		      else if(sDeleteData[k].substring(0,1).equals("T"))
		      {
		   		stype="3";
		       }
			  else
			  {
			     out.print("<script language='javascript'>alert('δ֪���ͣ�����!');</script>");
			  }
		   sDeleteDataValue=sDeleteData[k].substring(1,sDeleteData[k].length());
		   //out.print("sDeleteData"+sDeleteData[k]+"\n");
		   out.print("sPLANID="+sPLANID+"\n stype="+stype+"\n sDeleteDataValue="+sDeleteDataValue+"\n sOperType="+sOperType);
   		   PlanManager.deleteplantask(sPLANID,stype,sDeleteDataValue);
   		   if(sisLog.equals("1")) //�ƻ��ƶ��� ��ɾ���ƻ��������Ա��ͬ����д������¼��־��
   		   {
   		   		PlanManager.addplantasklog(sPLANID,stype,sDeleteDataValue,sOpId,"2",sRemark);
   		   }
		   }
		}
   		response.sendRedirect("PlanManager.PlanTask.jsp?planid="+sPLANID+"&operflag=1");
   }
   else
   {
   		out.print("<script language='javascript'>alert('δ֪���ͣ�����!');</script>");
   }
%>
<body>

<script language="javascript"> 
<!-- 
function clock()
{ 
	if(i==0)
	{ 
		clearTimeout(st); 
		window.opener=null;
		window.open('','_self',''); 
		window.close();
	} 
	i = i -1; 
	st = setTimeout("clock()",0.1); 
} 

var i=1
var flag;
flag=<%=flag%> ;
if(flag)
{
	clock(); 
}
--> 

</script>
</body>
</html>