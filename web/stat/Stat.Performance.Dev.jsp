<%@include file="../allcheck.jsp"%>
<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat" />
<jsp:useBean id="Stat_Performance" scope="page" class="dbOperation.Stat_Performance" />

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
//��ȡͳ��������
String sGroupType;
sGroupType=request.getParameter("GroupType");
//out.print("sGroupType="+sGroupType);
if(sGroupType==null)
{
	sGroupType="0";
}

//��ȡͳ����ID
String sGroupId;
sGroupId=request.getParameter("sGroupId");
if(sGroupId==null)
{
	sGroupId="";
}
//out.print("sGroupId="+sGroupId);

//��ȡͳ�Ʋ�Ʒ
String sProducts="";
String sProductTemp="";
Vector vProducts=new Vector();
vProducts=Stat_Performance.getGroupProductByGroup(sGroupType,"");
if(vProducts.size()>0)
{
  for(int i=0;i<vProducts.size();i++)
  {
  	 HashMap ProductsHash = (HashMap) vProducts.get(i);
  	 sProductTemp = (String)ProductsHash.get("PRODUCT_ID");
  	 sProducts = sProducts + "," + sProductTemp;
  }
}
sProducts = sProducts.replaceFirst(",",""); //ȥ����һλ�Ķ��š�

//��ȡϵͳʱ��
java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");    
Calendar   currentTime=Calendar.getInstance();
String sdate=df.format(currentTime.getTime()); //��ȡ��ǰʱ�䲢��ʽ��

//��ȡ��ѯ����
String sStartTime="";
String sEndTime="";
String sOper="";

sOper=request.getParameter("sOper");
if(sOper==null) sOper="";

sStartTime=request.getParameter("sStartTime");
if(sStartTime==null) sStartTime="";

sEndTime=request.getParameter("sEndTime");
if(sEndTime==null) sEndTime="";


Vector vGroupInfo = new Vector();
vGroupInfo = Stat_Performance.getGroupOpByType("1",sGroupType); //��ȡ��������Ϊ1������Э���� �ķ�����Ϣ��


Vector vDemandDevTime=new Vector();
Vector vDemandDevDemandTime=new Vector();
Vector vDevBugTime=new Vector();
Vector vDevAssignmentBugCount=new Vector();
Vector vProjectRequestCount=new Vector();
Vector vAuditCount=new Vector();
int iDemandDevTimeCount=0;
int iDemandDevDemandTime=0;
int iDevBugTimeCount=0;
int iDevAssignmentBugCount=0;
int iProjectRequestCount=0;
int iAuditCount=0;

if(sOper.equals("1")) //ͳ��
{
	vDemandDevTime=Stat_Performance.getDemandDevDemandTime(sProducts,sGroupType,sGroupId,sStartTime,sEndTime); //ͳ��DEV�����������ƽ������ʱ��
	iDemandDevTimeCount=vDemandDevTime.size();
	
	vDemandDevDemandTime=Stat_Performance.getDevAssignmentTime(sProducts,sGroupType,sGroupId,sStartTime,sEndTime);//ͳ��DEV�������������ɵ�ƽ��ʱ��
	iDemandDevDemandTime=vDemandDevDemandTime.size();

	vDevBugTime=Stat_Performance.getBugTime(sGroupType,sGroupId,sStartTime,sEndTime);//ͳ��DEV����BUG����ɵ�ƽ��ʱ��
	iDevBugTimeCount=vDevBugTime.size();	
	
	vDevAssignmentBugCount=Stat_Performance.getAssignmentBugCount(sGroupType,sGroupId,sStartTime,sEndTime);//ͳ��DEV����������񵥲�����bug�������ٷֱ�
	iDevAssignmentBugCount=vDevAssignmentBugCount.size();	
	
	vProjectRequestCount=Stat_Performance.getProjectRequestCount(sProducts,sStartTime,sEndTime);//����Ʒͳ�Ʋ�����Ч������
	iProjectRequestCount=vProjectRequestCount.size();	
	
	vAuditCount=Stat_Performance.getAuditCount(sProducts,sGroupType,sGroupId,sStartTime,sEndTime);//ͳ����������
	iAuditCount=vAuditCount.size();
}



%>



