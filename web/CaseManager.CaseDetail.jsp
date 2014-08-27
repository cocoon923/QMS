<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>
<%
  request.setCharacterEncoding("gb2312");
%>

<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>casedetail</title>
<!--将页面中所有text，textarea设置为readonly-->
<style>   
input,textarea 
{   
  cs:expression(this.readOnly=true);   
}   
</style>
<%
  int iCount=0;
  String sProductId="";
  String sRMId=request.getParameter("requirement");
  String sProducttype="";
  String sProductvalue="";
  String sgetCASEID="";
  String sProcessId="";
  if(sRMId!=null)
	 {
		  sProductvalue=sRMId.substring(1);
		  int iRMId=sRMId.indexOf("R");
		  if(iRMId>=0)
		     sProducttype="1";
		  else
		    sProducttype="2";  
      }   

  Vector Product=QueryBaseData.queryProduct(sProducttype,sProductvalue);
  String sproductName="";
   if(Product.size()>0)
  	{
  		HashMap Producthash = (HashMap) Product.get(0);
  		sProductId=(String) Producthash.get("PRODUCT_ID");
  		sproductName = "[" + (String) Producthash.get("PRODUCT_NAME") + "]"; 
 	 }
 //根据传入的case_seq，查询出界面上显示信息，并填入界面。
   String scaseseq=request.getParameter("caseId");
   String sCASEID="";
   String sCASENAME="";
   String sCASEDESC="";
   String sEXPRESULT="";
   String sCLIINFOID="";
   String sSVRINFOID="";
   String sCASEENV="";
   String sCASEDATAPREPARE="";
   String sSUBSYSID="";
   String sMODULEID="";
   String sOPID="";
   String sCASETYPE="";
   String sPROGRAMNAME="";
   String sCASECONCLUSION="";
   Vector CaseInfo=CaseOpera.querycasedetailinfo(scaseseq);
      if(CaseInfo.size()>0)
        {
          for(int i=CaseInfo.size()-1;i>=0;i--)
            {
				HashMap CaseInfohash = (HashMap) CaseInfo.get(i);
				sCASEID = (String) CaseInfohash.get("CASE_ID");
				sCASENAME = (String) CaseInfohash.get("CASE_NAME");
				sCASEDESC = (String) CaseInfohash.get("CASE_DESC");
				sEXPRESULT = (String) CaseInfohash.get("EXP_RESULT");
				sCLIINFOID = (String) CaseInfohash.get("CLI_INFO_ID");
				sSVRINFOID = (String) CaseInfohash.get("SVR_INFO_ID");
				sCASEENV = (String) CaseInfohash.get("CASE_ENV");
				sCASEDATAPREPARE = (String) CaseInfohash.get("CASE_DATA_PREPARE");
				sSUBSYSID = (String) CaseInfohash.get("SUB_SYS_ID");
				sMODULEID = (String) CaseInfohash.get("MODULE_ID");
				sOPID = (String) CaseInfohash.get("OP_ID");
				sCASETYPE = (String) CaseInfohash.get("CASE_TYPE");
				sPROGRAMNAME = (String) CaseInfohash.get("PROGRAM_NAME");
				sCASECONCLUSION = (String) CaseInfohash.get("CASE_CONCLUSION");
				
             }
         }
		      


//获取case步骤数据
	Vector vCaseStep=new Vector();
	vCaseStep=CaseOpera.querycaseProcess(scaseseq,"");
	iCount=vCaseStep.size();


