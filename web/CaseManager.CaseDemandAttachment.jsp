<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>

<%
   String sOperType=request.getParameter("sOperType");
   String sRMId=request.getParameter("requirement"); 
   String attachmentseq=request.getParameter("attachmentseq");
   if(sOperType==null) sOperType="";
   if(sRMId==null) sRMId="";
   if(attachmentseq==null) attachmentseq="";
   
%>

<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>需求相关附件</title>
<script language="JavaScript">
window.location.reload();

function changecolor(obj)
{
obj.className = "buttonstyle2";
}

function restorcolor(obj)
{
obj.className = "buttonstyle";
}

function dialogcommit(form1)
  {   
      var OperType=<%=sOperType%>;
      if(OperType==null)
      {
      	OperType="";
      }
      else if(OperType=="1" ||OperType=="3")
      {
	      var sFileName=document.getElementById('ATTACHMENT').value;
	      if(sFileName.length>0)
	      {
	          sFileName=sFileName.substr(sFileName.length-4,4);
	          if(sFileName.toLowerCase()!=".doc" && sFileName.toLowerCase()!=".txt" && sFileName.toLowerCase()!="docx")
	          {
	            alert("上传的文件不是doc或txt文件，请重新上传！");
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
	         alert("未选择文件或选择文件不正确，请检查！");
		  }
	  }
	  else if(OperType=="2" || OperType=="4")
	  {
	  	 form1.submit();
		 window.close();
		 window.returnValue="Y";
	  }
	  else
	  {
	  	alert("提交数据不正确，请检查！");
	  }
  }	

function cancle()
{ 
	window.close();
	//window.returnValue="Y";
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="CaseDemandAttachmentForm" method="post" action="CaseManager.OperDemandAttachment.jsp"  ENCTYPE="multipart/form-data">  
<input type="hidden" value="<%if(sRMId!=null) out.print(sRMId);%>" name="requirement">
<input type="hidden" value="<%if(sOperType!=null) out.print(sOperType);%>" name="sOperType">
<input type="hidden" value="<%if(attachmentseq!=null) out.print(attachmentseq);%>" name="attachmentseq">

<td class="contentoutside"><table style= "width: 480px; " width="100%" border="0" cellspacing="0" cellpadding="0">      
       <tr class="pagetitle1">附件：<%//out.print("<br>sOperType="+sOperType+"<br>sRMId="+sRMId+"<br>attachmentseq="+attachmentseq); %></tr>	
       <tr class="contentbg"> 
       <%
       		if(sOperType.equals("1") ||sOperType.equals("3"))
       		{
       %>
       <input type="FILE" style= "width: 480px; " name="ATTACHMENT" value="<% //if(sOperType=="2"){if(sACCESSORY!=null) out.print(sACCESSORY);}else sACCESSORY=sACCESSORY;%>">   
       <%	}
       		else if(sOperType.equals("2")|| sOperType.equals("4"))
       		{
       			int iCountAttachment=0;
				String sAttachmentName="";
				String sNewName="";   
			    Vector vAttachment=new Vector();
       			if(sRMId!=null)
	 			{
				  String sSubRMId=sRMId.substring(1);
				  int iRMId=sRMId.indexOf("R");
				  if(iRMId>=0)
				     iRMId=1;
				  else
				    iRMId=2; 
       			if(sOperType.equals("2"))
       			{
       				vAttachment=dataBean.getDemandAttachmentInfo(sSubRMId,iRMId,"DEMAND_SOLUTION",attachmentseq);
	      		}
	      		else //sOperType.equals("4")
	      		{
	      			vAttachment=dataBean.getDemandAttachmentInfo(sSubRMId,iRMId,"REMARK3",attachmentseq);
	      		}
	      		iCountAttachment=vAttachment.size();
      			}
      			if(iCountAttachment==1)
      			{
      				HashMap Attachmenthash = (HashMap) vAttachment.get(0);
      				sAttachmentName=(String)Attachmenthash.get("OLD_NAME");
      				sNewName=(String)Attachmenthash.get("ATTACHMENT_NAME");
      				
       			       		
       %>
       <td class="pagetextdetails" align="left"><%out.print(sAttachmentName); %>
       <input type="hidden" value="<%if(sAttachmentName!=null) out.print(sAttachmentName);%>" name="attachmentname">
       <input type="hidden" value="<%if(sNewName!=null) out.print(sNewName);%>" name="newname">
       
       <%	
       			}
       		}
       		else
       		{
       	%>
       	<class="pagetextdetails" align="left"><%out.print("操作不正确，请确认！"); %>
       	<%	
       		}
       %>
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
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="cancle()" >取消
                 		<br></td>
                      </tr>
 </table>
</td>
</table>
</div>
</td>
</tr>
</table></td>
</form>
  </body>	
 </html>