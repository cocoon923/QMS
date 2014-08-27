<!--add by huyf  -->
<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.util.*,java.io.*,java.sql.*"%>
<jsp:useBean id="DemandManager" scope="page"
	class="dbOperation.DemandManager" />

<%
	request.setCharacterEncoding("gb2312");
%>
<html>
<head>
<base target="_self">
<meta name="GENERATOR" content="Microsoft">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>commitTrack</title>
</head>
<%
	String sopId = (String) session.getValue("OpId");
	if (sopId == null)
		sopId = "";
	//获取页面其他参数
	String demandID = request.getParameter("demandID");
	String replyMsg = request.getParameter("replyMsg");
	if (demandID == null)
		demandID = "";
	if (replyMsg == null)
		replyMsg = "";
	String rollBackSts = DemandManager.getRollBackRequestSts(demandID);
	boolean done = DemandManager.commitNewDemandTrack(sopId, demandID,
			replyMsg, rollBackSts);
%>
<script language="JavaScript">
	var done =<%=done%>;
	if (done) {
		alert("数据提交成功！");
	} else {
		alert("数据提交失败！");
	}
	window.close();
</script>
<body>
</body>
</html>