//获取需求相关属性
	    String ORI_DEMAND_INFO="";
	    String DEMAND_SOLUTION="";
	    String DEMAND_CHG_INFO="";
	    String REMARK1="";
	    String REMARK2="";
	    String REMARK3="";
	    String REMARK4="";
	    String REMARK5="";
	    String REMARK6="";
	   if(sRMId!=null)
	   {
		  String sSubRMId=sRMId.substring(1);
		  int iRMId=sRMId.indexOf("R");
		  if(iRMId>=0)
		     iRMId=1;
		  else
		    iRMId=2;  
	      Vector vDemand =dataBean.getDemandInfo(sSubRMId,iRMId);
	      if(vDemand.size()>0)
	      {
	        HashMap hash = (HashMap) vDemand.get(0);
	        ORI_DEMAND_INFO=(String)hash.get("ORI_DEMAND_INFO");
	        DEMAND_SOLUTION=(String)hash.get("DEMAND_SOLUTION");
	        DEMAND_CHG_INFO=(String)hash.get("DEMAND_CHG_INFO");
	        REMARK1=(String)hash.get("REMARK1");
	        REMARK2=(String)hash.get("REMARK2");
	        REMARK3=(String)hash.get("REMARK3");
	        REMARK4=(String)hash.get("REMARK4");
	        REMARK5=(String)hash.get("REMARK5");
	        REMARK6=(String)hash.get("REMARK6");
	      }
	    }
%>

<%
	
%>

<script language="JavaScript">
function jsSelectItemByValue(objSelect, objItemText) 
{            
    //判断是否存在        
    var isExit = false;        
    for (var i = 0; i < objSelect.options.length; i++) 
    {        
        if (objSelect.options[i].text == objItemText) 
        {        
            objSelect.options[i].selected = true;        
            isExit = true;        
            break;        
        }        
    }
}


function changecolor(obj){
obj.className = "buttonstyle2"}

function restorcolor(obj){
obj.className = "buttonstyle"}	

function a1(form1)
  {   
      var a=form1.requirement.value;
      var sSubSystem =document.all.selectSubSys.options[document.all.selectSubSys.selectedIndex].value;
      var sModule =document.all.selectModule.options[document.all.selectModule.selectedIndex].value;
      
      if(sSubSystem=="")
      {
          alert("请选择子系统后再点击<保存>按钮!");
          document.all.selectSubSys.focus();
      }
      else if(sModule=="")
      {
          alert("请选择模块后再点击<保存>按钮!");
          document.all.selectModule.focus();
      }
      else if(a=="")
      {
         alert("无数据保存，请填写信息后再点击<保存>按钮！");
      }
      else
      {
        form1.submit();
      }
  }

function addDialogBox(CaseInfoForm)
{ 
//	var k=showModalDialog('CaseManager.CaseStep.jsp',window,'dialogWidth:750px;status:no;dialogHeight:450px')

	var refresh=showModalDialog('CaseManager.CaseStep.jsp?requirement=<%=sRMId%>&caseseq=<%=scaseseq%>&sCaseProcessID=&OperType=1',window,'dialogWidth:750px;status:no;dialogHeight:450px');
	if(refresh=="Y")   
  	{
  		self.location.reload(); 
  	}
  	
//	window.open('CaseManager.CaseStep.jsp?requirement=<%=sRMId%>&caseseq=<%=scaseseq%>&sCaseProcessID=1&OperType=1',"StepInfo",'height=450px,width=750px,scrollbars=yes,resizable=yes');

//	var k=showModalDialog('CaseManager.CaseStep.jsp?requirement=R19921&caseseq=238&CaseID=OB营帐-GS-R19921-00003&sCaseProcessID=&OperType=1',window,'dialogWidth:950px;status:no;dialogHeight:450px'); 
	
} 

function updateDialogBox(CaseInfoForm)
{ 
   var count="<%=iCount%>";
//   alert(count);
   var j=0;
   var processid="";
   if(count>0)
   {
     var obj = document.getElementsByName("StepRadio");
     for(i=0;i<obj.length;i++)
     {
       if(obj[i].checked)
       {
           j=1;
           processid=obj[i].value;
           sProcessId=processid;
           break;
           alert(obj[i].value);
      }
     }
     if(j==0)
     {
        alert("2---没有选中的步骤，不能进行修改!");
     }
     else
     {
	   var refresh=showModalDialog('CaseManager.CaseStep.jsp?requirement=<%=sRMId%>&caseseq=<%=scaseseq%>&sCaseProcessID='+sProcessId+'&OperType=2',window,'dialogWidth:750px;status:no;dialogHeight:450px');
		if(refresh=="Y")   
  		{
  			self.location.reload(); 
  		}
     }  
   }
   else
   {
      alert("1---没有选中的步骤，不能进行修改!");
   }
	

} 


