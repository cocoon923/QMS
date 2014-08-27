<html>
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="staff" scope="session" class="bean.StaffInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>验证登录CASE管理界面</title>

</head>
<%
    String op_id = staff.getOp_id();
    //String op_id="100889";
    if(op_id!=null)
    {
   		 session.setAttribute("OpId",op_id);
    }
    String OperFlag= (String)request.getParameter("OperFlag");
    if(OperFlag==null) OperFlag="";
    
	int EntityFlag= QueryBaseData.queryOpGroupCount(op_id);
	
	if(EntityFlag==1)
	{
		String sEntityFlag="1";
		session.setAttribute("EntityFlag",sEntityFlag);
		session.setMaxInactiveInterval(43200);
				
		if(OperFlag.equals("0"))  //case管理首页
		{
			response.sendRedirect("index.jsp");
		}
		if(OperFlag.equals("1"))  //用例管理
		{
			response.sendRedirect("casemanager.jsp");
		}
		if(OperFlag.equals("2"))  //用例补录
		{
			response.sendRedirect("CaseManager.CaseRecord.jsp");
		}
		if(OperFlag.equals("3"))  //查询
		{
			response.sendRedirect("CaseManager.Query.jsp");
		}
		if(OperFlag.equals("4"))  //重点需求录入
		{
			response.sendRedirect("importrequrimentmanager/ImportRequirementManager.jsp");
		}
		if(OperFlag.equals("5"))  //重点需求查询
		{
			response.sendRedirect("importrequrimentmanager/QueryImportRequirement.jsp");
		}
		if(OperFlag.equals("6"))  //新建计划
		{
			response.sendRedirect("plan/PlanManager.NewPlan.jsp");
		}
		if(OperFlag.equals("7"))   //计划管理
		{
			response.sendRedirect("plan/PlanManager.ManagerPlan.jsp");
		}
		if(OperFlag.equals("8"))   //查询统计
		{
			response.sendRedirect("stat/Stat.Index.jsp");
		}
	}
	else
	{
		out.print("<script language='javascript'>alert('您没有权限查看此页面，请更换其他页面操作，谢谢!');</script>");
	}
%>
<body>


</body>
</html>

