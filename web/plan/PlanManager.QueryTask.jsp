<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />

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
String sPlanId=request.getParameter("planid");
String sPlanner="";
String sSessionOpId=(String)session.getValue("OpId");
if(sSessionOpId==null) sSessionOpId="";
String sStartTime="";
String sEndTime="";
if(sPlanId==null || sPlanId.equals(""))
{
	out.print("<script language='javascript'>alert('计划编号不能为空!');</script>");
}
else
{
	Vector PlanInfo=PlanManager.queryplaninfo(sPlanId,"","","","","","","","","");
	  if(PlanInfo.size()>0)
	  {
	  	HashMap PlanInfohash = (HashMap) PlanInfo.get(0);
	  	sStartTime=(String) PlanInfohash.get("START_TIME");
	  	sStartTime=sStartTime.substring(0,10);
	  	sEndTime=(String) PlanInfohash.get("END_TIME");
	  	sEndTime=sEndTime.substring(0,10);
	  	sPlanner= (String) PlanInfohash.get("PLANNER");
	  }
}

//获取主页面参数，查询需求、故障信息
String Products=request.getParameter("Products");
String demand_sta_id=request.getParameter("demand_sta_id");
String proj_request_id=request.getParameter("proj_request_id");
String feature_status=request.getParameter("feature_status");
String stype=request.getParameter("stype");
String srepStartTime=request.getParameter("srepStartTime");
String srepEndTime=request.getParameter("srepEndTime");
String sdevStartTime=request.getParameter("sdevStartTime");
String sdevEndTime=request.getParameter("sdevEndTime");
String sproductId=request.getParameter("sproductId");
String sdemandstatus=request.getParameter("sdemandstatus");
String sgroupId=request.getParameter("sgroupId");
String sOpid=request.getParameter("sOpid");
String sDemandId=request.getParameter("sDemandId");
if(stype==null)
{
	stype="";
}
if(srepStartTime==null)
{
	srepStartTime="";
}
if(srepEndTime==null)
{
	srepEndTime="";
}
if(sdevStartTime==null)
{
	sdevStartTime="";
}
if(sdevEndTime==null)
{
	sdevEndTime="";
}
if(sproductId==null)
{
	sproductId="";
}
if(sdemandstatus==null)
{
	sdemandstatus="";
}
if(sgroupId==null)
{
	sgroupId="";
}
if(sOpid==null)
{
	sOpid="";
}
if(sDemandId==null)
{
	sDemandId="";
}


//out.print("sOPERA="+sOPERA+";sSTARTTIME="+sSTARTTIME+";sENDTIME="+sENDTIME+";sPRODUCTID="+sPRODUCTID+";sSUBSYSID="+sSUBSYSID+";sMODULEID="+sMODULEID+";sGROUPID="+sGROUPID+";sOPID="+sOPID+";sTYPE="+sTYPE+";sVALUE="+sVALUE);
int iCount=0;
Vector vDemandInfo=new Vector();


if(!stype.equals(""))
{	
	if(stype.equals("1"))
	{
		vDemandInfo=PlanManager.querydemandinfo(stype,srepStartTime,srepEndTime,sdevStartTime,sdevStartTime,sproductId,sdemandstatus,sgroupId,sOpid,sDemandId,Products,demand_sta_id,sPlanId);
	}
	else if(stype.equals("2"))
	{
		vDemandInfo=PlanManager.querydemandinfo(stype,srepStartTime,srepEndTime,sdevStartTime,sdevStartTime,sproductId,sdemandstatus,sgroupId,sOpid,sDemandId,Products,proj_request_id,sPlanId);		
	}
	else if(stype.equals("3"))
	{
		vDemandInfo=PlanManager.querydemandinfo(stype,srepStartTime,srepEndTime,sdevStartTime,sdevStartTime,sproductId,sdemandstatus,sgroupId,sOpid,sDemandId,Products,feature_status,sPlanId);		
	}
	else
	{
		out.print("程序出现异常，请联系管理员！");
	}
	iCount=vDemandInfo.size();
}  

%>
 
<title>Querytask</title>

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

function dialogcommit(form1)
{   
	var planner="<%=sPlanner%>";
	var opid="<%=sSessionOpId%>";
	
	var remark=document.getElementById("remark").value;
	if(planner!="" && planner!=opid)
	{
		if(remark=="" || remark==null)
		{
			alert("请输入说明信息再提交数据！谢谢！")
		}
		else
		{
			form1.submit();
			window.close();
			window.returnValue="Y";
		}
	}
	else
	{
		form1.submit();
		window.close();
		window.returnValue="Y";
	}
}

function cancle()
{ 
	window.close();
	//window.returnValue="Y";
} 

function allcheck() 
{
  var objs = QueryTask.getElementsByTagName("input");
  for(var i=0; i<objs.length; i++) 
  {
    if(objs[i].type.toLowerCase() == "checkbox" )
      {
      	objs[i].checked = true;
      }
  }
}

