<%@include file="../allcheck.jsp"%>
<jsp:useBean id="Approval" scope="page" class="dbOperation.DemandManager" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="ImportRequriment" scope="page" class="dbOperation.ImportRequriment" />


<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<%@ include file= "../connections/con_start.jsp" %>
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
String sProductId="1"; 
String sDEMAND_ID =    "";
String sDEMAND_TITLE = "";
String sVERSION_ID =   "";
String sPRODUCT_ID =   "";
String sSUB_SYS_ID =   "";
String sMODULE_ID =    "";
String sDEMAND_TYPE =  "";
String sLEVEL_ID =     "";
String sFINISHTIME=    "";
String sDEMAND_DESC =  "";
String sSTATUS =  "";

String sPLAN_DEV_BEGIN_TIME =  "";
String sPLAN_DEV_TIME =  "";
String sREAL_DEV_TIME = "";
String sREAL_TEST_TIME =  "";


String sDEV_ID = "";
String sTESTER_ID = "";
String sDEMAND_SRC_ID = "";

String sFlag=request.getParameter("sFlag");
if(sFlag==null) sFlag="0";

//获取当前登录操作员
  String sopId=(String)session.getValue("OpId");
  String demandID=(String)request.getParameter("demandID"); 

  
//查询[1]开发中/[3]再处理中的任务单、查询[6]待dev处理的bug单
//Vector vPendingTask=Approval.getPendingTask("1",sopId,"1,3","6");
  
Vector vVersion=QueryBaseData.querySysBaseType("APPLICATION_RECORD","VERSION");
Vector vStatus=QueryBaseData.querySysBaseType("DEMAND_REQUEST","STATUS");

//获取开发人员列表
Vector developers=QueryBaseData.queryOpInfo("","");
Vector testers=QueryBaseData.queryOpInfo("","");


Vector vDemandRequest = ImportRequriment.getDemandRequestById(demandID);
if(vDemandRequest.size()>0){
	HashMap reqMap = (HashMap) vDemandRequest.get(0);
	sDEMAND_ID = (String)reqMap.get("DEMAND_ID");
	sDEMAND_TITLE = (String)reqMap.get("DEMAND_TITLE");
	sVERSION_ID = (String)reqMap.get("VERSION_ID"); 
	sPRODUCT_ID = (String)reqMap.get("PRODUCT_ID");
	sSUB_SYS_ID = (String)reqMap.get("SUB_SYS_ID");
	sMODULE_ID = (String)reqMap.get("MODULE_ID");
	sDEMAND_TYPE = (String)reqMap.get("DEMAND_TYPE");
	sLEVEL_ID = (String)reqMap.get("LEVEL_ID");
	sFINISHTIME=(String)reqMap.get("FINISHTIME"); 
	sDEMAND_DESC = (String)reqMap.get("DEMAND_DESC");
	sSTATUS = (String)reqMap.get("STATUS");
	
	sPLAN_DEV_BEGIN_TIME = (String)reqMap.get("PLAN_DEV_BEGIN_TIME");
	sPLAN_DEV_TIME = (String)reqMap.get("PLAN_DEV_TIME");
	sREAL_DEV_TIME = (String)reqMap.get("REAL_DEV_TIME");
	sREAL_TEST_TIME = (String)reqMap.get("REAL_TEST_TIME");
	
	
	sDEV_ID = (String)reqMap.get("DEV_ID");
	sTESTER_ID = (String)reqMap.get("TESTER_ID");
	sDEMAND_SRC_ID = (String)reqMap.get("DEMAND_SRC_ID"); 
	
	sDEMAND_TITLE = sDEMAND_TITLE.replaceAll("\\n","");
	sDEMAND_TITLE = sDEMAND_TITLE.replaceAll("\\n","");

	sDEMAND_DESC = sDEMAND_DESC.replaceAll("\\n","");
	sDEMAND_DESC = sDEMAND_DESC.replaceAll("\r","");

	
	if(sDEMAND_SRC_ID==null) sDEMAND_SRC_ID="";
	if(sPLAN_DEV_BEGIN_TIME==null) sPLAN_DEV_BEGIN_TIME="";
	if(sPLAN_DEV_TIME==null) sPLAN_DEV_TIME="";
	if(sREAL_DEV_TIME==null) sREAL_DEV_TIME="";
	if(sREAL_TEST_TIME==null) sREAL_TEST_TIME="";

	

}