function queryUpdateDialogBox(sPROCESSID)
{ 
	 var refresh=showModalDialog('CaseManager.CaseStepDetail.jsp?requirement=<%=sRMId%>&caseseq=<%=scaseseq%>&sCaseProcessID='+sPROCESSID+'&OperType=2',window,'dialogWidth:750px;status:no;dialogHeight:450px');
     if(refresh=="Y")   
  	 {
  			self.location.reload(); 
  	 }
} 


function FP_goToURL(url) 
{
   var count="<%=iCount%>";
//   alert(count);
   var j=0;
   var processid="";
   if(count>0)
   {
//     var obj = document.all.StepRadio;
     var obj = document.getElementsByName("StepRadio");
     for(i=0;i<=obj.length;i++)
     {
       if(obj[i].checked)
       {
           j=1;
           processid=obj[i].value;
           sProcessId=processid;
           break;
           alert(obj[i].value);
      }
     }
     if(j==0)
     {
        alert("2---没有选中的步骤，不能进行修改、删除、复制!");
     }
     else
     {
//       alert(url);
//       alert(processid);
   	   window.location=url+"&PROCESSID="+processid;
      // window.location="test1.jsp?name="+caseId;
      //  alert(caseId);
     }  
   }
   else
   {
      alert("1---没有选中的步骤，不能进行修改、删除、复制!");
   }
}




 
</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name="CaseInfoForm" method="post" action="CaseManager.OperCaseInfo.jsp"> 
<input type="hidden" value="<%if(scaseseq!=null) out.print(scaseseq);%>" name="CaseInfo">
<input type="hidden" value="<%if(sRMId!=null) out.print(sRMId);%>" name="requirement">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>CASE信息:<%//out.print("sProductId="+sProductId+";sProducttype="+sProducttype+";sProductvalue="+sProductvalue+";scaseseq=" + scaseseq + ";sCASEID=" + sCASEID +";sCASENAME="+ sCASENAME +";sCASEDESC="+ sCASEDESC +";sEXPRESULT="+ sEXPRESULT +";sCLIINFOID="+ sCLIINFOID +";sSVRINFOID="+ sSVRINFOID +";sCASEDATAPREPARE="+ sCASEDATAPREPARE +";sSUBSYSID="+sSUBSYSID+";sMODULEID="+sMODULEID+";sCASETYPE="+sCASETYPE+";sPROGRAMNAME="+sPROGRAMNAME); %><br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr> 
          <td class="contentbg"><table width="734" border="0" cellspacing="0" cellpadding="1" height="19">
              <tr class="contentbg"> 
                <td width="13%" class="pagetitle1">功能点：</td>
                <td width="77%" class="pagetextdetails">
                <%
                	String sfuncName;
                	Vector funcName=QueryBaseData.getfuncName (sProducttype,sProductvalue) ;
                	if(funcName.size()>0)
                	 {
                		for(int i=funcName.size()-1;i>=0;i--)
                	  	{
							HashMap funcNamehash = (HashMap) funcName.get(i);
							sfuncName = (String) funcNamehash.get("FUNCNAME");
							out.print(sfuncName);
                	  	}
                	 }
                 %>
                </td>
                <td width="10%" class="pagetextdetails" align="middle">
                <%
                   out.print(sproductName);                  
                %>