<title>StatPerformanceDev</title>

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
	var grouptype="";
	var groupid="";

	//��ȡͳ�ƿ�ʼʱ��
	if(document.StatPerformanceDev.chk_start_date.checked==true)
	{
		starttime = document.getElementById('repstarttime').value;
	}
	//��ȡͳ�ƽ���ʱ��
	if(document.StatPerformanceDev.chk_end_date.checked==true)
	{
		endtime = document.getElementById('rependtime').value;
	}
	//��ȡgroup_type����
	grouptype = document.getElementById('Group_Type').value;
	if(grouptype=="")
	{
		grouptype="0";
	}
	//��ȡgroup_id��ֵ
    var checkbox = document.getElementsByName("groupid");     
    for (var i = 0; i < checkbox.length; i++)   
    {   
	    var sgroupidTemp="";
	    if (checkbox[i].checked)   
	    {   
			sgroupidTemp=',' + checkbox[i].value ;  
			groupid = groupid + sgroupidTemp; 
	    }   
    }
    groupid = groupid.replace(',',''); //ȥ����һλ����,����ƴsql��    
	    
	//����ʱ���ʽΪ��YYYYMMDDhh24miss
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
	window.location=url+"&sStartTime="+starttime+"&sEndTime="+endtime+"&GroupType="+grouptype+"&sGroupId="+groupid;	
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StatPerformanceDev" method="post">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>��ѯ��ͳ��������<br>
  </td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="contentbg">
  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">ͳ�ƿ�ʼʱ�䣺 </div>
  <div align="right"> </div></td>
  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_start_date" <%if(!sStartTime.equals("")) out.print("checked"); %>>
  <input name="repstarttime" type="text" class="inputstyle" id="repstarttime"  onClick="JSCalendar(this);"  value="<%if(!sStartTime.equals(""))out.print(sStartTime.substring(0,4)+"-"+sStartTime.substring(4,6)+"-"+sStartTime.substring(6,8));else out.print(sdate);%>" size="10">
                
  <tr>
  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">ͳ�ƽ���ʱ�䣺 </div>
  <div align="right"> </div></td>
  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_end_date" <%if(!sEndTime.equals("")) out.print("checked"); %>>
  <input name="devstarttime" type="text" class="inputstyle" id="rependtime"  onClick="JSCalendar(this);"  value="<%if(!sEndTime.equals("")) out.print(sEndTime.substring(0,4)+"-"+sEndTime.substring(4,6)+"-"+sEndTime.substring(6,8));else out.print(sdate);%>" size="10">
  <input type="hidden" value="<%out.print(sGroupType);%>" name="Group_Type">
  </tr>

  <tr class="contentbg">
  <td class="pagetitle1" style= "height: 40px; " >ͳ���飺</td>
  <td><class="pagetextdetails">
  <%
	   String sgroupid="";
	   String sgroupname="";
  	   if(vGroupInfo.size()>0)
  	   {
  	   	  for(int i=vGroupInfo.size()-1;i>=0;i--)
  	   	  {
  	   	  	HashMap GroupInfoHash = (HashMap) vGroupInfo.get(i);
  	   	  	sgroupid = (String)GroupInfoHash.get("STAT_GROUP_ID");
  	   	  	sgroupname= (String)GroupInfoHash.get("STAT_GROUP_NAME");
  %>

  <input type="checkbox" value="<%=sgroupid%>" name="groupid" 
  <%
  	if(!sGroupId.equals("")) 
  	{
  		sGroupId="," + sGroupId + ",";
  		String sgroupidTemp=","+sgroupid+",";
  		if(sGroupId.indexOf(sgroupidTemp)>=0)
  		{
  		  	out.print("checked"); 
  		}
  	}
  %> ><font class="pagetextdetails"><%="["+sgroupid+"]"+sgroupname%>&nbsp;&nbsp;
  <%
		 }
	}
  %>                
  </font></td></tr>
  
  <tr class="contentbg1">
  <td class="pagetitle1">&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
  </table></td></tr></table>
  
  <tr><td><div align="left"><table width="146" border="0" cellspacing="5" cellpadding="5"><tr>
   
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="statInfo(/*href*/'Stat.Performance.Dev.jsp?sOper=1')">ͳ ��</td>
  </tr>
  </table></td>
  </tr></table></div></td></tr>
  
