<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat_Dev" />

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<% 
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0); 
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<%@ page contentType="text/html; charset=gb2312"%>


<%

//获取查询参数
String sStartTime="";
String sEndTime="";
String sGroupId="";
String type="";

type=request.getParameter("type");
if(type==null) type="";

sStartTime=request.getParameter("sStartTime");
if(sStartTime==null) sStartTime="";

sEndTime=request.getParameter("sEndTime");
if(sEndTime==null) sEndTime="";

sGroupId=request.getParameter("groupid");
if(sGroupId==null) sGroupId="";


Vector vStatDemandDetail=new Vector();
Vector vStatDemandOpSum=new Vector();
Vector vStatSlipDetail=new Vector();
Vector vStatSlipOpSum=new Vector();
Vector vStatRevertDetail=new Vector();
Vector vStatRevertOpSum=new Vector();
Vector vStatAssignmentDetail=new Vector();
Vector vStatAssignmentOpSum=new Vector();


int iOpSumSlip=0;
int iOpSumRevert=0;
int iOpSumAssignment=0;

if(type.equals("1")) //统计需求
{
	//获取需求明细数据
	vStatDemandDetail=Stat.StatDemandDetail(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
} 
if(type.equals("2")) //统计bug
{	
  	//获取按人员统计bug数
  	vStatSlipOpSum = Stat.StatSlipsOpSum(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
	if(vStatSlipOpSum.size()>0)
  	{
  	  for(int l=0;l<vStatSlipOpSum.size();l++)
  	  {
  	  	HashMap StatSlipOpSumHash = (HashMap) vStatSlipOpSum.get(l);
  	  	String scount = (String)StatSlipOpSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iOpSumSlip = iOpSumSlip+sumscount;
  	  }
  	}
  	//获取bug明细数据
	vStatSlipDetail=Stat.StatSlipsDetail(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
}
if(type.equals("3")) //统计回退
{
  	//获取按人员统计回退单数
  	vStatRevertOpSum = Stat.StatRevertOpSum(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
	if(vStatRevertOpSum.size()>0)
  	{
  	  for(int l=0;l<vStatRevertOpSum.size();l++)
  	  {
  	  	HashMap StatRevertOpSumHash = (HashMap) vStatRevertOpSum.get(l);
  	  	String scount = (String)StatRevertOpSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iOpSumRevert = iOpSumRevert+sumscount;
  	  }
  	}
  	//获取故障明细数据
	vStatRevertDetail=Stat.StatRevertDetail(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
}

if(type.equals("4")) //统计任务单
{
  	//获取按人员统计任务单数
  	vStatAssignmentOpSum = Stat.StatAssignmentOpSum(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
	if(vStatAssignmentOpSum.size()>0)
  	{
  	  for(int l=0;l<vStatAssignmentOpSum.size();l++)
  	  {
  	  	HashMap StatAssignmentOpSumHash = (HashMap) vStatAssignmentOpSum.get(l);
  	  	String scount = (String)StatAssignmentOpSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iOpSumAssignment = iOpSumAssignment+sumscount;
  	  }
  	}
  	//获取故障明细数据
	vStatAssignmentDetail=Stat.StatAssignmentDetail(sStartTime,sEndTime,"100022","2,3,4",sGroupId);
}

%>



<title>StatDepartmentWorkForDev</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<script language="JavaScript" type="text/JavaScript">

function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}




</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StatDepWorkDetailForDetail" method="post">
<%
	if(type.equals("1")) //需求
	{
%>
 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>提交需求明细:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="10%" class="pagecontenttitle">需求编号<br></td>
      <td width="60%" class="pagecontenttitle">需求名称<br></td>
      <td width="15%" class="pagecontenttitle">需求版本<br></td>
      <td width="10%" class="pagecontenttitle">需求提交组<br></td>
  </tr>
  <%
  		int i1=0;
  		String sdemandid="";
  		String sdemandtitle="";
  		String sversion="";
  		String sgroupname="";
  		if(vStatDemandDetail.size()>0)
  	    {
  	   	  for(int i2=0;i2<vStatDemandDetail.size();i2++)
  	   	  {
  	   	  	i1++;
  	   	  	HashMap StatDemandDetailHash = (HashMap) vStatDemandDetail.get(i2);
  	   	  	sdemandid = (String) StatDemandDetailHash.get("DEMAND_ID");
  	   	  	sdemandtitle = (String) StatDemandDetailHash.get("DEMAND_TITLE");
  	   	  	sversion = (String) StatDemandDetailHash.get("VERSION");
  	   	  	sgroupname = (String) StatDemandDetailHash.get("GROUP_NAME");
		
  %>
   <tr> 
    <td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=i1%>)</td>
    <td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=<%=sdemandid %>" target="_blank"><%=sdemandid%></a></td>
	<td class="<%if(i1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=sdemandtitle%></td>
	<td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sversion %></td>
	<td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=sgroupname %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>

  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="10%" class="pagecontenttitle">需求编号<br></td>
      <td width="60%" class="pagecontenttitle">需求名称<br></td>
      <td width="15%" class="pagecontenttitle">需求版本<br></td>
      <td width="10%" class="pagecontenttitle">需求提交组<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

<%
	}
%>
<%
	if(type.equals("2"))  //bug
	{
%>

 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>按组内人员统计处理bug数:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">人员</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  
    <%
  		String sopname1="";
  		String scount1="";
  		String per1="";
  		double dcount1=0;
  		if(vStatSlipOpSum.size()>0)
  	    {
  	   	  for(int j=0;j<vStatSlipOpSum.size();j++)
  	   	  {
  	   	  	HashMap StatSlipOpSumHash = (HashMap) vStatSlipOpSum.get(j);
  	   	  	sopname1 = (String)StatSlipOpSumHash.get("OP_NAME");
  	   	  	scount1 = (String)StatSlipOpSumHash.get("COUNT");
  	   	  	
  	   	  	dcount1 = Double.parseDouble(scount1); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per1 = nf.format(dcount1/iOpSumSlip);// 要转化的数 
  %>
   <tr> 
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname1%></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount1 %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per1 %></td>
   </tr>  
  <%
  		  }
  		}  
  %>
  
   <tr> 
	<td class="coltext">合计：</td>
	<td class="coltext" ><%=iOpSumSlip %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>处理bug明细：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="5%" class="pagecontenttitle">bug编号<br></td>
      <td width="70%" class="pagecontenttitle">bug名称<br></td>
      <td width="10%" class="pagecontenttitle">处理人员<br></td>
      <td width="10%" class="pagecontenttitle">往返次数<br></td>
  </tr>
  
    <%
  		int j1=0;
  		String sslipid="";
  		String stitle="";
  		String sopenname="";
  		String snum="";
  		if(vStatSlipDetail.size()>0)
  	    {
  	   	  for(int j2=0;j2<vStatSlipDetail.size();j2++)
  	   	  {
  	   	  	j1++;
  	   	  	HashMap StatSlipDetailHash = (HashMap) vStatSlipDetail.get(j2);
  	   	  	sslipid = (String) StatSlipDetailHash.get("SLIP_ID");
  	   	  	stitle = (String) StatSlipDetailHash.get("TITLE");
  	   	  	snum = (String) StatSlipDetailHash.get("NUM");
  	   	  	sopenname = (String) StatSlipDetailHash.get("OP_NAME"); 	
  %>
   <tr> 
    <td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=j1%>)</td>
    <td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/bug/query/bug_query_result.jsp?op_id=<%=sslipid %>" target="_blank"><%=sslipid%></a></td>
	<td class="<%if(j1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=stitle%></td>
	<td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=sopenname %></td>
	<td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=snum %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>  
  

  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="5%" class="pagecontenttitle">bug编号<br></td>
      <td width="70%" class="pagecontenttitle">bug名称<br></td>
      <td width="10%" class="pagecontenttitle">处理人员<br></td>
      <td width="10%" class="pagecontenttitle">往返次数<br></td>
  </tr>
  </table></td></tr></table></td></tr></table>

<%
	}
%>
<%
	if(type.equals("3"))  //回退单
	{
%>

 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>按组内人员统计处理回退单数:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">人员</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  
    <%
  		String sopname2="";
  		String scount2="";
  		String per2="";
  		double dcount2=0;
  		if(vStatRevertOpSum.size()>0)
  	    {
  	   	  for(int k=0;k<vStatRevertOpSum.size();k++)
  	   	  {
  	   	  	HashMap StatRevertOpSumHash = (HashMap) vStatRevertOpSum.get(k);
  	   	  	sopname2 = (String)StatRevertOpSumHash.get("OP_NAME");
  	   	  	scount2 = (String)StatRevertOpSumHash.get("COUNT");
  	   	  	
  	   	  	dcount2 = Double.parseDouble(scount2); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per2 = nf.format(dcount2/iOpSumRevert);// 要转化的数 
  %>
   <tr> 
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname2%></td>
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount2 %></td>
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per2 %></td>
   </tr>  
  <%
  		  }
  		}  
  %>
  
   <tr> 
	<td class="coltext">合计：</td>
	<td class="coltext" ><%=iOpSumRevert %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>回退单明细：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="10%" class="pagecontenttitle">回退单编号<br></td>
      <td width="75%" class="pagecontenttitle">回退单名称<br></td>
      <td width="10%" class="pagecontenttitle">处理人员<br></td>
  </tr>
  
      <%
  		int k1=0;
  		String srequestid="";
  		String sreptitle="";
  		String sfromname="";
  		if(vStatRevertDetail.size()>0)
  	    {
  	   	  for(int k2=0;k2<vStatRevertDetail.size();k2++)
  	   	  {
  	   	  	k1++;
  	   	  	HashMap StatRevertDetailHash = (HashMap) vStatRevertDetail.get(k2);
  	   	  	srequestid = (String) StatRevertDetailHash.get("REQUEST_ID");
  	   	  	sreptitle = (String) StatRevertDetailHash.get("REP_TITLE");
  	   	  	sfromname = (String) StatRevertDetailHash.get("OP_NAME");  			
  %>
   <tr> 
    <td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=k1%>)</td>
    <td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/revert/revert_query_detail.jsp?request_id=<%=srequestid %>" target="_blank"><%=srequestid%></a></td>
	<td class="<%if(k1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=sreptitle%></td>
	<td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=sfromname %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>

  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="10%" class="pagecontenttitle">回退单编号<br></td>
      <td width="75%" class="pagecontenttitle">回退单名称<br></td>
      <td width="10%" class="pagecontenttitle">处理人员<br></td>
  </tr>
  </table></td></tr></table></td></tr></table>

<%
	}
%>

<%
	if(type.equals("4"))  //任务单
	{
%>

 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>按组内人员统计处理任务单数:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">人员</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  
    <%
  		String sopname3="";
  		String scount3="";
  		String per3="";
  		double dcount3=0;
  		if(vStatAssignmentOpSum.size()>0)
  	    {
  	   	  for(int m=0;m<vStatAssignmentOpSum.size();m++)
  	   	  {
  	   	  	HashMap StatAssignmentOpSumHash = (HashMap) vStatAssignmentOpSum.get(m);
  	   	  	sopname3 = (String)StatAssignmentOpSumHash.get("OP_NAME");
  	   	  	scount3 = (String)StatAssignmentOpSumHash.get("COUNT");
  	   	  	
  	   	  	dcount3 = Double.parseDouble(scount3); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per3 = nf.format(dcount3/iOpSumAssignment);// 要转化的数 
  %>
   <tr> 
	<td class="<%if(m%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname3%></td>
	<td class="<%if(m%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount3 %></td>
	<td class="<%if(m%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per3 %></td>
   </tr>  
  <%
  		  }
  		}  
  %>
  
   <tr> 
	<td class="coltext">合计：</td>
	<td class="coltext" ><%=iOpSumAssignment %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>任务单明细：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="10%" class="pagecontenttitle">任务单编号<br></td>
      <td width="65%" class="pagecontenttitle">任务单名称<br></td>
      <td width="10%" class="pagecontenttitle">提交时间<br></td>
      <td width="10%" class="pagecontenttitle">处理人员<br></td>
  </tr>
  
      <%
  		int m1=0;
  		String staskid="";
  		String stasktitle="";
  		String staskmemotime="";
  		String staskopname="";
  		if(vStatAssignmentDetail.size()>0)
  	    {
  	   	  for(int m2=0;m2<vStatAssignmentDetail.size();m2++)
  	   	  {
  	   	  	m1++;
  	   	  	HashMap StatAssignmentDetailHash = (HashMap) vStatAssignmentDetail.get(m2);
  	   	  	staskid = (String) StatAssignmentDetailHash.get("TASK_ID");
  	   	  	stasktitle = (String) StatAssignmentDetailHash.get("TITLE");
  	   	  	staskmemotime = (String) StatAssignmentDetailHash.get("MEMO_TIME");
  	   	  	staskopname = (String) StatAssignmentDetailHash.get("OP_NAME");  	  			
  %>
   <tr> 
    <td class="<%if(m1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=m1%>)</td>
    <td class="<%if(m1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/task/query/task_query_detail.jsp?op_id=<%=staskid %>" target="_blank"><%=staskid%></a></td>
	<td class="<%if(m1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=stasktitle%></td>
	<td class="<%if(m1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=staskmemotime %></td>
	<td class="<%if(m1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=staskopname %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>

  <tr><td width="5%" class="pagecontenttitle">序号</td>
      <td width="10%" class="pagecontenttitle">任务单编号<br></td>
      <td width="65%" class="pagecontenttitle">任务单名称<br></td>
      <td width="10%" class="pagecontenttitle">提交时间<br></td>
      <td width="10%" class="pagecontenttitle">处理人员<br></td>
  </tr>

<%
	}
%>
</table></td></tr></table></td></tr></table>

  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1" align="center">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="window.close()">关 闭</td>
  </tr>
  </table></td>

</form>         
</body>
</html>
                