<input type="hidden" value="<%if(sproductName!=null) out.print(sproductName);%>" name="Version">
                </td>
              </tr>
            </table> </td>
        </tr>
        <tr> 
          <td class="contentbottomline"><table width="734" border="0" cellspacing="0" cellpadding="1" height="271">
              <tr> 
                <td class="pagetitle1">case编号：<%//out.print("sProducttype="+sProducttype+";sProductvalue="+sProductvalue); %></td>
                <td><strong><input style= "width: 245px; " type="text" name="CASEID" class="inputstyle" size="42"  value="<%if(sCASEID!=null) out.print(sCASEID);%>">
                	<input type="hidden" value="<%if(sgetCASEID!=null) out.print(sgetCASEID);%>" name="getCASEID">
                </strong></td>
                <td class="pagetitle1">case名称：<br></td>
                <td class="pagetextdetails">
                	<input style= "width: 274px; " type="text" name="CASENAME" class="inputstyle" size="47"  value="<%if(sCASENAME!=null) out.print(sCASENAME);%>"> </td>
              </tr>
              <tr class="contentbg"> 
                <td class="pagetitle1">case描述：</td>
                <td> 
                  <textarea name="CASEDESC" style= "width: 245px; "  class="inputstyle"><%if(sCASEDESC!=null) out.print(sCASEDESC);%></textarea></td>
                <td class="pagetitle1">预期结果：</td>
                <td><textarea name="EXPRESULT" style= "width: 274px; "  class="inputstyle"><%if(sEXPRESULT!=null) out.print(sEXPRESULT);%></textarea></td>
              </tr>
              <tr height=""> 
                <td class="pagetitle1">前台版本：</td>
                <td>
                 <select  style= "width: 247px; " disabled="disabled"  name="CLIINFOID" class="inputstyle" size="1" >
                 <option value="" selected=selected><%if(sCLIINFOID!=null) out.print(sCLIINFOID);else out.print("-------请选择-------"); %></option>
                </SELECT>
                </td>
                <td class="pagetitle1">后台版本：</td>
                <td>
                <select style= "width: 274px; " disabled="disabled" name="SVRINFOID" class="inputstyle" size="1" >
                 <option value="" selected=selected><%if(sSVRINFOID!=null) out.print(sSVRINFOID);else out.print("-------请选择-------"); %></option>
    	      </SELECT>
    	      </td>
              </tr>
              <tr class="contentbg"> 
                <td class="pagetitle1">测试环境：</td>
                <td> 
                  <textarea name="CASEENV" style= "width: 245px; "  class="inputstyle" ><%if(sCASEENV!=null) out.print(sCASEENV);%></textarea></td>
                <td class="pagetitle1">数据准备：</td>
                <td> 
                  <textarea name="CASEDATAPREPARE" style= "width: 274px; " class="inputstyle" ><%if(sCASEDATAPREPARE!=null) out.print(sCASEDATAPREPARE);%></textarea></td>
              </tr>
              
              <tr> 
                <td class="pagetitle1">子系统：</td>
                <td>
                <select  style= "width: 247px; " disabled="disabled" name="SUBSYSID" id="selectSubSys" class="inputstyle" size="1" onchange="ChangeSubSys()" >
                  <option value="" selected=selected><%if(sSUBSYSID!=null) out.print(sSUBSYSID);else out.print("-------请选择-------"); %></option>
 				 </SELECT>
               </td>
                <td class="pagetitle1">模块：</td>
                <td>
                 <select  style= "width: 274px; " disabled="disabled" name="MODULEID" id="selectModule" class="inputstyle" size="1"  >
                 <option value="" selected=selected><%if(sMODULEID!=null) out.print(sMODULEID);else out.print("-------请选择-------"); %></option>
    			</SELECT>
				</td>
              </tr>
 			<tr class="contentbg"> 
                <td class="pagetitle1">进程/接口：</td>
                <td>
                  <textarea name="PROGRAMNAME" style= "width: 245px; " class="inputstyle"><%if(sPROGRAMNAME!=null) out.print(sPROGRAMNAME);%></textarea></td>
               
               <td class="pagetitle1">case类型：</td>
                <td>
                 <select  style= "width: 274px; " disabled="disabled" name="CASETYPE" class="inputstyle" size="1" >
                 <option value="" selected=selected><%if(sCASETYPE!=null) out.print(sCASETYPE);else out.print("-------请选择-------"); %></option>
 				 </SELECT>
 				</td>
              </tr>
              
			  <tr> 
                <td class="pagetitle1">case编写人：</td>
                <td>
                <select  style= "width: 247px; " disabled="disabled" name="OPID" id="selectWriteOp" class="inputstyle" size="1" >
                 <option value="" selected=selected><%if(sOPID!=null) out.print(sOPID);else out.print("-------请选择-------"); %></option>
                  </select>
                </td>
                <td class="pagetitle1">case执行人：</td>
                <td>
                <select  style= "width: 274px; " disabled="disabled" name="selectExecuteOp" id="selectWriteOp" class="inputstyle" size="1" >
                 <option value="" selected=selected><%if(sOPID!=null) out.print(sOPID);else out.print("-------请选择-------"); %></option>
                  </select>
                 <tr>
                <td class="pagetitle">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table> </td>

