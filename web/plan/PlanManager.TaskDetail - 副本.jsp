<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />

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
String sDemand_id="";
String sDemand_id_temp="";
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

int iCount=0;
Vector vDemandInfo=new Vector();
vDemandInfo=PlanManager.trackdemandinfo(sPlanId);
iCount=vDemandInfo.size();

%>
 
<title>Querytaskdetail</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
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

function dialogcommit(form1)
{   
	form1.submit();
	window.close();
	window.returnValue="Y";
}

function cancle()
{ 
	window.close();
} 


function openNewWindow(type,sid)
{
       if(type=="1") //需求
       {
          window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sid);
       }
       else if(type=="2")     //故障
       {
          window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sid);
       }
       else if (type=="3")  //研发功能点任务单
       {
       	  window.open("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+sid);
       }
       else
       {
       		alert("id值不正确，请检查！");
       }
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr class="title">
          <td>计划任务列表:</td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
   <tr class="contentbg">
   <td class="pagetitle1" style= "height: 25px; ">计划名："<%=sPlanName %>",  计划开始时间：<%=sStartTime %> --- 计划结束时间：<%=sEndTime %></td>
   </tr>     
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr>
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">标识</td>                
                <td width="5%" class="pagecontenttitle">编号</td>
                <td width="24%" class="pagecontenttitle">标题<br></td>
                <td width="8%" class="pagecontenttitle">工程名称</td>                
                <td width="8%" class="pagecontenttitle">产品<br></td>
                <td width="7%" class="pagecontenttitle">状态<br></td>
                <td width="10%" class="pagecontenttitle">测试人员<br></td>
                <td width="10%" class="pagecontenttitle">归属组<br></td>
                <td width="10%" class="pagecontenttitle">开发人员<br></td>
                <td width="8%" class="pagecontenttitle">提交测试时间<br></td>
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
			      int abc = vDemandInfo.size();
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
			 	if(sDemand_id.indexOf(sDEMAND_ID)>0)
			 	{
			 %>
			 			<tr> 
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">(<%=j%>)</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" style="color:#ff0000;">遗留</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>"  name="DEMAND_ID" style="color:#ff0000;"><a href="
				             <%
				             	if(stype.equals("1")) //需求
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("2"))//故障
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("3")) //任务单
				             	{
				             		out.print("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             %>"   target="_blank"><%=sDEMAND_ID%></a></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEMAND_TITLE" style="color:#ff0000;">&nbsp;<%=sDEMAND_TITLE%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="PROJ_NAME" style="color:#ff0000;">&nbsp;<%=sPROJ_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="PRODUCT_NAME" style="color:#ff0000;">&nbsp;<%=sPRODUCT_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="STA_NAME" style="color:#ff0000;">&nbsp;<%=sSTA_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TESTER_NAME" style="color:#ff0000;">&nbsp;<%=sTESTER_NAME_new%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="GROUP_NAME" style="color:#ff0000;">&nbsp;<%if(sGROUP_NAME==null) out.print("");else out.print(sGROUP_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEV_NAME" style="color:#ff0000;">&nbsp;<%=sDEV_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="REP_TIME" style="color:#ff0000;">&nbsp;<%=sREP_TIME%></td>
				         </tr>  
			 <%	
			 	}
			 	else
			 	{
			 %>

				        <tr> 
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">(<%=j%>)</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>">新增</td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>"  name="DEMAND_ID"><a href="
				             <%
				             	if(stype.equals("1")) //需求
				             	{
				             		out.print("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("2"))//故障
				             	{
				             		out.print("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             	else if(stype.equals("3")) //任务单
				             	{
				             		out.print("http://10.10.10.158/task/query/task_query_detail.jsp?op_type=100&op_id="+ sDEMAND_ID.substring(1,sDEMAND_ID.length()));
				             	}
				             %>"  target="_blank"><%=sDEMAND_ID%></a></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEMAND_TITLE">&nbsp;<%=sDEMAND_TITLE%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="PROJ_NAME">&nbsp;<%=sPROJ_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="PRODUCT_NAME">&nbsp;<%=sPRODUCT_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="STA_NAME">&nbsp;<%=sSTA_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="TESTER_NAME">&nbsp;<%=sTESTER_NAME_new%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="GROUP_NAME">&nbsp;<%if(sGROUP_NAME==null) out.print("");else out.print(sGROUP_NAME);%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="DEV_NAME">&nbsp;<%=sDEV_NAME%></td>
				             <td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" name="REP_TIME">&nbsp;<%=sREP_TIME%></td>
				         </tr>         	  

	        <%       
	        		 }
	                 j=j+1;
	                 }
	              }  
	         %>
             
            <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">标识</td>
                <td width="5%" class="pagecontenttitle">编号</td>
                <td width="24%" class="pagecontenttitle">标题<br></td>
                <td width="8%" class="pagecontenttitle">工程名称</td>                
                <td width="8%" class="pagecontenttitle">产品<br></td>
                <td width="7%" class="pagecontenttitle">状态<br></td>
                <td width="10%" class="pagecontenttitle">测试人员<br></td>
                <td width="10%" class="pagecontenttitle">归属组<br></td>
                <td width="10%" class="pagecontenttitle">开发人员<br></td>
                <td width="8%" class="pagecontenttitle">提交测试时间<br></td>
              </tr>
            </table></td>
        </tr>
        <tr>
   		<td><div align="center">
       <table width="146" border="0" cellspacing="5" cellpadding="5">           
		<td width="101" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
        <tr> 
        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="cancle()" >关闭</td>
        </tr>
        </table>
        <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	    <tr> 
	    <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="window.open('PlanManager.TaskDetailExportExcel.jsp?planid=<%=sPlanId %>')">导出EXCEL<br></td>
	    </tr>
	    </table></td>
   </table>
   </table>
   </td>
   </tr>
   </table>
</body>
</html>
