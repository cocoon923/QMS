<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="CaseOpera" scope="page" class="dbOperation.CaseOpera" />
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
  String sProductId="";
  String sProducttype="";
  String sProductvalue=""; 
  String sRMId=request.getParameter("requirement");
  String sCaseSeq=request.getParameter("caseseq");
  String sopId=(String)session.getValue("OpId");
  String sCaseProcessID=request.getParameter("sCaseProcessID");
  String sOperType=request.getParameter("OperType");//OperTypeֵΪ��1��������2���޸ģ�3��ɾ��
  
  Vector vRec=new Vector();
  vRec=CaseOpera.querycaseProcess(sCaseSeq,"");
  int iCount=vRec.size();
  String sId;
  String[] Array_processrecid=new String[iCount];
  if(vRec.size()>0)
  {
	int j=0;
	for(int i=iCount-1;i>=0;i--)
	{
		HashMap vRechash = (HashMap) vRec.get(i);
		sId = (String) vRechash.get("PROCESS_ID");
		//out.print("sId"+j+"="+sId+"\n");
		Array_processrecid[j]=sId;
		j++;
	}
  }
  
%>

<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>case����</title>
<script language="JavaScript">
window.location.reload();

function changecolor(obj){
obj.className = "buttonstyle2";
}

function restorcolor(obj){
obj.className = "buttonstyle";}	



