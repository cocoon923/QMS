<%@include file="../allcheck.jsp"%>
<jsp:useBean id="Approval" scope="page" class="dbOperation.DemandManager" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />

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
String sFlag=request.getParameter("sFlag");
if(sFlag==null) sFlag="0";

//获取当前登录操作员
  String sopId=(String)session.getValue("OpId");
//查询[1]开发中/[3]再处理中的任务单、查询[6]待dev处理的bug单
Vector vPendingTask=Approval.getPendingTask("1",sopId,"1,3","6");
  
Vector vVersion=QueryBaseData.querySysBaseType("APPLICATION_RECORD","VERSION");
Vector vStatus=QueryBaseData.querySysBaseType("DEMAND_REQUEST","STATUS");




%>

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
	  var sDemandType = document.all.DEMAND_TYPE.options[document.all.DEMAND_TYPE.selectedIndex].value;
      var sLevelId = document.all.LEVEL_ID.options[document.all.LEVEL_ID.selectedIndex].value;
      var sStatus = document.all.STATUS.options[document.all.STATUS.selectedIndex].value;

	  
     if(sTitle == ""){alert("请填写 标题 后再点击<提交申请>按钮!"); document.all.demand_title.focus();return;}
     if(sVersion == ""){alert("请选择 产品版本 后再点击<提交申请>按钮!");document.all.versionid.focus();return;}
     if(sProduct == ""){alert("请选择 产品 后再点击<提交申请>按钮!");document.all.PRODUCT_ID.focus();return;} 
 	 if(sSubSystem == ""){alert("请选择 子系统 后再点击<提交申请>按钮!");document.all.select_subsys.focus();return;}       
     if(sModule == ""){alert("请选择 模块 后再点击<提交申请>按钮!");document.all.MODULE_ID.focus();return;}
     if(sDemandType == ""){alert("请选择 需求类别  后再点击<提交申请>按钮!");document.all.DEMAND_TYPE.focus();return;}
     if(sLevelId == ""){alert("请选择 紧急程度  后再点击<提交申请>按钮!");document.all.LEVEL_ID.focus();return;}
     if(sStatus == ""){alert("请填写需求状态 后再点击<提交申请>按钮!");document.all.STATUS.focus();return;}
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
		
	/* 	var s = document.getElementById("MODULE_ID");
		alert(s);
	     for(var i=0;s.length>=0;){
	            s.options[i]=null;
	            s.length--;
	     } */
		//alert("document.length=" + document.getElementById("allModule").options.length);
		for (var i=0;i<document.getElementById("allModule").options.length;i++)
		{
		  len = document.getElementById("allModule").options[i].value.indexOf("*");
		  if (document.getElementById("allModule").options[i].value.substring(0,len)==value1)
		  {
			  var o = document.createElement("OPTION");
		      o.text = document.getElementById("allModule").options[i].text;
		      o.value=document.getElementById("allModule").options[i].value.substring(len+1);
			  document.getElementById("MODULE_ID").add(o);
			  //(window.Option.create(document.getElementById("allModule").options[i].text,document.getElementById("allModule").options[i].value.substring(len+1),0));
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
          <td><br></br>需求单录入:
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
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
                
                <tr class="contentbg" style="display:none">
    				<td  align="right" class="pagetitle1">需求编号：</td>
    				<td colspan="4"><input name="DEMAND_ID" type="text" class="inputstyle" id="DEMAND_ID"  readonly="readonly"  size="90"></td>
    			</tr>
                <tr class="contentbg">
    				<td  align="right" class="pagetitle1">标&nbsp;&nbsp;&nbsp;题：<font color=red>*</font></td>
    				<td colspan="4"><input name="DEMAND_TITLE" type="text" class="inputstyle" id="demand_title" size="90"></td>
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
                  <td width="35%"><select  name="PRODUCT_ID" class="inputstyle" id="PRODUCT_ID" onChange="onProductChange();">
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
                  <td><select  name="MODULE_ID" class="inputstyle" id="MODULE_ID">
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
    				<td><select name="DEMAND_TYPE" size="1" class="inputstyle" id="DEMAND_TYPE">
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
    				<td class="pagetitle1"><input name="FINISHTIME" type="text" class="inputstyle" id="FINISHTIME"  onClick="JSCalendar(this);"  size="10">
                    <font color="#FF00FF">(YYYY-MM-DD)</font></td>
    			</tr>
    			
                <tr class="contentbg">
    			  <td class="pagetitle1" align="right" >需求描述:<font color=red>*</font></td>
                  <td colspan="3">
                  <textarea class="inputstyle" rows="9" name="REMARK" id="remark" cols="100" ></textarea>
                  </td>
                </tr>
                  
	  			<tr> 
	          	<td class="contentbottomline"><div align="left"> 
	                <tr> 
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1"></table></td>
	             <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	             <tr> 
	                <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">提交申请
      				<input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="commit(this.form)" ></td>
	             </tr>                
             </table></td></tr></table></td></tr></table></td></tr></table></td></tr></table></form>
</body>
<%@ include file= "../connections/con_end.jsp"%>
</html>
                