</tr>    

	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title"> 
          <td>case步骤详细信息<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="5%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="15%" class="pagecontenttitle">描述</td>
                <td width="15%" class="pagecontenttitle">预期结果<br></td>
                <td width="15%" class="pagecontenttitle">数据检查<br></td>
                <td width="15%" class="pagecontenttitle">实际结果<br></td>
                <td width="15%" class="pagecontenttitle">后台日志<br></td>
                <td width="5%" class="pagecontenttitle">dump-in<br></td>
                <td width="5%" class="pagecontenttitle">dump-out</td>
                <td width="5%" class="pagecontenttitleright">附件</td>
              </tr>
		<% 
		   if(sCASEID!=null)
		   {
		      String sPROCESSID="";
		      String sPROCESSDESC="";
		      String sProcessEXPRESULT="";
		      String sCASEDATACHECK="";
		      String sCASELOG="";
		      String sREALRESULT="";
		      String sProcessTATUS="";
		      String sINDUMP="";
		      String sOUTDUMP="";
		      String sACCESSORY="";
		      
		      int iCaseStep=vCaseStep.size();
		      iCount=iCaseStep;
		      
		      int jCS=1;
		      //iCount=vCase.size();
		      if(vCaseStep.size()>0)
		      {
		         int iCS=1;
		         for(iCS=vCaseStep.size()-1;iCS>=0;iCS--)
		         {
	                HashMap hash = (HashMap) vCaseStep.get(iCS);
	                
	                sPROCESSID =(String) hash.get("PROCESS_ID");
	                sPROCESSDESC = (String) hash.get("PROCESS_DESC");
	                sProcessEXPRESULT = (String) hash.get("EXP_RESULT");
	                sCASEDATACHECK = (String) hash.get("CASE_DATA_CHECK");
	                sCASELOG = (String) hash.get("CASE_LOG");
	                sREALRESULT = (String) hash.get("REAL_RESULT");
	                sProcessTATUS = (String) hash.get("TATUS");
	                sINDUMP = (String) hash.get("IN_DUMP");
	                sOUTDUMP = (String) hash.get("OUT_DUMP");
	                sACCESSORY = (String) hash.get("ACCESSORY");

        			if(iCS%2!=0)
        			{
        		 %>
			        <tr> 
			             <td class="coltext"><div align="center"> 
			                 <input type="radio" disabled="disabled" name="StepRadio" value="<%=sPROCESSID%>">
			             </div></td>
			             <td class="coltext" onclick="queryUpdateDialogBox(<%=sPROCESSID%>)"><a href="#"><%=sPROCESSID%></a></td>
			             <td class="coltext10"><%if(sPROCESSDESC!=null) {sPROCESSDESC=sPROCESSDESC.replaceAll("\r\n", "<br>");out.print(sPROCESSDESC);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sProcessEXPRESULT!=null) {sProcessEXPRESULT=sProcessEXPRESULT.replaceAll("\r\n", "<br>");out.print(sProcessEXPRESULT);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sCASEDATACHECK!=null) {sCASEDATACHECK=sCASEDATACHECK.replaceAll("\r\n", "<br>");out.print(sCASEDATACHECK);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sREALRESULT!=null) {sREALRESULT=sREALRESULT.replaceAll("\r\n", "<br>");out.print(sREALRESULT);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sCASELOG!=null) {sCASELOG=sCASELOG.replaceAll("\r\n", "<br>");out.print(sCASELOG);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sINDUMP!=null) {sINDUMP=sINDUMP.replaceAll("\r\n", "<br>");out.print(sINDUMP);} else out.print("&nbsp;");%></td>			             			             
			             <td class="coltext10"><%if(sOUTDUMP!=null) {sOUTDUMP=sOUTDUMP.replaceAll("\r\n", "<br>");out.print(sOUTDUMP);} else out.print("&nbsp;");%></td>
			             <td class="coltext">
			             <%
			             	 if(sACCESSORY!=null)
			                  {
			             %>
			              <a href="upload/<%=sACCESSORY%>" target="Window_Name"><%=sACCESSORY%></a>
			             <% 
			                  }
			                  else
			                  {
			                     out.print("&nbsp;");
			                  }
			             %></td>			             
			         </tr>
         	<%
         		}
         	 %>
         	 <%
         	 	if(iCS%2==0)
         	 	{
         	  %>
			        <tr> 
			             <td class="coltext"><div align="center"> 
			                 <input type="radio" disabled="disabled" name="StepRadio" value="<%=sPROCESSID%>">
			             </div></td>
			             <td class="coltext2" onclick="queryUpdateDialogBox(<%=sPROCESSID%>)"><a href="#"><%=sPROCESSID%></a></td>
			             <td class="coltext20"><%if(sPROCESSDESC!=null) {sPROCESSDESC=sPROCESSDESC.replaceAll("\r\n", "<br>");out.print(sPROCESSDESC);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sProcessEXPRESULT!=null) {sProcessEXPRESULT=sProcessEXPRESULT.replaceAll("\r\n", "<br>"); out.print(sProcessEXPRESULT);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sCASEDATACHECK!=null) {sCASEDATACHECK=sCASEDATACHECK.replaceAll("\r\n", "<br>");out.print(sCASEDATACHECK);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sREALRESULT!=null) {sREALRESULT=sREALRESULT.replaceAll("\r\n", "<br>");out.print(sREALRESULT);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sCASELOG!=null) {sCASELOG=sCASELOG.replaceAll("\r\n", "<br>");out.print(sCASELOG);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sINDUMP!=null) {sINDUMP=sINDUMP.replaceAll("\r\n", "<br>");out.print(sINDUMP);} else out.print("&nbsp;");%></td>			             			             
			             <td class="coltext20"><%if(sOUTDUMP!=null) {sOUTDUMP=sOUTDUMP.replaceAll("\r\n", "<br>");out.print(sOUTDUMP);} else out.print("&nbsp;");%></td>
			             <td class="coltext2">
			             <%
			             	 if(sACCESSORY!=null)
			                  {
			             %>
			               <a href="upload/<%=sACCESSORY%>" target="Window_Name"><%=sACCESSORY%></a>
			             <% 
			                  }
			                  else
			                  {
			                     out.print("&nbsp;");
			                  }
			             %></td>			             
			         </tr>      	  
         	  <%
         	  	} 
         	  %>
        <%        
                 jCS=jCS+1;
                 }
              }
            }   
         %>

              <tr> 
                <td class="pagecontenttitle">&nbsp;</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="15%" class="pagecontenttitle">描述</td>
                <td width="15%" class="pagecontenttitle">预期结果<br></td>
                <td width="15%" class="pagecontenttitle">数据检查<br></td>
                <td width="15%" class="pagecontenttitle">实际结果<br></td>
                <td width="15%" class="pagecontenttitle">后台日志<br></td>
                <td width="5%" class="pagecontenttitle">dump-in<br></td>
                <td width="5%" class="pagecontenttitle">dump-out</td>
                <td width="5%" class="pagecontenttitleright">附件</td>
              </tr>
            </table></td>
        </tr>      
      </table>
