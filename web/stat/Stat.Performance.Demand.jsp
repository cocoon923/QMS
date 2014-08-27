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
sGroupId=request.getParameter("GroupId");
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
//out.print("sProducts="+sProducts);
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


Vector vDemandSccbTime=new Vector();
Vector vDemandSccbDemandTime=new Vector();
int iDemandSccbTimeCount=0;
int iDemandSccbDemandTime=0;

if(sOper.equals("1")) //ͳ��
{
	vDemandSccbTime=Stat_Performance.getDemandSCCBTime(sProducts,sGroupType,sGroupId,sStartTime,sEndTime); //ͳ��SCCB�������󻨷�ʱ��
	iDemandSccbTimeCount=vDemandSccbTime.size();
	
	vDemandSccbDemandTime=Stat_Performance.getDemandSCCBDemandTime(sProducts,sGroupType,sGroupId,sStartTime,sEndTime);//ͳ��SCCB����������ɵ�ƽ��ʱ��
	iDemandSccbDemandTime=vDemandSccbTime.size();
}



%>



<title>StatPerformanceDemand</title>

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
	if(document.StartPerformanceDemand.chk_start_date.checked==true)
	{
		starttime = document.getElementById('repstarttime').value;
	}
	//��ȡͳ�ƽ���ʱ��
	if(document.StartPerformanceDemand.chk_end_date.checked==true)
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
	window.location=url+"&sStartTime="+starttime+"&sEndTime="+endtime+"&GroupType="+grouptype+"&GroupId="+groupid;	
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StartPerformanceDemand" method="post">

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
  <input type="hidden" value="<%out.print(sGroupType);%>" name="Group_Type" id="Group_Type">
  </tr>

  <tr class="contentbg">
  <td class="pagetitle1" style= "height: 40px; " >ͳ���飺</td>
  <td><class="pagetextdetails">
  <%
	   String sgroupid="";
	   String sgroupname="";
  	   if(vGroupInfo.size()>0)
  	   {
  	   	  for(int i=0;i<vGroupInfo.size();i++)
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
  %> 
  ><font class="pagetextdetails"><%="["+sgroupid+"]"+sgroupname%>&nbsp;&nbsp;
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
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="statInfo(/*href*/'Stat.Performance.Demand.jsp?sOper=1')">ͳ ��</td>
  </tr>
  </table></td>
  </tr></table></div></td></tr>
  
<%
  	if(iDemandSccbTimeCount>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>SCCB/PM������������ƽ��ʱ��:<br></td>
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
  	   if(vDemandSccbTime.size()>0)
  	   {
  	   	  for(int i=0;i<vDemandSccbTime.size();i++)
  	   	  {
  	   	  	HashMap DemandSccbTimeHash = (HashMap) vDemandSccbTime.get(i);
  	   	  	sopname = (String)DemandSccbTimeHash.get("OP_NAME");
  	   	  	scount = (String)DemandSccbTimeHash.get("COUNT");
  	   	  	stotaltime = (String)DemandSccbTimeHash.get("TOTALTIME");
  	   	  	stime = (String)DemandSccbTimeHash.get("TIME");
  	   	  	sgroup_id = (String)DemandSccbTimeHash.get("GROUPID");
  	   	  	sgroup_name = (String)DemandSccbTimeHash.get("GROUPNAME");
  	   	  	
  	   	  	 	   	  	
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
  	if(iDemandSccbDemandTime>0)
  	{
%>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>SCCB/PM����������ȫ�������ƽ��ʱ�䣨ֻͳ�Ʋ�����ɵ����󣬰������������Թ��̣�:<br></td>
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
  	   String sopname1="";
  	   String scount1="";
  	   String stotaltime1="";
  	   String stime1="";
  	   String sgroup_id1="";
  	   String sgroup_name1="";
  	   if(vDemandSccbDemandTime.size()>0)
  	   {
  	   	  for(int i=0;i<vDemandSccbDemandTime.size();i++)
  	   	  {
  	   	  	HashMap DemandSccbDemandTimeHash = (HashMap) vDemandSccbDemandTime.get(i);
  	   	  	sopname1 = (String)DemandSccbDemandTimeHash.get("OP_NAME");
  	   	  	scount1 = (String)DemandSccbDemandTimeHash.get("COUNT");
  	   	  	stotaltime1 = (String)DemandSccbDemandTimeHash.get("TOTALTIME");
  	   	  	stime1 = (String)DemandSccbDemandTimeHash.get("TIME");
  	   	  	sgroup_id1 = (String)DemandSccbDemandTimeHash.get("GROUPID");
  	   	  	sgroup_name1 = (String)DemandSccbDemandTimeHash.get("GROUPNAME");
  	   	  	 	   	  	
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
      <td width="20%" class="pagecontenttitle">������<br></td>
      <td width="20%" class="pagecontenttitle">����ʱ���죩<br></td>
      <td width="20%" class="pagecontenttitle">ƽ����ʱ���죩<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
<%
	}
 %>

</form>         
</body>
</html>
                
