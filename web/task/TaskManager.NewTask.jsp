<!--modify by huyf  -->
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*"%>
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="TaskManager" scope="page" class="dbOperation.TaskManager" />
<jsp:useBean id="ImportRequriment" scope="page" class="dbOperation.ImportRequriment" />
<%
  request.setCharacterEncoding("gb2312");
%>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�½�����</title>
<%
//��ȡ��ǰ��¼����Ա
String sopId=(String)session.getValue("OpId");
String demandID=(String)request.getParameter("demandID"); 
if(sopId==null) 
sopId="";
//��ȡ������ɱ�־
String soperflag=(String)request.getParameter("taskOperflag");
if(soperflag==null) soperflag="";
//��ȡ������Ա�б�
Vector developers=QueryBaseData.queryOpInfo("","");
Vector testers=QueryBaseData.queryOpInfo("","");


//��������ʱ����ȡ���ɵ�������
String sTaskId=request.getParameter("TaskId");
String sDeveloper="";
String sTester="";
String sTaskDesc="";
String sDevTime="";
String sTestTime="";
String sDemandID="";
String sDemandDesc="";
String sDemandName="";
String sDemandStatus="";
String sProjectName="";
String sLevelId="";
String sSubSysName="";
String sModuleName="";
String sFinishTime="";
if(sTaskId==null)
{
	sTaskId="";
}
Vector vTaskInfo=new Vector();
String sNewTaskId="";
/* if(sTaskId.equals("")) //��������
{ */
	sNewTaskId=TaskManager.getNewTaskSeq();
 	Vector vDemandRequest = ImportRequriment.getRequirementList("","","","","",demandID);
 	if(vDemandRequest.size()>0){
 		HashMap reqMap=(HashMap) vDemandRequest.get(0);
    	sDemandID=(String)reqMap.get("DEMAND_ID");
    	sDemandDesc=(String)reqMap.get("DEMAND_DESC");
    	sDemandName=(String)reqMap.get("DEMAND_NAME");
    	sDemandStatus=(String)reqMap.get("STATE");
    	sProjectName=(String)reqMap.get("PROJECT_NAME");
    	sLevelId=(String)reqMap.get("LEVEL_ID");
    	sSubSysName=(String)reqMap.get("SUBSYS_NAME");
    	sModuleName=(String)reqMap.get("MODULE_NAME");
    	sFinishTime=(String)reqMap.get("FINISHTIME");
    	
    	sDemandDesc = sDemandDesc.replaceAll("\\n","");
    	sDemandDesc = sDemandDesc.replaceAll("\r","");
    	
/*  	} */
}
else //���²�����ѯ��ʾ������Ϣ
{
	vTaskInfo=TaskManager.querytaskinfo(sTaskId);
	if(vTaskInfo.size()>0)
	{
		HashMap TaskInfoHash =(HashMap) vTaskInfo.get(0);
		sDeveloper=(String)TaskInfoHash.get("ACCEPTER_ID");
		sTester=(String)TaskInfoHash.get("CLOSER_ID");
		sTaskDesc=(String)TaskInfoHash.get("TASK_DESC");
		sDevTime=(String)TaskInfoHash.get("DEV_TIME");
		sTestTime=(String)TaskInfoHash.get("TEST_TIME");
	}
}
%>
<script language="JavaScript">
var sDemandDescVal = '<%=sDemandDesc%>';

window.onload = function() { 
	document.getElementById("DEMAND_DESC").value = sDemandDescVal;
}


var operflag="<%=soperflag%>";
if(operflag==2){
	 alert('ͬһ������Աͬһ����ֻ�ܴ���һ������!');
}
var developer="<%=sDeveloper%>";
var tester="<%=sTester%>";

var devTime="<%=sDevTime%>";
var testTime="<%=sTestTime%>";
var taskDesc="<%=sTaskDesc%>";
if(developer!=''){
	document.getElementById("SLECT_DEVLOPER").value=developer;
}
if(tester!=''){
	document.getElementById("SLECT_TESTER").value=tester;
}
if(devTime!=''){
document.getElementById("DEV_FINISH_TIME").value=devTime;
	  
}
if(testTime!=''){
	document.getElementById("TEST_FINISH_TIME").value=testTime;
}
if(taskDesc!=''){
	document.getElementById("TaskDesc").value=taskDesc;
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


function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}	

