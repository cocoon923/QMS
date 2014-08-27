<%@include file="../allcheck.jsp"%>
<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<%@ include file= "../connections/con_start.jsp"%>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>

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

<script language="javascript">	

function empty()    
	{
		document.open.submit();	
	}
	
function ToSubmit(form1)
{
   form1.submit();
}




</script>
<%
	String sTemp= "";
	String sdate_s = "";
	String sdate_s2 = "";
	String sDate="";
	String sDate1="";
	String sDate2="";
	String ssql6="";  //获取数据库系统时间sql
	String ssql51=""; //获取部门内所有组
	String ssql52=""; //获取部门内所有小组所有成员
	String ssql53=""; //获取部门内指定一个小组的成员
	String ssql56=""; //获取计划标识枚举
	ResultSet rs6=null;		
	ResultSet rs51=null;
	ResultSet rs52=null;
	ResultSet rs53=null;
	ResultSet rs56=null;
	Statement stmt6 = conn.createStatement();
	Statement stmt51 = conn.createStatement();
	Statement stmt52 = conn.createStatement();
	Statement stmt53 = conn.createStatement();
	Statement stmt56 = conn.createStatement();
	
	String defProduct = "";
	String defSubsys = "";
	String defModule = "";
	String defGroup = "";
	String defOperator="";