function dialogcommit(form1)
  {   
      var sFileName=document.getElementById('ACCESSORY').value;
      if(sFileName.length>0)
      {
          sFileName=sFileName.substr(sFileName.length-4,4);
          if(sFileName.toLowerCase()!=".jpg")
          {
            alert("���ϴ����ļ�����jpg�ļ����������ϴ���");
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



function textCounter(field,iCount)   //�����ж������ַ��Ƿ񳬳�
{
   var text=field.value;
   var iCount1=iCount+1;
   if (text==null)
   {
   	 text="";
   }
   if(text.replace(/[^\x00-\xff]/g,"xx").length>iCount)
   {
     alert("���볬��"+iCount1+"�ַ���");
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

function textCounter1()  //���ڼ��case�������Ƿ��ظ�
{
	var processid;
	var oldprocessid;
	oldprocessid="<%=sCaseProcessID%>";
    processid=document.getElementById("PROCESSID").value;
    if(processid==null || processid=="null" || processid=="")
    {
    	alert("case�����Ų���Ϊ�գ�");
    	document.getElementById("PROCESSID").focus();
    }
	else
	{
<%
		int k1=0;
		for(k1=0;k1<=Array_processrecid.length-1;k1++)
		{
%>

			if(processid==<%=Array_processrecid[k1]%>)
			{
				if(processid!=oldprocessid)
				{
		 			alert("����Ĳ������Ѵ���"+processid+"�����������룡");
		 			document.getElementById("PROCESSID").focus();
		 		}
			}
<%			
		}

%>	
	if(processid>99)
	{
		alert("�Զ����ɱ���ѳ������ֵ99�����ֹ���������1-99֮�䲻�ظ������֣�");
		document.getElementById("PROCESSID").focus();
	}
	}
}

function delPic()
{
   var sUrl="CaseManager.DeleteCaseStepAccessory.jsp";
   var sTemp="<%=sCaseSeq%>";
   sUrl=sUrl+"?caseseq="+sTemp;
   sTemp="<%=sCaseProcessID%>"; //sCaseProcessID
   sUrl=sUrl+"&sCaseProcessID="+sTemp;
   window.open(sUrl);
   //alert(sUrl);
  // window.location=sUrl;
  // window.close();
  // var refresh=showModalDialog(sUrl,window,'dialogWidth:750px;status:no;dialogHeight:450px');
  // self.location.reload(); 


   //var sTemp=document.getElementById('sRMId').value;
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id="CaseStepInfoForm" name="CaseStepInfoForm" method="post" action="CaseManger.OperCaseStepInfo.jsp"  ENCTYPE="multipart/form-data">  
<%
  if(sRMId!=null)
	 {
		  sProductvalue=sRMId.substring(1);
		  int iRMId=sRMId.indexOf("R");
		  if(iRMId>=0)
		     sProducttype="1"; //����ı�Ŷ�Ӧ����������
		  else
		    sProducttype="2"; //����ı�Ŷ�Ӧ���ǹ��ϱ�� 
      }   


 //��������ж���ҳ�����������������޸Ĳ���,���Խ�����case��Ϣ��ı������и�ֵ
   String sPROCESSDESC="";
   String sEXPRESULT="";
   String sCASEDATACHECK="";
   String sCASELOG="";
   String sREALRESULT="";
   String sINDUMP="";
   String sOUTDUMP="";
   String sACCESSORY="";

if(sOperType.equals("2")==true)
 {
   Vector CaseStepInfo=CaseOpera.querycaseProcess(sCaseSeq,sCaseProcessID);

      if(CaseStepInfo.size()>0)
        {
          for(int i=CaseStepInfo.size()-1;i>=0;i--)
            {
				HashMap CaseStepInfohash = (HashMap) CaseStepInfo.get(i);
				sPROCESSDESC = (String) CaseStepInfohash.get("PROCESS_DESC");
				sEXPRESULT = (String) CaseStepInfohash.get("EXP_RESULT");
				sCASEDATACHECK = (String) CaseStepInfohash.get("CASE_DATA_CHECK");
				sCASELOG = (String) CaseStepInfohash.get("CASE_LOG");
				sREALRESULT = (String) CaseStepInfohash.get("REAL_RESULT");
				sINDUMP = (String) CaseStepInfohash.get("IN_DUMP");
				sOUTDUMP = (String) CaseStepInfohash.get("OUT_DUMP");
				sACCESSORY = (String) CaseStepInfohash.get("ACCESSORY");
            }
         }
 }
 
  
 %>
<input type="hidden" value="<%if(sCaseSeq!=null) out.print(sCaseSeq);%>" name="CaseSeq">
<input type="hidden" value="<%if(sRMId!=null) out.print(sRMId);%>" name="requirement">
<input type="hidden" value="<%=sOperType%>" name="sOperType"> 

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>����CASE����:<%//out.print("sOperType='"+sOperType+"';\n sProductId='"+sProductId+"',\n sProducttype="+sProducttype+"';\n sProductvalue="+sProductvalue+";\n sRMId=" + sRMId + ";\n sCaseSeq=" + sCaseSeq +";\n sopId="+ sopId +";\n sCaseProcessID="+ sCaseProcessID); %><br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table style= "width: 700px; " width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr class="contentbg">
       <td width="10%" align="left" class="pagetitle1">����ID��</td>
       <td width="77%" class="pagetextdetails">
        <input type="hidden" value="<%=sCaseProcessID%>" name="sCaseProcessID">
        <strong><input type="text" style="" name="PROCESSID" id="PROCESSID" class="inputstyle" size="42"  MaxLength="2" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onblur="textCounter1()" value=
             <%		
                    if(sOperType.equals("1")==true)  //�����������µĲ���ID
                    {
                		String snewCaseStepID;
                		String sStepIDValue;
                		sStepIDValue=CaseOpera.getCaseProcessID(sCaseSeq);
                		//sStepIDValue=" value="+snewCaseStepID;
						out.print(sStepIDValue);								
                	}                	
                	if(sOperType.equals("2")==true) //�޸ģ���ȡԭ�еĲ���ID
                	{
                		String soldCaseProcessID;              		
                		//soldCaseProcessID=" value=" + sCaseProcessID;
                		out.print(sCaseProcessID); 
                	}                
                	 
               %>></strong>
       </tr>

      <table width="100%" border="0" cellspacing="0" cellpadding="0" style= "width: 700px; " >
       <tr class="pagetitle1">������<%//out.print("sPROCESSDESC="+sPROCESSDESC+"\n sEXPRESULT="+sEXPRESULT+"\n sCASEDATACHECK="+sCASEDATACHECK+"\n sCASELOG="+sCASELOG+"\n sREALRESULT="+sREALRESULT+"\n sINDUMP="+sINDUMP+"\n sOUTDUMP="+sOUTDUMP);%></tr>
       <tr class="contentbg"> 
       <textarea style= "width: 700px; " class="inputstyle" rows="5" name="PROCESSDESC"  onKeyUp="textCounter(this.form.PROCESSDESC,3999)"><%if(sOperType.equals("2")==true){if(sPROCESSDESC!=null) out.print(sPROCESSDESC);}else sPROCESSDESC=sPROCESSDESC;%></textarea>
       </tr>
          
       <tr class="pagetitle1">Ԥ�ڽ����</tr>
       <tr class="contentbg"> 
	   <textarea style= "width: 700px; " class="inputstyle" rows="5" name="EXPRESULT" cols="133" onKeyUp="textCounter(this.form.EXPRESULT,3999)"><%if(sOperType.equals("2")==true){if(sEXPRESULT!=null) out.print(sEXPRESULT);}else sEXPRESULT=sEXPRESULT;%></textarea>
       </tr>

       <tr class="pagetitle1">���ݼ�飺</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 700px; " class="inputstyle" rows="5" name="CASEDATACHECK" cols="133" onKeyUp="textCounter(this.form.CASEDATACHECK,3999)"><%if(sOperType.equals("2")==true){if(sCASEDATACHECK!=null) out.print(sCASEDATACHECK);}else sCASEDATACHECK=sCASEDATACHECK;%></textarea>
       </tr>
    
       <tr class="pagetitle1">ʵ�ʽ����</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 700px; " class="inputstyle" rows="5" name="REALRESULT" cols="133" onKeyUp="textCounter(this.form.REALRESULT,3999)"><%if(sOperType.equals("2")==true){if(sREALRESULT!=null) out.print(sREALRESULT);}else sREALRESULT=sREALRESULT;%></textarea>
       </tr>
       
       <tr class="pagetitle1">��̨��־��</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 700px; " class="inputstyle" rows="6" name="CASELOG" cols="133" onKeyUp="textCounter(this.form.CASELOG,3999)"><%if(sOperType.equals("2")==true){if(sCASELOG!=null) out.print(sCASELOG);}else sCASELOG=sCASELOG;%></textarea>
       </tr>

    
       <tr class="pagetitle1">�������룺</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 700px; " class="inputstyle" rows="6" name="INDUMP" cols="133" onKeyUp="textCounter(this.form.INDUMP,3999)"><%if(sOperType.equals("2")==true){if(sINDUMP!=null) out.print(sINDUMP);}else sINDUMP=sINDUMP;%></textarea>
       </tr>
       
       <tr class="pagetitle1">���������</tr>
       <tr class="contentbg"> 
       <textarea style= "width: 700px; " class="inputstyle" rows="6" name="OUTDUMP" cols="133" onKeyUp="textCounter(this.form.OUTDUMP,3999)"><%if(sOperType.equals("2")==true){if(sOUTDUMP!=null) out.print(sOUTDUMP);}else sOUTDUMP=sOUTDUMP;%></textarea>
       </tr>
      
       <tr class="pagetitle1">������</tr>
       <tr class="contentbg"> 
       <input type="FILE" style= "width: 600px; " name="ACCESSORY" value="<% //if(sOperType=="2"){if(sACCESSORY!=null) out.print(sACCESSORY);}else sACCESSORY=sACCESSORY;%>"> 
       <input type="button"   runat="server" value="ɾ������" OnClick="delPic()">      
       </tr>
       
       <tr>
          <td><div align="center">
              <table width="146" border="0" cellspacing="5" cellpadding="5">           
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" OnClick="commit.click()" >�ύ
    				  	<input type="button" name="commit" id="commit" runat="server"  style="display:none;" OnClick="dialogcommit(this.form)" >                        
                        <br></td>
						</tr>
						</table>

						<td width="101" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      	<tr> 
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="cancle()" >ȡ��
                 		<br></td>
                      </tr>
 </table>
 </td>
 </table>
 </div>
 </td>
 </tr>
 </table>
 </table>
 </td>
 </tr>
 </table>
 </form>

  </body>	
 </html>