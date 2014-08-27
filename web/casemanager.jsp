<%@include file="allcheck.jsp"%>
<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*"%>
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<%
  request.setCharacterEncoding("gb2312");
%>

<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>

<html
<%
    session.setAttribute("sFlag","0");
    String sRMId=request.getParameter("requirement");
    String sOpId=(String)session.getValue("OpId");
    String sUpdateInfo=request.getParameter("updateInfo");
    String sDeleteInfo=request.getParameter("deleteInfo");
    String sCopyCaseInfo=request.getParameter("copyCaseInfo");
    if(sDeleteInfo!=null)
      out.print("<script language='javascript'>alert('删除Case成功!');</script>");
     if(sCopyCaseInfo!=null)
      out.print("<script language='javascript'>alert('复制Case成功!');</script>");
      
    //判断操作需求是否关联其他源需求，如果是，则跳转到case补录界面进行操作。  
    int iCount=0;
    int iList1=0;
    Vector vRemandRelationList1=new Vector();
    Vector vCase=new Vector();
    if(sRMId!=null)
	 {
		  String sSubRMId=sRMId.substring(1);
		  int iRMId=sRMId.indexOf("R");
		  if(iRMId>=0)
		     iRMId=1;
		  else
		    iRMId=2;  
		  if(iRMId==1)
		  {
		  	 vRemandRelationList1=dataBean.queryDemandRealtion("",sSubRMId,"0");
			 iList1=vRemandRelationList1.size();
			 if(iList1>0)
			 {
			 	%>
			      <script language="JavaScript">
			      	window.location="CaseManager.CaseRecord.jsp?requirement=<%=sRMId%>";
				  </script> 
	  			<%
			 }
			 else
			 {
			 	vCase=dataBean.getAllCaseInfoall(sSubRMId,iRMId);
	      		iCount=vCase.size();
			 }
		  }
		  else
		  {	
	      	vCase=dataBean.getAllCaseInfoall(sSubRMId,iRMId);
	      	iCount=vCase.size();
	      }
      }
      Vector ver=dataBean.getDemandForCase(sOpId);	
      int iRequestCount=ver.size();
    //out.print("id:"+sRMId);
    
    
//使用查询需求或关联的源需求查询需求的附件信息   
int iCountAttachment=0;
String sAttachmentSeq="";   
String sAttachmentSeqTemp=""; 
Vector vAttachment=new Vector();
if(sRMId!=null)
{
	String sSubRMId=sRMId.substring(1);
	int iRMId=sRMId.indexOf("R");
	if(iRMId>=0)
		iRMId=1;
	else
		iRMId=2;  
	// Vector vDemand =dataBean.getDemandInfo(sSubRMId,iRMId);
	vAttachment=dataBean.getDemandAttachmentInfo(sSubRMId,iRMId,"DEMAND_SOLUTION","");
	iCountAttachment=vAttachment.size();
}
if(iCountAttachment>0)
{
   for(int m=vAttachment.size()-1;m>=0;m--)
   {
      sAttachmentSeqTemp="";
      HashMap Attachmenthash = (HashMap) vAttachment.get(m);
      sAttachmentSeqTemp=(String)Attachmenthash.get("SEQ");
      sAttachmentSeq=sAttachmentSeq+sAttachmentSeqTemp+",";
   }
	sAttachmentSeq=sAttachmentSeq.substring(0,sAttachmentSeq.length()-1);
}
      

//使用查询需求或关联的源需求查询需求的参数附件信息   
int iCountAttachment1=0;
String sAttachmentSeq1="";   
String sAttachmentSeqTemp1=""; 
Vector vAttachment1=new Vector();
if(sRMId!=null)
{
	String sSubRMId=sRMId.substring(1);
	int iRMId=sRMId.indexOf("R");
	if(iRMId>=0)
		iRMId=1;
	else
		iRMId=2;  
	vAttachment1=dataBean.getDemandAttachmentInfo(sSubRMId,iRMId,"REMARK3","");
	iCountAttachment1=vAttachment1.size();
}
if(iCountAttachment1>0)
{
   for(int m=vAttachment1.size()-1;m>=0;m--)
   {
      sAttachmentSeqTemp1="";
      HashMap Attachmenthash1 = (HashMap) vAttachment1.get(m);
      sAttachmentSeqTemp1=(String)Attachmenthash1.get("SEQ");
      sAttachmentSeq1=sAttachmentSeq1+sAttachmentSeqTemp1+",";
   }
	sAttachmentSeq1=sAttachmentSeq1.substring(0,sAttachmentSeq1.length()-1);
}

