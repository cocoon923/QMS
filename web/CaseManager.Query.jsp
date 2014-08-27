<%@include file="allcheck.jsp"%>
<jsp:useBean id="CaseQuery" scope="page" class="dbOperation.CaseQuery" />
<jsp:useBean id="CaseInfo" scope="page" class="dbOperation.CaseInfo" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<%@ include file= "connections/con_start.jsp" %>

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


<%
//获取本页面参数，查询case信息
String sSTARTTIME=request.getParameter("sStartTime");
if(sSTARTTIME==null)
{
	sSTARTTIME="";
}
else sSTARTTIME=sSTARTTIME.trim();

String sENDTIME=request.getParameter("sEndTime");
if(sENDTIME==null)
{
	sENDTIME="";
}
else sENDTIME=sENDTIME.trim();

String sPRODUCTID=request.getParameter("sProductId");
if(sPRODUCTID==null)
{
	sPRODUCTID="";
}
else sPRODUCTID=sPRODUCTID.trim();

String sSUBSYSID=request.getParameter("sSubSysId");
if(sSUBSYSID==null)
{
	sSUBSYSID="";
}
else sSUBSYSID=sSUBSYSID.trim();

String sMODULEID=request.getParameter("sModuleId");
if(sMODULEID==null)
{
	sMODULEID="";
}
else sMODULEID=sMODULEID.trim();

String sGROUPID=request.getParameter("sGroupId");
if(sGROUPID==null)
{
	sGROUPID="";
}
else sGROUPID=sGROUPID.trim();

String sOPID=request.getParameter("sOpid");
if(sOPID==null)
{
	sOPID="";
}
else sOPID=sOPID.trim();

String sTYPE=request.getParameter("sType");
if(sTYPE==null)
{
	sTYPE="";
}
else sTYPE=sTYPE.trim();

String sVALUE=request.getParameter("sValue");
if(sVALUE==null)
{
	sVALUE="";
}
else sVALUE=sVALUE.trim();

String sOPERA=request.getParameter("sOpera");
if(sOPERA==null)
{
	sOPERA="";
}
else sOPERA=sOPERA.trim();


//out.print("sOPERA="+sOPERA+";sSTARTTIME="+sSTARTTIME+";sENDTIME="+sENDTIME+";sPRODUCTID="+sPRODUCTID+";sSUBSYSID="+sSUBSYSID+";sMODULEID="+sMODULEID+";sGROUPID="+sGROUPID+";sOPID="+sOPID+";sTYPE="+sTYPE+";sVALUE="+sVALUE);
int iCount=0;
int iList=0;
Vector vCaseInfo=new Vector();
Vector vRemandRelationList=new Vector();
if(sOPERA.equals("1"))
{
	if(sTYPE.equals("1") && !sVALUE.equals(""))
	{
		vRemandRelationList=CaseInfo.queryDemandRealtionIn("",sVALUE,"0");
		iList=vRemandRelationList.size();
		if(iList>0)
		{
		%>
		  <script language="JavaScript">
	      	alert("查询的需求编号中存在关联其他需求的编号，此处查询出源需求信息！");
		  </script> 
		<%
		}
	}
	vCaseInfo=CaseQuery.queryCaseInfoall(sSTARTTIME,sENDTIME,sPRODUCTID,sSUBSYSID,sMODULEID,sGROUPID,sOPID,sTYPE,sVALUE);
	iCount=vCaseInfo.size();
}
  

%>

<script language="javascript">

//去左空格; 
	function ltrim(s)
	{ 
		return s.replace( /^\s*/, ""); 
	} 

//去右空格; 
	function rtrim(s)
	{ 
		return s.replace( /\s*$/, ""); 
	}
	 
