<%@include file="../allcheck.jsp"%>
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

//获取系统时间
java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");    
Calendar   currentTime=Calendar.getInstance();
String sdate=df.format(currentTime.getTime()); //获取当前时间并格式化

//获取查询参数
String sStartTime="";
String sEndTime="";
String sOper="";

sOper=request.getParameter("sOper");
if(sOper==null) sOper="";

sStartTime=request.getParameter("sStartTime");
if(sStartTime==null) sStartTime="";

sEndTime=request.getParameter("sEndTime");
if(sEndTime==null) sEndTime="";

String StatDemandSum="";

Vector vStatDemandGroupSum=new Vector();
Vector vStatSlipSum=new Vector();
Vector vStatAssignmentGroupSum=new Vector();
Vector vStatRevertGroupSum=new Vector();
int iSumDemand=0;
int iSumSlip=0;
int iSumAssignment=0;
int iSumRevert=0;

if(sOper.equals("1")) //统计操作
{
	StatDemandSum=Stat.StatDemandSum(sStartTime,sEndTime,"100022","2,3,4");
	//获取按组统计的需求数据
	vStatDemandGroupSum=Stat.StatDemandGroupSum(sStartTime,sEndTime,"100022","2,3,4");
	if(vStatDemandGroupSum.size()>0)
  	{
  	  for(int l=0;l<vStatDemandGroupSum.size();l++)
  	  {
  	  	HashMap StatDemandGroupSumHash = (HashMap) vStatDemandGroupSum.get(l);
  	  	String scount = (String)StatDemandGroupSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iSumDemand = iSumDemand+sumscount;
  	  }
  	}
  	
  	//获取按组统计的bug数据
	vStatSlipSum=Stat.StatSlipsGroupSum(sStartTime,sEndTime,"100022","2,3,4");
	if(vStatSlipSum.size()>0)
  	{
  	  for(int l=0;l<vStatSlipSum.size();l++)
  	  {
  	  	HashMap StatSlipSumHash = (HashMap) vStatSlipSum.get(l);
  	  	String scount1 = (String)StatSlipSumHash.get("COUNT");
  	  	int sumscount1=Integer.parseInt(scount1);
  	  	iSumSlip = iSumSlip+sumscount1;
  	  }
  	}
  	
  	//获取按组统计的任务单数据
	vStatAssignmentGroupSum=Stat.StatAssignmentGroupSum(sStartTime,sEndTime,"100022","2,3,4");
	if(vStatAssignmentGroupSum.size()>0)
  	{
  	  for(int l=0;l<vStatAssignmentGroupSum.size();l++)
  	  {
  	  	HashMap StatAssignmentGroupSumHash = (HashMap) vStatAssignmentGroupSum.get(l);
  	  	String scount2 = (String)StatAssignmentGroupSumHash.get("COUNT");
  	  	int sumscount2=Integer.parseInt(scount2);
  	  	iSumAssignment = iSumAssignment + sumscount2;
  	  }
  	}
  	
  	//获取按组统计的回退单数据
	vStatRevertGroupSum=Stat.StatRevertGroupSum(sStartTime,sEndTime,"100022","2,3,4");
	if(vStatRevertGroupSum.size()>0)
  	{
  	  for(int l=0;l<vStatRevertGroupSum.size();l++)
  	  {
  	  	HashMap StatRevertGroupSumHash = (HashMap) vStatRevertGroupSum.get(l);
  	  	String scount2 = (String)StatRevertGroupSumHash.get("COUNT");
  	  	int sumscount2=Integer.parseInt(scount2);
  	  	iSumRevert = iSumRevert + sumscount2;
  	  }
  	}
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


function statInfo(url)
{
	var starttime="";
	var endtime="";

	//获取统计开始时间
	if(document.StatDepWorkForDev.chk_start_date.checked==true)
	{
		starttime = document.getElementById('repstarttime').value;
	}
	//获取统计结束时间
	if(document.StatDepWorkForDev.chk_end_date.checked==true)
	{
		endtime = document.getElementById('rependtime').value;
	}
	    
	//处理时间格式为：YYYYMMDDhh24miss
	if((starttime!=null)&&(starttime!=""))
	{
	  	var time=starttime.replace("-","");
	   	time=time.replace("-","");
	   	starttime=time+"000000";
	}
	if((endtime!=null)&&(endtime!=""))
	{
	   	var time=endtime.replace("-","");
	   	time=time.replace("-","");
	   	endtime=time+"235959";
	}
	//alert(url+"&sStartTime="+starttime+"&sEndTime="+endtime+"&sProductId="+productId+"&sGroupId="+groupId+"&sTestId="+Opid+"&sDemandId="+DemandId);
	window.location=url+"&sStartTime="+starttime+"&sEndTime="+endtime;	
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StatDepWorkForDev" method="post">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>查询、统计条件（开发）：<br>
  </td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="contentbg">
  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">统计开始时间： </div>
  <div align="right"> </div></td>
  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_start_date" <%if(!sStartTime.equals("")) out.print("checked"); %>>
  <input name="repstarttime" type="text" class="inputstyle" id="repstarttime"  onClick="JSCalendar(this);"  value="<%if(!sStartTime.equals(""))out.print(sStartTime.substring(0,4)+"-"+sStartTime.substring(4,6)+"-"+sStartTime.substring(6,8));else out.print(sdate);%>" size="10">
                
  <tr>
  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">统计结束时间： </div>
  <div align="right"> </div></td>
  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_end_date" <%if(!sEndTime.equals("")) out.print("checked"); %>>
  <input name="devstarttime" type="text" class="inputstyle" id="rependtime"  onClick="JSCalendar(this);"  value="<%if(!sEndTime.equals("")) out.print(sEndTime.substring(0,4)+"-"+sEndTime.substring(4,6)+"-"+sEndTime.substring(6,8));else out.print(sdate);%>" size="10">
  </tr>

  <tr class="contentbg">
  <td class="pagetitle1">&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
  </table></td></tr></table>
  
  <tr><td><div align="left"><table width="146" border="0" cellspacing="5" cellpadding="5"><tr>
   
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="statInfo(/*href*/'Stat.DepartmentWorkForDev.jsp?sOper=1')">统 计</td>
  </tr>
  </table></td>
  </tr></table></div></td></tr>
  
  <%
  	if(iSumDemand>0)
  	{
  %>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>统计提交需求:<br>注：计算需求数--各组需求数相加；实际需求数--查询条件得到的需求个数。因一需求可能多人开发，故此二数值可能不等：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  <%
  	   String sgroupname="";
  	   String sgroupid="";
  	   String scount="";
  	   double dcount=0;
  	   String per="";
  	   if(vStatDemandGroupSum.size()>0)
  	   {
  	   	  for(int i=0;i<vStatDemandGroupSum.size();i++)
  	   	  {
  	   	  	HashMap StatDemandGroupSumHash = (HashMap) vStatDemandGroupSum.get(i);
  	   	  	sgroupname = (String)StatDemandGroupSumHash.get("GROUP_NAME");
  	   	  	sgroupid = (String)StatDemandGroupSumHash.get("GROUP_ID");
  	   	  	scount = (String)StatDemandGroupSumHash.get("COUNT");
  	   	  	
  	   	  	dcount = Double.parseDouble(scount); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per = nf.format(dcount/iSumDemand);// 要转化的数 

  	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="Stat.DepartmentWorkDetailForDev.jsp?type=1&groupid=<%=sgroupid %>&sStartTime=<%=sStartTime %>&sEndTime=<%=sEndTime %>" target="_blank"><%=sgroupname%></a></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per %></td>
   </tr>   
  <% 	   	  	
  	   	  }
  	   }
  %>
  
   <tr> 
	<td class="coltext">合计：</td>
	<td class="coltext" ><%out.print("计算需求数："+iSumDemand+"/实际需求数："+StatDemandSum); %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

  <%
 	}
  %>
  
  
  <%
  	if(iSumAssignment>0)
  	{
  %>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>统计任务单：</td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  
    <%
  	   String sgroupname2="";
  	   String sgroupid2="";
  	   String scount2="";
  	   double dcount2=0;
  	   String per2="";
  	   if(vStatAssignmentGroupSum.size()>0)
  	   {
  	   	  for(int k=0;k<vStatAssignmentGroupSum.size();k++)
  	   	  {
  	   	  	HashMap StatProjectRequestGroupSumHash = (HashMap) vStatAssignmentGroupSum.get(k);
  	   	  	sgroupname2 = (String)StatProjectRequestGroupSumHash.get("GROUP_NAME");
  	   	  	sgroupid2 = (String)StatProjectRequestGroupSumHash.get("GROUP_ID");
  	   	  	scount2 = (String)StatProjectRequestGroupSumHash.get("COUNT");
  	   	  	
  	   	  	dcount2 = Double.parseDouble(scount2);  	   	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per2 = nf.format(dcount2/iSumAssignment);// 要转化的数 
  %>
    <tr> 
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="Stat.DepartmentWorkDetailForDev.jsp?type=4&groupid=<%=sgroupid2 %>&sStartTime=<%=sStartTime %>&sEndTime=<%=sEndTime %>" target="_blank"><%=sgroupname2%></a></td>
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount2 %></td>
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=per2 %></td>
   </tr>   
  <% 	   	  	
  	   	  }
  	   }
  %> 
  
  <tr> 
	<td class="coltext" >合计：</td>
	<td class="coltext" ><%out.print("计算任务单数："+iSumAssignment+"/实际任务单数："+iSumAssignment);%></td>
	<td class="coltext" >100%</td>
   </tr>
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  </table></td></tr></table></td></tr></table>
  <%
 	}
  %>


  <%
  	if(iSumSlip>0)
  	{
  %>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>统计提交bug：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  
    <%
  	   String sgroupname1="";
  	   String sgroupid1="";
  	   String scount1="";
  	   double dcount1=0;
  	   String per1="";
  	   if(vStatSlipSum.size()>0)
  	   {
  	   	  for(int j=0;j<vStatSlipSum.size();j++)
  	   	  {
  	   	  	HashMap StatSlipSumHash = (HashMap) vStatSlipSum.get(j);
  	   	  	sgroupname1 = (String)StatSlipSumHash.get("GROUP_NAME");
  	   	  	sgroupid1 = (String)StatSlipSumHash.get("GROUP_ID");
  	   	  	scount1 = (String)StatSlipSumHash.get("COUNT");
  	   	  	
  	   	  	dcount1 = Double.parseDouble(scount1);  	   	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per1 = nf.format(dcount1/iSumSlip);// 要转化的数 
  %>
    <tr> 
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>"><a href="Stat.DepartmentWorkDetailForDev.jsp?type=2&groupid=<%=sgroupid1 %>&sStartTime=<%=sStartTime %>&sEndTime=<%=sEndTime %>" target="_blank"><%=sgroupname1%></a></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount1 %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=per1 %></td>
   </tr> 
  <% 	   	  	
  	   	  }
  	   }
  %>
  <tr> 
	<td class="coltext" >合计：</td>
	<td class="coltext" ><%out.print("计算bug数："+iSumSlip+"/实际bug数："+iSumSlip); %></td>
	<td class="coltext" >100%</td>
   </tr> 
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  </table></td></tr></table></td></tr></table>
  <%
 	}
  %>
  <%
  	if(iSumRevert>0)
  	{
  %>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>统计处理回退单：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  
    <%
  	   String sgroupname3="";
  	   String sgroupid3="";
  	   String scount3="";
  	   double dcount3=0;
  	   String per3="";
  	   if(vStatRevertGroupSum.size()>0)
  	   {
  	   	  for(int m=0;m<vStatRevertGroupSum.size();m++)
  	   	  {
  	   	  	HashMap StatRevertSumHash = (HashMap) vStatRevertGroupSum.get(m);
  	   	  	sgroupname3 = (String)StatRevertSumHash.get("GROUP_NAME");
  	   	  	sgroupid3 = (String)StatRevertSumHash.get("GROUP_ID");
  	   	  	scount3 = (String)StatRevertSumHash.get("COUNT");
  	   	  	
  	   	  	dcount3 = Double.parseDouble(scount3);  	   	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// 小数点后保留几位   
			per3 = nf.format(dcount3/iSumRevert);// 要转化的数 
  %>
    <tr> 
	<td class="<%if(m%2!=0) out.print("coltext");else out.print("coltext2"); %>"><a href="Stat.DepartmentWorkDetailForDev.jsp?type=3&groupid=<%=sgroupid3 %>&sStartTime=<%=sStartTime %>&sEndTime=<%=sEndTime %>" target="_blank"><%=sgroupname3%></a></td>
	<td class="<%if(m%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount3 %></td>
	<td class="<%if(m%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=per3 %></td>
   </tr> 
  <% 	   	  	
  	   	  }
  	   }
  %>
  <tr> 
	<td class="coltext" >合计：</td>
	<td class="coltext" ><%out.print("计算回退单数："+iSumRevert+"/实际回退单数："+iSumRevert); %></td>
	<td class="coltext" >100%</td>
   </tr> 
  <tr><td width="30%" class="pagecontenttitle">组</td>
      <td width="35%" class="pagecontenttitle">数量<br></td>
      <td width="35%" class="pagecontenttitle">百分比<br></td>
  </tr>
  <%
 	}
  %>
  
</table></td></tr></table></td></tr></table>
</form>         
</body>
</html>
                
