<%@include file="../allcheck.jsp"%>
<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat" />


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
String Products="1,2";
//获取查询参数
String sDemand_Id="";
String sCondition="";
String sStartTime="";
String sEndTime="";
String sProductId="";
String sGroupId="";
String sTestOpId="";
String sValue="";
String sStatus="";
String sStatusId="";
String demandid="";

Vector vStatDemand=new Vector();

sStartTime=request.getParameter("sStartTime");
if(sStartTime==null) sStartTime="";
if(!sStartTime.equals("")) sCondition=sCondition+"sStartTime:"+sStartTime+";";
	
sEndTime=request.getParameter("sEndTime");
if(sEndTime==null) sEndTime="";
if(!sEndTime.equals("")) sCondition=sCondition+"sEndTime:"+sEndTime+";";
	
sProductId=request.getParameter("sProductId");
if(sProductId==null) sProductId="";
if(!sProductId.equals("")) sCondition=sCondition+"sProductId:"+sProductId+";";
	
sStatus=request.getParameter("status");
if(sStatus==null) sStatus="";
if(!sStatus.equals("")) sCondition=sCondition+"sStatus:"+sStatus+";";
if(!sStatus.equals(""))
{
	if(sStatus.indexOf("0")>=0)
	{
		sStatusId=sStatusId+",1,2,3,4";
	}
	if(sStatus.indexOf("1")>=0)
	{
		sStatusId=sStatusId+",5";
	}
	sStatusId=sStatusId.replaceFirst(",","");
}
	
sGroupId=request.getParameter("sGroupId");
if(sGroupId==null) sGroupId="";
if(!sGroupId.equals("")) sCondition=sCondition+"sGroupId:"+sGroupId+";";
	
sTestOpId=request.getParameter("sTestId");
if(sTestOpId==null) sTestOpId="";
if(!sTestOpId.equals("")) sCondition=sCondition+"sTestOpId:"+sTestOpId+";";
	
sValue=request.getParameter("sDemandId");
if(sValue==null) sValue="";
if(!sValue.equals("")) sCondition=sCondition+"sValue:"+sValue+";";


//处理显示的统计条件内容
if(!sCondition.equals(""))
{
	sCondition=sCondition.replaceAll("sStartTime:"," 开始时间:");
	sCondition=sCondition.replaceAll("sEndTime:"," 结束时间:");
	sCondition=sCondition.replaceAll("sProductId:"," 产品:");
	sCondition=sCondition.replaceAll("sStatus:"," 状态:");
	sCondition=sCondition.replaceAll("sGroupId:"," 组:");
	sCondition=sCondition.replaceAll("sTestOpId:"," 测试人员:");
	sCondition=sCondition.replaceAll("sValue:"," 需求编号:");	
}


//获取统计信息
Vector vStatInfo=new Vector();
Vector vStatDetailInfo=new Vector();
String sDevTimeSum="";
String sQaTimeSum="";
String sDevTimePer="";
String sQaTimePer="";
int iCount=0;

//获取统计的汇总信息
vStatInfo=Stat.QueryStatInfoAll("1",sStartTime,sEndTime,sProductId,sStatusId,sGroupId,sTestOpId,sValue,Products,"");
if(vStatInfo.size()>0)
{
	for(int i=0;i<vStatInfo.size();i++)
	{
		HashMap StatInfoHash = (HashMap) vStatInfo.get(i);
		sDevTimeSum = (String) StatInfoHash.get("DEVTIME");
		sQaTimeSum = (String) StatInfoHash.get("QATIME");
		sDevTimePer = (String) StatInfoHash.get("DEV_TIME_PER");
		sQaTimePer = (String) StatInfoHash.get("QA_TIME_PER");			
	}
}	
//获取统计的明细信息
vStatDetailInfo=Stat.QueryStatDetailInfoAll("1",sStartTime,sEndTime,sProductId,sStatusId,sGroupId,sTestOpId,sValue,Products,"");
iCount=vStatDetailInfo.size();

%>