</table>
<div align="center"></div>
        <tr> 
          <td class="contentbottomline"><table width="734" border="0" cellspacing="0" cellpadding="1" height="66">
              <tr> 
                <td  class="pagetitle1">结论:</td></tr>
              <tr>  
                <td><textarea style= "width: 780px; " name="CASECONCLUSION" id="CASECONCLUSION" cols="130" class="inputstyle" onKeyUp="textCounter(this.form.CASEENV,2000)"><%if(sCASEID!=null){if(sCASECONCLUSION!=null) out.print(sCASECONCLUSION);else sCASECONCLUSION=sCASECONCLUSION;} else sCASECONCLUSION=sCASECONCLUSION; %></textarea></td>
              </tr>
            </table> </td>
        </tr>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>关联需求相关属性:<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>      
      <table width="803" border="0" cellspacing="0" cellpadding="0">
       <tr class="pagetitle1">原始需求:</tr>
       <tr class="contentbg"> 
        <textarea style= "width: 780px; " class="inputstyle" rows="6" name="ORIDEMANDINFO"><%if(ORI_DEMAND_INFO!=null){out.print(ORI_DEMAND_INFO);}%></textarea>
       </tr>
          
	   <tr class="pagetitle1">&nbsp;</tr>
       <tr class="pagetitle1">解决方案：</tr>
       <tr class="contentbg"> 
	   <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="DEMANDSOLUTION" cols="133"><%if(DEMAND_SOLUTION!=null){out.print(DEMAND_SOLUTION);}%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>
       <tr class="pagetitle1">测试分析：</tr>
       <tr class="contentbg"> 
	   <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK6" cols="133" ><% if(REMARK6!=null){ out.print(REMARK6);}%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>
       <tr class="pagetitle1">需求变更确认：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="DEMANDCHGINFO" cols="133" ><% if(DEMAND_CHG_INFO!=null){ out.print(DEMAND_CHG_INFO);}%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>       
       <tr class="pagetitle1">[注释1]功能适用：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="REMARK1" cols="133" ><% if(REMARK1!=null){ out.print(REMARK1);}%><%//=REMARK1%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>          
       <tr class="pagetitle1">[注释2]需求单号：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="REMARK2" cols="133" ><% if(REMARK2!=null){ out.print(REMARK2);}%><%//=REMARK2%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>        
       <tr class="pagetitle1">[注释3]涉及修改：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="REMARK3" cols="133" ><% if(REMARK3!=null){ out.print(REMARK3);}%><%//=REMARK3%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>          
       <tr class="pagetitle1">[注释4]测试结论：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="REMARK4" cols="133" ><%if(REMARK4!=null){ out.print(REMARK4);}%><%//=REMARK4%></textarea>
       </tr>

 	   <tr class="pagetitle1">&nbsp;</tr>         
       <tr class="pagetitle1">[注释5]备注|特别提醒：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; "  class="inputstyle" rows="6" name="REMARK5" ><% if(REMARK5!=null){ out.print(REMARK5);}%><%//=REMARK5%></textarea>
       </tr>   
       
      
         <tr>
	     <td width="100">
	       <table width="80" border="0" cellspacing="1" cellpadding="1">
		   </table>
		</td>
    	</tr> 

  </table>         
         <tr> 
          <td><br><div align="center">
              <table width="146" border="0" cellspacing="5" cellpadding="5">
	           <tr> 
	           <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	           <tr> <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="javascript:window.close();">关 闭</td>
	           </tr>
              </table>
			</td>
        </tr>
      </table></td>
  </tr>
</table>

</body>

</html>