function commit(form)
{   

   if(operflag=="1")
   {
   		alert("�����Ѿ�����ɹ��������ٱ��棡");
   		return;
   }
   if(operflag=="2"){
	   alert('ͬһ������Աͬһ����ֻ�ܴ���һ������!');
   }
   else
   {
	   developer=document.getElementById("SLECT_DEVLOPER").value;
	   devTime=document.getElementById("DEV_FINISH_TIME").value;
	   testTime=document.getElementById("TEST_FINISH_TIME").value;
	   taskDesc=document.getElementById("TaskDesc").value;
	   tester=document.getElementById("SLECT_TESTER").value;
	   
	   
	   
   	 	
   	 	if(developer=="")
   	 	{
   	 		alert("<������Ա>δѡ����ѡ��");
   	 	}
   	 	else if(tester=="")
   	 	{
   	 		alert("<������Ա>δѡ����ѡ��");
   	 	}
   	 	else if(devTime=="")
   	 	{
   	 		alert("<�ƻ��������ʱ��>δѡ����ѡ��");
   	 	}
   	  else if(testTime=="")
	 	{
	 		alert("<�ƻ��������ʱ��>δѡ����ѡ��");
	 	}
   	  else if(taskDesc=="")
	 	{
	 		alert("<��������>δ��д����ѡ��");
	 	}
   	 	else
   	 	{
   	 		form.submit();
   	 	}
   }
}

</script>
<script language="JavaScript"  src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="taskInfo" method="post" action="TaskManager.OperTask.jsp"> 
<input type="hidden" value="<%out.print("");%>" name="slips">
<input type="hidden" value="<%out.print("");%>" name="sassignment">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">       
          <td><br></br>����¼��:
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
                <tr class="contentbg">
    				<td  align="right" class="pagetitle1">�����ţ�</td>
    				<td colspan="4"><input name="DEMAND_ID" type="text" class="inputstyle" id="DEMAND_ID"  readonly="readonly"  value=<%out.print(sDemandID);%> size="20"></td>
    			</tr>
                <tr class="contentbg">
    				<td  align="right" class="pagetitle1">�������ƣ�</td>
    				<td colspan="4"><input name="DEMAND_NAME" type="text" class="inputstyle" id="DEMAND_NAME"  readonly="readonly"  value=<%out.print(sDemandName);%> size="90"></td>
    			</tr>
 
                <tr class="contentbg">
    				<td  align="right" class="pagetitle1">����������</td>
    				<td colspan="3">
                  		<textarea class="inputstyle" rows="9" name="DEMAND_DESC" id="DEMAND_DESC"  cols="90" readonly="readonly"> </textarea>
                 	</td>
    				<!-- <td colspan="3"><input name="DEMAND_DESC" type="text" class="inputstyle" id="DEMAND_DESC"  readonly="readonly"  value=<%out.print(sDemandDesc);%> size="90"></td> -->
    			</tr>
               <tr class="contentbg">
    				<td  align="right" class="pagetitle1">�����������ʱ�䣺</td>
    				<td><input name="sDemandFinishTime" type="text" class="inputstyle" id="sDemandFinishTime"  readonly="readonly"  value=<%out.print(sFinishTime);%> size="20"></td>
    			</tr>
    			<tr class="contentbg"><td>&nbsp;</td></tr>
    			
                <tr>
                  <td class="pagetitle1" align="right">������Ա��<font color=red>*</font></td>
                  <td><select  name="SLECT_DEVLOPER" id="SLECT_DEVLOPER" size="1"  class="inputstyle">
                      <option value="" selected> ------------ ��ѡ�� ------------ </option>
                     <%
                     if(developers.size()>0){
						for( int i=0;i<developers.size();i++)
						{
							HashMap devloper=(HashMap)developers.get(i);
					 %>
                      <option value="<%=devloper.get("OP_ID")%>"> <%=devloper.get("OP_NAME")%></option>
                     <%
						}
						}
					 %>
                    </select>
                  <td class="pagetitle1" align="left">������Ա��<font color=red>*</font></td>
                  <td><select  name="SLECT_TESTER" id="SLECT_TESTER" size="1"  class="inputstyle">
                      <option value="" selected> ------------ ��ѡ�� ------------ </option>
                     <%
                     if(testers.size()>0){
						for( int i=0;i<testers.size();i++)
						{
							HashMap tester=(HashMap)testers.get(i);
					 %>
                      <option value="<%=tester.get("OP_ID")%>"> <%=tester.get("OP_NAME")%></option>
                     <%
						}
						}
					 %>
                    </select>
                </tr>
                <tr>
                   	<td class="pagetitle1" align="right" >�ƻ��������ʱ�䣺<font color=red>*</font></td>
    				<td><input name="DEV_FINISH_TIME" type="text" class="inputstyle" id="DEV_FINISH_TIME"  onClick="JSCalendar(this);" >
                   	
                   	<td class="pagetitle1" align="left" >�ƻ��������ʱ�䣺<font color=red>*</font></td>
    				<td><input name="TEST_FINISH_TIME" type="text" class="inputstyle" id="TEST_FINISH_TIME"  onClick="JSCalendar(this);" >
    			</tr>
                <tr class="contentbg">
    			  <td class="pagetitle1" align="right" >��������:<font color=red>*</font></td>
                  <td colspan="3">
                  <textarea class="inputstyle" rows="9" name="TaskDesc" id="TaskDesc" cols="90" ></textarea>
                  </td>
                </tr>
                
                
     			<!--  
                <tr class="contentbg">
                  <td width="10%">&nbsp;</td>
                  <td width="34%" class="pagetitle1">Ա���б�:</td>
                  <td width="12%" class="pagetitle1">&nbsp;</td>
                  <td width="44%" class="pagetitle1">������Ա�б�</td>
                </tr>
                <tr>
                  <td class="pagetitle1">���ͣ�</td>
                  <td><div onDblClick="move(document.open.list1,document.open.list2)">
                      <select name="list1" size="8" multiple class="inputstyle" width=150 >
                        <%
                          String sgroupid;
 						  sgroupid="2";                       
 						  Vector ver = ImportRequriment.getAllMailInfo(sgroupid);
 						  for(int j=0;j<ver.size();j++)
						 {
   							 HashMap map =(HashMap) ver.get(j);
    						 String sMail=(String) map.get("OP_MAIL");
    						 String sName=(String) map.get("OP_NAME");
						%>
                        <option value=<%=sMail%>> <font size="2"><%=sMail%></font>-<%=sName%> </option>
                        <%
						}
						%>
                      </select>
                    </div></td>
                  <td align="center" valign="middle"><div align="center"> <br>
                      <table width="100%" border="0" cellspacing="1" cellpadding="1">
                        <tr>
                          <td><div align="center">
                              <table width="34" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                  <td width="30" class="buttonstyle" onClick="move(document.open.list1,document.open.list2)" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" >&gt;&gt;&gt;</td>
                                </tr>
                              </table>
                            </div></td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <table width="34" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                  <td width="30" class="buttonstyle" onClick="move(document.open.list2,document.open.list1);" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)">&lt;&lt;&lt;</td>
                                </tr>
                              </table>
                            </div></td>
                        </tr>
                      </table>
                      <br>
                      <br>
                    </div></td>
                  <td><div onDblClick="move(document.open.list2,document.open.list1);">
                      <select name="list2" size="8" multiple class="inputstyle" width=150>
                      </select>
                    </div></td>
                </tr>-->
   
                
                
                
	          <tr> 
	          	<td align="center" >
	             <table width="80" border="0" cellspacing="1" cellpadding="1">
	             <tr> 
	                <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">�ύ
      				<input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="commit(this.form)" >
      				</td>
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
             </td>
             </tr>
             </table>
             </form>