<title>StatInfo</title>

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
<form name="StatDevTest" method="post" onSubmit="">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>统计信息汇总：<br>
  </td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>  </tr>
  
  <tr> 
  <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="contentbg">
  <td width="20%" class="pagetitle1" style= "height: 40px; "><div align="left">统计条件： </div>
  <div align="right"> </div></td>
  <td width="80%" class="pagetextdetails"><%=sCondition %>
  </td></tr>

                
  <tr>
  <td width="20%" class="pagetitle1" style= "height: 40px; "><div align="left">统计总需求数： </div>
  <div align="right"> </div></td>
  <td width="80%" class="pagetextdetails"><%if(iCount>0) out.print(iCount); %>
  </tr>
                
  <tr class="contentbg">
  <td width="20%" class="pagetitle1" style= "height: 40px; "><div align="left">开发时间（合计）： </div>
  <div align="right"> </div></td>
  <td width="80%" class="pagetextdetails"><%if(iCount>0) out.print(sDevTimeSum+"天 [ 所占比例："+sDevTimePer+" ]"); %>
  </tr>
                
  <tr>
  <td width="20%" class="pagetitle1" style= "height: 40px; "><div align="left">测试时间（合计）： </div>
  <div align="right"> </div></td>
  <td width="80%" class="pagetextdetails"><%if(iCount>0) out.print(sQaTimeSum+"天 [ 所占比例："+sQaTimePer+" ]"); %>
  </tr>				
                
  <tr class="contentbg">
  <td class="pagetitle1">&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
  </table></td></tr></table>
  
  <tr><td><div align="left"><table width="146" border="0" cellspacing="5" cellpadding="5"><tr>
  
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="window.open('Stat.DevTestTimeExportExcel.jsp?sStartTime=<%=sStartTime %>&sEndTime=<%=sEndTime%>&sProductId=<%=sProductId%>&status=<%=sStatus%>&sGroupId=<%=sGroupId%>&sTestId=<%=sTestOpId%>&sDemandId=<%=demandid%>')">导出明细</td>
  </tr>
  </table></td>                  
                    
  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="window.close()">关 闭</td>
  </tr>
  </table></td>
  </tr></table></div></td></tr>
  
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>开发/测试时间 统计详细信息：<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">ID</td>
      <td width="5%" class="pagecontenttitle">编号</td>
      <td width="48%" class="pagecontenttitle">描述<br></td>
      <td width="10%" class="pagecontenttitle">完成时间<br></td>
      <td width="8%" class="pagecontenttitle">开发时间<br>(单位：天)<br></td>
      <td width="8%" class="pagecontenttitle">测试时间<br>(单位：天)<br></td>
      <td width="8%" class="pagecontenttitle">开发时间比例<br></td>
      <td width="8%" class="pagecontenttitle">测试时间比例<br></td>
  </tr>
  <%
  		int j=0;
  		String sdemandid="";
  		String sdemanddesc="";
  		String sdevtime="";
  		String sqatime="";
  		String sdevtimeper="";
  		String sqatimeper="";
  		String sclosetime="";
  		
  		if(vStatDetailInfo.size()>0)
  		{
  			for(int k=0;k<vStatDetailInfo.size();k++)
  			{
  				j++;
  				HashMap StatInfoDetailHash = (HashMap) vStatDetailInfo.get(k);
				sdemandid = (String) StatInfoDetailHash.get("DEMAND_ID");
				sdemanddesc = (String) StatInfoDetailHash.get("DEMAND_TITLE");
				sclosetime = (String) StatInfoDetailHash.get("CLOSETIME");
				sdevtime = (String) StatInfoDetailHash.get("DEVTIME");
				sqatime = (String) StatInfoDetailHash.get("QATIME");
				sdevtimeper = (String) StatInfoDetailHash.get("DEVTIMEPER");
				sqatimeper = (String) StatInfoDetailHash.get("QATIMEPER");
  %>
    <tr> 
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=j%>)</td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=<%=sdemandid %>" target="_blank"><%=sdemandid %></a></td>
	<td class="<%if(j%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=sdemanddesc %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%if(sclosetime==null || sclosetime.equals("")) out.print("未完成需求");else out.print(sclosetime); %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sdevtime %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sqatime %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sdevtimeper %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sqatimeper %></td>
  </tr>  
  
  <%			
  			}
  		}
  		
  %>
  
  <tr><td width="5%" class="pagecontenttitle">ID</td>
      <td width="5%" class="pagecontenttitle">编号</td>
      <td width="48%" class="pagecontenttitle">描述<br></td>
      <td width="10%" class="pagecontenttitle">完成时间<br></td>
      <td width="8%" class="pagecontenttitle">开发时间<br>(单位：天)<br></td>
      <td width="8%" class="pagecontenttitle">测试时间<br>(单位：天)<br></td>
      <td width="8%" class="pagecontenttitle">开发时间比例<br></td>
      <td width="8%" class="pagecontenttitle">测试时间比例<br></td>
  </tr>

</table></td></tr></table></td></tr></table>
</form>         
</body>
</html>
                