%>

<script>

var sVal1 = '<%=sVERSION_ID%>';
var sVal2 = '<%=sPRODUCT_ID%>';
var sVal3 = '<%=sSUB_SYS_ID%>';
var sVal4 = '<%=sMODULE_ID%>';
var sVal5 = '<%=sDEMAND_TYPE%>';
var sVal6 = '<%=sLEVEL_ID%>';
var sVal7 = '<%=sDEMAND_DESC%>';
var sVal8 = '<%=sSTATUS%>';
var sVal9 = '<%=sPLAN_DEV_TIME%>';
var sVal10 = '<%=sREAL_TEST_TIME%>';
var sVal11 = '<%=sDEV_ID%>';
var sVal12 = '<%=sTESTER_ID%>';
var sVal13 = '<%=sDEMAND_TITLE%>';

var sVal14 = '<%=sREAL_DEV_TIME%>';
var sVal15 = '<%=sPLAN_DEV_BEGIN_TIME%>';

window.onload = function() { 
	
document.getElementById("versionid").value = sVal1;
document.getElementById("PRODUCT_ID").value = sVal2;

if(sVal3 != "" && sVal3 != null){
	document.getElementById("select_subsys").value = sVal3;
	getModuleChange();
}

document.getElementById("MODULE_ID").value = sVal4;
document.getElementById("DEMAND_TYPE").value = sVal5;
document.getElementById("LEVEL_ID").value = sVal6;
document.getElementById("remark").value = sVal7;
document.getElementById("STATUS").value = sVal8;

document.getElementById("SELECT_DEVLOPER").value = sVal11;
document.getElementById("SELECT_TESTER").value = sVal12;
document.getElementById("demand_title").value = sVal13;


}


</script>	

