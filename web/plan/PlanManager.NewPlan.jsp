<%@include file="../allcheck.jsp"%>
<jsp:useBean id="PlanManager" scope="page" class="dbOperation.PlanManager" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />

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
//��ȡϵͳʱ��
//java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
//java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ��
//String sdate = formatter.format(currentTime); //������ʱ���ʽ�� 
  java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");    
  Calendar   currentTime=Calendar.getInstance();
  //String sdate=df.format(currentTime.getTime()); //��ȡ��ǰʱ�䲢��ʽ��
  int i=currentTime.get(currentTime.DAY_OF_WEEK); //��ȡ��ǰ�����ڵ�ǰ�ܵĵڼ���,����Ϊ��1�죬����Ϊ��7��

  currentTime.add(Calendar.DAY_OF_WEEK,-i+2); //��ȡ��ǰ������������һ������
  String sdate=df.format(currentTime.getTime());
  
  currentTime.add(Calendar.DAY_OF_WEEK,6); //��ȡ��ǰʱ���6��ʱ��    
  String sdate_s=df.format(currentTime.getTime());


//��ȡ�������ʶ������1��ʶ����ɹ���
String Operflag="";
Operflag=request.getParameter("operflag");
if(Operflag==null) Operflag="0";
if(Operflag.equals("1"))
{
	out.print("<script language='javascript'>alert('����ɹ�!');</script>");
}

//��ȡ�½��ƻ����
  String sPlanSeq="";
  String sOperType="1";
  String sPlanName="";
  String sStartTime="";
  String sEndTime="";
  String sPlanner="";
  sPlanSeq=request.getParameter("PLAN_ID");
  if(sPlanSeq==null) sPlanSeq="";
  if(sPlanSeq==null || sPlanSeq.equals(""))
  {
  	sPlanSeq=PlanManager.getNewPlanSeq();
  }
  else
  {
	  Vector PlanInfo=PlanManager.queryplaninfo(sPlanSeq,"","","","","","","","","");
	  if(PlanInfo.size()>0)
	  {
	  	sOperType="2";
	  	HashMap PlanInfohash = (HashMap) PlanInfo.get(0);
	  	sPlanName=(String) PlanInfohash.get("PLAN_NAME");
	  	sStartTime=(String) PlanInfohash.get("START_TIME");
	  	sStartTime=sStartTime.substring(0,10);
	  	sEndTime=(String) PlanInfohash.get("END_TIME");
	  	sEndTime=sEndTime.substring(0,10);
	  	sPlanner=(String) PlanInfohash.get("PLANNER");  	
	  }
	  else
	  {
	  	sOperType="1";
	  	sPlanSeq=PlanManager.getNewPlanSeq();
	  }
  }

//�ƻ��ƶ��˲�Ϊ�գ���ѯ�����ƺ��ʼ���ַ
String splannerid="";
if(sPlanner!=null && !sPlanner.equals(""))
{
  Vector Planner=QueryBaseData.queryOpInfoForNewPlan("",sPlanner);
  if(Planner.size()>0)
  	{
  		HashMap Plannerhash = (HashMap) Planner.get(0);
  		splannerid=(String) Plannerhash.get("OP_ID");
  		String planner_name=(String) Plannerhash.get("OP_NAME");
  		String planner_mail = (String) Plannerhash.get("OP_MAIL");
  		sPlanner=planner_name +" - "+ planner_mail;
 	 }    
}  
  
//��ȡ��ǰ��¼����Ա
  String sopId=(String)session.getValue("OpId");
  String sopname="";
  String sopmail="";
  Vector OpName=QueryBaseData.queryOpInfoForNewPlan("",sopId);
  String sopName="";
  if(OpName.size()>0)
  	{
  		HashMap OpNamehash = (HashMap) OpName.get(0);
  		splannerid=(String) OpNamehash.get("OP_ID");
  		sopname=(String) OpNamehash.get("OP_NAME");
  		sopmail = (String) OpNamehash.get("OP_MAIL");
  		sopName=sopname +" - "+ sopmail;
 	 }    


%>

<title>newplan</title>

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
   var opid="<%=sopId%>";
   var opertype=form.opertype.value;
   //alert(opid+"_"+opertype);
   
   if(opid=="1")
   {
   		form.submit();
   	}
   	else
   	{
   		alert("��û��Ȩ���½��ƻ���");
   	}
}

function goToURL(url)
{
   var opid="<%=sopId%>";
   var sOperType="<%=sOperType%>";
   
   if(opid=="1")
   {
   		if(sOperType!="1") // �Ѿ�����ƻ����������Ӽƻ���ϸ��
   		{
   			window.location=url;
   		}
   		else
   		{
   			alert("���������ƻ��������������ϸ��");
   		}
   }
   else
   {
   		alert("��û��Ȩ�����Ӽƻ���ϸ��");
   }
   	
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="NewPlan" method="post" action="PlanManager.OperPlanInfo.jsp"> 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>�½��ƻ�:<%//out.print("\n sOperType="+sOperType);%><br>
          <input type="hidden" value="<%=sOperType%>" name="opertype">
          <input type="hidden" value="0" name="operflag">
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
                 <tr class="contentbg">
                  <td width="15%" class="pagetitle1">�ƻ���ţ�</td>
                  <td width="85%" class="pagetextdetails"> <%=sPlanSeq%><input type="hidden" value="<%=sPlanSeq%>" name="PLAN_ID"></td>
                </tr>
                
                <tr>
                  <td width="15%" class="pagetitle1">�ƻ����ƣ�</td>
                  <td width="85%"><input style= "width: 550px; " name="PLAN_NAME" class="inputstyle" id="PLAN_NAME" value="<%if(sPlanName==null) out.print("");else out.print(sPlanName);%>"></td>
                </tr>
                
                 <tr  class="contentbg">
                  <td width="15%" class="pagetitle1">�ƻ�ʱ�䣺</td>
                  <td width="85%"><input style= "width: 80px; " name="START_TIME" class="inputstyle" id="START_TIME" onClick="JSCalendar(this);" value="<%if(sOperType.equals("1"))out.print(sdate);else out.print(sStartTime);%>"> -- 
                  <input style= "width: 80px; " name="END_TIME" class="inputstyle" id="END_TIME"  value="<%if(sOperType.equals("1"))out.print(sdate_s);else out.print(sStartTime);%>"  onClick="JSCalendar(this);"></td>
                </tr>  
                              
                <tr>
                  <td width="15%" class="pagetitle1">�ƻ��ƶ��ˣ�</td>
                  <td width="85%" class="pagetextdetails"><%if(sOperType.equals("1")) out.print(sopName);else out.print(sPlanner);%><input type="hidden" value="<%=splannerid%>" name="PLANNER"></td>
                </tr>                                     
                
                <tr  class="contentbg">
                  <td class="pagetitle1">&nbsp;</td>
                  <td>&nbsp;</td>
              	</tr>                                

	  			<tr> 
	          	<td class="contentbottomline"><div align="left"> 
	                <tr> 
	                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	                <tr> 
	                <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">�� ��
      				<input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="commit(this.form)" ></td>
				  </tr>
				  </table></td>
	             <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	             <tr> 
	             <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="goToURL(/*href*/'PlanManager.PlanTask.jsp?planid=<%=sPlanSeq%>')">������ϸ</td>
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
</td>
</tr>
</table>
</form>
</body>
</html>
                
