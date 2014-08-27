<%@ page contentType="application/msexcel; charset=gb2312" import="java.util.*,java.io.*,java.sql.*"   language="java"%>
<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat" />

<html>

<head>
<title>需求开发、测试时间统计明细信息导出</title>

<style type="text/css">
.style1 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid white;
	border-right: 1.0pt solid white;
	border-top: 1.0pt solid white;
	border-bottom-style: none;
	border-bottom-color: inherit;
	border-bottom-width: medium;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: #CCCCCC;
}
.style2 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid white;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top: 1.0pt solid white;
	border-bottom-style: none;
	border-bottom-color: inherit;
	border-bottom-width: medium;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: #CCCCCC;
}
.style3 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid white;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom-style: none;
	border-bottom-color: inherit;
	border-bottom-width: medium;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: #CCCCCC;
}
.style4 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid #CCCCCC;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom: 1.0pt solid #CCCCCC;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: white;
}
.style5 {
	color: blue;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: underline;
	font-family: 宋体;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid #CCCCCC;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom: 1.0pt solid #CCCCCC;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: white;
}
.style6 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: left;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid #CCCCCC;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom: 1.0pt solid #CCCCCC;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: white;
}
.style7 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid #CCCCCC;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom: 1.0pt solid #CCCCCC;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: #F9F9F9;
}
.style8 {
	color: blue;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: underline;
	font-family: 宋体;
	text-align: center;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid #CCCCCC;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom: 1.0pt solid #CCCCCC;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: #F9F9F9;
}
.style9 {
	color: #666666;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: ??, sans-serif;
	text-align: left;
	vertical-align: middle;
	white-space: normal;
	border-left: 1.0pt solid #CCCCCC;
	border-right-style: none;
	border-right-color: inherit;
	border-right-width: medium;
	border-top-style: none;
	border-top-color: inherit;
	border-top-width: medium;
	border-bottom: 1.0pt solid #CCCCCC;
	padding-left: 1px;
	padding-right: 1px;
	padding-top: 1px;
	background: #F9F9F9;
}
</style>

</head>

<%
String Products="1,2";
//获取查询参数
String sDemand_Id="";
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
		sStatusId=sStatusId+",5";
	}
	sStatusId=sStatusId.replaceFirst(",","");
}
	
sGroupId=request.getParameter("sGroupId");
if(sGroupId==null) sGroupId="";
	
sTestOpId=request.getParameter("sTestId");
if(sTestOpId==null) sTestOpId="";
	
sValue=request.getParameter("sDemandId");
if(sValue==null) sValue="";

//获取统计的明细信息
Vector vStatDetailInfo=new Vector();
vStatDetailInfo=Stat.QueryStatDetailInfoAll("1",sStartTime,sEndTime,sProductId,sStatusId,sGroupId,sTestOpId,sValue,Products,"");



%>

<% 
  java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
  String sWordName="需求单开发-测试时间统计信息"+"."+sdf.format(date);
  
  request.setCharacterEncoding("gb2312");
  response.setHeader( "Content-Disposition", "attachment;filename="  + new String(sWordName.getBytes("gb2312"), "ISO8859-1" )+".xls" );
%>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="961" style="border-collapse:
 collapse;width:722pt">
	<colgroup>
		<col width="30" style="mso-width-source:userset;mso-width-alt:960;width:23pt">
		<col width="70" style="mso-width-source:userset;mso-width-alt:2240;width:53pt">
		<col width="514" style="mso-width-source:userset;mso-width-alt:16448;width:386pt">
		<col width="72" span="3" style="width:54pt">
		<col width="64" style="mso-width-source:userset;mso-width-alt:2048;width:48pt">
		<col width="67" style="mso-width-source:userset;mso-width-alt:2144;width:50pt">
	</colgroup>
	<tr height="18" style="height:13.5pt">
		<td rowspan="2" height="36" width="30" style="height: 27.0pt; width: 23pt" class="style1">
		ID</td>
		<td rowspan="2" width="70" style="width: 53pt" class="style1">编号</td>
		<td rowspan="2" width="514" style="width: 386pt" class="style1">描述</td>
		<td rowspan="2" width="72" style="width: 54pt" class="style1">完成时间</td>
		<td width="72" style="width: 54pt" class="style2">开发时间</td>
		<td width="72" style="width: 54pt" class="style2">测试时间</td>
		<td rowspan="2" width="64" style="width: 48pt" class="style1">开发时间比例</td>
		<td rowspan="2" width="67" style="width: 50pt" class="style2">测试时间比例</td>
	</tr>
	<tr height="18" style="height:13.5pt">
		<td height="18" width="72" style="height: 13.5pt; width: 54pt" class="style3">
		(单位：天)</td>
		<td width="72" style="width: 54pt" class="style3">(单位：天)</td>
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
		<tr height="19" style="height:14.25pt">
		<td height="19" width="30" style="height: 14.25pt; width: 23pt" class="style4"><%=j %></td>
		<td width="70" style="width: 53pt; text-underline-style: single;" class="style5">
		<a target="_blank" href="http://localhost:8089/QMS/demand/DemandManager.ModifyDemand.jsp?op_id=<%=sdemandid %>"><%=sdemandid %></a></td>
		<td width="514" style="width: 386pt" class="style6"><%=sdemanddesc %></td>
		<td width="72" style="width: 54pt" class="style4"><%if(sclosetime==null || sclosetime.equals("")) out.print("未完成需求");else out.print(sclosetime); %></td>
		<td width="72" style="width: 54pt" class="style4"><%=sdevtime %></td>
		<td width="72" style="width: 54pt" class="style4"><%=sqatime %></td>
		<td width="64" style="width: 48pt" class="style4"><%=sdevtimeper %></td>
		<td width="67" style="width: 50pt" class="style4"><%=sqatimeper %></td>
	</tr>

	<%
			}
		}
	%>
</table>

</body>

</html>