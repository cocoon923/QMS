<%@include file="../allcheck.jsp"%>
<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat" />
<%@ include file= "../connections/con_start.jsp" %>

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
String Products="1";
String sDemand_Id="";

//获取系统时间
java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");    
Calendar   currentTime=Calendar.getInstance();
String sdate=df.format(currentTime.getTime()); //获取当前时间并格式化

  
//获取当前登录操作员
String sopId=(String)session.getValue("OpId");
if(sopId==null) sopId="";

//获取查询参数
String sStartTime="";
String sEndTime="";
String sProductId="";
String sGroupId="";
String sTestOpId="";
String sValue="";
String sStatus="";
String sStatusId="";
String sOper="";
Vector vStatDemand=new Vector();

sOper=request.getParameter("sOper");
if(sOper==null) sOper="";

if(sOper.equals("1"))//查询操作
{
	sStartTime=request.getParameter("sStartTime");
	if(sStartTime==null) sStartTime="";
	
	sEndTime=request.getParameter("sEndTime");
	if(sEndTime==null) sEndTime="";
	
	sProductId=request.getParameter("sProductId");
	if(sProductId==null) sProductId="";
	
	
	sStatus=request.getParameter("status");
	if(sStatus==null) sStatus="";
	if(!sStatus.equals(""))
	{
		if(sStatus.indexOf("0")>=0)
		{
			sStatusId=sStatusId+",1,2,3,4";
		}
		if(sStatus.indexOf("1")>=0)
		{
			sStatusId=sStatusId+",5,51";
		}
		sStatusId=sStatusId.replaceFirst(",","");
	}
	
	sGroupId=request.getParameter("sGroupId");
	if(sGroupId==null) sGroupId="";
	
	sTestOpId=request.getParameter("sTestId");
	if(sTestOpId==null) sTestOpId="";
	
	sValue=request.getParameter("sDemandId");
	if(sValue==null) sValue="";
	
	//out.print("<br>sStartTime="+sStartTime+"<br>sEndTime="+sEndTime+"<br>sProductId="+sProductId+"<br>sGroupId="+sGroupId+"<br>sTestOpId="+sTestOpId+"<br>sValue="+sValue+"<br>Products="+Products);
	vStatDemand=Stat.statdemand("1",sStartTime,sEndTime,sProductId,sStatusId,sGroupId,sTestOpId,sValue,Products);
}

%>