//去左右空格; 
	function trim(s)
	{ 
		return rtrim(ltrim(s)); 
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
		document.getElementById("select_subsys").options.length=1;
		document.getElementById("MODULE_ID").options.length=1;
		var lenOption=document.getElementById("allSubsys").options.length;
		var rValue;
		for (var i=0;i<document.getElementById("allSubsys").options.length;i++)
		{
		  len = document.getElementById("allSubsys").options[i].value.indexOf("*");
		  if (document.getElementById("allSubsys").options[i].value.substring(0,len)==value1)
		  {
				//alert(document.open.allProject.options[i].value.substring(0,len)+":"+value1);
				//document.getElementById("select_subsys").add(window.Option.create(document.getElementById("allSubsys").options[i].text,document.getElementById("allSubsys").options[i].value.substring(len+1),0));
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
		document.getElementById("MODULE_ID").length=1;
		var lenOption=document.getElementById("allModule").options.length;
		var rValue;

		for (var i=0;i<document.getElementById("allModule").options.length;i++)
		{
		  len = document.getElementById("allModule").options[i].value.indexOf("*");
		  if (document.getElementById("allModule").options[i].value.substring(0,len)==value1)
		  {
				//alert(document.open.allProject.options[i].value.substring(0,len)+":"+value1);
				  //document.getElementById("MODULE_ID").add(window.Option.create(document.getElementById("allModule").options[i].text,document.getElementById("allModule").options[i].value.substring(len+1),0));
				  var o = document.createElement("OPTION");
			      o.text = document.getElementById("allModule").options[i].text;
			      o.value=document.getElementById("allModule").options[i].value.substring(len+1);
				  document.getElementById("MODULE_ID").add(o);
		  }
		}
	}
	
	function getGroupChange()
	{
		var value1=document.getElementById("GROUP_ID").value;
	
		//取子系统信息
		document.getElementById("OP_ID").length=1;
		var lenOption=document.getElementById("allOperator").options.length;
		var rValue;

		for (var i=0;i<document.getElementById("allOperator").options.length;i++)
		{
		  len = document.getElementById("allOperator").options[i].value.indexOf("*");
		  if (document.getElementById("allOperator").options[i].value.substring(0,len)==value1)
		  {
				//alert(document.open.allProject.options[i].value.substring(0,len)+":"+value1);
				document.getElementById("OP_ID").add(window.Option.create(document.getElementById("allOperator").options[i].text,document.getElementById("allOperator").options[i].value.substring(len+1),0));
		  }
		}
	}	

function empty()    
	{
		document.open.submit();	
	}
	

function FP_goToQueryURL(url)
{
	var sStartTime="";
	var sEndTime="";
	var sProductId="";
	var sSubSysId="";
	var sModuleId="";
	var sGroupId="";
	var sOpid="";
	var sType="";
	var sValue="";
	var sDemandId="";
	var sRequestId="";

	if(document.CaseQuery.chk_date.checked==true)
	{
    	sStartTime=document.getElementById('startTime').value;
    	sEndTime=document.getElementById('endTime').value;
    }
    sProductId=document.getElementById('PRODUCT_ID').value;
    sSubSysId=document.getElementById('select_subsys').value;
    sModuleId=document.getElementById('MODULE_ID').value;
    sGroupId=document.getElementById('GROUP_ID').value;
    sOpid=document.getElementById('OP_ID').value;
    sDemandId=document.getElementById('demand_id').value;
    sRequestId=document.getElementById('request_id').value;
    
    //根据界面上获取的需求、故障id，转换为存到数据库表中的类型和值，查询用
    if(sDemandId!="" && sRequestId=="")
    {
    	sType="1";
    	sValue=sDemandId;
    }
    else if(sDemandId=="" && sRequestId!="")
    {
    	sType="2";
    	sValue=sRequestId;
    }
    else if (sDemandId!="" && sRequestId!="")
    {
    	sType="1,2";
    	sValue=sDemandId+","+sRequestId;
    }
    else
    {
    	sType="";
    	sValue="";
    }
    //处理时间格式为：YYYYMMDDhh24miss

    if((sStartTime!=null)&&(sStartTime!=""))
    {
    	var time=sStartTime.replace("-","");
    	time=time.replace("-","");
    	sStartTime=time+"000000";
    }
    if((sEndTime!=null)&&(sEndTime!=""))
    {
    	var time=sEndTime.replace("-","");
    	time=time.replace("-","");
    	sEndTime=time+"235959";
    }
    
    //alert("&sStartTime="+sStartTime+"&sEndTime="+sEndTime+"&sProductId="+sProductId+"&sSubSysId="+sSubSysId+"&sModuleId="+sModuleId+"&sGroupId="+sGroupId+"&sOpid="+sOpid+"&sType="+sType+"&sValue="+sValue);
    window.location=url+"&sStartTime="+sStartTime+"&sEndTime="+sEndTime+"&sProductId="+sProductId+"&sSubSysId="+sSubSysId+"&sModuleId="+sModuleId+"&sGroupId="+sGroupId+"&sOpid="+sOpid+"&sType="+sType+"&sValue="+sValue;
}


function openNewWindow(sid)
{
       var sId=sid.substr(1,sid.length);
       if((sid.substr(0,1))=="R") //需求
       {
          //window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sId);
       }
       else     //故障F
       {
          //window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sId);
       }
}
function openNewCaseWindow(sid)
{
	var iindex=sid.indexOf(",");
	var sID=sid.substr(0,iindex);
	var sCASESEQ=sid.substr(iindex+1,sid.length);
	//alert(sID);
	//alert(sCASESEQ);
	
	window.open("CaseManager.CaseDetail.jsp?requirement="+sID+"&caseId="+sCASESEQ);
}

</script>
<%
	String sTemp= "";
	String sdate_s = "";
	String sDate="";
	String ssql6="";  //获取数据库系统时间sql
	String ssql17=""; //获取所有子系统下的所有模块
	String ssql19=""; //获取指定子系统
	String ssql23=""; //获取指定一个产品下的子系统
	String ssql24=""; //获取指定一个子系统下的模块
	String ssql30=""; //获取指定所有产品下的所有子系统
	String ssql51=""; //获取部门内所有组
	String ssql52=""; //获取部门内所有小组所有成员
	String ssql53=""; //获取部门内指定一个小组的成员	
	ResultSet rs6=null;	
	ResultSet rs17=null;
	ResultSet rs19=null;	
	ResultSet rs23=null;
	ResultSet rs24=null;
	ResultSet rs30=null;
	ResultSet rs51=null;
	ResultSet rs52=null;
	ResultSet rs53=null;	
	Statement stmt6 = conn.createStatement();
	Statement stmt17 = conn.createStatement();
	Statement stmt19 = conn.createStatement();	
	Statement stmt23 = conn.createStatement();
	Statement stmt24 = conn.createStatement();
	Statement stmt30 = conn.createStatement();
	Statement stmt51 = conn.createStatement();
	Statement stmt52 = conn.createStatement();
	Statement stmt53 = conn.createStatement();
	
	String defProduct ="1";
	String defSubsys ="";
	String defModule ="";
	String defGroup ="";
	String defOperator="";
	String Products="(1)";
	
	try
	{		
		ssql6="select to_char(sysdate-1,'YYYY-MM-DD') sdate_s,to_char(sysdate,'YYYY-MM-DD') sdate from dual";
//		out.println("ssql6="+ssql6+";\n");
		try
		{
			rs6 = stmt6.executeQuery(ssql6);
			while(rs6.next())
			{
				sDate = rs6.getString("sdate");
				sdate_s = rs6.getString("sdate_s");
			}
		}	
	    catch(Exception e)
		{
	       out.println(e.toString());
		}
		
		ssql17="select subsys_id as upid,module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		      +" from product_detail  where status = 1 and product_id in  "+Products+" order by upid,name";
//		out.println("ssql17="+ssql17+";\n");
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
//		  out.println("ssql17="+ssql17+";\n");
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
//		out.println("ssql23="+ssql23+";\n");
		try{
			rs23 = stmt23.executeQuery(ssql23);
		}
	    catch(Exception e)
		{
	       out.println(e.toString());
		 }
		
		ssql24="select module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		      +" from product_detail  where  STATUS=1 and  SUBSYS_ID ='"+defSubsys+"' order by name";
//		out.println("ssql24="+ssql24+";\n");
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
		      +" from group_op_info a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id";
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
		      +" from group_op_info a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id"
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
	 	
		
	}	
	finally
	{
	}
			


 %>
<title>casequery</title>

<link href="css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>

<script language="JavaScript" type="text/JavaScript">
	function changecolor(obj){
	obj.className = "buttonstyle2"}
	function restorcolor(obj){
	obj.className = "buttonstyle"}
	function loadPage(url) {
		window.location = url;
	}

	function empty()    
	{
		document.open.submit();	
	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="CaseQuery" method="post" onSubmit="return empty()"> 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>查询CASE:<br></td>
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
                <tr >
                  <td width="13%" class="pagetitle1"><div align="left">查询日期： </div>
                    <div align="right"> </div></td>
                  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_date" checked>
                    <input name="startTime" type="text" class="inputstyle" id="startTime"  onClick="JSCalendar(this);"  value="<%=sdate_s%>" size="10">
                    ---
                    <input name="endTime" type="text" class="inputstyle" id="endTime" value="<%=sDate%>" size="10"  onClick="JSCalendar(this);" ></td>
                </tr>
                <tr class="contentbg">
                  <td class="pagetitle1">产品名称：</td>
                  <td><font color="#0000FF">
                    <select style= "width: 550px; " name="PRODUCT_ID" class="inputstyle" id="PRODUCT_ID" onChange="onProductChange();">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                   	  <%
						while(rs19.next())
						{
					  %>
                      <option value="<%=rs19.getString("id")%>"  > <%=rs19.getString("name")%></option>
                      <%
						}
					  %>                
                    </select>
                    </font></td>
                </tr>
                <tr>
                  <td class="pagetitle1">子系统：</td>
                  <td><span class="pagetextdetails"><font color="#330099">
                    <select style= "width: 550px; " name="select_subsys" id="select_subsys" size="1"  class="inputstyle"  width="350"  onChange="getModuleChange();">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                     <%
						while(rs23.next())
						{
					 %>
                      <option value="<%=rs23.getString("id")%>" > <%=rs23.getString("name")%></option>
                     <%
						}
					 %>
                    </select>
                    </font>
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
                    </DIV></td>
                </tr>
                <tr class="contentbg">
                  <td class="pagetitle1">模块：</td>
                  <td><font color="#0000FF">
                    <select style= "width: 550px; " name="MODULE_ID" class="inputstyle" id="MODULE_ID">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
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
                <tr >
                  <td class="pagetitle1">人员归属组：</td>
                  <td><select style= "width: 550px; " name="GROUP_ID" class="inputstyle" id="GROUP_ID" onChange="getGroupChange();">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                      <%
						while(rs51.next())
						{
					  %>
                      <option value="<%=rs51.getString("id")%>"> <%=rs51.getString("name")%></option>
                      <%
						}
					  %>  
                    </select>

                <tr class="contentbg">
                  <td class="pagetitle1">编写人员：</td>
                  <td><font color="#0000FF">
                    <select style= "width: 550px; " name="OP_ID" class="inputstyle" id=""OP_ID"">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                      <%
						while(rs53.next())
						{
					  %>
                      <option value="<%=rs53.getString("id")%>" ><%=rs53.getString("name")%></option>
                      <%
						}
					  %>
                    </select>
                    <DIV align=left style="display:none">
                      <select name="allOperator" id="allOperator">
                        <%
						  while(rs52.next())
						   {
							  sTemp= rs52.getString("upid")+"*"+rs52.getString("id");
						%>
                        <option value="<%=sTemp%>"> <%=rs52.getString("name")%></option>
                        <%
							}
						%>
                      </select>
                    </DIV>                  
                    </td>
                </tr>
                
                <tr>
                  <td class="pagetitle1">需求ID：</td>
                  <td class="pagetextdetails">
                  <input name="demand_id" type="text" class="inputstyle" id="demand_id"   size="35"></td></tr>
                <tr class="contentbg" style="display:none;">
                  <td class="pagetitle1">故障ID：</td>
                  <td class="pagetextdetails">
                  <input name="request_id" type="text" class="inputstyle" id="request_id"   size="35"></td></tr>
                <tr>
                <td class="pagetitle1">&nbsp;</td>
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
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToQueryURL(/*href*/'CaseManager.Query.jsp?sOpera=1')">查 询</td>
	                      </tr>
	                    </table></td>
	                  <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                      <tr> 
	                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" >导出EXCEL</td>
	                      </tr>
	                    </table></td>
	                </tr>
	              </table>
	            </div></td>
	        </tr>
	      </table></td>
	  	</tr>
		</table>
		<div align="center"></div>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title"> 
          <td>CASE列表<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">需求编号</td>
                <td width="15%" class="pagecontenttitle">CASE编号<br></td>
                <td width="20%" class="pagecontenttitle">CASE名称<br></td>
                <td width="20%" class="pagecontenttitle">预期结果<br></td>
                <td width="15%" class="pagecontenttitle">CASE模块<br></td>
                <td width="10%" class="pagecontenttitle">CASE编写人<br></td>
                <td width="10%" class="pagecontenttitle">编写人归属组<br></td>
              </tr>
			 <% 
				  String sid="";
			      String scaseId="";
			      String scaseName="";
			      String scaseDesc="";
			      String smoduleId="";
			      String sopName="";
			      String sgroupId="";
			      String scaseSeq="";
			      String sExpResult="";
			      String sModuleId="";
		          String sModuleName="";	
			      int j=1;
			      if(vCaseInfo.size()>0)
			      {
			         for(int i=vCaseInfo.size()-1;i>=0;i--)
			         {
		                HashMap hash = (HashMap) vCaseInfo.get(i);
		                sid = (String) hash.get("ID");
		                scaseId = (String) hash.get("CASE_ID");
		                scaseName = (String) hash.get("CASE_NAME");
		                scaseDesc = (String) hash.get("CASE_DESC");
		                sExpResult = (String) hash.get("EXP_RESULT");
		                smoduleId = (String) hash.get("MODULE_ID");
		                sopName = (String) hash.get("OP_NAME");
		                sgroupId = (String) hash.get("GROUP_NAME");
		                scaseSeq= (String) hash.get("CASE_SEQ");
		                sModuleId = (String) hash.get("MODULE_ID");
						sModuleName = (String) hash.get("MODULE_NAME");
						smoduleId=sModuleName;
		     %>
	        		<%
	        			if(i%2!=0)
	        			{
	        		 %>
				        <tr> 
				             <td class="coltext">(<%=j%>)</td>
				             <td class="coltext" ><a href="
				             <%
				             	String stype=sid.substring(0,1);
				             	if(stype.equals("R"))  //需求
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sid.substring(1,sid.length()));
				             	}
				             	else  //故障
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sid.substring(1,sid.length()));
				             	}
				             %>"   target="_blank"><%=sid%></a></td>
				             <td class="coltext" ><a href="CaseManager.CaseDetail.jsp?requirement=<%=sid%>&caseId=<%=scaseSeq%>" target="_blank"><%=scaseId%><input type="hidden" value=<%=scaseSeq%> name="caseId"></a></td>
				             <td class="coltext10"><%if(scaseName!=null) {scaseName=scaseName.replaceAll("\r\n", "<br>");out.print(scaseName);} else out.print("&nbsp;");%></td>
				             <td class="coltext10"><%if(sExpResult!=null) {sExpResult=sExpResult.replaceAll("\r\n", "<br>");out.print(sExpResult);}else out.print("&nbsp;"); %></td>
				             <td class="coltext"><%if(smoduleId!=null) out.print(smoduleId);else out.print("&nbsp;"); %></td>
				             <td class="coltext"><%if(sopName!=null) out.print(sopName);else out.print("&nbsp;");%></td>
				             <td class="coltext10"><%if(sgroupId!=null) out.print(sgroupId);else out.print("&nbsp;");%></td>
				         </tr>
	         	<%
	         		}
	         	 %>
	         	 <%
	         	 	if(i%2==0)
	         	 	{
	         	  %>
				        <tr> 
				             <td class="coltext2">(<%=j%>)</td>
				             <td class="coltext2"><a href="
				             <%
				             	String stype=sid.substring(0,1);
				             	if(stype.equals("R"))  //需求
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sid.substring(1,sid.length()));
				             	}
				             	else  //故障
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sid.substring(1,sid.length()));
				             	}
				             %>"  target="_blank"><%=sid%></a></td>
				             <td class="coltext2"><a href="CaseManager.CaseDetail.jsp?requirement=<%=sid%>&caseId=<%=scaseSeq%>"  target="_blank"><%=scaseId%><input type="hidden" value=<%=scaseSeq%> name="caseId"></a></td>
				             <td class="coltext20"><%if(scaseName!=null) {scaseName=scaseName.replaceAll("\r\n", "<br>");out.print(scaseName);} else out.print("&nbsp;");%></td>
				             <td class="coltext20"><%if(sExpResult!=null) {sExpResult=sExpResult.replaceAll("\r\n", "<br>");out.print(sExpResult);}else out.print("&nbsp;"); %></td>
				             <td class="coltext2"><%if(smoduleId!=null) out.print(smoduleId);else out.print("&nbsp;"); %></td>
				             <td class="coltext2"><%if(sopName!=null) out.print(sopName);else out.print("&nbsp;");%></td>
				             <td class="coltext20"><%if(sgroupId!=null) out.print(sgroupId);else out.print("&nbsp;");%></td>
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
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">需求编号</td>
                <td width="15%" class="pagecontenttitle">CASE编号<br></td>
                <td width="20%" class="pagecontenttitle">CASE名称<br></td>
                <td width="20%" class="pagecontenttitle">预期结果<br></td>
                <td width="15%" class="pagecontenttitle">CASE模块<br></td>
                <td width="10%" class="pagecontenttitle">CASE编写人<br></td>
                <td width="10%" class="pagecontenttitle">编写人归属组<br></td>
              </tr>
            </table></td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        </td>
        </tr>
        </table>      
</form>

</body>
<%@ include file= "connections/con_end.jsp"%>
</html>
