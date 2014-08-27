<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>case编号</title>
<script language="JavaScript">
	
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%String sProductId;
  String sProducttype="1";
  String sProductvalue="19925";
  String sopId="101383";
  Vector Product=QueryBaseData.queryProduct(sProducttype,sProductvalue);
  String sproductName;
  HashMap Producthash = (HashMap) Product.get(0);
  sProductId=(String) Producthash.get("PRODUCT_ID");
  sproductName = "[" + (String) Producthash.get("PRODUCT_NAME") + "]"; 
 %>

<form method="post" action="CaseManager.NewCase.jsp">
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>新增case<br></td>
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
                </td>
              </tr>
            </table> </td>
        </tr>
        <tr> 
          <td class="contentbottomline"><table width="734" border="0" cellspacing="0" cellpadding="1" height="190">
              <tr> 
                <td class="pagetitle1">case编号：</td>
                <td><strong><input style= "width: 245px; " type="text" name="textfield" class="inputstyle" size="42" disabled="disabled" style="background-color:#0c0c0" <%
                	 String snewCaseId;
                	 Vector newCaseId=QueryBaseData.getnewCaseId (sProducttype,sProductvalue) ;
                	  if(newCaseId.size()>0)
                	  {
                	  	for(int i=newCaseId.size()-1;i>=0;i--)
                	  	{
							HashMap newCaseIdhash = (HashMap) newCaseId.get(i);
							snewCaseId = (String) newCaseIdhash.get("NEWCASEID");
							snewCaseId=" value="+snewCaseId;
							out.print(snewCaseId);
                	  	}
                	  }
                	 
                %>></strong></td>
                <td class="pagetitle1">case名称：<br></td>
                <td class="pagetextdetails"><input style= "width: 274px; " type="text" name="textfield7" class="inputstyle" size="47"> </td>
              </tr>
              <tr class="contentbg"> 
                <td class="pagetitle1">case描述：</td>
                <td> 
                  <textarea name="textarea" cols="32" class="inputstyle"></textarea></td><td class="pagetitle1">预期结果：</td>
                <td><textarea name="textarea" cols="36" class="inputstyle"></textarea></td>
              </tr>
              <tr height=""> 
                <td class="pagetitle1">前台版本：</td>
                <td>
                 <select  style= "width: 247px; " name="selectClient" class="inputstyle" size="1" >
                 <option value="">-------请选择-------</option>
                	<%String sClientVersion;
                	  String stablename;
                	  String scolname;
                	  String sId;
                	  String sName;
                	  Vector ClientVersion=QueryBaseData.querySysBaseType ("CASE_REC","CLI_INFO_ID");
                	  if(ClientVersion.size()>0)
                	  {
                	  	for(int i=ClientVersion.size()-1;i>=0;i--)
                	  	{
							HashMap ClientVersionhash = (HashMap) ClientVersion.get(i);
							sId = (String) ClientVersionhash.get("CODE_VALUE");
							sName = (String) ClientVersionhash.get("CNAME");
							sClientVersion="[" + sId +"] "+ sName;
							/*sClientVersion="<option value="+sId+" selected=selected>"+sClientVersion+"</option>";
							*/sClientVersion="<option value="+sId+">"+sClientVersion+"</option>";
							out.print(sClientVersion);
                	  	}
                	  }
                 %>
                </td>
                <td class="pagetitle1">后台版本：</td>
                <td>
                <select style= "width: 274px; " name="selectServer" class="inputstyle" size="1" >
                 <option value="">-------请选择-------</option>
                	<%String sserverInfo;
                	  String stablenameSvrInfo;
                	  String scolnameSvrInfo;
                	  String sIdSvrInfo;
                	  String sNameSvrInfo;
                	  Vector ServerInfo=QueryBaseData.querySysBaseType ("CASE_REC","SVR_INFO_ID");
                	  if(ClientVersion.size()>0)
                	  {
                	  	for(int i=ServerInfo.size()-1;i>=0;i--)
                	  	{
							HashMap ServerInfohash = (HashMap) ServerInfo.get(i);
							sIdSvrInfo = (String) ServerInfohash.get("CODE_VALUE");
							sNameSvrInfo = (String) ServerInfohash.get("CNAME");
							sserverInfo="[" + sIdSvrInfo +"] "+ sNameSvrInfo;
							/*sserverInfo="<option value="+sIdSvrInfo+" selected=selected>"+sserverInfo+"</option>";
							*/sserverInfo="<option value="+sIdSvrInfo+">"+sserverInfo+"</option>";
							out.print(sserverInfo);
                	  	}
                	  }
                 %>
                 </td>
              </tr>
              <tr class="contentbg"> 
                <td class="pagetitle1">测试环境：</td>
                <td> 
                  <textarea name="textarea" cols="32" class="inputstyle"></textarea></td>
                <td class="pagetitle1">数据准备：</td>
                <td> 
                  <textarea name="textarea" cols="36" class="inputstyle"></textarea></td>
              </tr>
              <tr> 
                <td class="pagetitle1">子系统：</td>
                <td>
                <select  style= "width: 247px; " name="selectSubSys" id="selectSubSys" class="inputstyle" size="1" onchange="getselectSubSysValue()" >
                 <option value="">-------请选择-------</option>
                	<%String ssubSys;
                	  String ssubSysId;
                	  String ssubSysName;
                	  Vector SubSys=QueryBaseData.querySubSystem (sProductId);
                	  if(SubSys.size()>0)
                	  {
                	  	for(int i=SubSys.size()-1;i>=0;i--)
                	  	{
							HashMap SubSyshash = (HashMap) SubSys.get(i);
							ssubSysId = (String) SubSyshash.get("SUBSYS_ID");
							ssubSysName = (String) SubSyshash.get("SUBSYS_NAME_CN");
							ssubSys="<option value="+ssubSysId+">"+ssubSysName+"</option>";
							out.print(ssubSys);
                	  	}
                	  }
                 %>
                 </select>
                </td>
                <td class="pagetitle1">模块：</td>
                <td>
                 <select  style= "width: 274px; " name="selectModule" id="selectModule" class="inputstyle" size="1"  >
                 <option value="">-------请选择-------</option>
                	<%String sModuleInfo;
                	  String sModuleId;
                	  String sModuleName;
                	  String ssubSystemId="700003";
                	  %>
                	  <script language="JavaScript">
                	  function getselectSubSysValue()
                	  {
					  	ssubSystemId = document.getElementById("selectSubSys").value;	
					  	alert(ssubSystemId + " " + sProductId);
					  	//Vector ModuleInfo=QueryBaseData.queryModule(sProductId,ssubSystemId);	
					  }
					  </script>		  
					 <%					  
                	  Vector ModuleInfo=QueryBaseData.queryModule(sProductId,ssubSystemId);
                	  if(ModuleInfo.size()>0)
                	  {
                	  	for(int i=ModuleInfo.size()-1;i>=0;i--)
                	  	{
							HashMap ModuleInfohash = (HashMap) ModuleInfo.get(i);
							sModuleId = (String) ModuleInfohash.get("MODULE_ID");
							sModuleName = (String) ModuleInfohash.get("MODULE_NAME");
							sModuleInfo="<option value="+sModuleId+">"+sModuleName+"</option>";
							out.print(sModuleInfo);
                	  	}
                	  }
                 	%>
                 </select>
				</td>
              </tr>
			  <tr class="contentbg"> 
                <td class="pagetitle1">case编写人：</td>
                <td>
                <select  style= "width: 247px; " name="selectWriteOp" id="selectWriteOp" class="inputstyle" size="1" >
                	<%String sWriteOpInfo;
                	  String sWriteOpId;
                	  String sWriteOpLoginName;
                	  String sWriteOpname;
                	  String sgroupId="";
                	  Vector WriteOpInfo=QueryBaseData.queryOpInfo (sgroupId, "");
                	  if(WriteOpInfo.size()>0)
                	  {
                	  	for(int i=WriteOpInfo.size()-1;i>=0;i--)
                	  	{
							HashMap WriteOpInfohash = (HashMap) WriteOpInfo.get(i);
							sWriteOpId = (String) WriteOpInfohash.get("OP_ID");
							sWriteOpLoginName = (String) WriteOpInfohash.get("OP_LOGIN");
							sWriteOpname = (String) WriteOpInfohash.get("OP_NAME");
							sWriteOpInfo ="["+ sWriteOpLoginName +"] "+sWriteOpname;
							if(sWriteOpId.indexOf(sopId)>=0)
         					  {
        					     sWriteOpInfo="<option value="+sWriteOpId+" selected=selected>"+sWriteOpInfo+"</option>";
	    					   }
	 					      else
	 					      {
	     					     sWriteOpInfo="<option value="+sWriteOpId+" >"+sWriteOpInfo+"</option>";
	   					      }
							/*sExecuteOpInfo="<option value="+sExecuteOpId+">"+sExecuteOpInfo+"</option>";*/
							out.print(sWriteOpInfo);							
                	  	}
                	  }
                 %>
                 </select>
                </td>
                <td class="pagetitle1">case执行人：</td>
                <td>
                <select  style= "width: 274px; " name="selectExecuteOp" id="selectWriteOp" class="inputstyle" size="1" >
                	<%String sExecuteOpInfo;
                	  String sExecuteOpId;
                	  String sExecuteOpLoginName;
                	  String sExecuteOpname;
                	  Vector ExecuteOpInfo=QueryBaseData.queryOpInfo (sgroupId, "");
                	  if(ExecuteOpInfo.size()>0)
                	  {
                	  	for(int i=ExecuteOpInfo.size()-1;i>=0;i--)
                	  	{
							HashMap ExecuteOpInfohash = (HashMap) ExecuteOpInfo.get(i);
							sExecuteOpId = (String) ExecuteOpInfohash.get("OP_ID");
							sExecuteOpLoginName = (String) ExecuteOpInfohash.get("OP_LOGIN");
							sExecuteOpname = (String) ExecuteOpInfohash.get("OP_NAME");
							sExecuteOpInfo ="["+ sExecuteOpLoginName +"] "+sExecuteOpname;
							 if(sExecuteOpId.indexOf(sopId)>=0)
         					  {
        					     sExecuteOpInfo="<option value="+sExecuteOpId+" selected=selected>"+sExecuteOpInfo+"</option>";
	    					   }
	 					      else
	 					      {
	     					     sExecuteOpInfo="<option value="+sExecuteOpId+" >"+sExecuteOpInfo+"</option>";
	   					      }
							/*sExecuteOpInfo="<option value="+sExecuteOpId+">"+sExecuteOpInfo+"</option>";*/
							out.print(sExecuteOpInfo);
                	  	}
                	  }
                 %>
                 </select>
				</td>
              </tr>
            </table> </td>
        <tr>
          <td><div align="left">
              <table width="146" border="0" cellspacing="5" cellpadding="5">
                <tr>
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1" onclick="addRow()">
                      <tr> 
                        <td class="buttonstyle" >新建步骤
                        <script language="JavaScript">
                	  	function addRow()
                	  	{
							var tb = document.getElementById("steplist");
							var rnum = tb.rows.length-1;
							var row = tb.insertRow(rnum);
							for(var i=0;i<9;i++)
							{
								var cell= row.insertCell(i);
								cell.innerText;
								cell.style.backgroundColor = tb.rows[2].cells[i].style.backgroundColor;   
                        		cell.style.posWidth = tb.rows[2].cells[i].style.posWidth;   
                        		cell.style.posHeight = tb.rows[2].cells[i].style.posHeight;   
                        		cell.style.borderLeft = '1px solid';   
                        		cell.style.borderBottom = '1px solid';   
							} 

                	  	}
                	  	</script>
                        </td>
                      </tr>
                    </table></td>
                  <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" >修改步骤</td>
                      </tr>
                    </table></td>
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" >删除步骤</td>
                      </tr>
                    </table></td>
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" >复制步骤</td>
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
    <td><table width="895" border="0" cellspacing="0" cellpadding="0"  height="111">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="5%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="15%" class="pagecontenttitle">描述</td>
                <td width="15%" class="pagecontenttitle">预期结果<br></td>
                <td width="15%" class="pagecontenttitle">数据检查<br></td>
                <td width="15%" class="pagecontenttitle">实际结果<br></td>
                <td width="6%" class="pagecontenttitle">是否通过<br></td>
                <td width="8%" class="pagecontenttitle">dump-in<br></td>
                <td width="8%" class="pagecontenttitle">dump-out</td>
                <td width="6%" class="pagecontenttitleright">附件</td>
              </tr>
              <tr> 
                <td class="coltext"><div align="center"> 
                    <input type="checkbox" name="checkbox" value="checkbox">
                  </div></td>
                <td class="coltext"><a href="#" class="coltext">1</a></td>
                <td class="coltext">操作员档案维护</td>
                <td class="coltext">成功打开界面</td>
                <td class="coltext">无数据检查，步骤为界面显示</td>
                <td class="coltext">成功打开界面</td>
                <td class="coltext">通过</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltextright"><input type="file" name="user_file" size="10" ></td>
              </tr>
              <tr> 
                <td class="coltext2"><div align="center"> 
                    <input type="checkbox" name="checkbox2" value="checkbox">
                  </div></td>
                <td class="coltext2"><a href="#" class="coltext2">2</a></td>
                <td class="coltext2">点击营业厅[31000000]兰州移动分公司，查看GUI_NOTSHOW_OPERSET_1、GUI_NOTSHOW_OPERSET_2参数中配置此营业厅下的操作员；点击查找按钮，看是否存在参数中配置的操作员</td>
                <td class="coltext2">无参数中配置的操作员，即：op_id=147、171、3、93100016的操作员在界面上都不存在</td>
                <td class="coltext2">无数据检查，步骤为界面显示</td>
                <td class="coltext2">成功打开界面<br></td>
                <td class="coltext2">通过<br></td>
                <td class="coltext2"><br></td>
                <td class="coltext2"><br></td>
                <td class="coltext2right"><input type="file" name="user_file" size="10"></td>
              </tr>
              <tr> 
                <td class="coltext"><div align="center"> 
                    <input type="checkbox" name="checkbox3" value="checkbox">
                  </div></td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltext">&nbsp;</td>
                <td class="coltextright">&nbsp;</td>
              </tr>
              <tr> 
                <td class="pagecontenttitle">&nbsp;</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="15%" class="pagecontenttitle">描述</td>
                <td width="15%" class="pagecontenttitle">预期结果<br></td>
                <td width="15%" class="pagecontenttitle">数据检查<br></td>
                <td width="15%" class="pagecontenttitle">实际结果<br></td>
                <td width="6%" class="pagecontenttitle">是否通过<br></td>
                <td width="8%" class="pagecontenttitle">dump-in<br></td>
                <td width="8%" class="pagecontenttitle">dump-out</td>
                <td width="6%" class="pagecontenttitleright">附件</td>
              </tr>
            </table></td>
        </tr>
        
      </table></td>
  </tr>
</table>
<div align="center"></div>
        <tr> 
          <td class="contentbottomline"><table width="734" border="0" cellspacing="0" cellpadding="1" height="66">
              <tr> 
                <td width="14%" class="pagetitle1">结论:</td>
                <td width="86%"><textarea name="textarea" cols="130" class="inputstyle"></textarea></td>
              </tr>
            </table> </td>
        </tr>
         <tr> 
          <td><div align="center">
              <table width="146" border="0" cellspacing="5" cellpadding="5">
                <tr>
                  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr>
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onClick="loadPage('rightframe.htm')" >提交<br></td>
                      </tr>
                    </table></td>
                  <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
                      <tr> 
                        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onClick="loadPage('rightframe4.htm')">取消<br></td>
                      </tr>
                    </table></td>
                </tr>
              </table>
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<div align="center"></div>

</form>

</body>

</html>
