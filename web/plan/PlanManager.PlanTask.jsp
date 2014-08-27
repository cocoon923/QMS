
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

<%
//获取计划id
String sPlanId=request.getParameter("planid");
String sStartTime="";
String sEndTime="";
String sPlanName="";
String sPlanner="";
String sPlanFlag="";
String sDemand_id="";
String sDemand_id_temp="";
String sOpId=(String)session.getValue("OpId");
if(sOpId==null) sOpId="";
Vector vPlanTaskInfo=new Vector();
Vector vPlanTaskInfoAgain=new Vector();
if(sPlanId==null || sPlanId.equals(""))
{
	out.print("<script language='javascript'>alert('计划编号不能为空!');</script>");
}
else
{
	//取计划基本信息
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
	  	sPlanner=(String) PlanInfohash.get("PLANNER");
	  	sPlanFlag=(String) PlanInfohash.get("FLAG");
	  }
	 //取计划下任务信息 
	 vPlanTaskInfo=PlanManager.queryplantaskinfo(sPlanId,"","","","","","","","","","","");

	//获取此计划下重复的计划任务，拼成串
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
	 
}

String Products="1";
String demand_sta_id="1,2,3,4,5";
String proj_request_id="1,2,3,4,5,6";
String feature_status = "1,2,3,4";

%>

<script language="javascript">	

function empty()    
	{
		document.open.submit();	
	}
	
function ToSubmit(form1)
{
   form1.submit();
}

