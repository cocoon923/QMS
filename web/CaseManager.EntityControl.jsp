<html>
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />
<jsp:useBean id="staff" scope="session" class="bean.StaffInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*,java.sql.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��֤��¼CASE�������</title>

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
				
		if(OperFlag.equals("0"))  //case������ҳ
		{
			response.sendRedirect("index.jsp");
		}
		if(OperFlag.equals("1"))  //��������
		{
			response.sendRedirect("casemanager.jsp");
		}
		if(OperFlag.equals("2"))  //������¼
		{
			response.sendRedirect("CaseManager.CaseRecord.jsp");
		}
		if(OperFlag.equals("3"))  //��ѯ
		{
			response.sendRedirect("CaseManager.Query.jsp");
		}
		if(OperFlag.equals("4"))  //�ص�����¼��
		{
			response.sendRedirect("importrequrimentmanager/ImportRequirementManager.jsp");
		}
		if(OperFlag.equals("5"))  //�ص������ѯ
		{
			response.sendRedirect("importrequrimentmanager/QueryImportRequirement.jsp");
		}
		if(OperFlag.equals("6"))  //�½��ƻ�
		{
			response.sendRedirect("plan/PlanManager.NewPlan.jsp");
		}
		if(OperFlag.equals("7"))   //�ƻ�����
		{
			response.sendRedirect("plan/PlanManager.ManagerPlan.jsp");
		}
		if(OperFlag.equals("8"))   //��ѯͳ��
		{
			response.sendRedirect("stat/Stat.Index.jsp");
		}
	}
	else
	{
		out.print("<script language='javascript'>alert('��û��Ȩ�޲鿴��ҳ�棬���������ҳ�������лл!');</script>");
	}
%>
<body>


</body>
</html>