function allcanclecheck() 
{
  var objs = QueryTask.getElementsByTagName("input");
  for(var i=0; i<objs.length; i++) 
  {
    if(objs[i].type.toLowerCase() == "checkbox" )
      {
      	objs[i].checked = false;
      }
  }
}

function getcheckdata()
{
	var value=new Array();
	var data="";
	var checkbox = document.getElementsByName("checkbox"); 
	for (var i = 0; i < checkbox.length; i++)   
    {   
	    if (checkbox[i].checked)   
	    {    
			value[i]=checkbox[i].value;
			data+=value[i]+',';
	    }
    }
    alert(data);
}

function openNewWindow(type,sid)
{
       if(type=="1") //需求
       {
          //window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sid);
       }
       else if(type=="2")     //故障
       {
          //window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sid);
       }
       else if(type=="3") //功能点任务单
       {
       	  //window.open("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+sid);
       }
       else
       {
       		alert("id值不正确，请检查！");
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
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="QueryTask" method="post" action="PlanManager.OperPlanTask.jsp">
<input type="hidden" value="<%=sPlanId%>" name="planid">
<input type="hidden" value="1" name="opertype">
<input type="hidden" value="<%=stype%>" name="type">
<input type="hidden" value="<%=sSessionOpId%>" name="OpId">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>查询结果列表:<%//out.print("sPlanId="+sPlanId+"\n &srepStartTime="+srepStartTime+"\n &srepEndTime="+srepEndTime+"\n &sdevStartTime="+sdevStartTime+"\n &sdevEndTime="+sdevEndTime+"\n &stype="+stype+"\n &sproductId="+sproductId+"\n &sdemandstatus="+sdemandstatus+"\n &sgroupId="+sgroupId+"\n &sOpid="+sOpid+"\n &sDemandId="+sDemandId);%><br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
	  <tr class="contentbg">
      <td width="13%" class="pagetitle1" style= "height: 40px; ">设定计划任务开始/结束 时间:
      <input name="taskstarttime" type="text" class="inputstyle" id="taskstarttime"  onClick="JSCalendar(this);"  value="<%=sStartTime%>" size="10">
       ---
      <input name="taskendtime" type="text" class="inputstyle" id="taskendtime" value="<%=sEndTime%>" size="10"  onClick="JSCalendar(this);" >
      </td>
      </tr>
      
      <tr class="contentbg">
      <td class="pagetitle1" style= "height: 40px; ">增加任务说明:
      <textarea style= "width: 660px; " class="inputstyle" rows="2" name="remark" id="remark" cols="133" onKeyUp="textCounter(this.form.remark,3999)"></textarea>*
      </td>
      </tr>
            
	  <tr>
	  <td class="pagetitle1" style= "height: 30px; ">
	  <a href="#"  onclick="allcheck()">全部选中</a>
	  <a href="#"  onclick="allcanclecheck()">全部取消</a>
	  </td>
	  </tr>   	    
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr>
              	<td width="3%" class="pagecontenttitle"></td> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">编号</td>
                <td width="22%" class="pagecontenttitle">标题<br></td>
                <td width="10%" class="pagecontenttitle">工程名称</td>                
                <td width="10%" class="pagecontenttitle">产品<br></td>
                <td width="7%" class="pagecontenttitle">状态<br></td>
                <td width="10%" class="pagecontenttitle">测试人员<br></td>
                <td width="10%" class="pagecontenttitle">归属组<br></td>
                <td width="10%" class="pagecontenttitle">开发人员<br></td>
                <td width="8%" class="pagecontenttitle">申报时间<br></td>
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
			         
		                HashMap hash = (HashMap) vDemandInfo.get(i);
		                sDEMAND_ID = (String) hash.get("DEMAND_ID");
		                sDEMAND_TITLE = (String) hash.get("DEMAND_TITLE");
		                sPROJ_NAME = (String) hash.get("PROJ_NAME");
		                sPRODUCT_NAME = (String) hash.get("PRODUCT_NAME");
		                sSTA_NAME = (String) hash.get("STA_NAME");
		                sREP_TIME = (String) hash.get("REP_TIME");
		                //sTESTER_NAME= (String) hash.get("CASE_SEQ");
		                //sGROUP_NAME = (String) hash.get("OP_NAME");
		                //sDEV_NAME = (String) hash.get("GROUP_NAME");	                
		     %>
			 <%
			 	String sTESTER_NAME_Temp="";
			 	String sGROUP_NAME_Temp="";
			 	String sDEV_NAME_Temp="";
			 	String sTESTER_ID_Temp="";
			 	String sGROUP_ID_Temp="";
			 	String sDEV_ID_Temp="";
			 	Vector vOPInfo=PlanManager.querydemandopinfo(stype,sDEMAND_ID);
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
			 			sGROUP_NAME_Temp = (String) OPInfohash.get("GROUP_NAME");
			 			if(sGROUP_NAME_Temp==null)
			 			{
			 				sGROUP_NAME_Temp="";
			 			}
			 			if(inum==vOPInfo.size()-1)
			 			{
			 				sGROUP_NAME=sGROUP_NAME_Temp;
			 			}
			 			else
			 			{	
			 				if(sGROUP_NAME.equals("")||sGROUP_NAME==null||sGROUP_NAME_Temp.equals(""))
			 				{
			 					sGROUP_NAME=sGROUP_NAME;
			 				}
			 				else
			 				{
					 			if(sGROUP_NAME.indexOf(sGROUP_NAME_Temp)<0)
					 			{
					 				sGROUP_NAME=sGROUP_NAME + ','+ sGROUP_NAME_Temp;
					 			}
					 			else
					 			{
					 				sGROUP_NAME=sGROUP_NAME;
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
			 <%
			 	if(i%2!=0)
			 	{
			 %>

				        <tr> 
				             <td class="coltext"><input name="checkbox" type="checkbox" id="checkbox" value="<%=sDEMAND_ID%>" ></td>
				             <td class="coltext">(<%=j%>)</td>
				             <td class="coltext"  name="DEMAND_ID"><a href="#"  onclick="openNewWindow('<%=stype%>','<%=sDEMAND_ID%>')"><%=sDEMAND_ID%></a></td>
				             <td class="coltext" name="DEMAND_TITLE">&nbsp;<%=sDEMAND_TITLE%></td>
				             <td class="coltext" name="PROJ_NAME">&nbsp;<%=sPROJ_NAME%></td>
				             <td class="coltext" name="PRODUCT_NAME">&nbsp;<%=sPRODUCT_NAME%></td>
				             <td class="coltext" name="STA_NAME">&nbsp;<%=sSTA_NAME%></td>
				             <td class="coltext" name="TESTER_NAME">&nbsp;<%=sTESTER_NAME%></td>
				             <td class="coltext" name="GROUP_NAME">&nbsp;<%=sGROUP_NAME%></td>
				             <td class="coltext" name="DEV_NAME">&nbsp;<%=sDEV_NAME%></td>
				             <td class="coltext" name="REP_TIME">&nbsp;<%=sREP_TIME%></td>
				         </tr>         	  

	        <%
	        		}
	        		else
	        		{
	        %>
	        			<tr> 
				             <td class="coltext2"><input name="checkbox" type="checkbox" id="checkbox" value="<%=sDEMAND_ID%>" ></td>
				             <td class="coltext2">(<%=j%>)</td>
				             <td class="coltext2"  name="DEMAND_ID"><a href="#"  onclick="openNewWindow('<%=stype%>','<%=sDEMAND_ID%>')"><%=sDEMAND_ID%></a></td>
				             <td class="coltext2" name="DEMAND_TITLE">&nbsp;<%=sDEMAND_TITLE%></td>
				             <td class="coltext2" name="PROJ_NAME">&nbsp;<%=sPROJ_NAME%></td>
				             <td class="coltext2" name="PRODUCT_NAME">&nbsp;<%=sPRODUCT_NAME%></td>
				             <td class="coltext2" name="STA_NAME">&nbsp;<%=sSTA_NAME%></td>
				             <td class="coltext2" name="TESTER_NAME">&nbsp;<%=sTESTER_NAME%></td>
				             <td class="coltext2" name="GROUP_NAME">&nbsp;<%=sGROUP_NAME%></td>
				             <td class="coltext2" name="DEV_NAME">&nbsp;<%=sDEV_NAME%></td>
				             <td class="coltext2" name="REP_TIME">&nbsp;<%=sREP_TIME%></td>
				         </tr> 
	        <%       
	        		 } 
	                 j=j+1;
	                 }
	              }  
	         %>
             
            <tr> 
              	<td width="3%" class="pagecontenttitle"></td> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">编号</td>
                <td width="22%" class="pagecontenttitle">标题<br></td>
                <td width="10%" class="pagecontenttitle">工程名称</td>                
                <td width="10%" class="pagecontenttitle">产品<br></td>
                <td width="7%" class="pagecontenttitle">状态<br></td>
                <td width="10%" class="pagecontenttitle">测试人员<br></td>
                <td width="10%" class="pagecontenttitle">归属组<br></td>
                <td width="10%" class="pagecontenttitle">开发人员<br></td>
                <td width="8%" class="pagecontenttitle">申报时间<br></td>
              </tr>
            </table></td>
        </tr>
        <tr>
   		<td><div align="center">
       <table width="146" border="0" cellspacing="5" cellpadding="5">           
           <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
               <tr> 
                 <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" OnClick="commit.click()" >提交
		  		<input type="button" name="commit" id="commit" runat="server"  style="display:none;" OnClick="dialogcommit(this.form)" >                      
                <br></td>
		</tr>
		</table>

		<td width="101" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
               	<tr> 
                 <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="cancle()" >取消<br></td>
               </tr>
        </table>
        </td>
   </table>
   </table>
   </td>
   </tr>
   </table>
</form>      
</body>
</html>
