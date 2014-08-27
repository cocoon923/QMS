<%@include file="../allcheck.jsp"%>
<jsp:useBean id="DataImport" scope="page" class="common.DataImport" />

<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.util.*,java.io.*"%>

<%
	request.setCharacterEncoding("gb2312");
%>
<%@ include file="../connections/con_start.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<%@ page contentType="text/html; charset=gb2312"%>


<%    
      String errorMsg=request.getParameter("errorMsg");
      String importFlag=request.getParameter("importFlag");
		if (importFlag == null)
			importFlag = "0";
		//获取当前登录操作员
		String sopId = (String) session.getValue("OpId");
		//查询导入类型
		Vector ver = DataImport.queryCfgImportList(null);
%>


<title>Requisitions</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JSFiles/JSCalendar/JSCalendar.js"
	type="text/JavaScript"></script>

<script language="JavaScript" type="text/JavaScript">
	var importFlag=<%=importFlag%>;
	if(importFlag==1){
		alert("import data successed!");
	}else if(importFlag==2){
		var errorMsg=<%=errorMsg%>;
		alert(errorMsg);
	}
	function changecolor(obj) {
		obj.className = "buttonstyle2";
	}

	function restorcolor(obj) {
		obj.className = "buttonstyle";
	}

	function dialogcommit(form1) {
		var sFileName = document.getElementById('fileId').value;
		var sImportType=document.getElementById('IMPORT_TYPE').value;
		if(sImportType==null||sImportType==''){
			alert("请选择导入类型");
			return;
		}
		if (sFileName.length > 0) {
			sFileName = sFileName.substr(sFileName.length - 4, 4);
			if (sFileName.toLowerCase() != ".xls") {
				alert("上传的文件不是.xls文件，请重新上传！");
			} else {
				form1.submit();
			}

		}else{
			alert("请选择文件路径");
		}

	}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="importFile" method="post"
		action="ImportManger.OperImport.jsp" ENCTYPE="multipart/form-data">
		<table>
			<tr class="contentbg">
				<td width="45%">导入类型：<select name="IMPORT_TYPE" class="inputstyle"  style="width: 360px;"
					id="IMPORT_TYPE">
						<option value="" selected>------------ 请选择 ------------</option>
						<%
							if (ver.size() > 0) {
									for (int i = 0; i < ver.size(); i++) {
										HashMap map = (HashMap) ver.get(i);
						%>
						<option value="<%=map.get("IMPORT_TYPE")%>">
							<%=map.get("IMPORT_NAME")%></option>
						<%
							}
								}
						%>
				</select></td>
			</tr>
			
			<tr class="contentbg">
				<td width="35%">导入路径：<input type="FILE" style="width: 360px;" name="fileName"
					id="fileId"></td>
			</tr>

			<tr>
				<td><div align="center">
						<table width="146" border="0" cellspacing="5" cellpadding="5">
						<tr>
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
<%@ include file="../connections/con_end.jsp"%>
</html>