<%
  	if(iDemandDevTimeCount>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>������Ա������������ƽ��ʱ��:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">������<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
  <%
  	   String sopname="";
  	   String scount="";
  	   String stotaltime="";
  	   String stime="";
  	   String sgroup_id="";
  	   String sgroup_name="";
  	   if(vDemandDevTime.size()>0)
  	   {
  	   	  for(int i=0;i<vDemandDevTime.size();i++)
  	   	  {
  	   	  	HashMap DemandDevTimeHash = (HashMap) vDemandDevTime.get(i);
  	   	  	sopname = (String)DemandDevTimeHash.get("OP_NAME");
  	   	  	scount = (String)DemandDevTimeHash.get("COUNT");
  	   	  	stotaltime = (String)DemandDevTimeHash.get("TOTALTIME");
  	   	  	stime = (String)DemandDevTimeHash.get("TIME");
  	   	  	sgroup_id = (String)DemandDevTimeHash.get("GROUPID");
  	   	  	sgroup_name = (String)DemandDevTimeHash.get("GROUPNAME");
  	   	  	 	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%="["+sgroup_id+"]"+ sgroup_name %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=stotaltime %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=stime %></td>
   </tr>   
  <%	   	  	
  	   	  }
  	   }
  %>
  
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">������<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
<%
	}
 %>
 
 <%
  	if(iDemandDevDemandTime>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>������Ա���������������ƽ��ʱ�䣨ֻͳ�Ʋ�����ɵ����񵥣����������������Թ��̣�:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">���������<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
  <%
  	   String sopname1="";
  	   String scount1="";
  	   String stotaltime1="";
  	   String stime1="";
  	   String sgroup_id1="";
  	   String sgroup_name1="";
  	   if(vDemandDevDemandTime.size()>0)
  	   {
  	   	  for(int i=0;i<vDemandDevDemandTime.size();i++)
  	   	  {
  	   	  	HashMap DemandDevDemandTimeHash = (HashMap) vDemandDevDemandTime.get(i);
  	   	  	sopname1 = (String)DemandDevDemandTimeHash.get("OP_NAME");
  	   	  	scount1 = (String)DemandDevDemandTimeHash.get("COUNT");
  	   	  	stotaltime1 = (String)DemandDevDemandTimeHash.get("TOTALTIME");
  	   	  	stime1 = (String)DemandDevDemandTimeHash.get("TIME");
  	   	  	sgroup_id1 = (String)DemandDevDemandTimeHash.get("GROUPID");
  	   	  	sgroup_name1 = (String)DemandDevDemandTimeHash.get("GROUPNAME");
  	   	  	 	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname1 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%="["+sgroup_id1+"]"+ sgroup_name1 %></td>	
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount1 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=stotaltime1 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=stime1 %></td>
   </tr>   
  <%	   	  	
  	   	  }
  	   }
  %>
  
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">���������<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
<%
	}
 %>

