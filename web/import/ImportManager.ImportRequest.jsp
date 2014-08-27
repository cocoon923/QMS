
<jsp:useBean id="dataBean" scope="page" class="dbOperation.CaseInfo" />
<jsp:useBean id="DemandManager" scope="page"
	class="dbOperation.DemandManager" />

<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.util.*,java.io.*,java.sql.*"%>

<%
	request.setCharacterEncoding("gb2312");
%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	String sTableName = request.getParameter("sTableName");
%>

<%
	
%>


<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>文件导入</title>
<script language="JavaScript">
	window.location.reload();
	function changecolor(obj) {
		obj.className = "buttonstyle2";
	}

	function restorcolor(obj) {
		obj.className = "buttonstyle";
	}

	function dialogcommit(form1) {
		var sFileName = document.getElementById('fileId').value;
		if (sFileName.length > 0) {
			sFileName = sFileName.substr(sFileName.length - 4, 4);
			if (sFileName.toLowerCase() != ".xls") {
				alert("上传的文件不是.xls文件，请重新上传！");
			} else {
				form1.submit();
				window.close();
				window.returnValue = "Y";
			}

		} else {
			alert("请选择文件路径");
		}

	}
<%//DemandManager.CommitDemand("1",sopId,sProductId,sSubsysId,sModuleId,sVersionId,sTitle,sRemark,sFinishTime,sDemandType,sLevelId);   
			//response.sendRedirect("DemandManager.NewDemand.jsp?sFlag=1");%>
	function cancle() {
		window.close();
		//window.returnValue="Y";
	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="importFile" method="post"
		action="ImportManger.OperImport.jsp?IMPORT_TYPE=REQUEST_IMPORT&SOURCEJSP=IMPORTMANAGER.IMPORTREQUEST.JSP" ENCTYPE="multipart/form-data">
		<table style="width: 480px;" width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr class="pagetitle1">
				<td>附件：<%
					//out.print("<br>sOperType="+sOperType+"<br>sRMId="+sRMId+"<br>attachmentseq="+attachmentseq);
				%>
				</td>
			</tr>
			<tr class="contentbg">
				<td><input type="FILE" style="width: 480px;" name="fileName"
					id="fileId" /></td>
			</tr>
			<tr>
				<td><div align="center">
						<table width="146" border="0" cellspacing="5" cellpadding="5">
							<td width="100" height="30">
								<table width="80" border="0" cellspacing="1" cellpadding="1">
									<tr>
										<td class="buttonstyle" onMouseOver="changecolor(this)"
											onMouseOut="restorcolor(this)" OnClick="commit.click()">提交
											<input type="button" name="commit" id="commit" runat="server"
											style="display: none;" OnClick="dialogcommit(this.form)">
											<br>
										</td>
									</tr>
								</table>
								</td>
							<td width="101" height="30">
								<table width="80" border="0" cellspacing="1" cellpadding="1">
									<tr>
										<td class="buttonstyle" onMouseOver="changecolor(this)"
											onMouseOut="restorcolor(this)" onclick="cancle()">取消 <br></td>
									</tr>
								</table>
							</td>
						</table>
					</div></td>
			</tr>
		</table>
	</form>
</body>
</html>