function FP_goToQueryURL()
{
	//var stype="";
	var srepStartTime="";
	var srepEndTime="";
	var sdevStartTime="";
	var sdevEndTime="";
	var sproductId="";
	var sdemandstatus="";
	var sgroupId="";
	var sOpid="";
	var sDemandId="";
	var sPlanFlag="<%=sPlanFlag%>"

	//获取查询模式，确定是查询故障、还是查询需求,还是查功能点任务单
	for(var i=0;i<document.PlanTaskQuery.type.length;i++)
	{
	    if(document.PlanTaskQuery.type[i].checked)
	    {
	      stype=document.PlanTaskQuery.type[i].value;
	    }
	}
	//alert('stype='+stype);
	
	//获取需求/故障 申报时间段
	if(document.PlanTaskQuery.chk_rep_date.checked==true)
	{
    	srepStartTime=document.getElementById('repstarttime').value;
    	srepEndTime=document.getElementById('rependtime').value;
    }
    //获取开发时间段
    if(document.PlanTaskQuery.chk_dev_date.checked==true)
	{
    	sdevStartTime=document.getElementById('devstarttime').value;
    	sdevEndTime=document.getElementById('devendtime').value;
    }
    //获取产品名称
    var checkbox = document.getElementsByName("productid");     
    for (var i = 0; i < checkbox.length; i++)   
    {   
	    var sproductIdTemp="";
	    if (checkbox[i].checked)   
	    {   
			sproductIdTemp=',' + checkbox[i].value ;  
			sproductId = sproductId + sproductIdTemp; 
	    }   
    }
    sproductId = sproductId.replace(',',''); //去掉第一位逗号,用于拼sql用
    
    //根据查询模式获取查询需求、故障状态
    if(stype=="1")  //需求
    {
	    var checkbox1 = document.getElementsByName("demandstauts");     
	    for (var j = 0; j < checkbox1.length; j++)   
	    {   
		    var sdemandstatusTemp="";
		    if (checkbox1[j].checked)   
		    {   
				sdemandstatusTemp =  ',' + checkbox1[j].value;   
				sdemandstatus = sdemandstatus + sdemandstatusTemp;
		    }
	    }
    }
    else if(stype=="2") //故障
    {
	    var checkbox2 = document.getElementsByName("demandstauts1");     
	    for (var j = 0; j < checkbox2.length; j++)   
	    {   
		    var sdemandstatusTemp="";
		    if (checkbox2[j].checked)   
		    {   
				sdemandstatusTemp = ','+ checkbox2[j].value ;
				sdemandstatus = sdemandstatus +  sdemandstatusTemp  
		    }  
		 }  
    }
    else if (stype=="3") //功能点任务单
    {
    	var checkbox3 = document.getElementsByName("demandstauts2");     
	    for (var j = 0; j < checkbox3.length; j++)   
	    {   
		    var sdemandstatusTemp="";
		    if (checkbox3[j].checked)   
		    {   
				sdemandstatusTemp = ','+ checkbox3[j].value ;
				sdemandstatus = sdemandstatus +  sdemandstatusTemp  
		    }  
		 }  
    }
    sdemandstatus = sdemandstatus.replace(',',''); //去掉第一位逗号,用于拼sql用
    
    //获取归属组
    var checkbox3 = document.getElementsByName("groupid");     
    for (var k = 0; k < checkbox3.length; k++)   
    {   
	    var sgroupIdTemp="";
	    if (checkbox3[k].checked)   
	    {   
			sgroupIdTemp = ',' + checkbox3[k].value;
			sgroupId =  sgroupId +  sgroupIdTemp
	    }
    }
    sgroupId = sgroupId.replace(',',''); //去掉第一位逗号,用于拼sql用
    
    sOpid=document.getElementById('opid').value;
    sDemandId=document.getElementById('demand_id').value;

    //处理时间格式为：YYYYMMDDhh24miss

    if((srepStartTime!=null)&&(srepStartTime!=""))
    {
    	var time=srepStartTime.replace("-","");
    	time=time.replace("-","");
    	srepStartTime=time+"000000";
    }
    if((srepEndTime!=null)&&(srepEndTime!=""))
    {
    	var time=srepEndTime.replace("-","");
    	time=time.replace("-","");
    	srepEndTime=time+"235959";
    }
    if((sdevStartTime!=null)&&(sdevStartTime!=""))
    {
    	var time=sdevStartTime.replace("-","");
    	time=time.replace("-","");
    	sdevStartTime=time+"000000";
    }
    if((sdevEndTime!=null)&&(sdevEndTime!=""))
    {
    	var time=sdevEndTime.replace("-","");
    	time=time.replace("-","");
    	sdevEndTime=time+"235959";
    }
    
//    alert("&srepStartTime="+srepStartTime+"&srepEndTime="+srepEndTime+"&sdevStartTime="+sdevStartTime+"&sdevEndTime="+sdevEndTime+"&stype="+stype+"&sproductId="+sproductId+"&sdemandstatus="+sdemandstatus+"&sgroupId="+sgroupId+"&sOpid="+sOpid+"&sDemandId="+sDemandId);
//    window.location=url+"?srepStartTime="+srepStartTime+"&srepEndTime="+srepEndTime+"&sdevStartTime="+sdevStartTime+"&sdevEndTime="+sdevEndTime+"&stype="+stype+"&sproductId="+sproductId+"&sdemandstatus="+sdemandstatus+"&sgroupId="+sgroupId+"&sOpid="+sOpid+"&sDemandId="+sDemandId;

	if(sPlanFlag=="0")
	{
		alert("计划已经关闭，不能再修改！");
	}
	else
	{
		var refresh=showModalDialog('PlanManager.QueryTask.jsp?planid=<%=sPlanId%>&srepStartTime='+srepStartTime+'&srepEndTime='+srepEndTime+'&sdevStartTime='+sdevStartTime+'&sdevEndTime='+sdevEndTime+'&stype='+stype+'&sproductId='+sproductId+'&sdemandstatus='+sdemandstatus+'&sgroupId='+sgroupId+'&sOpid='+sOpid+'&sDemandId='+sDemandId+'&Products=<%=Products%>&demand_sta_id=<%=demand_sta_id%>&proj_request_id=<%=proj_request_id%>&feature_status=<%=feature_status%>&opertype=1',window,'dialogWidth:900px;status:no;dialogHeight:600px');
		
		
		if(refresh=="Y")   
	  	{
	  		self.location.reload(); 
	  	}
  	}
	
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

function allcheck(formname) 
{
  var objs = formname.getElementsByTagName("input");
  for(var i=0; i<objs.length; i++) 
  {
    if(objs[i].type.toLowerCase() == "checkbox" )
      {
      	objs[i].checked = true;
      }
  }
}

function allcanclecheck(formname) 
{
  var objs = formname.getElementsByTagName("input");
  for(var i=0; i<objs.length; i++) 
  {
    if(objs[i].type.toLowerCase() == "checkbox" )
      {
      	objs[i].checked = false;
      }
  }
}


function dialogcommit(form1)
{   
	var planner="<%=sPlanner%>";
	var opid="<%=sOpId%>";
	var sPlanFlag="<%=sPlanFlag%>"
	
	var remark=document.getElementById("remark").value;
	
	if(sPlanFlag=="0")
	{
		alert("计划已经关闭，不能再修改！");
	}
	else
	{
		if(planner!="" && planner!=opid)
		{
			if(remark=="" || remark==null)
			{
				alert("请输入说明信息再提交数据！谢谢！")
			}
			else
			{
				var bln=window.confirm("数据删除后不能恢复，请确定是否删除？\n\n点<确定>，删除；点<取消>，取消删除！"+"\n");	
				if(bln==true)
				{
					form1.submit();
				}	
			}
		}
		else
		{
			var bln=window.confirm("数据删除后不能恢复，请确定是否删除？\n\n点<确定>，删除；点<取消>，取消删除！"+"\n");	
			if(bln==true)
			{
				form1.submit();
			}
		}
	}
}


function textCounter(field,iCount)
{
   var text=field.value;
   var iCount1=iCount+1;
   if (text==null)
   {
   	 text="";
   }
   if(text.replace(/[^\x00-\xff]/g,"xx").length>iCount)
   {
     alert("输入超出"+iCount1+"字符！");
     var str = "";  
     var l = 0;  
     var schar;  
     for(var i=0; schar=text.charAt(i); i++)  
     {  
        str += schar;  
        l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);  
        if(l >= iCount)  
        {  
            break;  
        }  
     }  
    field.value=str; 
   }
}


