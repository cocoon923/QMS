<%@ page contentType="application/msexcel; charset=gb2312" import="java.util.*,java.io.*,java.sql.*"   language="java"%>
<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />

<html>

<head>
<title>计划跟踪明细信息导出</title>
</head>
<%
//获取计划id
String sPlanId=request.getParameter("planid");
if(sPlanId==null) 
{
	sPlanId="";
}

//取计划基本信息
String sStartTime="";
String sEndTime="";
String sPlanName="";
Vector vPlanInfo=new Vector();
vPlanInfo=PlanManager.queryplaninfo(sPlanId,"","","","","","","","","");
if(vPlanInfo.size()>0)
{
	HashMap PlanInfohash = (HashMap) vPlanInfo.get(0);
  	sStartTime=(String) PlanInfohash.get("START_TIME");
  	sStartTime=sStartTime.substring(0,10);
  	sEndTime=(String) PlanInfohash.get("END_TIME");
  	sEndTime=sEndTime.substring(0,10);
  	sPlanName=(String) PlanInfohash.get("PLAN_NAME");
}

//取计划下任务信息 
Vector vPlanTaskInfo=new Vector();
vPlanTaskInfo=PlanManager.queryplantaskinfo(sPlanId,"","","","","","","","","","","");
String sDemand_id="";
String sDemand_id_temp="";
Vector vPlanTaskInfoAgain=new Vector();
vPlanTaskInfoAgain=PlanManager.queryplantaskinfoagain(sPlanId);
if(vPlanTaskInfoAgain.size()>0)
	{
		for(int ia=0;ia<vPlanTaskInfoAgain.size();ia++)
		{
			HashMap vPlanTaskInfoAgainHash=(HashMap) vPlanTaskInfoAgain.get(ia);
			sDemand_id_temp=(String )vPlanTaskInfoAgainHash.get("DEMAND_ID");
			sDemand_id=sDemand_id+","+sDemand_id_temp;
		}
	}


int iCount=0;
Vector vDemandInfo=new Vector();
vDemandInfo=PlanManager.trackdemandinfo(sPlanId);
iCount=vDemandInfo.size();
%>

<% 
  java.util.Date date = new java.util.Date(System.currentTimeMillis()); 
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
  String sWordName=sPlanName+"."+sdf.format(date);
  
  request.setCharacterEncoding("gb2312");
  response.setHeader( "Content-Disposition", "attachment;filename="  + new String(sWordName.getBytes("gb2312"), "ISO8859-1" )+".xls" );