//	String Products = "("+staff.getProducts()+")";
//	String Products="2,3,92,93,169";
//	String demand_sta_id="8,10,13,15,16";
//	String proj_request_id="1,2,3,4,5,6";
	
	try
	{		
		ssql6="select to_char(sysdate-7,'YYYY-MM-DD') sdate_s,to_char(sysdate,'YYYY-MM-DD') sdate from dual";
//		out.println("ssql6="+ssql6+";\n");
		try
		{
			rs6 = stmt6.executeQuery(ssql6);
			while(rs6.next())
			{
				sDate = rs6.getString("sdate");
				sDate1 = rs6.getString("sdate");
				sDate2 = rs6.getString("sdate");
				sdate_s = rs6.getString("sdate_s");
				sdate_s2 = rs6.getString("sdate_s");
			}
		}	
	    catch(Exception e)
		{
	       out.println(e.toString());
		}
		
		
		ssql51="select group_id as id,'['||group_id||'] '||group_name as name from group_def";
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
		      +" from (select * from group_op_info union select * from group_op_info_ext) a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id and c.op_stat=1";
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

		ssql53="select a.op_id as id,c.op_mail||' - '||c.op_name as name "
		      +" from (select * from group_op_info union select * from group_op_info_ext) a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id"
		      +" and b.group_id='"+defGroup+"'";
//	   out.println("ssql53="+ssql53+";\n");
	   if (ssql53!=null)
	  	{
			try
			{
				rs53 = stmt53.executeQuery(ssql53);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}
		
		ssql56="select code_value as id,cname,'['||code_value||'] '||cname as name from sys_base_type "
		      +" where table_name='PLAN' and col_name='FLAG' order by code_value";
//	   out.println("ssql56="+ssql56+";\n");
	   if (ssql56!=null)
	  	{
			try
			{
				rs56 = stmt56.executeQuery(ssql56);
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



<%
String sOpId=(String)session.getValue("OpId");
if(sOpId==null) sOpId="";

//获取界面checkbox勾选信息
String sIsCheckQueryDate=request.getParameter("chk_query_date");
String sIsCheckDate=request.getParameter("chk_date");
String sIsCheckCreateDate=request.getParameter("chk_create_date");
//out.print("sIsCheckQueryDate="+sIsCheckQueryDate+";sIsCheckDate="+sIsCheckDate+";sIsCheckCreateDate="+sIsCheckCreateDate);
if(sIsCheckQueryDate==null)
{
	sIsCheckQueryDate="";
}
if(sIsCheckDate==null)
{
	sIsCheckDate="";
}
if(sIsCheckCreateDate==null)
{
	sIsCheckCreateDate="";
}

String sStartTime="";
String sEndTime="";
String sDateValue="";
String sCreatTimeStart="";
String sCreatTimeEnd="";
if(sIsCheckQueryDate.equals("on"))
{
	sStartTime=request.getParameter("starttime");
	sEndTime=request.getParameter("endtime");	
	if(!sStartTime.equals(""))
	{
		sdate_s=sStartTime;
	}
	if(!sEndTime.equals(""))
	{
		sDate=sEndTime;
	}
}
if(sIsCheckDate.equals("on"))
{
	sDateValue=request.getParameter("querydate");
	if(!sDateValue.equals(""))
	{
		sDate1=sDateValue;
	}
}
if(sIsCheckCreateDate.equals("on"))
{
	sCreatTimeStart=request.getParameter("createstarttime");
	sCreatTimeEnd=request.getParameter("createendtime");		
	if(!sCreatTimeStart.equals(""))
	{
		sdate_s2=sCreatTimeStart;
	}
	if(!sCreatTimeEnd.equals(""))
	{
		sDate2=sCreatTimeEnd;
	}
}

String sPlanName=request.getParameter("plan_name");
if(sPlanName==null)
{
	sPlanName="";
}
String sPlanner=request.getParameter("planner");
if(sPlanner==null)
{
	sPlanner="";
}

String sFlag=request.getParameter("flag");
if(sFlag==null)
{
	sFlag="";
}

String sPlanId=request.getParameter("plan_id");
if(sPlanId==null)
{
	sPlanId="";
}

String sQueryData=request.getParameter("sQueryDate");
if(sQueryData==null)
{
	sQueryData="";
}

String closeFlag="";
String closeplanid="";
Vector vPlanInfo=new Vector();
boolean Flag=false;
closeFlag=request.getParameter("closeFlag");
closeplanid=request.getParameter("planid");
if(closeFlag==null)
{
	closeFlag="";
}
if(closeplanid==null)
{
	closeplanid="";
}
if(closeFlag.equals("1"))
{
	Flag=PlanManager.colseplan(closeplanid);
	if(Flag==true)
	{
		out.print("<script language='javascript'>alert('计划关闭成功!');</script>");
		closeFlag="0";
		vPlanInfo=PlanManager.queryplaninfo(sPlanId,sPlanName,sStartTime.replaceAll("-",""),sEndTime.replaceAll("-",""),sPlanner,sCreatTimeStart.replaceAll("-",""),sCreatTimeEnd.replaceAll("-",""),sFlag,"",sDateValue.replaceAll("-",""));		
	}
}
else
{
	if(sQueryData.equals("1"))
	{
		//out.print("\n sPlanId="+sPlanId+"\n ;sPlanName="+sPlanName+"\n ;sStartTime="+sStartTime.replaceAll("-","")+"\n ;sEndTime="+sEndTime.replaceAll("-","")+"\n ;sPlanner="+sPlanner+"\n ;sCreatTimeStart="+sCreatTimeStart.replaceAll("-","")+"\n ;sCreatTimeEnd="+sCreatTimeEnd.replaceAll("-","")+"\n ;sFlag="+sFlag+"\n ;sDateValue="+sDateValue.replaceAll("-",""));
		vPlanInfo=PlanManager.queryplaninfo(sPlanId,sPlanName,sStartTime.replaceAll("-",""),sEndTime.replaceAll("-",""),sPlanner,sCreatTimeStart.replaceAll("-",""),sCreatTimeEnd.replaceAll("-",""),sFlag,"",sDateValue.replaceAll("-",""));
	}	
}
int iCount=vPlanInfo.size();

%>

<script language="javascript">	
function goToURL(url)
{
   var opid="<%=sOpId%>"
   //限制操作员为：，其他人员不能操作
   if(opid=="1" || opid=="100068" || opid=="100072" || opid=="101237" || opid=="101238" || opid=="101383" || opid=="101590" ||opid=="101880" ||opid=="101983"||opid=="101596"||opid=="103945"||opid=="104368"||opid=="104383" || opid=="104371" || opid=="104379" || opid=="104373" || opid=="104716")
   {
   	  window.location=url;
   }
   else
   {
	  alert("您没有权限进行此操作！");
   }
}


function FP_goToQueryURL(url)
{
	
   var count="<%=iCount%>";
   var j=0;
   var planid="";
   var id="";
   var flag="";
   if(count>0)
   {
     var obj = document.getElementsByName("planidradio");
     
     
     for(i=0;i<obj.length;i++)
     {
       if(obj[i].checked)
       {
           j=1;
           id=obj[i].value;
           if(id!="")
	           {
	           	 var k=id.indexOf("|");
	             var len=id.length;
	             planid=id.substring(0,k);
			     flag=id.substring(k+1,len);
			   }
           break;
           //alert(obj[i].value);
      }
     }
     if(j==0)
     {
        alert("没有选中的计划，不能操作!");
     }
     else
     {
		window.open(url+'?planid='+planid);
		//var refresh=showModalDialog('PlanManager.TaskDetail.jsp?planid='+planid+'',window,'dialogWidth:900px;status:no;dialogHeight:600px');
		
		//if(refresh=="Y")   
	  	//{
	  	//	self.location.reload(); 
	  	//}
  	}
	}
}


function colseplan()
{
	
   var count="<%=iCount%>";
   var opid="<%=sOpId%>"
   var j=0;
   var id="";
   var planid="";
   var flag="";
   //限制操作员为：其他人员不能操作
   if(opid=="1" || opid=="100068" || opid=="100072" ||opid=="104368")
   {
	   if(count>0)
	   {
	     var obj = document.getElementsByName("planidradio");
	     for(i=0;i<obj.length;i++)
	     {
	       if(obj[i].checked)
	       {
	           j=1;
	           id=obj[i].value;
	           //拆分计划id和计划是否关闭标志
	           if(id!="")
	           {
	           	 var k=id.indexOf("|");
	             var len=id.length;
	             planid=id.substring(0,k);
			     flag=id.substring(k+1,len);
			   }
	           break;
	           //alert(obj[i].value);
	      }
	     }
	     if(j==0)
	     {
	        alert("没有选中的计划，不能关闭!");
	     }
	     else
	     {
			if(flag=="0")
			{
				alert("计划已关闭，不能再关闭，请确认！");
			}	
			else
			{
				window.location='PlanManager.ManagerPlan.jsp?planid='+planid+'&closeFlag=1&chk_query_date=<%=sIsCheckQueryDate%>&chk_date=<%=sIsCheckDate%>&chk_create_date=<%=sIsCheckCreateDate%>&starttime=<%=sStartTime%>&endtime=<%=sEndTime%>&querydate=<%=sDateValue%>&createstarttime=<%=sCreatTimeStart%>&createendtime=<%=sCreatTimeEnd%>&plan_name=<%=sPlanName%>&planner=<%=sPlanner%>&flag=<%=sFlag%>&plan_id=<%=sPlanId%>&sQueryDate=<%=sQueryData%>';
	  		}
	  	}
		}
	}
	else
	{
		alert("您无权限进行此操作！");
	}
}


function FP_goToURL(url) 
{
   var count="<%=iCount%>";
   var opid="<%=sOpId%>"
   var j=0;
   var planID="";
   var id="";
   var flag="";
   
   //限制操作员为：
   if(opid=="1")
   {
	   if(count>0)
	   {
	     var obj = document.getElementsByName("planidradio");

	     for(i=0;i<obj.length;i++)
	     {
	       if(obj[i].checked)
	       {
	           j=1;
	           id=obj[i].value;
	           if(id!="")
	           {
	           	 var k=id.indexOf("|");
	             var len=id.length;
	             planID=id.substring(0,k);
			     flag=id.substring(k+1,len);
			   }
	           break;
	      }
	     }
	     if(j==0)
	     {
	        alert("没有选中计划，不能进行编辑操作!");
	     }
	     else
	     {
	       window.location=url+"?planid="+planID;
	     }  
	   }
	   else
	   {
	      alert("没有计划，不能进行编辑操作!");
	   }
   }
   else
   {
   		alert("您没有权限进行此操作！");
   }
}

</script>

 
<title>managerplan</title>

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

function loadPage(url) 
{
	window.location = url;
}

function empty()    
{
	document.open.submit();	
}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="PlanTaskQuery" method="post" onSubmit="return empty()"action="">
 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">
          <td>查询计划:<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
                <tr class="contentbg">
                  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">查询时间段： </div>
                    <div align="right"> </div></td>
                  <td width="87%" class="pagetextdetails">
                  <%
                  	if(sIsCheckQueryDate.equals("on"))
                  	{
                  %>
                  <input name="chk_query_date" type="checkbox" id="chk_query_date" checked>
                  <%
                  	}
                  	else
                  	{
                  %>
                  <input name="chk_query_date" type="checkbox" id="chk_query_date">
                  <%
                  	}
                  %>
                    <input name="starttime" type="text" class="inputstyle" id="starttime"  onClick="JSCalendar(this);"  value="<%=sdate_s%>" size="10">
                    ---
                    <input name="endtime" type="text" class="inputstyle" id="endtime" value="<%=sDate%>" size="10"  onClick="JSCalendar(this);" >
                    <font class="pagetextdetails">（计划开始、结束时间，如不做查询条件可为空）</font>
                    </td>
                </tr>
				<tr>
                  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">计划制定时间： </div>
                    <div align="right"> </div></td>
                  <td width="87%" class="pagetextdetails">
                  <%
                  	if(sIsCheckCreateDate.equals("on"))
                  	{
                  %>
                  <input name="chk_create_date" type="checkbox" id="chk_create_date" checked>
                  <%
                  	}
                  	else
                  	{
                  %>
                  <input name="chk_create_date" type="checkbox" id="chk_create_date">
                  <%
                  	}
                  %>
                    <input name="createstarttime" type="text" class="inputstyle" id="createstarttime"  onClick="JSCalendar(this);"  value="<%=sdate_s2%>" size="10">
                    ---
                    <input name="createendtime" type="text" class="inputstyle" id="createendtime" value="<%=sDate2%>" size="10"  onClick="JSCalendar(this);" >
                    <font class="pagetextdetails">（计划制定的开始、结束时间，如不做查询条件可为空）</font>
                    </td>
                </tr>
                
                <tr  class="contentbg">
                  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">计划包含日期： </div>
                    <div align="right"> </div></td>
                  <td width="87%" class="pagetextdetails">
                  <%
                  	if(sIsCheckDate.equals("on"))
                  	{
                  %>
                  <input name="chk_date" type="checkbox" id="chk_date" checked>
                  <%
                  	}
                  	else
                  	{
                  %> 
                  <input name="chk_date" type="checkbox" id="chk_date">
                  <%
                  	}
                  %> 
                    <input name="querydate" type="text" class="inputstyle" id="querydate"  onClick="JSCalendar(this);"  value="<%=sDate1%>" size="10">
                    <font class="pagetextdetails">（计划中开始时间结束时间包含的日期）</font>
                    </td>
                </tr>
               
                <tr>
                  <td class="pagetitle1" style= "height: 40px; " >计划名称：</td>
                  <td><class="pagetextdetails"><input name="plan_name" type="text" class="inputstyle" id="demand_id" size="35" value="<%if(!sPlanName.equals("")||sPlanName!=null){out.print(sPlanName);}%>"> 
                  <font class="pagetextdetails">（模糊匹配）</font>
                  </td>
                </tr>
                
                <tr class="contentbg">
                  <td class="pagetitle1" style= "height: 30px; ">计划制定人：</td>
                  <td><font color="#0000FF">
                    <select style= "width: 550px; " name="planner" class="inputstyle" id="planner">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                      <%
						while(rs52.next())
						{
							if(rs52.getString("id").equals(sPlanner)==true)
							{
					  %>
					  <option value="<%=rs52.getString("id")%>" selected><%=rs52.getString("name")%></option>
					  <%		
							}
							else
							{
					  %>
                      <option value="<%=rs52.getString("id")%>"><%=rs52.getString("name")%></option>
                      <%
							}
						}
					  %>
                    </select>      
                    </td>
                </tr>
                
                <tr>
                  <td class="pagetitle1" style= "height: 30px; ">计划标识：</td>
                  <td><font color="#0000FF">
                    <select style= "width: 550px; " name="flag" class="inputstyle" id="flag">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                      <%
						while(rs56.next())
						{
							if(rs56.getString("id").equals(sFlag)==true)
							{
						%>
					 <option value="<%=rs56.getString("id")%>" selected><%=rs56.getString("name")%></option>
						<%	
							}
							else
							{
					  %>
                      <option value="<%=rs56.getString("id")%>"><%=rs56.getString("name")%></option>
                      <%
                      		}
						}
					  %>
                    </select>      
                    </td>
                </tr>
                
                <tr  class="contentbg">
                  <td class="pagetitle1" style= "height: 30px; ">计划编号：</td>
                  <td class="pagetextdetails">
                  <input name="plan_id" type="text" class="inputstyle" id="plan_id"   size="35" value="<%if(!sPlanId.equals("")||sPlanId!=null){out.print(sPlanId);}%>">
                  <font class="pagetextdetails">（可以输入多个编号，用英文逗号分割，结尾不要逗号，例如：1,2,3）</font>
                  </td></tr>
                
                <tr>
                <td class="pagetitle1">&nbsp;<input type="hidden" name="sQueryDate" value="1"></td>
                <td>&nbsp;</td>
              </tr>
              </table></td>
			 </tr>
	  		<tr> 
	          <td class="contentbottomline"><div align="left"> 
	          <table width="146" border="0" cellspacing="5" cellpadding="5">
	          <tr> 
	          <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">查询计划
              <input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="ToSubmit(this.form)" ></td>
	          </tr>
	          </table></td>
	          <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="goToURL(/*href*/'PlanManager.NewPlan.jsp')">新增计划<br></td>
	          </tr>
	          </table></td>
	          <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToURL(/*href*/'PlanManager.PlanTask.jsp')">编辑计划<br></td>
	          </tr>
	          </table></td>
	          <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToQueryURL('PlanManager.TaskDetail.jsp')">跟踪计划<br></td>
	          </tr>
	          </table></td>
	          <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToQueryURL('PlanManager.TaskDetailExportExcel.jsp')">导出跟踪<br></td>
	          </tr>
	          </table></td>
	          <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="colseplan()">关闭计划<br></td>
	          
	          </tr>
			</table>
			</td>
	        </tr>
	      </table></td>
	  	</tr>
		</table>
		<div align="center"></div>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title"> 
          <td>计划列表:<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="3%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="37%" class="pagecontenttitle">名称</td>
                <td width="10%" class="pagecontenttitle">计划开始</td>                
                <td width="10%" class="pagecontenttitle">计划结束</td>
                <td width="10%" class="pagecontenttitle">计划制定人</td>
                <td width="10%" class="pagecontenttitle">状态</td>
                <td width="10%" class="pagecontenttitle">建立时间</td>
              </tr>
			 <% 
			      String sPLAN_ID="";
			      String sPLAN_NAME="";
			      String sSTART_TIME="";
			      String sEND_TIME="";
			      String sPLANNER_NAME="";
			      String sFLAG_NAME="";
			      String sFLAG="";
			      String sCREATE_TIME="";
			      
			      int j=1;
			      if(vPlanInfo.size()>0)
			      {
			         //for(int i=vPlanInfo.size()-1;i>=0;i--)
			         for(int i=0;i<=vPlanInfo.size()-1;i++) //修改为倒序排列。liyf-20090806
			         {
		                HashMap hash = (HashMap) vPlanInfo.get(i);
		                sPLAN_ID = (String) hash.get("PLAN_ID");
		                sPLAN_NAME = (String) hash.get("PLAN_NAME");
		                sSTART_TIME = (String) hash.get("START_TIME");
		                if(sSTART_TIME!=null && !sSTART_TIME.equals("") && !sSTART_TIME.equals("-"))
		                {
		                	sSTART_TIME=sSTART_TIME.substring(0,10);
		                }
		                sEND_TIME = (String) hash.get("END_TIME");
		                if(sEND_TIME!=null && !sEND_TIME.equals("") && !sEND_TIME.equals("-"))
		                {
		                	sEND_TIME=sEND_TIME.substring(0,10);
		                }		                
		                sPLANNER_NAME = (String) hash.get("PLANNER_NAME");
		                sFLAG_NAME = (String) hash.get("FLAG_NAME");
		                sFLAG = (String) hash.get("FLAG");
		                sCREATE_TIME = (String) hash.get("CREATE_TIME");
		                if(sCREATE_TIME!=null && !sCREATE_TIME.equals("") && !sCREATE_TIME.equals("-"))
		                {
		                	sCREATE_TIME=sCREATE_TIME.substring(0,10);
		                }		                
		                             
		      %>
	        		<%
	        			if(i%2!=0)
	        			{
	        		 %>
				        <tr> 
				             <td class="coltext"><div align="center"><input type="radio" name="planidradio" value="<%out.print(sPLAN_ID+"|"+sFLAG);%>"></div></td>
				             <td class="coltext">(<%=j%>)</td>
				             <td class="coltext" ><a href="#"  onclick="goToURL(/*href*/'PlanManager.PlanTask.jsp?planid=<%=sPLAN_ID%>')"><%=sPLAN_ID%></a></td>
				             <td class="coltext" ><%=sPLAN_NAME%></td>
				             <td class="coltext"><%=sSTART_TIME%></td>
				             <td class="coltext"><%=sEND_TIME %></td>
				             <td class="coltext"><%=sPLANNER_NAME %></td>
				             <td class="coltext"><%=sFLAG_NAME%></td>
				             <td class="coltext"><%=sCREATE_TIME%></td>			             
				         </tr>
	         	<%
	         		}
	         	 %>
	         	 <%
	         	 	if(i%2==0)
	         	 	{
	         	  %>
				        <tr> 
				             <td class="coltext2"><div align="center"><input type="radio" name="planidradio" value="<%out.print(sPLAN_ID+"|"+sFLAG);%>"></div></td>				             
				             <td class="coltext2">(<%=j%>)</td>
				             <td class="coltext2" ><a href="#"  onclick="goToURL(/*href*/'PlanManager.PlanTask.jsp?planid=<%=sPLAN_ID%>')"><%=sPLAN_ID%></a></td>
				             <td class="coltext2" ><%=sPLAN_NAME%></td>
				             <td class="coltext2"><%=sSTART_TIME%></td>
				             <td class="coltext2"><%=sEND_TIME %></td>
				             <td class="coltext2"><%=sPLANNER_NAME %></td>
				             <td class="coltext2"><%=sFLAG_NAME%></td>
				             <td class="coltext2"><%=sCREATE_TIME%></td>	
				         </tr>         	  
	         	  <%
	         	  	} 
	         	  %>
	        <%        
	                 j=j+1;
	                 }
	              }  
	         %>   
            <tr> 
                <td width="3%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="37%" class="pagecontenttitle">名称</td>
                <td width="10%" class="pagecontenttitle">计划开始</td>                
                <td width="10%" class="pagecontenttitle">计划结束</td>
                <td width="10%" class="pagecontenttitle">计划制定人</td>
                <td width="10%" class="pagecontenttitle">状态</td>
                <td width="10%" class="pagecontenttitle">建立时间</td>
              </tr>
            </table></td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        </table>      
</td>
</tr>
</table>
</form>
</body>
<%@ include file= "../connections/con_end.jsp"%>
</html>