StringBuffer hostur=request.getRequestURL();  //获取当前页面URL地址
String hosturl=hostur.toString();
hosturl=hosturl.substring(0,hosturl.indexOf("QMS"));
    
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用例管理</title>
<script language="JavaScript">
  function a1(form1)
  {   
      var a=form1.requirement.value;
      if(a=="")
      {
         alert("请先查询后再修改");
      }
      else
      {
        form1.submit();
      }
  }
function FP_swapImg() {//v1.0
 var doc=document,args=arguments,elm,n; doc.$imgSwaps=new Array(); for(n=2; n<args.length;
 n+=2) { elm=FP_getObjectByID(args[n]); if(elm) { doc.$imgSwaps[doc.$imgSwaps.length]=elm;
 elm.$src=elm.src; elm.src=args[n+1]; } }
}

function FP_preloadImgs() {//v1.0
 var d=document,a=arguments; if(!d.FP_imgs) d.FP_imgs=new Array();
 for(var i=0; i<a.length; i++) { d.FP_imgs[i]=new Image; d.FP_imgs[i].src=a[i]; }
}

function FP_getObjectByID(id,o) {//v1.0
 var c,el,els,f,m,n; if(!o)o=document; if(o.getElementById) el=o.getElementById(id);
 else if(o.layers) c=o.layers; else if(o.all) el=o.all[id]; if(el) return el;
 if(o.id==id || o.name==id) return o; if(o.childNodes) c=o.childNodes; if(c)
 for(n=0; n<c.length; n++) { el=FP_getObjectByID(id,c[n]); if(el) return el; }
 f=o.forms; if(f) for(n=0; n<f.length; n++) { els=f[n].elements;
 for(m=0; m<els.length; m++){ el=FP_getObjectByID(id,els[n]); if(el) return el; } }
 return null;
}

function FP_changeProp() {//v1.0
 var args=arguments,d=document,i,j,id=args[0],o=FP_getObjectByID(id),s,ao,v,x;
 d.$cpe=new Array(); if(o) for(i=2; i<args.length; i+=2) { v=args[i+1]; s="o"; 
 ao=args[i].split("."); for(j=0; j<ao.length; j++) { s+="."+ao[j]; if(null==eval(s)) { 
  s=null; break; } } x=new Object; x.o=o; x.n=new Array(); x.v=new Array();
 x.n[x.n.length]=s; eval("x.v[x.v.length]="+s); d.$cpe[d.$cpe.length]=x;
 if(s) eval(s+"=v"); }
}

function FP_goToADDURL(url)
{
     var var1="<%=sRMId%>";
     if(var1=="null")
     {
       alert("请查询后再操作");
     }
     else
     {
        window.location=url;
     }
}