<%
	String sTemp= "";
	String sdate_s = "";
	String sDate="";
	String ssql16=""; 
	String ssql17=""; //获取所有子系统下的所有模块
	String ssql19=""; //获取指定子系统
	String ssql23=""; //获取指定一个产品下的子系统
	String ssql24=""; //获取指定一个子系统下的模块
	String ssql30=""; //获取指定所有产品下的所有子系统
	ResultSet rs16=null;
	ResultSet rs17=null;
	ResultSet rs19=null;	
	ResultSet rs23=null;
	ResultSet rs24=null;
	ResultSet rs30=null;
	Statement stmt16 = conn.createStatement();
	Statement stmt17 = conn.createStatement();
	Statement stmt19 = conn.createStatement();	
	Statement stmt23 = conn.createStatement();
	Statement stmt24 = conn.createStatement();
	Statement stmt30 = conn.createStatement();
	
	String defProduct ="1";
	String defSubsys ="";
	String defModule ="";
	String defGroup ="";
	String defOperator="";
	String Products="("+sProductId+")";
	
	try
	{		
		
		ssql16="select to_char(sysdate+7,'YYYY-MM-DD') sdate_s,to_char(sysdate,'YYYY-MM-DD') sdate from dual";
		try
		{
			rs16 = stmt16.executeQuery(ssql16);
			while(rs16.next())
			{
				sDate = rs16.getString("sdate");
				sdate_s = rs16.getString("sdate_s");
			}
		}	
	    catch(Exception e)
		{
	       out.println(e.toString());
		}
		
		
		
		ssql17="select subsys_id as upid,module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		      +" from product_detail  where status = 1 and product_id in  "+Products+" order by upid,name";
		System.out.println("ssql17="+ssql17+";\n");
		if(ssql17!="")
		{
			try
			{
				rs17 = stmt17.executeQuery(ssql17);
			}	
		    catch(Exception e)
			{
		       out.println(e.toString());
			}
		}

		  ssql19 = " select product_id id,product_name,'['||product_id||']'||product_name as name "
		      +" from product where product_id in "+Products+" order by name ";
		  System.out.println("ssql19="+ssql19+";\n");
		  try
		  {
			  rs19 = stmt19.executeQuery(ssql19);
		  }
	      catch(Exception e)
		 {
	       out.println(e.toString());
		  }
		
		ssql23=" select subsys_id as id,substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn as name "
		      +" from subsys_def  where status=1 and PRJ_ID ='"+ defProduct +"' order by name";
		System.out.println("ssql23="+ssql23+";\n");
		try{
			rs23 = stmt23.executeQuery(ssql23);
		}
	    catch(Exception e)
		{
	       out.println(e.toString());
		 }
		
		ssql24="select module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		      +" from product_detail  where  STATUS=1 and  SUBSYS_ID ='"+defSubsys+"' order by name";
		System.out.println("ssql24="+ssql24+";\n");
		try
		{
			rs24 = stmt24.executeQuery(ssql24);
		}
	    catch(Exception e)
		{
	       out.println(e.toString());
		 }
		 
		ssql30="select prj_id as upid, subsys_id as id,"
		      +"substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn as name "
		      +"from subsys_def where status = 1 and prj_id in  "+Products+" order by upid,name";
//	   out.println("ssq30="+ssql30+";\n");
	   if (ssql30!=null)
	  	{
			try
			{
				rs30 = stmt30.executeQuery(ssql30);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}
	 	
	 			ssql30="select prj_id as upid, subsys_id as id,"
		      +"substr(subsys_name_cn,instr(subsys_name_cn,'(')+1,instr(subsys_name_cn,')')-instr(subsys_name_cn,'(')-1)||' -- '||subsys_name_cn as name "
		      +"from subsys_def where status = 1 and prj_id in  "+Products+" order by upid,name";
//	   out.println("ssq30="+ssql30+";\n");
	   if (ssql30!=null)
	  	{
			try
			{
				rs30 = stmt30.executeQuery(ssql30);
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

<title>Requisitions</title>

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

function commit(form)
{   
	  //var a=form.requirement.value;
      var sTitle = document.getElementById("DEMAND_TITLE").value;
	  var sVersion = document.all.versionid.options[document.all.versionid.selectedIndex].value;
	  var sProduct = document.all.PRODUCT_ID.options[document.all.PRODUCT_ID.selectedIndex].value;
      var sSubSystem = document.all.select_subsys.options[document.all.select_subsys.selectedIndex].value;
      var sModule = document.all.MODULE_ID.options[document.all.MODULE_ID.selectedIndex].value;
      var sRemark = document.getElementById("remark").value;
      var sFinishTime = document.getElementById("FINISHTIME").value;
	  var sDemandType = document.all.versionid.options[document.all.DEMAND_TYPE.selectedIndex].value;
      var sLevelId = document.all.versionid.options[document.all.LEVEL_ID.selectedIndex].value;

      var sPlanDevBeginTime = document.getElementById("PLAN_DEV_BEGIN_TIME").value;
      var sPlanDevTime = document.getElementById("PLAN_DEV_TIME").value;
      var sRealDevTime = document.getElementById("REAL_DEV_TIME").value;
      var sRealTestTime = document.getElementById("REAL_TEST_TIME").value;      
      
      var sSelectDevloper = document.getElementById("SELECT_DEVLOPER").value;
      var sSelectTester = document.getElementById("SELECT_TESTER").value;
      var sDemandSrcId = document.getElementById("DEMAND_SRC_ID").value;

               
	  
     if(sTitle == ""){alert("请填写 标题 后再点击<提交申请>按钮!"); document.all.demand_title.focus();return;}
     if(sVersion == ""){alert("请选择 产品版本 后再点击<提交申请>按钮!");document.all.versionid.focus();return;}
     if(sProduct == ""){alert("请选择 产品 后再点击<提交申请>按钮!");document.all.PRODUCT_ID.focus();return;} 
 	 if(sSubSystem == ""){alert("请选择 子系统 后再点击<提交申请>按钮!");document.all.select_subsys.focus();return;}       
     if(sModule == ""){alert("请选择 模块 后再点击<提交申请>按钮!");document.all.MODULE_ID.focus();return;}
     if(sDemandType == ""){alert("请选择 需求类别  后再点击<提交申请>按钮!");document.all.DEMAND_TYPE.focus();return;}
     if(sLevelId == ""){alert("请选择 紧急程度  后再点击<提交申请>按钮!");document.all.LEVEL_ID.focus();return;}
     if(sFinishTime == ""){alert("请填写 期望完成时间 后再点击<提交申请>按钮!");document.all.FINISHTIME.focus();return;}
     if(sRemark == ""){alert("请填写 需求描述 后再点击<提交申请>按钮!");document.all.remark.focus();return;}
  
	 form.submit();
	
}


function onProductChange()
	{
		var value1=document.getElementById("PRODUCT_ID").value;

		//取模块信息
		//getSubsys();	
		getSubsysChange();	
	
	}

function getSubsysChange()
	{
		var value1=document.getElementById("PRODUCT_ID").value;
	
		//取子系统信息
		//document.getElementById("select_subsys").options.length=1;
		//document.getElementById("MODULE_ID").options.length=1;
		var lenOption=document.getElementById("allSubsys").options.length;
		var rValue;
		for (var i=0;i<document.getElementById("allSubsys").options.length;i++)
		{
		  len = document.getElementById("allSubsys").options[i].value.indexOf("*");
		  if (document.getElementById("allSubsys").options[i].value.substring(0,len)==value1)
		  {
			  var o = document.createElement("OPTION");
		      o.text = document.getElementById("allSubsys").options[i].text;
		      o.value=document.getElementById("allSubsys").options[i].value.substring(len+1);
			  document.getElementById("select_subsys").add(o);
		  }
		}
	}	
	
function getModuleChange()
	{
		var value1=document.getElementById("select_subsys").value;
	
		//取子系统信息
		//document.getElementById("MODULE_ID").length=1;
		var lenOption=document.getElementById("allModule").options.length;
		var rValue;
		
		for (var i=0;i<document.getElementById("allModule").options.length;i++)
		{
		  len = document.getElementById("allModule").options[i].value.indexOf("*");
		  if (document.getElementById("allModule").options[i].value.substring(0,len)==value1)
		  {
			  var o = document.createElement("OPTION");
		      o.text = document.getElementById("allModule").options[i].text;
		      o.value=document.getElementById("allModule").options[i].value.substring(len+1);
			  document.getElementById("MODULE_ID").add(o);
		  }
		}
	}


var Flag=<%=sFlag%>
if(Flag=='1')
{
alert("提交成功！");
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="Requisitions" method="post" action="DemandManager.OperDemand.jsp"> 
<input type="hidden" value="<%out.print("");%>" name="slips">
<input type="hidden" value="<%out.print("");%>" name="sassignment">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">       
          <td><br></br>需求补录:
          <br></br>
          </td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          <tr class="contentbg"><td class="pagetitle1">基本信息：</td></tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
              	<tr class="contentbg" style="display:none">
    				<td  align="right" class="pagetitle1">需求编号：</td>
    				<td colspan="4"><input name="DEMAND_ID" type="text" class="inputstyle" id="DEMAND_ID"  readonly="readonly"  value=<%out.print(sDEMAND_ID);%> size="90"></td>
    			</tr>
                <tr class="contentbg">
    				<td  align="right" class="pagetitle1">标&nbsp;&nbsp;&nbsp;题：<font color=red>*</font></td>
    				<td colspan="4"><input name="DEMAND_TITLE" type="text" class="inputstyle" id="demand_title" readonly="readonly"  value=<%out.print(sDEMAND_TITLE);%> size="90"></td>
    			</tr>
                
                <tr>
                  <td align="right" width="15%" class="pagetitle1">产品版本：<font color=red>*</font></td>
                  <td width="35%"><select  name="VERSION_ID" id="versionid" class="inputstyle" size="1">
                 <option value="" selected>------------ 请选择 ------------</option>
                     <%
						String sId="";
	                    String sName="";
	                    if(vVersion.size()>0)
					  	{
					  		for(int j=vVersion.size()-1;j>=0;j--)
					  		{
					  			HashMap Version = (HashMap) vVersion.get(j);
					  			sId = (String)Version.get("CODE_VALUE");
					  			sName = (String)Version.get("CNAME");
					  	%>
					  	<option value="<%=sId%>" > <%out.print("["+sId+"] "+sName);%></option>   
					  	<%
					  		}
					  	}
					 %>
                    </select>
                  
                  </td>
        
                  <td width="15%" class="pagetitle1" align="right">产品：<font color=red>*</font></td>
                  <td width="35%"><select  name="PRODUCT_ID" class="inputstyle" id="PRODUCT_ID"  onChange="onProductChange();" >
                      <option value="" selected> ------------ 请选择 ------------ </option>
                   	  <%
						while(rs19.next())
						{
					  %>
                      <option value="<%=rs19.getString("id")%>"  > <%=rs19.getString("name")%></option>
                      <%
						}
					  %>           
                    </td>
                </tr>
                    
                
                 <tr>
                  <td class="pagetitle1" align="right">子系统：<font color=red>*</font></td>
                  <td><select  name="select_subsys" id="select_subsys" size="1"  class="inputstyle"  onChange="getModuleChange();">
                      <option value="" selected> ------------ 请选择 ------------ </option>
                     <%
						while(rs23.next())
						{
					 %>
                      <option value="<%=rs23.getString("id")%>" > <%=rs23.getString("name")%></option>
                     <%
						}
					 %>
                    </select>
                    <DIV align=left style="display:none">
                      <select name="allSubsys" id="allSubsys">
                        <%
							while(rs30.next())
							{
							sTemp= rs30.getString("upid")+"*"+rs30.getString("id");
						%>
						<option value="<%=sTemp%>"> <%=rs30.getString("name")%></option>
                        <%
							}
						%>
                      </select>
                    </DIV>                  
                    </td>
                              
                  <td class="pagetitle1" align="right" >模块：<font color=red>*</font></td>
                  <td><select  name="MODULE_ID" class="inputstyle" id="MODULE_ID"  >
                      <option value="" selected> ------------ 请选择 ------------ </option>
                      <%
						while(rs24.next())
						{
					  %>
                      <option value="<%=rs24.getString("id")%>" ><%=rs24.getString("name")%></option>
                      <%
						}
					  %>
                    </select>
                    <DIV align=left style="display:none">
                      <select name="allModule" id="allModule">
                        <%
						  while(rs17.next())
						   {
							  sTemp= rs17.getString("upid")+"*"+rs17.getString("id");
						%>
                        <option value="<%=sTemp%>"> <%=rs17.getString("name")%></option>
                        <%
							}
						%>
                      </select>
                    </DIV>                  
                    </td>
                </tr>
               <!--   
                <tr>
                  <td class="pagetitle1" align="right">涉及变更：
                  <td>
                  <input type="checkbox" name="mult"><font class="pagetextdetails"><%out.print("是否复合需求");%>&nbsp;&nbsp;</font>
                  <input type="checkbox" name="DB"><font class="pagetextdetails"><%out.print("是否有DB变更");%>&nbsp;&nbsp;</font>
                  </td>
                </tr>-->

				<tr>
    				<td class="pagetitle1" align="right" >需求类别：<font color=red>*</font></td>
    				<td><select name="DEMAND_TYPE" size="1" class="inputstyle" id="DEMAND_TYPE" >
                      <option value=""> ------------ 请选择 ------------ </option>
                      <option value="1" selected> 新增功能 </option>
                      <option value="2" > 现有功能优化 </option>
                      
                     </select></td>
    			  <td class="pagetitle1" align="right" >紧急程度：<font color=red>*</font></td>
    			  <td><select name="LEVEL_ID" id="LEVEL_ID" size="1" class="inputstyle" >
                      <option value=""> ------------ 请选择 ------------ </option>
                      <option value="1" > 紧急 </option>
                      <option value="2" > 一般 </option>
                    </select></td>
                </tr>
                <tr>
  				  <td align="right" width="15%" class="pagetitle1">需求状态：<font color=red>*</font></td>
                  <td width="35%"><select  name="STATUS" id="STATUS" class="inputstyle" size="1">
                 <option value="" selected>------------ 请选择 ------------</option>
                     <%
						String sStatusId="";
	                    String sStatusName="";
	                    if(vStatus.size()>0)
					  	{
					  		for(int j=vStatus.size()-1;j>=0;j--)
					  		{
					  			HashMap Status = (HashMap) vStatus.get(j);
					  			sStatusId = (String)Status.get("CODE_VALUE");
					  			sStatusName = (String)Status.get("CNAME");
					  	%>
					  	<option value="<%=sStatusId%>" > <%out.print("["+sStatusId+"] "+sStatusName);%></option>   
					  	<%
					  		}
					  	}
					 %>
                    </select>
                  
                  </td>
                </tr>
                
                <tr>
                   	<td class="pagetitle1" align="right" >期望完成时间：<font color=red>*</font></td>
    				<td class="pagetitle1"><input name="FINISHTIME" type="text" class="inputstyle" id="FINISHTIME"  onClick="JSCalendar(this);" value=<%out.print(sFINISHTIME);%> size="10">
                    <font color="#FF00FF">(YYYY-MM-DD)</font></td>
    			</tr>
    			
                <tr class="contentbg">
    			  <td class="pagetitle1" align="right" >需求描述:<font color=red>*</font></td>
                  <td colspan="3">
                  <textarea class="inputstyle" rows="9" name="REMARK" id="remark"  cols="100" ></textarea>
                  </td>
                </tr>
               
               
               <tr class="contentbg"><td class="pagetitle1">补录信息：</td></tr>
               
               
               <tr>
    				<td  align="right" class="pagetitle1">复合需求ID：</td>
    				<td colspan="2"><input name="DEMAND_SRC_ID" type="text" class="inputstyle" id="DEMAND_SRC_ID"   size="50" value=<%out.print(sDEMAND_SRC_ID);%> ></td>
    			</tr>
               
               <tr>
                <td class="pagetitle1" align="right">开发人员：</td>
                  <td><select  name="SELECT_DEVLOPER" id="SELECT_DEVLOPER" size="1"  class="inputstyle">
                      <option value="" selected> ------------ 请选择 ------------ </option>
                     <%
                     if(developers.size()>0){
						for( int i=0;i<developers.size();i++)
						{
							HashMap devloper=(HashMap)developers.get(i);
					 %>
                      <option value="<%=devloper.get("OP_ID")%>"> <%=devloper.get("OP_NAME")%></option>
                     <%
						}
						}
					 %>
                    </select>
                  <td class="pagetitle1" align="right">测试人员：</td>
                  <td><select  name="SELECT_TESTER" id="SELECT_TESTER" size="1"  class="inputstyle">
                      <option value="" selected> ------------ 请选择 ------------ </option>
                     <%
                     if(testers.size()>0){
						for( int i=0;i<testers.size();i++)
						{
							HashMap tester=(HashMap)testers.get(i);
					 %>
                      <option value="<%=tester.get("OP_ID")%>"> <%=tester.get("OP_NAME")%></option>
                     <%
						}
						}
					 %>
                    </select>
               </tr>
               
               <tr>
                    <td class="pagetitle1" align="right" >开发计划开始时间：</td>
    				<td class="pagetitle1"><input name="PLAN_DEV_BEGIN_TIME" type="text" class="inputstyle" id="PLAN_DEV_BEGIN_TIME"  onClick="JSCalendar(this);" size="10" value=<%out.print(sPLAN_DEV_BEGIN_TIME);%> >
                    <font color="#FF00FF">(YYYY-MM-DD)</font></td>
                    
                   	<td class="pagetitle1" align="right" >开发计划完成时间：</td>
    				<td class="pagetitle1"><input name="PLAN_DEV_TIME" type="text" class="inputstyle" id="PLAN_DEV_TIME"  onClick="JSCalendar(this);" size="10" value=<%out.print(sPLAN_DEV_TIME);%> >
                    <font color="#FF00FF">(YYYY-MM-DD)</font></td>
                    

    			
    			 </tr>
    			 <tr>
    			    <td class="pagetitle1" align="right" >开发实际完成时间：</td>
    				<td class="pagetitle1"><input name="REAL_DEV_TIME" type="text" class="inputstyle" id="REAL_DEV_TIME"  onClick="JSCalendar(this);" size="10" value=<%out.print(sREAL_DEV_TIME);%> >
                    <font color="#FF00FF">(YYYY-MM-DD)</font></td>
                     
    			    <td class="pagetitle1" align="right" >测试实际完成时间：</td>
    				<td class="pagetitle1"><input name="REAL_TEST_TIME" type="text" class="inputstyle" id="REAL_TEST_TIME"  onClick="JSCalendar(this);" size="10" value=<%out.print(sREAL_TEST_TIME);%> >
                    <font color="#FF00FF">(YYYY-MM-DD)</font></td>
    			
    			</tr>
                  
	  			<tr> 
	          	<td class="contentbottomline"><div align="left"> 
	                <tr> 
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1"></table></td>
	             <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	             <tr> 
	                <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">提交
      				<input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="commit(this.form)" ></td>
	             </tr>                
             </table></td></tr></table></td></tr></table></td></tr></table></td></tr></table></form>
</body>
<%@ include file= "../connections/con_end.jsp"%>




</html>
                

                