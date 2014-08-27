
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />

<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*" %>
<%
  request.setCharacterEncoding("gb2312");
%>
<%@ include file= "connections/con_start.jsp" %>

<% 
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>

<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<%
  int iCount=0;
  String sProductId="";
  String sRMId=request.getParameter("requirement");
  String sFlag=(String)session.getAttribute("sFlag");
  
//  out.print("sFlag="+sFlag);
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
  String sopId=(String)session.getValue("OpId");
  Vector Product=QueryBaseData.queryProduct(sProducttype,sProductvalue);
  String sproductName="";
   if(Product.size()>0)
  	{
  		HashMap Producthash = (HashMap) Product.get(0);
  		sProductId=(String) Producthash.get("PRODUCT_ID");
  		sproductName = "[" + (String) Producthash.get("PRODUCT_NAME") + "]"; 
 	 }
 //根据入参判断是页面是新增操作还是修改操作,并对界面上case信息框的变量进行赋值
   String scaseseq=request.getParameter("caseId");
   String sOldCaseID=request.getParameter("sOldCaseID");

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
   Vector CaseInfo=new Vector();
   
   if(scaseseq!=null)
   {
   	  CaseInfo=CaseOpera.querycaseRec(scaseseq);//("2");//
   }
   else if(sOldCaseID!=null)
   {
   	  CaseInfo=CaseOpera.querycaseRec(sOldCaseID);
   }
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
			if(sCASETYPE==null) sCASETYPE="";
			sPROGRAMNAME = (String) CaseInfohash.get("PROGRAM_NAME");
			sCASECONCLUSION = (String) CaseInfohash.get("CASE_CONCLUSION");	
       }
    }
		      


//获取case步骤数据
	Vector vCaseStep=new Vector();
	if(sOldCaseID==null)
	{
		vCaseStep=CaseOpera.querycaseProcess(scaseseq,"");
	}
	iCount=vCaseStep.size();
	

%>

<%
	String sTemp="";
	String sDate="";
	String ssql17=""; //获取所有子系统下的所有模块
	String ssql19=""; //获取指定子系统
	String ssql23=""; //获取指定一个产品下的子系统
	String ssql24=""; //获取指定一个子系统下的模块
	String ssql30=""; //获取指定所有产品下的所有子系统
	String ssql51=""; //获取部门内所有组
	String ssql52=""; //获取部门内所有小组所有成员
	String ssql53=""; //获取部门内指定一个小组的成员
	String ssql54=""; //获取前台版本枚举
	String ssql55=""; //获取后台版本枚举
	String ssql56=""; //获取case类型枚举			
	ResultSet rs17=null;
	ResultSet rs19=null;	
	ResultSet rs23=null;
	ResultSet rs24=null;
	ResultSet rs30=null;
	ResultSet rs51=null;
	ResultSet rs52=null;
	ResultSet rs53=null;
	ResultSet rs54=null;
	ResultSet rs55=null;
	ResultSet rs56=null;
					
	Statement stmt17 = conn.createStatement();
	Statement stmt19 = conn.createStatement();	
	Statement stmt23 = conn.createStatement();
	Statement stmt24 = conn.createStatement();
	Statement stmt30 = conn.createStatement();
	Statement stmt51 = conn.createStatement();
	Statement stmt52 = conn.createStatement();
	Statement stmt53 = conn.createStatement();
	Statement stmt54 = conn.createStatement();
	Statement stmt55 = conn.createStatement();
	Statement stmt56 = conn.createStatement();	
	
	String defProduct = "";
	String defSubsys="";
	

	if(sSUBSYSID!=null)
	{
		defSubsys = sSUBSYSID;
	}
	else
	{
		defSubsys = "";

	}
	
	
	String defModule = "";
	String defOperator = "";
	String defCliinfo = "";
	String defSvrinfo = "";
	String defCasetype = "";