function FP_goToURL(url) 
{
   var count="<%=iCount%>";
   var j=0;
   //alert(count);
   var caseId="";
   if(count>0)
   {
//     var obj = document.all.case1;
     var obj = document.getElementsByName("case1");
     for(i=0;i<obj.length;i++)
     {
       if(obj[i].checked)
       {
           j=1;
           caseId=obj[i].value;
           break;
          // alert(obj[i].value);
      }
     }
     if(j==0)
     {
        alert("没有选中CASE，不能进行修改、删除、复制!");
     }
     else
     {
       window.location=url+"&caseId="+caseId;
      // window.location="test1.jsp?name="+caseId;
      //  alert(caseId);
     }  
   }
   else
   {
      alert("没有CASE，不能进行修改、删除、复制!");
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

function FP_goToQueryURL(url)
{
	var sRe;
    sRe=document.getElementById('requirement').value;
    if(sRe == "" || sRe == null){
    	alert("【用例功能点】 不允许为空！");
    	return;
    }
    
    window.location=url+"?requirement="+sRe;
}

function openNewWindow(form1)
{
    var iCount=<%=iRequestCount%>;
    var sRe;
    if(iCount==0)
    {
       alert("你当前没有需求，不能查看详细的需求！");
    }   
    else
    {
       sRe=document.getElementById('requirement').value;
       var sId=sRe.substr(1,sRe.length);
       if((sRe.substr(0,1))=="R") //需求
       {
          window.open("http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id="+sId);
       }
       else     //故障F
       {
          window.open("http://10.10.10.158/project/query/proj_query_result.jsp?op_id="+sId);
       }
    }
}

function changecolor(obj){
obj.className = "buttonstyle2"}

function restorcolor(obj){
obj.className = "buttonstyle"}	


function createWord(from)
{
    var iCount=<%=iRequestCount%>;
    var sRe;
    if(iCount==0)
    {
       alert("你当前没有需求和故障，不能生成文档！");
    }   
    else
    {
       sRe=document.getElementById('requirement').value;
       window.open("createWord.jsp?requirement="+sRe);
    }
}


function AttachmentDialogBox(sOperType)
{ 
	var a=form1.requirement.value;
    if(a=="" )
    {
        alert("请先查询后再增加附件！");
    }
    else
    {
		var refresh=showModalDialog('CaseManager.CaseDemandAttachment.jsp?requirement=<%=sRMId%>&sOperType='+sOperType,window,'dialogWidth:500px;status:no;dialogHeight:150px');
		if(refresh=="Y")   
		{
		 self.location.reload(); 
		}
	}

} 

function DeleteAttachmentDialogBox(sOperType)
{ 
   var count="<%=iCountAttachment%>";
   var p=0;
   var attachmentseq="";

   if(count>0)
   {
	  var obj = document.getElementsByName("attachmentseq");
	  for(i=0;i<obj.length;i++)
	  {
	    if(obj[i].checked)
	    {
	       p=1;
	       attachmentseq=obj[i].value;
	       break;
	    }
	  }
	 if(p==0)
	 {
	    alert("没有选中附件，不能删除!");
	 }
	 else
	 {
	    //window.location=url+"&attachmentseq="+attachmentseq;
	    
	    var refresh=showModalDialog('CaseManager.CaseDemandAttachment.jsp?requirement=<%=sRMId%>&sOperType='+sOperType+'&attachmentseq='+attachmentseq,window,'dialogWidth:500px;status:no;dialogHeight:150px');
		if(refresh=="Y")   
		{
		 self.location.reload(); 
		}
	 }  
   }
   else
   {
	  alert("没有选中附件，不能删除!");
   }
} 

function DeleteAttachmentDialogBox1(sOperType)
{ 
   var count="<%=iCountAttachment1%>";
   var p=0;
   var attachmentseq="";

   if(count>0)
   {
	  var obj = document.getElementsByName("attachmentseq1");
	  for(i=0;i<obj.length;i++)
	  {
	    if(obj[i].checked)
	    {
	       p=1;
	       attachmentseq=obj[i].value;
	       break;
	    }
	  }
	 if(p==0)
	 {
	    alert("没有选中附件，不能删除!");
	 }
	 else
	 {
	    //window.location=url+"&attachmentseq="+attachmentseq;
	    
	    var refresh=showModalDialog('CaseManager.CaseDemandAttachment.jsp?requirement=<%=sRMId%>&sOperType='+sOperType+'&attachmentseq='+attachmentseq,window,'dialogWidth:500px;status:no;dialogHeight:150px');
		if(refresh=="Y")   
		{
		 self.location.reload(); 
		}
	 }  
   }
   else
   {
	  alert("没有选中附件，不能删除!");
   }
} 


function word_onclick()
{
	sid="<%=sRMId%>";
	window.open("querycase.jsp?requirement="+sid);

}



</script>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

</head>
<body>
<form method="post" action="casemanager.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="pagetitle1"> 
          <td>用例功能点：<br></td>
          <td width="24"> <div align="left"><br>
        </tr>
	<% 
	   
	   String sId="";
	   String sName="";
	   String sALL="";

	 %>
	<td>
	<select style= "width: 650px; " align="left" name="requirement" id="requirement" class="inputstyle" size="1" onchange="FP_changeProp(/*id*/'layer5',0,'style.visibility','visible')">
	<%
	  if(ver.size()>0)
	  {
	   for(int i=ver.size()-1;i>=0;i--)
	     {
	       HashMap hash = (HashMap) ver.get(i);
           sId = (String) hash.get("SID");
           //out.print("sId="+sId);
          // sALL=sALL+"---"+sId;
           sName = (String) hash.get("NAME");
           if(sRMId!=null)
           {
           if(sName.indexOf(sRMId)>=0)
           {
             out.print("<option value="+sId+" selected=selected>"+sName+"</option>");
	       }
	       else
	       {
	          out.print("<option value="+sId+" >"+sName+"</option>");
	       }
	       }
	       else
	       {
	       out.print("<option value="+sId+" >"+sName+"</option>");
	       }
	       
	 }
	%>
	</select>
	<% 
	 }
	%> 
	</td>
	</table>

<tr> 
   <td><div align="left">
   <table width="146" border="0" cellspacing="5" cellpadding="5">
   <tr>
	<td width="100"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" type="submit" name="B3" onclick="FP_goToQueryURL(/*href*/'casemanager.jsp')">查询case<br></td>
    	</tr> 
    </table></td>
    
	<td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="openNewWindow(this.form)">查看需求<br></td>
    	</tr>
    </table></td>
 
    <td width="1" height="1"><table width="1" border="0" cellspacing="0" cellpadding="0" height="30">
    	<tr> 
    	<td class="reportLine2"><br></td>
    	</tr>
    </table></td>
    
	<td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToADDURL(/*href*/'CaseManager.NewCase.jsp?requirement=<%=sRMId%>')">新增case<br></td>
    	</tr>
    </table></td>
    
    <td td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToURL(/*href*/'CaseManager.NewCase.jsp?requirement=<%=sRMId%>')">修改case<br></td>
    	</tr>
    </table></td>
    
    <td td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="DeleteRec(/*href*/'deleteCase.jsp?requirement=<%=sRMId%>')")">删除case<br></td>
    	</tr>
    </table></td>
    
    <td td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="FP_goToURL(/*href*/'copyCase.jsp?requirement=<%=sRMId%>')")>复制case<br></td>
    	</tr>
    </table></td>
   
    <td width="1" height="1"><table width="1" border="0" cellspacing="0" cellpadding="0" height="30">
    	<tr> 
    	<td class="reportLine2"><br></td>
    	</tr>
    </table></td>
    
	<td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
    	<tr> 
    	<td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="CreatWord.click()">生成文档
    	<input type="button" name="CreatWord" id="CreatWord" runat="server"  style="display:none;" OnClick="createWord(this.form)" >
    	</br></td>
    	</tr>
    </table></td>
    
 <tr>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr class="title"> 
          <td>case信息<br></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="3%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="3%" class="pagecontenttitle">ID</td>
                <td width="10%" class="pagecontenttitle">case编号<br></td>
                <td width="30%" class="pagecontenttitle">名称<br></td>
                <td width="30%" class="pagecontenttitle">预期结果<br></td>
                <td width="10%" class="pagecontenttitle">case结论<br></td>
                <td width="14%" class="pagecontenttitle">关联模块<br></td>
              </tr>
		<% 
		   if(sRMId!=null)
		   {
		      String sSubRMId=sRMId.substring(1);
		      int iRMId=sRMId.indexOf("R");
		      if(iRMId>=0)
		        iRMId=1;
		      else
		        iRMId=2;  
		     // Vector vCase=dataBean.getAllCaseInfo(sSubRMId,iRMId);

		      String sCaseId="";
		      String sCaseSeq="";
		      String sCaseName="";
		      String sCaseDesc="";
		      String sCaseExpResult="";
		      String sModule="";
		      String sCaseConclusion="";
		      String sModuleId;
	          String sModuleName;
		      int j=1;
		      //iCount=vCase.size();
		      if(vCase.size()>0)
		      {
		         for(int i=vCase.size()-1;i>=0;i--)
		         {
	                HashMap hash = (HashMap) vCase.get(i);
	                sCaseSeq = (String) hash.get("CASE_SEQ");
	                sCaseId = (String) hash.get("CASE_ID");
	                sCaseName = (String) hash.get("CASE_NAME");
	                sCaseDesc = (String) hash.get("CASE_DESC");
	                sCaseExpResult = (String) hash.get("EXP_RESULT");
	                sCaseConclusion = (String) hash.get("CASE_CONCLUSION");
	                sModuleId = (String) hash.get("MODULE_ID");
	                sModuleName=(String) hash.get("MODULE_NAME");
	                sModule=sModuleName;
	     %>
        		<%
        			if(i%2!=0)
        			{
        		 %>
			        <tr> 
			             <td class="coltext"><div align="center"> 
			                 <input type="radio" name="case1" value="<%=sCaseSeq%>">
			             </div></td>
			             <td class="coltext">(<%=j%>)</td>
			             <td class="coltext"><a href="CaseManager.NewCase.jsp?requirement=<%=sRMId%>&caseId=<%=sCaseSeq%>"><%=sCaseId%></a></td>
			             <td class="coltext10"><%if(sCaseName!=null) {sCaseName=sCaseName.replaceAll("\r\n", "<br>");out.print(sCaseName);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sCaseExpResult!=null) {sCaseExpResult=sCaseExpResult.replaceAll("\r\n", "<br>");out.print(sCaseExpResult);} else out.print("&nbsp;");%></td>
			             <td class="coltext10"><%if(sCaseConclusion!=null) {sCaseConclusion=sCaseConclusion.replaceAll("\r\n", "<br>");out.print(sCaseConclusion);} else out.print("&nbsp;"); %></td>
			             <td class="coltext"><%if(sModule!=null) {sModule=sModule.replaceAll("\r\n", "<br>");out.print(sModule);} else out.print("&nbsp;");%></td>
			         </tr>
         	<%
         		}
         	 %>
         	 <%
         	 	if(i%2==0)
         	 	{
         	  %>
			        <tr> 
			             <td class="coltext2"><div align="center"> 
			                 <input type="radio" name="case1" value="<%=sCaseSeq%>">
			             </div></td>
			             <td class="coltext2">(<%=j%>)</td>
			             <td class="coltext2"><a href="CaseManager.NewCase.jsp?requirement=<%=sRMId%>&caseId=<%=sCaseSeq%>"><%=sCaseId%></a></td>
			             <td class="coltext20"><%if(sCaseName!=null) {sCaseName=sCaseName.replaceAll("\r\n", "<br>");out.print(sCaseName);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sCaseExpResult!=null) {sCaseExpResult=sCaseExpResult.replaceAll("\r\n", "<br>");out.print(sCaseExpResult);} else out.print("&nbsp;");%></td>
			             <td class="coltext20"><%if(sCaseConclusion!=null) {sCaseConclusion=sCaseConclusion.replaceAll("\r\n", "<br>");out.print(sCaseConclusion);} else out.print("&nbsp;"); %></td>
			             <td class="coltext2"><%if(sModule!=null) {sModule=sModule.replaceAll("\r\n", "<br>");out.print(sModule);} else out.print("&nbsp;");%></td>
			         </tr>         	  
         	  <%
         	  	} 
         	  %>
        <%        
                 j=j+1;
                 }
              }
            }   
         %>

			<tr> 
                <td width="3%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="3%" class="pagecontenttitle">ID</td>
                <td width="10%" class="pagecontenttitle">case编号<br></td>
                <td width="30%" class="pagecontenttitle">名称<br></td>
                <td width="30%" class="pagecontenttitle">预期结果<br></td>
                <td width="10%" class="pagecontenttitle">case结论<br></td>
                <td width="14%" class="pagecontenttitle">关联模块<br></td>
              </tr>
	</table>