%>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="1044" style="border-collapse: collapse;width:786pt">
	<colgroup>
		<col width="50" style="mso-width-source:userset;mso-width-alt:1600;width:38pt" />
		<col width="62" style="mso-width-source:userset;mso-width-alt:1984;width:47pt" />
		<col width="62" style="mso-width-source:userset;mso-width-alt:1984;width:47pt" />
		<col width="270" style="mso-width-source:userset;mso-width-alt:8640;width:203pt" />
		<col width="104" style="mso-width-source:userset;mso-width-alt:3328;width:78pt" />
		<col width="66" style="mso-width-source:userset;mso-width-alt:2112;width:50pt" />
		<col width="72" span="3" style="width:54pt" />
		<col width="110" style="mso-width-source:userset;mso-width-alt:3520;width:83pt" />
		<col width="94" style="mso-width-source:userset;mso-width-alt:3008;width:71pt" />
		<col width="72" style="width:54pt" />
	</colgroup>

	<tr height="18" style="height:13.5pt">
		<td colspan="11" height="36" width="972" style="height: 27.0pt; width: 732pt;color: black;	font-size: 11.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: left;	vertical-align: middle;	white-space: normal;	border-style: none;	border-color: inherit;	border-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #98B7CD;" >
		计划任务列表:</td>
	</tr>

	<tr height="19" style="height:14.25pt">
		<td colspan="11" height="19" width="1044" style="height: 14.25pt; width: 786pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: general;	vertical-align: middle;	white-space: normal;	border-style: none;	border-color: inherit;	border-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #F0F0F0;">
		计划名："<%=sPlanName %>",  计划开始时间：<%=sStartTime %> --- 计划结束时间：<%=sEndTime %>
		</td>
	</tr>

	<tr height="18" style="height:13.5pt">
		<td height="18" width="50" style="height: 13.5pt; width: 38pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">
		序号</td>
		<td height="18" width="50" style="height: 13.5pt; width: 38pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">
		标识</td>
		<td width="62" style="width: 47pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;" >编号</td>
		<td width="270" style="width: 203pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">标题</td>
		<td width="104" style="width: 78pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">工程名称</td>
		<td width="66" style="width: 50pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">产品</td>
		<td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">状态</td>
		<td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">测试人员</td>
		<td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">归属组</td>
		<td width="110" style="width: 83pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">开发人员</td>
		<td width="94" style="width: 71pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">提交测试时间</td>
	</tr>
	
	<% 
		String sDEMAND_ID;
		String sDEMAND_TITLE;
		String sPROJ_NAME;
		String sPRODUCT_NAME;
		String sSTA_NAME;
		String sREP_TIME;
		String sTESTER_NAME;
		String sTESTER_ID;
		String sGROUP_NAME;
		String sGROUP_ID;
		String sDEV_NAME;
		String sDEV_ID;
		String sTESTER_NAME_new;
		String sDEMAND_SRC_ID;
		String sMODULE_ID;
		String sDEMAND_DESC;
		
		
		int j=1;
		if(vDemandInfo.size()>0)
		{
			for(int i=vDemandInfo.size()-1;i>=0;i--)
			{
			  sDEMAND_ID="";
			  sDEMAND_TITLE="";
			  sPROJ_NAME="";
			  sPRODUCT_NAME="";
			  sSTA_NAME="";
			  sREP_TIME="";
			  sTESTER_NAME="";
			  sTESTER_ID="";
			  sGROUP_NAME="";
			  sGROUP_ID="";
			  sDEV_NAME="";
			  sDEV_ID="";
			  sTESTER_NAME_new="";
			  HashMap hash = (HashMap) vDemandInfo.get(i);
		      sDEMAND_ID = (String) hash.get("DEMAND_ID");
		      sDEMAND_TITLE = (String) hash.get("DEMAND_TITLE");
		      sPROJ_NAME = (String) hash.get("PROJ_NAME");
		      sPRODUCT_NAME = (String) hash.get("PRODUCT_NAME");
		      sSTA_NAME = (String) hash.get("STA_NAME");
		      sREP_TIME = (String) hash.get("COMMIT_TIME");
		      sTESTER_NAME_new = (String) hash.get("TESTER_NAME");
		      sGROUP_NAME = (String) hash.get("GROUP_NAME");                
	%>
	<%
			  String sTESTER_NAME_Temp="";
			  String sGROUP_NAME_Temp="";
			  String sDEV_NAME_Temp="";
			  String sTESTER_ID_Temp="";
			  String sGROUP_ID_Temp="";
			  String sDEV_ID_Temp="";
			  String stype="";
			  String value="";
			  if(sDEMAND_ID.substring(0,1).equals("R"))
			  {
			 	stype="1";
			 	value=sDEMAND_ID.substring(1,sDEMAND_ID.length());
			  }
			  if(sDEMAND_ID.substring(0,1).equals("F"))
			  {
			 	 stype="2";
			 	 value=sDEMAND_ID.substring(1,sDEMAND_ID.length());
			  }
			  if(sDEMAND_ID.substring(0,1).equals("T"))
			  {
			 	 stype="3";
			 	 value=sDEMAND_ID.substring(1,sDEMAND_ID.length());
			  }
			  Vector vOPInfo=PlanManager.querydemandopinfo(stype,value);
			  if(vOPInfo.size()>0)
			  {
			 	 for(int inum=vOPInfo.size()-1;inum>=0;inum--)
			 	 {
			 		HashMap OPInfohash = (HashMap) vOPInfo.get(inum);
			 		sTESTER_NAME_Temp = (String) OPInfohash.get("TESTER_NAME");
			 		if(sTESTER_NAME_Temp==null)
			 		{
			 			sTESTER_NAME_Temp="";
			 		}
			 		if(inum==vOPInfo.size()-1)
			 		{
			 			sTESTER_NAME=sTESTER_NAME_Temp;
			 		}
			 		else
			 		{
				 		if(sTESTER_NAME.equals("")||sTESTER_NAME==null||sTESTER_NAME_Temp.equals(""))
				 		{
				 			sTESTER_NAME=sTESTER_NAME;
				 		}
				 		else
				 		{
					 		if(sTESTER_NAME.indexOf(sTESTER_NAME_Temp)<0)
					 		{
					 			sTESTER_NAME=sTESTER_NAME + ','+ sTESTER_NAME_Temp;
					 		}
					 		else
					 		{
					 			sTESTER_NAME=sTESTER_NAME;
					 		}
				 		}
			 		}
			 		sTESTER_ID_Temp = (String) OPInfohash.get("TESTER_ID");
			 		if(sTESTER_ID_Temp==null)
			 		{
			 			sTESTER_ID_Temp="";
			 		}
			 		if(inum==vOPInfo.size()-1)
			 		{
			 			sTESTER_ID=sTESTER_ID_Temp;
			 		}
			 		else
			 		{
				 		if(sTESTER_ID.equals("")||sTESTER_ID==null ||sTESTER_ID_Temp.equals(""))
				 		{
				 			sTESTER_ID=sTESTER_ID;
				 		}
				 		else
				 		{
					 		if(sTESTER_ID.indexOf(sTESTER_ID_Temp)<0)
					 		{
					 			sTESTER_ID=sTESTER_ID + ','+ sTESTER_ID_Temp;
					 		}
					 		else
					 		{
					 			sTESTER_ID=sTESTER_ID;
					 		}
				 		}
			 		 }	
			 		sDEV_NAME_Temp = (String) OPInfohash.get("DEV_NAME");
			 		if(sDEV_NAME_Temp==null)
			 		{
			 			sDEV_NAME_Temp="";
			 		}
			 		if(inum==vOPInfo.size()-1)
			 		{
			 			sDEV_NAME=sDEV_NAME_Temp;
			 		}
			 		else
			 		{
			 			if(sDEV_NAME.equals("")||sDEV_NAME==null||sDEV_NAME_Temp.equals(""))
			 			{
			 				sDEV_NAME=sDEV_NAME;
			 			}
			 			else
			 			{
					 		if(sDEV_NAME.indexOf(sDEV_NAME_Temp)<0)
					 		{
					 			sDEV_NAME=sDEV_NAME + ','+ sDEV_NAME_Temp;
					 		}
					 		else
					 		{
					 			sDEV_NAME=sDEV_NAME;
					 		}
				 		}
			 		}	
			 		sDEV_ID_Temp = (String) OPInfohash.get("DEV_ID");
			 		if(sDEV_ID_Temp==null)
			 		{
			 			sDEV_ID_Temp="";
			 		}
			 		if(inum==vOPInfo.size()-1)
			 		{
			 			sDEV_ID=sDEV_ID_Temp;
			 		}
			 		else
			 		{
			 			if(sDEV_ID.equals("")||sDEV_ID==null||sDEV_ID_Temp.equals(""))
			 			{
			 				sDEV_ID=sDEV_ID;
			 			}
			 			else
			 			{
					 		if(sDEV_ID.indexOf(sDEV_ID_Temp)<0)
					 		{
					 			sDEV_ID=sDEV_ID + ','+ sDEV_ID_Temp;
					 		}
					 		else
					 		{
					 			sDEV_ID=sDEV_ID;
					 		}
				 		}
			 		}	
			 			
			 		sGROUP_ID_Temp = (String) OPInfohash.get("ID");
			 		if(sGROUP_ID_Temp==null)
			 		{
			 			sGROUP_ID_Temp="";
			 		}
			 		if(inum==vOPInfo.size()-1)
			 		{
			 			sGROUP_ID=sGROUP_ID_Temp;
			 		}
			 		else
			 		{
				 		if(sGROUP_ID.equals("")||sGROUP_ID==null||sGROUP_ID_Temp.equals(""))
				 		{
				 			sGROUP_ID=sGROUP_ID;
				 		}
				 		else
				 		{
					 		if(sGROUP_ID.indexOf(sGROUP_ID_Temp)<0)
					 		{
					 			sGROUP_ID=sGROUP_ID + ','+ sGROUP_ID_Temp;
					 		}
					 		else
					 		{
					 			sGROUP_ID=sGROUP_ID;
					 		}
				 		}
			 		}				 			
			 	}
			}
			
	%>

				<tr height="49" style="height:36.75pt">
				             <td height="49" width="50" style="height: 36.75pt; width: 38pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;"><%=j%></td>
				             <td height="49" width="50" style="height: 36.75pt; width: 38pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;"><%if(sDemand_id.indexOf(sDEMAND_ID)>0) out.print("遗留"); else out.print("新增");%></td>
				             <td width="62" style="width: 47pt; text-underline-style: single;color: blue;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: underline;	font-family: 宋体;	text-align: center;vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="DEMAND_ID"><a href="<%
				             	if(stype.equals("1")) //需求
				             	{
				             		out.print("http://aiqcs.asiainfo.com/demand/query/demd_query_detail.jsp?op_id="+sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("2")) //故障
				             	{
				             		out.print("http://aiqcs.asiainfo.com/project/query/proj_query_result.jsp?op_id="+sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("3")) //任务单
				             	{
				             		out.print("http://aiqcs.asiainfo.com/task/query/task_query_detail.jsp?op_type=100&op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				            	else
				            	{
				            		out.print("error");
				            	}%>"><span style="font-size:9.0pt"><%=sDEMAND_ID%></span></a></td>
				             <td width="270" style="width: 203pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="DEMAND_TITLE">&nbsp;<%=sDEMAND_TITLE%></td>
				             <td width="104" style="width: 78pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="PROJ_NAME">&nbsp;<%=sPROJ_NAME%></td>
				             <td width="66" style="width: 50pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="PRODUCT_NAME">&nbsp;<%=sPRODUCT_NAME%></td>
				             <td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="STA_NAME">&nbsp;<%=sSTA_NAME%></td>
				             <td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="TESTER_NAME">&nbsp;<%=sTESTER_NAME_new%></td>
				             <td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="GROUP_NAME">&nbsp;<%if(sGROUP_NAME==null) out.print("");else out.print(sGROUP_NAME);%></td>
				             <td width="110" style="width: 83pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="DEV_NAME">&nbsp;<%=sDEV_NAME%></td>
				             <td width="94" style="width: 71pt;color: #666666;	font-size: 9.0pt;	font-weight: 400;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid #CCCCCC;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top-style: none;	border-top-color: inherit;	border-top-width: medium;	border-bottom: 1.0pt solid #CCCCCC;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: white;" name="REP_TIME">&nbsp;<%=sREP_TIME%></td>
				         </tr> 
	        <%       
	                 
	                 j=j+1;
	                 }
	              }  
	         %>
	
	
	<tr height="18" style="height:13.5pt">
		<td height="18" width="50" style="height: 13.5pt; width: 38pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">
		序号</td>
		<td height="18" width="50" style="height: 13.5pt; width: 38pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">
		标识</td>
		<td width="62" style="width: 47pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;" >编号</td>
		<td width="270" style="width: 203pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">标题</td>
		<td width="104" style="width: 78pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">工程名称</td>
		<td width="66" style="width: 50pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">产品</td>
		<td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">状态</td>
		<td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">测试人员</td>
		<td width="72" style="width: 54pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">归属组</td>
		<td width="110" style="width: 83pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">开发人员</td>
		<td width="94" style="width: 71pt;color: #666666;	font-size: 9.0pt;	font-weight: 700;	font-style: normal;	text-decoration: none;	font-family: 宋体;	text-align: center;	vertical-align: middle;	white-space: normal;	border-left: 1.0pt solid white;	border-right-style: none;	border-right-color: inherit;	border-right-width: medium;	border-top: 1.0pt solid white;	border-bottom-style: none;	border-bottom-color: inherit;	border-bottom-width: medium;	padding-left: 1px;	padding-right: 1px;	padding-top: 1px;	background: #CCCCCC;">提交测试时间</td>
	</tr>
</table>

</body>

</html>