<%
	String ssql19=""; //获取指定子系统	
	String ssql51=""; //获取部门内所有组
	String ssql52=""; //获取部门内所有小组所有成员
	ResultSet rs19=null;		
	ResultSet rs51=null;
	ResultSet rs52=null;
	Statement stmt19 = conn.createStatement();
	Statement stmt51 = conn.createStatement();
	Statement stmt52 = conn.createStatement();
	try
	{
		ssql19 = " select product_id id,product_name,'['||product_id||'] '||product_name as name "
		      +" from product where product_id in ("+Products+") order by id ";
//		  out.println("ssql17="+ssql17+";\n");
		  try
		  {
			  rs19 = stmt19.executeQuery(ssql19);
		  }
	      catch(Exception e)
		 {
	       out.println(e.toString());
		  }
		
		ssql51="select group_id as id,'['||group_id||'] '||group_name as name from group_def order by id";
//	   out.println("ssql51="+ssql51+";\n");
	   if (ssql51!=null)
	  	{
			try
			{
				rs51 = stmt51.executeQuery(ssql51);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}


		ssql52="select a.group_id as upid,a.op_id as id,c.op_mail||' - '||c.op_name as name "
		      +" from group_op_info a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id order by name";
//	   out.println("ssql52="+ssql52+";\n");
	   if (ssql52!=null)
	  	{
			try
			{
				rs52 = stmt52.executeQuery(ssql52);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}
	 		
	}
	finally
	{
	}
%>

<title>StatIntf</title>

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


function querydemand(url)
{
	var starttime="";
	var endtime="";
	var productId="";
	var groupId="";
	var Opid="";
	var DemandId="";
	var status="";
	
	var bln=window.confirm("查询生成统计信息时间可能比较长，是否继续？\n\n点<确定>，继续；点<取消>，取消！"+"\n");	
	if(bln==true)
	{
	
		//获取统计开始时间
		if(document.StatDevTest.chk_rep_start_date.checked==true)
		{
			starttime = document.getElementById('repstarttime').value;
		}
		//获取统计结束时间
		if(document.StatDevTest.chk_rep_end_date.checked==true)
		{
			endtime = document.getElementById('rependtime').value;
		}
		//获取产品名称
	    var checkbox = document.getElementsByName("productid");     
	    for (var i = 0; i < checkbox.length; i++)   
	    {   
		    var sproductIdTemp="";
		    if (checkbox[i].checked)   
		    {   
				sproductIdTemp=',' + checkbox[i].value ;  
				productId = productId + sproductIdTemp; 
		    }   
	    }
	    productId = productId.replace(',',''); //去掉第一位逗号,用于拼sql用
	    
	    //获取状态id
	    var checkbox = document.getElementsByName("status");     
	    for (var i = 0; i < checkbox.length; i++)   
	    {   
		    var statusTemp="";
		    if (checkbox[i].checked)   
		    {   
				statusTemp=',' + checkbox[i].value ;  
				status = status + statusTemp; 
		    }   
	    }
	    status = status.replace(',',''); //去掉第一位逗号,用于拼sql用
	    
	    //获取归属组
	    var checkbox3 = document.getElementsByName("groupid");     
	    for (var k = 0; k < checkbox3.length; k++)   
	    {   
		    var sgroupIdTemp="";
		    if (checkbox3[k].checked)   
		    {   
				sgroupIdTemp = ',' + checkbox3[k].value;
				groupId =  groupId +  sgroupIdTemp
		    }
	    }
	    groupId = groupId.replace(',',''); //去掉第一位逗号,用于拼sql用
	    
	    Opid=document.getElementById('testopid').value;
	    DemandId=document.getElementById('demand_id').value;
	    
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
	    window.location=url+"&sStartTime="+starttime+"&sEndTime="+endtime+"&sProductId="+productId+"&status="+status+"&sGroupId="+groupId+"&sTestId="+Opid+"&sDemandId="+DemandId;    	
	
	}
}


function addDialogBox()
{ 
	var sOper="<%=sOper%>";
	var url="";
	var open_url="";
	var index="";
	var sDemand_Id="";
	
	var starttime="";
	var endtime="";
	var productId="";
	var groupId="";
	var Opid="";
	var DemandId="";
	var status="";
	
	//var starttime1="<%=sStartTime%>";
	//var endtime1="<%=sEndTime%>";
	//var productId1="<%=sProductId%>";
	//var groupId1="<%=sGroupId%>";
	//var Opid1="<%=sTestOpId%>";
	//var DemandId1="<%=sValue%>";
	//var status1="<%=sStatus%>";
	
	url = window.location.href;
	index=url.indexOf("QMS");
	open_url=url.substring(0,index);
	
	var bln=window.confirm("现只按照条件统计已生成统计信息的数据，未完成需求结果可能不准确。\n\n如需准确统计，请确认已先查询重新生成统计信息。\n\n是否继续统计？\n\n点<确定>，继续；点<取消>，取消！"+"\n");	
	if(bln==true)
	{
		//获取统计开始时间
		if(document.StatDevTest.chk_rep_start_date.checked==true)
		{
			starttime = document.getElementById('repstarttime').value;
		}
		//获取统计结束时间
		if(document.StatDevTest.chk_rep_end_date.checked==true)
		{
			endtime = document.getElementById('rependtime').value;
		}
		//获取产品名称
		var checkbox = document.getElementsByName("productid");     
		for (var i = 0; i < checkbox.length; i++)   
		{   
		    var sproductIdTemp="";
		    if (checkbox[i].checked)   
		    {   
				sproductIdTemp=',' + checkbox[i].value ;  
				productId = productId + sproductIdTemp; 
		    }   
		}
		productId = productId.replace(',',''); //去掉第一位逗号,用于拼sql用
		    
		//获取状态id
		var checkbox = document.getElementsByName("status");     
		for (var i = 0; i < checkbox.length; i++)   
		{   
		    var statusTemp="";
		    if (checkbox[i].checked)   
		    {   
				statusTemp=',' + checkbox[i].value ;  
				status = status + statusTemp; 
		    }   
		 }
		status = status.replace(',',''); //去掉第一位逗号,用于拼sql用
		    
		//获取归属组
		var checkbox3 = document.getElementsByName("groupid");     
		for (var k = 0; k < checkbox3.length; k++)   
		{   
		    var sgroupIdTemp="";
		    if (checkbox3[k].checked)   
		    {   
				sgroupIdTemp = ',' + checkbox3[k].value;
				groupId =  groupId +  sgroupIdTemp
		    }
		}
		groupId = groupId.replace(',',''); //去掉第一位逗号,用于拼sql用
		    
		Opid=document.getElementById('testopid').value;
		DemandId=document.getElementById('demand_id').value;
		    
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
		    
		window.open(open_url+"QMS/stat/Stat.StatInfo.jsp?sStartTime="+starttime+"&sEndTime="+endtime+"&sProductId="+productId+"&status="+status+"&sGroupId="+groupId+"&sTestId="+Opid+"&sDemandId="+DemandId);		    
	}
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StatDevTest" method="post">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>查询、统计条件：<br>
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
  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_rep_start_date" <%if(!sStartTime.equals("")) out.print("checked"); %>>
  <input name="repstarttime" type="text" class="inputstyle" id="repstarttime"  onClick="JSCalendar(this);"  value="<%if(!sStartTime.equals(""))out.print(sStartTime.substring(0,4)+"-"+sStartTime.substring(4,6)+"-"+sStartTime.substring(6,8));else out.print(sdate);%>" size="10">
                
  <tr>
  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">统计结束时间： </div>
  <div align="right"> </div></td>
  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_rep_end_date" <%if(!sEndTime.equals("")) out.print("checked"); %>>
  <input name="devstarttime" type="text" class="inputstyle" id="rependtime"  onClick="JSCalendar(this);"  value="<%if(!sEndTime.equals(""))out.print(sEndTime.substring(0,4)+"-"+sEndTime.substring(4,6)+"-"+sEndTime.substring(6,8));else out.print(sdate);%>" size="10">
  </tr>
                
  <tr class="contentbg">
  <td class="pagetitle1" style= "height: 40px; " >产品名称：</td>
  <td><class="pagetextdetails">
  <%
	while(rs19.next())
	{
  %>
  <input type="checkbox" value="<%=rs19.getString("id")%>" name="productid" id="productid" 
  <%
  	if(!sProductId.equals(""))
  	{
  		sProductId=","+sProductId+",";
  		if(sProductId.indexOf(","+rs19.getString("id")+",")>=0)
  		{
  			out.print("checked");
  		}
  	} 
  %>><font class="pagetextdetails"><%=rs19.getString("name")%>&nbsp;&nbsp;
  <%
	 }
  %>                
  </font></td>
  </tr>
  
  <tr>
  <td class="pagetitle1" style= "height: 40px; ">状态：</td>
  <td><class="pagetextdetails">
  <input type="checkbox" value="0"  name="status" id="status" 
  <%
  	if(sStatus.indexOf("0")>=0)
  	{
  		out.print("checked");
  	} 
  %>><font class="pagetextdetails">[0] 未完成需求&nbsp;&nbsp;
  <input type="checkbox" value="1"  name="status" id="status"
  <%
  	if(sStatus.indexOf("1")>=0)
  	{
  		out.print("checked");
  	} 
  %>><font class="pagetextdetails">[1] 已完成需求&nbsp;&nbsp;                
  </font></td>
  </tr>
  
  
                
  <tr class="contentbg">
  <td class="pagetitle1" style= "height: 40px; ">测试人归属组：</td>
  <td><class="pagetextdetails">
  <%
	while(rs51.next())
	{
  %>
  <input type="checkbox" value="<%=rs51.getString("id")%>"  name="groupid" id="groupid" 
  <%
  	if(!sGroupId.equals(""))
  	{
  		sGroupId=","+sGroupId+",";
  		if(sGroupId.indexOf(","+rs51.getString("id")+",")>=0)
  		{
  			out.print("checked");
  		}
  	} 
  %>><font class="pagetextdetails"><%=rs51.getString("name")%>&nbsp;&nbsp;
  <%
	 }
  %>                
  </font></td>
  </tr>
				
  <tr>
  <td class="pagetitle1" style= "height: 30px; ">测试人员：</td>
  <td><font color="#0000FF">
  <select style= "width: 550px; " name="testopid" class="inputstyle" id="testopid">
  <option value="" selected> -------------- 选择所有 -------------- </option>
  <%
	while(rs52.next())
	{
  %>
  <option value="<%=rs52.getString("id")%>" 
  <%
  	if(!sTestOpId.equals(""))
  	{
  		if(sTestOpId.equals(rs52.getString("id")))
  		{
  			out.print("selected");
  		}
  	} 
  %>><%=rs52.getString("name")%></option>
  <%
	 }
  %>
  </select>      
  </td>
  </tr>
                
  <tr class="contentbg">
  <td class="pagetitle1" style= "height: 30px; ">ID：</td>
  <td class="pagetextdetails">
  <input name="demand_id" type="text" class="inputstyle" id="demand_id"   size="35" <%if(!sValue.equals("")) out.print("value="+sValue); %>>(注：可输入多个编号，用英文逗号分隔，例如：1,2,3)
  </td></tr>
                
  <tr>
  <td class="pagetitle1">&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
  </table></td></tr></table>
  
  <tr><td><div align="left"><table width="146" border="0" cellspacing="5" cellpadding="5"><tr>
  
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="querydemand(/*href*/'Stat.DevTestTime.jsp?sOper=1')">查 询</td>
  </tr>
  </table></td>                  
                    
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="addDialogBox()">统 计</td>
  </tr>
  </table></td>
  </tr></table></div></td></tr>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title"> 
  <td>统计需求列表：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">ID</td>
      <td width="20%" class="pagecontenttitle">编号</td>
      <td width="55%" class="pagecontenttitle">描述<br></td>
      <td width="20%" class="pagecontenttitle">状态<br></td>
  </tr>
  <%
  	  String demandid;
  	  String demanddesc;
  	  String demandstatus;
  	  String status;
  	  int i=0;
  	  //out.print("vStatDemand.size()="+vStatDemand.size());
  	  if(vStatDemand.size()>0)
  	  {
  		for(int j=0;j<vStatDemand.size();j++)
  		{
  			i++;
  			HashMap StatDemandhash = (HashMap) vStatDemand.get(j);
  			demandid=(String) StatDemandhash.get("DEMAND_ID");
  			demanddesc=(String) StatDemandhash.get("DEMAND_TITLE");
  			demandstatus=(String) StatDemandhash.get("STA_NAME");
  			status=(String) StatDemandhash.get("STATUS");
  			sDemand_Id=sDemand_Id+","+demandid;
  %>
  <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=i%>)</td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=<%=demandid %>" target="_blank"><%=demandid %></a></td>
	<td class="<%if(i%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=demanddesc %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=demandstatus %></td>
  </tr>  
  <%			
  		  	//判断需求是否生成统计信息
  		  	Stat.StatInfo("1",demandid,status);
  		}  			
  	  }
  %>
  <tr><td width="5%" class="pagecontenttitle">ID<input type="hidden" value="<%if(sDemand_Id!=null) out.print(sDemand_Id);%>" name="sDemand_Id" id="sDemand_Id"></td>
      <td width="20%" class="pagecontenttitle">编号</td>
      <td width="55%" class="pagecontenttitle">描述<br></td>
      <td width="20%" class="pagecontenttitle">状态<br></td>
  </tr>

</table></td></tr></table></td></tr></table></form>         
</body>
<%@ include file= "../connections/con_end.jsp" %>
</html>
                