</body>
</html>


<script language="JavaScript">
function move(fbox,tbox)  {
   for(var i=0; i<fbox.options.length; i++)  {
     if(fbox.options[i].selected && fbox.options[i].value != "")  {
        // ������Ŀ�б��Ҳ�
        var no = new Option();
        no.value = fbox.options[i].value
        no.text = fbox.options[i].text
        tbox.options[tbox.options.length] = no;

        //  ���������Ŀ�б�
        fbox.options[i].value = ""
        fbox.options[i].text = ""
     }
   }
   BumpUp(fbox);
   //SortD(tbox);
}
// ����յ���Ŀ�б�
function BumpUp(box)  {
  for(var i=0; i<box.options.length; i++)  {
     if(box.options[i].value == "")  {
       for(var j=i; j<box.options.length-1; j++)  {
         box.options[j].value = box.options[j+1].value
         box.options[j].text = box.options[j+1].text
       }
       var ln = i
       break
     }
   }
   if(ln < box.options.length)  {
     box.options.length -= 1;
     BumpUp(box);
   }
}

function clear_list2(fbox)  {
   for(var i=0; i<fbox.options.length; i++)  {
        //  �����Ŀ�б�
        fbox.options[i].value = ""
        fbox.options[i].text = ""
     }
   BumpUp(fbox);
   //SortD(tbox);
}

</script>