<%
  	if(iDevBugTimeCount>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>������Ա���BUG��ɵ�ƽ��ʱ��:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">BUG��<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
  <%
  	   String sopname2="";
  	   String scount2="";
  	   String stotaltime2="";
  	   String stime2="";
  	   String sgroup_id2="";
  	   String sgroup_name2="";
  	   if(vDevBugTime.size()>0)
  	   {
  	   	  for(int i=0;i<vDevBugTime.size();i++)
  	   	  {
  	   	  	HashMap DevBugTimeHash = (HashMap) vDevBugTime.get(i);
  	   	  	sopname2 = (String)DevBugTimeHash.get("OPNAME");
  	   	  	scount2 = (String)DevBugTimeHash.get("COUNT");
  	   	  	stotaltime2 = (String)DevBugTimeHash.get("TOTALTIME");
  	   	  	stime2 = (String)DevBugTimeHash.get("TIME");
  	   	  	sgroup_id2 = (String)DevBugTimeHash.get("GROUPID");
  	   	  	sgroup_name2 = (String)DevBugTimeHash.get("GROUPNAME");
  	   	  	 	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname2 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%="["+sgroup_id2+"]"+ sgroup_name2 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount2 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=stotaltime2 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=stime2 %></td>
   </tr>   
  <%	   	  	
  	   	  }
  	   }
  %>
  
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">BUG��<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
<%
	}
 %>
 
 <%
  	if(iDevAssignmentBugCount>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>������Ա������񵥼�����BUG����������:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">BUG��<br></td>
      <td width="20%" class="pagecontenttitle">������<br></td>
      <td width="20%" class="pagecontenttitle">BUG/���񵥰ٷֱ�<br></td>
  </tr>
  <%
  	   String sopname3="";
  	   String bugscount3="";
  	   String assignmentcount3="";
  	   String per3="";
  	   String sgroup_id3="";
  	   String sgroup_name3="";
  	   if(vDevAssignmentBugCount.size()>0)
  	   {
  	   	  for(int i=0;i<vDevAssignmentBugCount.size();i++)
  	   	  {
  	   	  	HashMap DevAssignmentBugCountHash = (HashMap) vDevAssignmentBugCount.get(i);
  	   	  	sopname3 = (String)DevAssignmentBugCountHash.get("OPNAME");
  	   	  	bugscount3 = (String)DevAssignmentBugCountHash.get("SUM");
  	   	  	assignmentcount3 = (String)DevAssignmentBugCountHash.get("ASSIGNMENT");
  	   	  	per3 = (String)DevAssignmentBugCountHash.get("PER");
  	   	  	sgroup_id3 = (String)DevAssignmentBugCountHash.get("GROUPID");
  	   	  	sgroup_name3 = (String)DevAssignmentBugCountHash.get("GROUPNAME");
  	   	  	 	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname3 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%="["+sgroup_id3+"]"+ sgroup_name3 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=bugscount3 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=assignmentcount3 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=per3 %></td>
   </tr>   
  <%	   	  	
  	   	  }
  	   }
  %>
  
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">BUG��<br></td>
      <td width="20%" class="pagecontenttitle">������<br></td>
      <td width="20%" class="pagecontenttitle">BUG/���񵥰ٷֱ�<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
<%
	}
 %>
 
  <%
  	if(iProjectRequestCount>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>��Ʒ������������������:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="25%" class="pagecontenttitle">��Ʒ����</td>
  	  <td width="25%" class="pagecontenttitle">��Ч������</td>
      <td width="25%" class="pagecontenttitle">����������<br></td>
      <td width="25%" class="pagecontenttitle">����/����ٷֱ�<br></td>
  </tr>
  <%
  	   String productname4="";
  	   String faultcount4="";
  	   String demandcount4="";
  	   String per4="";

  	   if(vProjectRequestCount.size()>0)
  	   {
  	   	  for(int i=0;i<vProjectRequestCount.size();i++)
  	   	  {
  	   	  	HashMap DProjectRequestCountHash = (HashMap) vProjectRequestCount.get(i);
  	   	  	productname4 = (String)DProjectRequestCountHash.get("PRODUCTNAME");
  	   	  	faultcount4 = (String)DProjectRequestCountHash.get("FAULTCOUNT");
  	   	  	demandcount4 = (String)DProjectRequestCountHash.get("DEMANDCOUNT");
  	   	  	per4 = (String)DProjectRequestCountHash.get("PER");

  	   	  	 	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=productname4 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=faultcount4 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=demandcount4 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=per4 %></td>
   </tr>   
  <%	   	  	
  	   	  }
  	   }
  %>
  
  <tr><td width="25%" class="pagecontenttitle">��Ʒ����</td>
  	  <td width="25%" class="pagecontenttitle">��Ч������</td>
      <td width="25%" class="pagecontenttitle">����������<br></td>
      <td width="25%" class="pagecontenttitle">����/����ٷֱ�<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
<%
	}
 %>
 
<%
  	if(iAuditCount>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>��������ͳ��:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
<tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">��Ч������<br></td>
      <td width="20%" class="pagecontenttitle">��Ч������<br></td>
      <td width="20%" class="pagecontenttitle">��������<br></td>
  </tr>
  <%
  	   String sopname5="";
  	   String okcount5="";
  	   String failcount5="";
  	   String sum5="";
  	   String sgroup_id5="";
  	   String sgroup_name5="";
  	   if(vAuditCount.size()>0)
  	   {
  	   	  for(int i=0;i<vAuditCount.size();i++)
  	   	  {
  	   	  	HashMap AuditCountHash = (HashMap) vAuditCount.get(i);
  	   	  	sopname5 = (String)AuditCountHash.get("OPNAME");
  	   	  	okcount5 = (String)AuditCountHash.get("OK");
  	   	  	failcount5 = (String)AuditCountHash.get("FAIL");
  	   	  	sum5 = (String)AuditCountHash.get("SUMCOUNT");
  	   	  	sgroup_id5 = (String)AuditCountHash.get("GROUPID");
  	   	  	sgroup_name5 = (String)AuditCountHash.get("GROUPNAME");
  	   	  	 	   	  	
  %>
    <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname5 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%="["+sgroup_id5+"]"+ sgroup_name5 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=okcount5 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=failcount5 %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sum5 %></td>
   </tr>   
  <%	   	  	
  	   	  }
  	   }
  %>
  
  <tr><td width="20%" class="pagecontenttitle">��Ա����</td>
  	  <td width="20%" class="pagecontenttitle">��Ա������</td>
      <td width="20%" class="pagecontenttitle">��Ч������<br></td>
      <td width="20%" class="pagecontenttitle">��Ч������<br></td>
      <td width="20%" class="pagecontenttitle">��������<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

<%
	}
 %>

</form>         
</body>
</html>
                