</td>
</tr>
</table>
</tr>
</table>
</div>
</td>
</form>

<form name="form1" method="post" action="updateDemand.jsp">
	<%
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
       <input type="hidden" value="<%if(sRMId!=null) out.print(sRMId);%>" name="requirement">
      <table width="803" border="0" cellspacing="0" cellpadding="0">
       <tr class="pagetitle1">原始需求:</tr>
       <tr class="contentbg"> 
        <textarea style= "width: 780px; " class="inputstyle" rows="6" name="ORIDEMANDINFO"  onKeyUp="textCounter(this.form.ORIDEMANDINFO,3999)"><%if(ORI_DEMAND_INFO!=null){out.print(ORI_DEMAND_INFO);}%></textarea>
       </tr>
          
	   <tr class="pagetitle1">&nbsp;</tr>
       <tr class="pagetitle1">解决方案：
        <a href="#"  onclick="AttachmentDialogBox('1')">增加附件</a>&nbsp;&nbsp;&nbsp;
	   <a href="#"  onclick="DeleteAttachmentDialogBox('2')" >删除附件</a>&nbsp;&nbsp;&nbsp;</tr>
	   <%
	   	 String sAttachmentName="";
	   	 String sAttachmentseq="";
	   	 String sNewName="";
	   	 if(iCountAttachment>0)
	      {
	      	for(int n=vAttachment.size()-1;n>=0;n--)
	      	{
	      		sAttachmentSeqTemp="";
	      		HashMap Attachmenthash = (HashMap) vAttachment.get(n);
	      		sAttachmentName=(String)Attachmenthash.get("OLD_NAME");
	      		sNewName=(String)Attachmenthash.get("ATTACHMENT_NAME");
	      		sAttachmentseq=(String)Attachmenthash.get("SEQ");
		%>
		<tr><br><input type="radio" name="attachmentseq" value="<%=sAttachmentseq%>"><font class="pagetextdetails"><a href="upload/solution/<%=sNewName%>" target="_blank"><%out.print(sAttachmentName+"("+sNewName+")");%></a></font>
		<%
	      	}

	      }
	   %>
       </tr>
       
       
       <tr class="contentbg"> 
	   <textarea style= "width: 780px; " class="inputstyle" rows="6" name="DEMANDSOLUTION" cols="133" onKeyUp="textCounter(this.form.DEMANDSOLUTION,3999)"><%if(DEMAND_SOLUTION!=null){out.print(DEMAND_SOLUTION);}%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>
       <tr class="pagetitle1">测试分析：</tr>
       <tr class="contentbg"> 
	   <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK6" cols="133" onKeyUp="textCounter(this.form.REMARK6,3999)"><% if(REMARK6!=null){ out.print(REMARK6);}%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>
       <tr class="pagetitle1">需求变更确认：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; " class="inputstyle" rows="6" name="DEMANDCHGINFO" cols="133" onKeyUp="textCounter(this.form.DEMANDCHGINFO,3999)"><% if(DEMAND_CHG_INFO!=null){ out.print(DEMAND_CHG_INFO);}%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>       
       <tr class="pagetitle1">[注释1]功能适用：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK1" cols="133" onKeyUp="textCounter(this.form.REMARK1,3999)"><% if(REMARK1!=null){ out.print(REMARK1);}%><%//=REMARK1%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>          
       <tr class="pagetitle1">[注释2]需求单号：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK2" cols="133" onKeyUp="textCounter(this.form.REMARK2,3999)"><% if(REMARK2!=null){ out.print(REMARK2);}%><%//=REMARK2%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>        
       <tr class="pagetitle1">[注释3]涉及修改：
       <a href="#"  onclick="AttachmentDialogBox('3')">增加附件</a>&nbsp;&nbsp;&nbsp;
	   <a href="#"  onclick="DeleteAttachmentDialogBox1('4')" >删除附件</a>&nbsp;&nbsp;&nbsp;</tr>
	   <%
	   	 String sAttachmentName1="";
	   	 String sAttachmentseq1="";
	   	 String sNewName1="";
	   	 if(iCountAttachment1>0)
	      {
	      	for(int n=vAttachment1.size()-1;n>=0;n--)
	      	{
	      		sAttachmentSeqTemp1="";
	      		HashMap Attachmenthash1 = (HashMap) vAttachment1.get(n);
	      		sAttachmentName1=(String)Attachmenthash1.get("OLD_NAME");
	      		sNewName1=(String)Attachmenthash1.get("ATTACHMENT_NAME");
	      		sAttachmentseq1=(String)Attachmenthash1.get("SEQ");
		%>
		<tr><br><input type="radio" name="attachmentseq1" value="<%=sAttachmentseq1%>"><font class="pagetextdetails"><a href="upload/solution/<%=sNewName1%>" target="_blank"><%out.print(sAttachmentName1+"("+sNewName1+")");%></a></font>
		<%
	      	}

	      }
	   %>
       </tr>
       
       
       <tr class="contentbg"> 
       <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK3" cols="133" onKeyUp="textCounter(this.form.REMARK3,3999)"><% if(REMARK3!=null){if(!REMARK3.equals("")) out.print(REMARK3); else out.print("1.涉及后台模块：\n2.涉及前台模块：\n3.DB变更：\n4.BO变更：\n5.BO变更影响模块：\n6.发布参数配置脚本：");}%><%//=REMARK3%></textarea>
       </tr>

	   <tr class="pagetitle1">&nbsp;</tr>          
       <tr class="pagetitle1">[注释4]测试结论：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK4" cols="133" onKeyUp="textCounter(this.form.REMARK4,3999)"><%if(REMARK4!=null){ out.print(REMARK4);}%><%//=REMARK4%></textarea>
       </tr>

 	   <tr class="pagetitle1">&nbsp;</tr>         
       <tr class="pagetitle1">[注释5]备注|特别提醒：</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 780px; " class="inputstyle" rows="6" name="REMARK5" onKeyUp="textCounter(this.form.REMARK5,3999)"><% if(REMARK5!=null){ out.print(REMARK5);}%><%//=REMARK5%></textarea>
       </tr>   
       
      
         <tr>
	     <td width="100">
	       <table width="80" border="0" cellspacing="1" cellpadding="1">
    	   <tr> 
    	  	    <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">提交
          <input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="a1(this.form)" >
		   </tr>
		   </table>
		</td>
    	</tr> 

  </table> 
 <%     if(sUpdateInfo!=null)
      out.print("<script language='javascript'>alert('操作成功!');</script>");
       %>
</form>
</body>

</html>