//	out.print("defProduct="+defProduct+";\n defSubsys="+defSubsys+";\n defModule="+defModule+";\n defOperator="+defOperator+";\n defCliinfo="+defCliinfo+";\n defSvrinfo="+defSvrinfo+";\n defCasetype="+defCasetype);		
	String Products="("+sProductId+")";
	
	try
	{	
		//ssql17="select subsys_id as upid,module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		//      +" from product_detail  where status = 1 and product_id in  "+Products+" order by upid,name";
		ssql17="select subsys_id as upid,module_id as id,module_name as name "
		      +" from product_detail  where status = 1 and product_id in  "+Products+" order by upid,name";
		//*****qcs数据库中模块名称数据修改，故修改sql语句*******end******
		
//		out.println("ssql17="+ssql17+";\n");
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

		  sql = " select product_id id,product_name,'['||product_id||']'||product_name as name "
		      +" from product where product_id in "+Products+" order by name ";
//		  out.println("ssql17="+ssql17+";\n");
		  try
		  {
			  rs19 = stmt19.executeQuery(sql);
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
		//*****qcs数据库中模块名称数据修改，故修改sql语句*****20090205modify*******start******
		//ssql24="select module_id as id,substr(module_name,instr(module_name,'(')+1,instr(module_name,')')-instr(module_name,'(')-1)||' -- '||module_name as name "
		//      +" from product_detail  where  STATUS=1 and  SUBSYS_ID ='"+defSubsys+"' order by name";
		ssql24="select module_id as id,module_name as name "
		      +" from product_detail  where  STATUS=1 and  SUBSYS_ID ='"+defSubsys+"' order by name";
				
		//out.println("ssql24="+ssql24+";\n");
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
		System.out.println("ssql30="+ssql30+";\n");

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


// case编写人中，增加显示所有有权限的操作员
//		ssql52="select a.group_id as upid,a.op_id as id,c.op_mail||' - '||c.op_name as name "
//		      +" from group_op_info a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id";
		ssql52="select a.group_id as upid,a.op_id as id,c.op_mail||' - '||c.op_name as name "
		      +" from group_op_info a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id"
		      +" union"
		      +" select a.group_id as upid,a.op_id as id,c.op_mail||' - '||c.op_name as name"
		      +" from group_op_info_ext a,group_def b,op_login c where a.group_id=b.group_id and a.op_id=c.op_id";
// case编写人中，增加显示所有有权限的操作员  
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

	   ssql54="select code_value as id,'['||code_value||'] '||cname as name from sys_base_type "
	         +" where table_name='CASE_REC' and col_name='CLI_INFO_ID' order by name";
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

	   ssql55="select code_value as id,'['||code_value||'] '||cname as name from sys_base_type "
	         +" where table_name='CASE_REC' and col_name='SVR_INFO_ID' order by id";
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
		System.out.println("ssql55="+ssql55+";\n");

	   ssql56="select code_value as id,'['||code_value||'] '||cname as name from sys_base_type "
	         +" where table_name='CASE_REC' and col_name='CASE_TYPE' order by id";
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


function SaveRemind(form1)
{
	var sCaseSeq=<%=scaseseq%>;
	var sRMId="<%=sRMId%>";
	var sFlag="<%=sFlag%>";
	var bln=window.confirm("即将离开此页面，请确定数据是否保存！是否返回？\n\n点<确定>，返回；点<取消>，取消返回！"+"\n");	
	if(bln==true)
	{
		if(sFlag=="1") 
		{
			window.location=/*href*/"CaseManager.CaseRecord.jsp?requirement="+sRMId;
		}
		else
		{
			window.location=location.href=/*href*/"casemanager.jsp?requirement="+sRMId;
		}
	}	
}

function addDialogBox(CaseInfoForm)
{ 
//	var k=showModalDialog('CaseManager.CaseStep.jsp',window,'dialogWidth:750px;status:no;dialogHeight:450px')
//判断界面case基本信息是否保存，如未保存，弹出提示提醒。
	var sCaseSeq=<%=scaseseq%>;
	if((sCaseSeq==null)||(sCaseSeq==""))
	{
		alert("信息未保存，请先点击保存按钮再操作！")
	}
	else
	{		
		var refresh=showModalDialog('CaseManager.CaseStep.jsp?requirement=<%=sRMId%>&caseseq=<%=scaseseq%>&sCaseProcessID=&OperType=1',window,'dialogWidth:750px;status:no;dialogHeight:450px');
		if(refresh=="Y")   
	  	{
	  		self.location.reload(); 
	  	}
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
	 //判断界面case基本信息是否保存，如未保存，弹出提示提醒。
	var sCaseSeq=<%=scaseseq%>;
	if((sCaseSeq==null)||(sCaseSeq==""))
	{
		alert("信息未保存，请先点击保存按钮再操作！")
	}
	else
	{
	  var refresh=showModalDialog('CaseManager.CaseStep.jsp?requirement=<%=sRMId%>&caseseq=<%=scaseseq%>&sCaseProcessID='+sPROCESSID+'&OperType=2',window,'dialogWidth:750px;status:no;dialogHeight:450px');
      if(refresh=="Y")   
  	  {
  		self.location.reload(); 
  	  }
  	}
} 


function FP_ADDURL(url)
{
  var oldCaseID=<%=scaseseq%>;
//判断界面case基本信息是否保存，如未保存，弹出提示提醒。
  var sCaseSeq=<%=scaseseq%>;
  if((sCaseSeq==null)||(sCaseSeq==""))
  {
	alert("信息未保存，请先点击保存按钮再操作！")
  }
  else
  {
  	window.location=url+"&sOldCaseID="+oldCaseID;
  }
}

function FP_goToURL(url) 
{
   var count="<%=iCount%>";
//   alert(count);
   var j=0;
   var processid="";
//判断界面case基本信息是否保存，如未保存，弹出提示提醒。
	var sCaseSeq=<%=scaseseq%>;
	if((sCaseSeq==null)||(sCaseSeq==""))
	{
		alert("信息未保存，请先点击保存按钮再操作！")
	}
	else
	{
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
	        alert("2---没有选中的步骤，不能进行修改、删除、复制!");
	     }
	     else
	     {
	   	   window.location=url+"&PROCESSID="+processid;
	     }  
	   }
	   else
	   {
	      alert("1---没有选中的步骤，不能进行修改、删除、复制!");
	   }
   }
}

function DeleteRec(url)
{
	var bln=window.confirm("数据删除后不能恢复，请确定是否删除？\n\n点<确定>，删除；点<取消>，取消删除！"+"\n");	
	if(bln==true)
	{
		FP_goToURL(url);
	}
	
}

function onProductChange()
	{
		//取模块信息
		//getSubsys();	
		getSubsysChange();	
	
	}

	function getSubsysChange()
	{
		var value1=<%=sProductId%>;
	
		//取子系统信息
		document.getElementById("selectSubSys").options.length=1;
		document.getElementById("selectModule").options.length=1;
		
		var lenOption=document.getElementById("allSubsys").options.length;
		var rValue;
		for (var i=0;i<document.getElementById("allSubsys").options.length;i++)
		{
		  len = document.getElementById("allSubsys").options[i].value.indexOf("*");
		  if (document.getElementById("allSubsys").options[i].value.substring(0,len)==value1)
		  {
				//alert(document.open.allProject.options[i].value.substring(0,len)+":"+value1);
				document.getElementById("selectSubSys").add(window.Option.create(document.getElementById("allSubsys").options[i].text,document.getElementById("allSubsys").options[i].value.substring(len+1),0));
		  }
		}
	}	
	
	function getModuleChange()
	{
 		var sSelectSubSys = document.getElementById("selectSubSys").value;
		
		//取子系统信息
		document.getElementById("selectModule").length=1;
		var lenOption=document.getElementById("allModule").options.length;
		var rValue;
		for (var i=0;i<document.getElementById("allModule").options.length;i++)
		{
		  len = document.getElementById("allModule").options[i].value.indexOf("*");
		  if (document.getElementById("allModule").options[i].value.substring(0,len)==sSelectSubSys)
		  {
				
				//document.getElementById("selectModule").add(window.Option.create(document.getElementById("allModule").options[i].text,document.getElementById("allModule").options[i].value.substring(len+1),0));
				//document.getElementById("selectSubSys").add(window.Option.create(document.getElementById("allSubsys").options[i].text,document.getElementById("allSubsys").options[i].value.substring(len+1),0));
				var o = document.createElement("OPTION");
			    o.text = document.getElementById("allModule").options[i].text;
			    o.value=document.getElementById("allModule").options[i].value.substring(len+1);
				document.getElementById("selectModule").add(o);
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
<title>casemanager</title>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name="CaseInfoForm" method="post" action="CaseManager.OperCaseInfo.jsp"> 
<input type="hidden" value="<%if(scaseseq!=null) out.print(scaseseq);%>" name="CaseInfo">
<input type="hidden" value="<%if(sRMId!=null) out.print(sRMId);%>" name="requirement">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>CASE信息:<%//out.print("\n sProductId="+sProductId+";sProducttype="+sProducttype+";sProductvalue="+sProductvalue+";scaseseq=" + scaseseq + ";sCASEID=" + sCASEID +";sCASENAME="+ sCASENAME +";sCASEDESC="+ sCASEDESC +";sEXPRESULT="+ sEXPRESULT +";sCLIINFOID="+ sCLIINFOID +";sSVRINFOID="+ sSVRINFOID +";sCASEDATAPREPARE="+ sCASEDATAPREPARE +";sSUBSYSID="+sSUBSYSID+";sMODULEID="+sMODULEID+";sCASETYPE="+sCASETYPE+";sPROGRAMNAME="+sPROGRAMNAME); %><br></td>
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
                <td><strong><input style= "width: 245px; " type="text" name="CASEID" id="CASEID" class="inputstyle" size="42" disabled="disabled" style="background:#0c0c0" 
                <%
                	if(scaseseq!=null)
                	{
                		String soldCaseId;
                		sgetCASEID=sCASEID;               		
                		soldCaseId=" value=" + sCASEID;
                		out.print(soldCaseId); 
                	}                
                    else
                    {
                		 String snewCaseId;
                		 Vector newCaseId=QueryBaseData.getnewCaseId(sProducttype,sProductvalue);
                		  if(newCaseId.size()>0)
                		  {
                		  	for(int i=newCaseId.size()-1;i>=0;i--)
                		  	{
								HashMap newCaseIdhash = (HashMap) newCaseId.get(i);
								snewCaseId = (String) newCaseIdhash.get("NEWCASEID");
								sgetCASEID=snewCaseId;
								snewCaseId=" value="+ snewCaseId;
								out.print(snewCaseId);
                		  	}
                		  } 
                		 }                	 
                	
                %>>
<input type="hidden" value="<%if(sgetCASEID!=null) out.print(sgetCASEID);%>" name="getCASEID" id="getCASEID">
                </strong></td>
                <td class="pagetitle1">case名称：<br></td>
                <td class="pagetextdetails">
                	<input style= "width: 274px; " type="text" name="CASENAME" class="inputstyle" size="47" onKeyUp="textCounter(this.form.CASENAME,254)"  value="<%if(sCASEID!=null || sOldCaseID!=null){if(sCASENAME!=null) out.print(sCASENAME); else sCASENAME=sCASENAME ;}else sCASENAME=sCASENAME ;%>"> </td>
              </tr>
              <tr class="contentbg"> 
                <td class="pagetitle1">case描述：</td>
                <td> 
                  <textarea name="CASEDESC" style= "width: 245px; " class="inputstyle" onKeyUp="textCounter(this.form.CASEDESC,1999)"><%if(sCASEID!=null || sOldCaseID!=null){if(sCASEDESC!=null) out.print(sCASEDESC);else sCASEDESC=sCASEDESC;}else sCASEDESC=sCASEDESC ; %></textarea></td>
                <td class="pagetitle1">预期结果：</td>
                <td><textarea name="EXPRESULT" style= "width: 274px; " class="inputstyle" onKeyUp="textCounter(this.form.EXPRESULT,1999)"><%if(sCASEID!=null || sOldCaseID!=null){if(sEXPRESULT!=null) out.print(sEXPRESULT);else sEXPRESULT=sEXPRESULT ;}else sEXPRESULT=sEXPRESULT ; %></textarea></td>
              </tr>
              <tr height=""> 
                <td class="pagetitle1">前台版本：</td>
                <td>
                 <select  style= "width: 247px; " name="CLIINFOID" class="inputstyle" size="1" >
                 <option value="">-------请选择-------</option>
                 <%
					while(rs54.next())
					{
						if(rs54.getString("id").equals(sCLIINFOID)==true)
						{	
				 %>
				 <option value="<%=rs54.getString("id")%>" selected><%=rs54.getString("name")%></option>
                 <%		}
                 		else
                 		{ 
                 %>
                 <option value="<%=rs54.getString("id")%>" ><%=rs54.getString("name")%></option>
                 <%      }
					}
				 %>
                 
                </td>
                <td class="pagetitle1">后台版本：</td>
                <td>
                <select style= "width: 274px; " name="SVRINFOID" class="inputstyle" size="1" >
                 <option value="">-------请选择-------</option>
                 <%
					while(rs55.next())
					{
						if(rs55.getString("id").equals(sSVRINFOID)==true)
						{
				 %>
                 <option value="<%=rs55.getString("id")%>" selected><%=rs55.getString("name")%></option>
                 <%		}
                 		else
                 		{
                 %>
                 <option value="<%=rs55.getString("id")%>" ><%=rs55.getString("name")%></option>                 
                 <%		}
					}
				 %>                	
                 </td>
              </tr>
              <tr class="contentbg"> 
                <td class="pagetitle1">测试环境：</td>
                <td> 
                  <textarea name="CASEENV" style= "width: 245px; " class="inputstyle" onKeyUp="textCounter(this.form.CASEENV,1999)"><%if(sCASEID!=null || sOldCaseID!=null){if(sCASEENV!=null){if(sCASEENV.equals("")==true) out.print("1.登录操作员/密码:\n2.登录营业厅:");else out.print(sCASEENV);}else sCASEENV=sCASEENV;}else sCASEENV=sCASEENV;%></textarea></td>
                <td class="pagetitle1">数据准备：</td>
                <td> 
                  <textarea name="CASEDATAPREPARE" style= "width: 274px; " class="inputstyle" onKeyUp="textCounter(this.form.CASEDATAPREPARE,1999)"><%if(sCASEID!=null || sOldCaseID!=null){if(sCASEDATAPREPARE!=null) out.print(sCASEDATAPREPARE);else sCASEDATAPREPARE=sCASEDATAPREPARE;}else sCASEDATAPREPARE=sCASEDATAPREPARE;%></textarea></td>
              </tr>
              
              <tr> 
                <td class="pagetitle1">子系统：</td>
                <td>
                <select  style= "width: 247px; " name="SUBSYSID" id="selectSubSys" class="inputstyle" size="1" onchange="getModuleChange()">
                 <option value="">-------请选择-------</option>
                     <%
						while(rs30.next())
						{
							if(rs30.getString("id").equals(sSUBSYSID)==true)
							{
					 %>
                      <option value="<%=rs30.getString("id")%>" selected> <%=rs30.getString("name")%></option>
                     <%		}
                     		else
                     		{
                     %>
                      <option value="<%=rs30.getString("id")%>" > <%=rs30.getString("name")%></option>                     
                     <%      }
						}
					 %>
                    </select>
                <td class="pagetitle1">模块：</td>
                <td>
                 <select  style= "width: 274px; " name="MODULEID" id="selectModule" class="inputstyle" size="1"  >
                 <option value="">-------请选择-------</option>
				  <%
						while(rs24.next())
						{
							if(rs24.getString("id").equals(sMODULEID)==true)
							{
					  %>
                      <option value="<%=rs24.getString("id")%>" selected><%=rs24.getString("name")%></option>
                      <%	}
                      		else
                      		{
                      %>
                      <option value="<%=rs24.getString("id")%>"><%=rs24.getString("name")%></option>
                      <%	}
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
 			<tr class="contentbg"> 
                <td class="pagetitle1">进程/接口：</td>
                <td>
                  <textarea name="PROGRAMNAME" style= "width: 245px; " class="inputstyle" onKeyUp="textCounter(this.form.PROGRAMNAME,511)"><%if(sCASEID!=null || sOldCaseID!=null){if(sPROGRAMNAME!=null) out.print(sPROGRAMNAME);else sPROGRAMNAME=sPROGRAMNAME;}else sPROGRAMNAME=sPROGRAMNAME;%></textarea></td>
               
               <td class="pagetitle1">case类型：</td>
                <td>
                 <select  style= "width: 274px; " name="CASETYPE" class="inputstyle" size="1" >
                	<option value="">-------请选择-------</option>
                	<%
						while(rs56.next())
						{
							if(!sCASETYPE.equals(""))
							{
								if(rs56.getString("id").equals(sCASETYPE)==true)
								{
			  		%>
                    <option value="<%=rs56.getString("id")%>" selected ><%=rs56.getString("name")%></option>
	                    <%		}
	                    		else
	                    		{
                    %>
                    <option value="<%=rs56.getString("id")%>" ><%=rs56.getString("name")%></option>
                 	<%			}
                 			}
                 			else
                 			{
                 				if(rs56.getString("id").equals("1")==true)
                 				{
                 	%>
                 	<option value="<%=rs56.getString("id")%>" selected ><%=rs56.getString("name")%></option>
                 	<%		
                 			     }
                 			     else
                 			     {
                 	%>
                 	<option value="<%=rs56.getString("id")%>" ><%=rs56.getString("name")%></option>
                 	<%		     
                 			     }
                 			 }    
                 		}	
			  		%>
				</td>
              </tr>
              
			  <tr> 
                <td class="pagetitle1">case编写人：</td>
                <td>
                <select  style= "width: 247px; " name="OPID" id="selectWriteOp" class="inputstyle" size="1" >
                <option value="">-------请选择-------</option>
                <%
					while(rs52.next())
					{
						if(!sOPID.equals(sopId) && !sOPID.equals(""))
						{
							if(rs52.getString("id").equals(sOPID)==true)
							{
				%>
                 <option value="<%=rs52.getString("id")%>" selected ><%=rs52.getString("name")%></option>
                <%			}
                			else
                			{
                %>
                <option value="<%=rs52.getString("id")%>" ><%=rs52.getString("name")%></option>
                <%			
                			}
                		}
                		else
                		{
                			if(rs52.getString("id").equals(sopId)==true)
                			{
                %>
                <option value="<%=rs52.getString("id")%>" selected ><%=rs52.getString("name")%></option>
                <%			}
                			else
                			{                		
                %>
                <option value="<%=rs52.getString("id")%>" ><%=rs52.getString("name")%></option>
                <%			}
                		}
                	}                		
				%>
                </select>
				</td>
              </tr>
            </table> </td>

</tr>    
        <tr>
          <td><div align="left">
              <table width="146" border="0" cellspacing="5" cellpadding="5">
                <tr>
                 <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
    				  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">保存</td>
    				  <input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="a1(this.form)" >
                      </tr>
                    </table></td> 
      
				  <td width="0" height="0"><table width="0" border="0" cellspacing="0" cellpadding="0" height="21">
				    	<tr> 
				    	</tr>
				    </table></td>    
				    <td width="1" height="1"><table width="1" border="0" cellspacing="0" cellpadding="0" height="30">
				    	<tr> 
				    	<td class="reportLine2"><br></td>
				    	</tr>
				    </table></td>
				    <td width="0" height="0"><table width="0" border="0" cellspacing="0" cellpadding="0" height="21">
				    	<tr> 
				    	</tr>
				    </table></td>
				    
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1" >
                      <tr> <%String Type="1"; %>
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="addDialogBox(CaseInfoForm)" >新建步骤
                        </td>
                      </tr>
                    </table></td>

                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="updateDialogBox(CaseInfoForm)" >修改步骤
                        </td>
                      </tr>
                    </table></td>                  
                    
                  <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="DeleteRec(/*href*/'CaseManger.OperCaseStepInfo.jsp?CaseSeq=<%=scaseseq%>&sOperType=3&requirement=<%=sRMId%>')" >删除步骤<br></td>
                      </tr>
                    </table></td>
                    
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToURL(/*href*/'CaseManger.OperCaseStepInfo.jsp?CaseSeq=<%=scaseseq%>&sOperType=4&requirement=<%=sRMId%>')">复制步骤<br></td>
                      </tr>

				    </table></td>
				    <td width="0" height="0"><table width="0" border="0" cellspacing="0" cellpadding="0" height="21">
				    	<tr> 
				    	</tr>
				    </table></td>                     
					<td width="1" height="1"><table width="1" border="0" cellspacing="0" cellpadding="0" height="30">
				    	<tr> 
				    	<td class="reportLine2"><br></td>
				    	</tr>
				    </table></td>
				    <td width="0" height="0"><table width="0" border="0" cellspacing="0" cellpadding="0" height="21">
				    	<tr> 
				    	</tr>
				    </table></td>
				    
				    <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                      <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="returnButton.click()">返回<br></td>
    				  <input type="button" name="returnButton" id="returnButton" runat="server"  style="display:none;" OnClick="SaveRemind(this.form)" >
                      </tr>
                   
                   </table></td>
				    <td width="0" height="0"><table width="0" border="0" cellspacing="0" cellpadding="0" height="21">
				    	<tr> 
				    	</tr>
				    </table></td>                     
					<td width="1" height="1"><table width="1" border="0" cellspacing="0" cellpadding="0" height="30">
				    	<tr> 
				    	<td class="reportLine2"><br></td>
				    	</tr>
				    </table></td>
				    <td width="0" height="0"><table width="0" border="0" cellspacing="0" cellpadding="0" height="21">
				    	<tr> 
				    	</tr>
				    </table></td>
				    
				    <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
					  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_ADDURL(/*href*/'CaseManager.NewCase.jsp?requirement=<%=sRMId%>')">新增case<br></td>
                      </tr>
                    </table></td>
                    
                   
                </tr>
              </table>
            </div></td>
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
                <td width="5%" class="pagecontenttitle">参数输入<br></td>
                <td width="5%" class="pagecontenttitle">参数输出</td>
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
			                 <input type="radio" name="StepRadio" value="<%=sPROCESSID%>">
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
			                 <input type="radio" name="StepRadio" value="<%=sPROCESSID%>">
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
                <td width="5%" class="pagecontenttitle">参数输入<br></td>
                <td width="5%" class="pagecontenttitle">参数输出</td>
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
                <td><textarea style= "width: 780px; " name="CASECONCLUSION" id="CASECONCLUSION" cols="130" class="inputstyle" onKeyUp="textCounter(this.form.CASEENV,2000)"><%if(sCASEID!=null || sOldCaseID!=null){if(sCASECONCLUSION!=null) out.print(sCASECONCLUSION);else sCASECONCLUSION=sCASECONCLUSION;} else sCASECONCLUSION=sCASECONCLUSION; %></textarea></td>
              </tr>
            </table> </td>
        </tr>
         <tr> 
          <td><br><div align="center">
              <table width="146" border="0" cellspacing="5" cellpadding="5">
                <tr>

                </tr>
              </table>
            </div><br></td>
        </tr>
      </table></td>
  </tr>
</table>
<div align="center"></div>

</form>
<% 
    String sAddFlag=(String)session.getAttribute("addStepFlag");
    String sUpdateFlag=(String)session.getAttribute("updateStepFlag");
    if(sAddFlag!=null)
    {
      out.print("<script language='javascript'>alert('新增步骤成功!');</script>");
      session.removeAttribute("addStepFlag");
    }
    if(sUpdateFlag!=null)
    {
      out.print("<script language='javascript'>alert('修改步骤成功!');</script>");
      session.removeAttribute("updateStepFlag");
    }
%>
</body>
<%@ include file= "connections/con_end.jsp"%>
</html>
