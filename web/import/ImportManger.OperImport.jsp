<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.util.*,java.io.*,java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<jsp:useBean id="fileUpload" scope="page"
	class="org.apache.commons.fileupload.servlet.ServletFileUpload" />
<jsp:useBean id="DemandImport" scope="page" class="common.DataImport" />
<%
	request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>commitRequisitionsInfo</title>
</head>
<%
	String errorMsg = null;
	String url = "";
	String sourceJsp = request.getParameter("SOURCEJSP");
	if (sourceJsp == null) {
		sourceJsp = "";
	}
	String importType = request.getParameter("IMPORT_TYPE");
	FileItemIterator iter = fileUpload.getItemIterator(request);
	while (iter.hasNext()) {
		FileItemStream item = iter.next();
		String name = item.getFieldName();
		InputStream stream = item.openStream();
		if (item.isFormField()) {

		} else {
			System.out.println("File field " + name
					+ " with file name " + item.getName()
					+ " detected.");
			String sOpId = (String) session.getValue("OpId");
			errorMsg = DemandImport.importData(stream, importType, "1");
		}
	}
	if (sourceJsp.equals("IMPORTMANAGER.IMPORTREQUEST.JSP")) {
		/* response.sendRedirect("../demand/DemandManager.DemandInfo.jsp?importFlag=1"); */
	} else {
		if (errorMsg == null) {
			url = "ImportManager.bacthImport.jsp?importFlag=1";
		} else {
			url="ImportManager.bacthImport.jsp?importFlag=2&errorMsg='"
					+ errorMsg+"'";
		}
	}
	response.sendRedirect(url);
%>
<script type="text/javascript">
	window.close();
</script>
<body>

</body>
</html>