</script>
<%
	String sTemp= "";
	String sdate_s = "";
	String sDate="";
	String ssql6="";  //获取数据库系统时间sql
	String ssql19=""; //获取指定子系统	
	String ssql51=""; //获取部门内所有组
	String ssql52=""; //获取部门内所有小组所有成员
	String ssql53=""; //获取部门内指定一个小组的成员
	String ssql54=""; //获取需求状态
	String ssql55=""; //获取故障状态
	String ssql56=""; //获取功能点状态		
	ResultSet rs6=null;
	ResultSet rs19=null;		
	ResultSet rs51=null;
	ResultSet rs52=null;
	ResultSet rs53=null;
	ResultSet rs54=null;
	ResultSet rs55=null;
	ResultSet rs56=null;	
	Statement stmt6 = conn.createStatement();
	Statement stmt19 = conn.createStatement();
	Statement stmt51 = conn.createStatement();
	Statement stmt52 = conn.createStatement();
	Statement stmt53 = conn.createStatement();
	Statement stmt54 = conn.createStatement();
	Statement stmt55 = conn.createStatement();
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
				sdate_s = rs6.getString("sdate_s");
			}
		}	
	    catch(Exception e)
		{
	       out.println(e.toString());
		}
		
		ssql19 = " select product_id id,product_name,'['||product_id||']'||product_name as name "
		      +" from product where product_id in ("+Products+") order by name ";
//		  out.println("ssql17="+ssql17+";\n");
		System.out.println("ssql19="+ssql19+";\n");

		  try
		  {
			  rs19 = stmt19.executeQuery(ssql19);
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
	 	
//	 	ssql54="select sta_id as id,sta_name,'['||sta_id||'] '||sta_name as name from demand_status where sta_id in "+ demand_sta_id;
	 	ssql54="select sta_id as id,sta_name as name from demand_status where sta_id in ("+ demand_sta_id+")";
//	   out.println("ssql54="+ssql54+";\n");
	   if (ssql54!=null)
	  	{
			try
			{
				rs54 = stmt54.executeQuery(ssql54);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}
	 	
//	 	ssql55="select id,'['||id||'] '||name as name from proj_status where id in "+proj_request_id;
	 	ssql55="select id,name from proj_status where id in ("+proj_request_id+")";
//	   out.println("ssql55="+ssql55+";\n");
	   if (ssql55!=null)
	  	{
			try
			{
				rs55 = stmt55.executeQuery(ssql55);
			}
			catch(Exception e)
			{
			   out.println(e.toString());
			 }
	 	}

	ssql56="select id,name from assignment_status where id in ("+feature_status+")";
//	   out.println("ssql55="+ssql55+";\n");
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

//获取本页面参数
String stype=request.getParameter("type");


%>
 
<title>plantask</title>

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

 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <form name="PlanTaskQuery" method="post" onSubmit="return empty()">
        <tr class="title">
          <td>查询需要添加明细:<br></td>
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
                <td class="pagetitle1" style= "height: 40px; ">&nbsp;</td>
                <td class="pagetitle1" align="left">
                <input type="radio" name="type" id="type" value="1" checked>查需求&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <!--  <input type="radio" name="type" id="type" value="2">查故障&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
                <input type="radio" name="type" id="type" value="3">查功能点任务单</td>
              </tr>
                <tr class="contentbg">
                  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">需求时间： </div>
                    <div align="right"> </div></td>
                  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_rep_date" >
                    <input name="repstarttime" type="text" class="inputstyle" id="repstarttime"  onClick="JSCalendar(this);"  value="<%=sdate_s%>" size="10">
                    ---
                    <input name="rependtime" type="text" class="inputstyle" id="rependtime" value="<%=sDate%>" size="10"  onClick="JSCalendar(this);" ></td>
                </tr>
                
                <tr>
                  <td width="13%" class="pagetitle1" style= "height: 40px; "><div align="left">开发时间： </div>
                    <div align="right"> </div></td>
                  <td width="87%" class="pagetextdetails"><input name="chk_date" type="checkbox" id="chk_dev_date">
                    <input name="devstarttime" type="text" class="inputstyle" id="devstarttime"  onClick="JSCalendar(this);"  value="<%=sdate_s%>" size="10">
                    ---
                    <input name="devendtime" type="text" class="inputstyle" id="devendtime" value="<%=sDate%>" size="10"  onClick="JSCalendar(this);" ></td>
                </tr>
                
                <tr class="contentbg">
                  <td class="pagetitle1" style= "height: 40px; " >产品名称：</td>
                  <td><class="pagetextdetails">
                   	  <%
						while(rs19.next())
						{
					  %>
                      <input type="checkbox" value="<%=rs19.getString("id")%>" name="productid"><font class="pagetextdetails"><%=rs19.getString("name")%>&nbsp;&nbsp;
                      <%
						}
					  %>                
                    </font></td>
                </tr>
                
                <tr>
                  <td class="pagetitle1" style= "height: 40px; ">需求状态：</td>
                  <td><font class="pagetextdetails">
                   	  <%
						while(rs54.next())
						{
					  %>
                      <input type="checkbox" value="<%=rs54.getString("id")%>"  name="demandstauts"><font class="pagetextdetails"><%=rs54.getString("name")%>&nbsp;&nbsp;
                      <%
						}
					  %>                
                    </font>
                    <br>
                    <br><font class="pagetextdetails">（选择"查需求"时有效）</font>
                    </td>
                </tr>
                
                <tr class="contentbg"  style="display:none">
                  <td class="pagetitle1" style= "height: 40px; ">故障状态：</td>
                  <td><font class="pagetextdetails">
                   	  <%
						while(rs55.next())
						{
					  %>
                      <input type="checkbox" value="<%=rs55.getString("id")%>"  name="demandstauts1"><font class="pagetextdetails"><%=rs55.getString("name")%>&nbsp;&nbsp;
                      <%
						}
					  %>                
                    </font>
                    <br>
                    <br><font class="pagetextdetails">（选择"查故障"时有效）</font>            
                    </td>
                </tr>
                
                <tr>
                  <td class="pagetitle1" style= "height: 40px; ">功能点任务单状态：</td>
                  <td><font class="pagetextdetails">
                   	  <%
						while(rs56.next())
						{
					  %>
                      <input type="checkbox" value="<%=rs56.getString("id")%>"  name="demandstauts2"><font class="pagetextdetails"><%=rs56.getString("name")%>&nbsp;&nbsp;
                      <%
						}
					  %>                
                    </font>
                    <br>
                    <br><font class="pagetextdetails">（选择&quot;查功能任务单点&quot;时有效）</font>            
                    </td>
                </tr>
                
                <tr  class="contentbg">
                  <td class="pagetitle1" style= "height: 40px; ">测试人归属组：</td>
                   <td><class="pagetextdetails">
                   	  <%
						while(rs51.next())
						{
					  %>
                      <input type="checkbox" value="<%=rs51.getString("id")%>"  name="groupid"><font class="pagetextdetails"><%=rs51.getString("name")%>&nbsp;&nbsp;
                      <%
						}
					  %>                
                    </font></td>
				</tr>
				
				<tr>
                  <td class="pagetitle1" style= "height: 30px; ">测试人员：</td>
                  <td><font color="#0000FF">
                    <select style= "width: 550px; " name="opid" class="inputstyle" id="opid">
                      <option value="" selected> -------------- 选择所有 -------------- </option>
                      <%
						while(rs52.next())
						{
					  %>
                      <option value="<%=rs52.getString("id")%>"><%=rs52.getString("name")%></option>
                      <%
						}
					  %>
                    </select>      
                    </td>
                </tr>
                
                <tr  class="contentbg">
                  <td class="pagetitle1" style= "height: 30px; ">ID：</td>
                  <td class="pagetextdetails">
                  <input name="demand_id" type="text" class="inputstyle" id="demand_id"   size="35">
                  <br><font class="pagetextdetails">（当选择"查需求"时，输入需求号；选择"查故障"时，输入故障编号；选择"查功能点任务单"是，输入任务单编号，多个编号之间用英文逗号分割，如：1,2,3）</font>
                  </td></tr>
                
                <tr>
                <td class="pagetitle1">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              </table></td></tr>

	          <td class="contentbottomline"><div align="left"> 
	          <table width="146" border="0" cellspacing="5" cellpadding="5">
	          <tr> 
	          <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToQueryURL()">查 询</td>
	          </tr>
	          </table></td>
	          </form>
	          
	          <form  name="TaskDetail" method="post" action="PlanManager.OperPlanTask.jsp">
		      <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
		      <tr> 
		      <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="commit.click()">删除任务</td>
		      <input type="button" name="commit" id="commit" runat="server"  style="display:none;" OnClick="dialogcommit(this.form)" >
		      <input type="hidden" value="2" name="opertype">  
		      </tr>
		      </table>
		      </td>
		      </tr>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="title">
          <td>计划任务列表:(列表中红色字体的任务表示在多个计划中出现过。)<input type="hidden" value="<%=sPlanId%>" name="planid"><input type="hidden" value="<%=sOpId%>" name="OpId"><br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
   <tr class="contentbg">
   <td class="pagetitle1" style= "height: 25px; ">计划名："<%=sPlanName %>",  计划开始时间：<%=sStartTime %> --- 计划结束时间：<%=sEndTime %></td>
   </tr>
   
   <tr class="contentbg">
   <td class="pagetitle1" style= "height: 40px; ">删除任务说明:
   <textarea style= "width: 660px; " class="inputstyle" rows="2" name="remark" id="remark" cols="133" onKeyUp="textCounter(this.form.remark,3999)"></textarea>*
   </td>
   </tr>
   
   <tr>
	<td class="pagetitle1" style= "height: 30px; ">
	<font color=blue  face="宋体" style="text-decoration:underline;" onclick="allcheck(TaskDetail)" target="_parent" >全部选中</font>
	<font color=blue  face="宋体" style="text-decoration:underline;" onclick="allcanclecheck(TaskDetail)" target="_parent" >全部取消</font>
	</td>
   </tr>   	       
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr>
              	<td width="3%" class="pagecontenttitle">&nbsp;</td> 
                <td width="3%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">编号</td>
                <td width="5%" class="pagecontenttitle">标识</td>
                <td width="20%" class="pagecontenttitle">名称<br></td>
                <td width="8%" class="pagecontenttitle">计划开始</td>                
                <td width="8%" class="pagecontenttitle">计划结束<br></td>
                <td width="7%" class="pagecontenttitle">实际开始<br></td>
                <td width="7%" class="pagecontenttitle">实际结束<br></td>
                <td width="8%" class="pagecontenttitle">执行人<br></td>
                <td width="8%" class="pagecontenttitle">归属组<br></td>
                <td width="5%" class="pagecontenttitle">状态<br></td>
                <td width="5%" class="pagecontenttitle">类型<br></td>
                <td width="8%" class="pagecontenttitle">研发<br></td>
              </tr>
			  <% 
			      String sID="";
			      String sTASK_NAME="";
			      String sPLAN_START_TIME="";
			      String sPLAN_END_TIME="";
			      String sREAL_START_TIME="";
			      String sREAL_END_TIME="";
			      String sTASK_EXECUTOR="";
			      String sEXECUTOR_GROUP="";
			      String sSTATUS_NAME="";
			      String sTYPE_NAME="";
			      String sTASK_DEV="";
			      int j=1;
			      if(vPlanTaskInfo.size()>0)
			      {
			         for(int i=vPlanTaskInfo.size()-1;i>=0;i--)
			         {
		                HashMap hash = (HashMap) vPlanTaskInfo.get(i);
		                sID = (String) hash.get("ID");
		                sTASK_NAME = (String) hash.get("TASK_NAME");
		                sPLAN_START_TIME = (String) hash.get("PLAN_START_TIME");
		                sPLAN_END_TIME = (String) hash.get("PLAN_END_TIME");
		                sREAL_START_TIME = (String) hash.get("REAL_START_TIME");
		                sREAL_END_TIME = (String) hash.get("REAL_END_TIME");
		                sTASK_EXECUTOR = (String) hash.get("TASK_EXECUTOR");
		                sEXECUTOR_GROUP = (String) hash.get("EXECUTOR_GROUP");
		                sSTATUS_NAME = (String) hash.get("STATUS_NAME");
		                sTYPE_NAME = (String) hash.get("TYPE_NAME");
		                sTASK_DEV = (String) hash.get("TASK_DEV");
		                if(sDemand_id.indexOf(sID)>0)
		                {
		      %>
						<tr> 
							 <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;"><input name="checkbox" type="checkbox" id="checkbox" value="<%=sID %>"></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">(<%=j%>)</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">遗留</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;"><a href="
				             <%
				             	if(sID.substring(0,1).equals("R"))//需求
				             	{
				             		//out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sID.substring(1,sID.length()));
				             	}
				             	else if(sID.substring(0,1).equals("F")) //故障
				             	{
				             		//out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sID.substring(1,sID.length()));
				             	}
				             	else if(sID.substring(0,1).equals("T")) //任务单
				             	{
				             		//out.print("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+sID.substring(1,sID.length()));
				             	}
				             %>" target="_blank"><%=sID%></a></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sTASK_NAME==null) out.print(""); else out.print(sTASK_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sPLAN_START_TIME==null) out.print(""); else out.print(sPLAN_START_TIME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sPLAN_END_TIME==null) out.print(""); else out.print(sPLAN_END_TIME); %></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sREAL_START_TIME==null) out.print(""); else out.print(sREAL_START_TIME); %></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sREAL_END_TIME==null) out.print(""); else out.print(sREAL_END_TIME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sTASK_EXECUTOR==null) out.print(""); else out.print(sTASK_EXECUTOR);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sEXECUTOR_GROUP==null) out.print(""); else out.print(sEXECUTOR_GROUP);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;"><%if(sSTATUS_NAME==null) out.print(""); else out.print(sSTATUS_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;"><%if(sTYPE_NAME==null) out.print(""); else out.print(sTYPE_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">&nbsp;<%if(sTASK_DEV==null) out.print(""); else out.print(sTASK_DEV);%></td>			             
				         </tr>
	        <%        		                
		                }
		                else
		                {	                
		      %>

				        <tr> 
							 <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>"><input name="checkbox" type="checkbox" id="checkbox" value="<%=sID %>"></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">(<%=j%>)</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">新增</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="
				             <%
				             	if(sID.substring(0,1).equals("R"))//需求
				             	{
				             		//out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sID.substring(1,sID.length()));
				             	}
				             	else if(sID.substring(0,1).equals("F")) //故障
				             	{
				             		//out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sID.substring(1,sID.length()));
				             	}
				             	else if(sID.substring(0,1).equals("T")) //任务单
				             	{
				             		//out.print("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+sID.substring(1,sID.length()));
				             	}
				             %>"target="_blank"><%=sID%></a></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" >&nbsp;<%if(sTASK_NAME==null) out.print(""); else out.print(sTASK_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sPLAN_START_TIME==null) out.print(""); else out.print(sPLAN_START_TIME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sPLAN_END_TIME==null) out.print(""); else out.print(sPLAN_END_TIME); %></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sREAL_START_TIME==null) out.print(""); else out.print(sREAL_START_TIME); %></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sREAL_END_TIME==null) out.print(""); else out.print(sREAL_END_TIME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sTASK_EXECUTOR==null) out.print(""); else out.print(sTASK_EXECUTOR);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sEXECUTOR_GROUP==null) out.print(""); else out.print(sEXECUTOR_GROUP);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>"><%if(sSTATUS_NAME==null) out.print(""); else out.print(sSTATUS_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>"><%if(sTYPE_NAME==null) out.print(""); else out.print(sTYPE_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">&nbsp;<%if(sTASK_DEV==null) out.print(""); else out.print(sTASK_DEV);%></td>			             
				         </tr>
	        <%        
	        			}
	                 j=j+1;
	                 }
	              }  
	         %>  
             
            <tr> 
                <td width="3%" class="pagecontenttitle">&nbsp;</td> 
                <td width="3%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">编号</td>
                <td width="5%" class="pagecontenttitle">标识</td>
                <td width="20%" class="pagecontenttitle">名称<br></td>
                <td width="8%" class="pagecontenttitle">计划开始</td>                
                <td width="8%" class="pagecontenttitle">计划结束<br></td>
                <td width="7%" class="pagecontenttitle">实际开始<br></td>
                <td width="7%" class="pagecontenttitle">实际结束<br></td>
                <td width="8%" class="pagecontenttitle">执行人<br></td>
                <td width="8%" class="pagecontenttitle">归属组<br></td>
                <td width="5%" class="pagecontenttitle">状态<br></td>
                <td width="5%" class="pagecontenttitle">类型<br></td>
                <td width="8%" class="pagecontenttitle">研发<br></td>
              </tr>
            </table></td>

</tr>
</table>
</td>
</tr>
</table>
</table>
</div>
</td>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</form>
</body>

<%@ include file= "../connections/con_end.jsp"%>
</html>
