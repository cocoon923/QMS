<jsp:useBean id="Approval" scope="page" class="dbOperation.Approval" />
<jsp:useBean id="QueryBaseData" scope="page" class="dbOperation.QueryBaseData" />

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.io.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<% 
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0); 
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<%@ page contentType="text/html; charset=gb2312"%>

<html>
<%
//获取当前登录操作员
  String sopId=(String)session.getValue("OpId");

//查询我提交的申请单
Vector vMyApplicationList=Approval.getMyApproval("0",sopId);
//查询待我审批的申请单
Vector vMyApprovalList=Approval.getMyApproval("1",sopId);
  
%>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<title>我的审批</title>


<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="MyApprovalManager" method="post" action=""> 

<%
	if(vMyApplicationList.size()>0)
	{
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">       
          <td><br></br>我的申请单:
          <br></br>
          </td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  	</tr>
  	
 	 <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="MyApplicationList">
              <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="10%" class="pagecontenttitle">申请单编号</td>
                <td width="20%" class="pagecontenttitle">申请功能</td>
                <td width="25%" class="pagecontenttitle">状态</td>
                <td width="20%" class="pagecontenttitle">当前审批人</td>
                <td width="15%" class="pagecontenttitle">提交申请时间</td>
                <td width="15%" class="pagecontenttitle">操作</td>
              </tr>
		<% 
			String sSeq="";
			String sApplicationType="";
			String sApplicationSts="";
			String sCurrentOpId="";
			String sApplicationTime="";
			int j=0;
			
			if(vMyApplicationList.size()>0)
			{
				for(int i=vMyApplicationList.size()-1;i>=0;i--)
				{
				  	j++;
				  	HashMap MyApplicationList = (HashMap) vMyApplicationList.get(i);
				  	sSeq = (String)MyApplicationList.get("SEQ");
				  	sApplicationType = (String)MyApplicationList.get("TYPE_NAME");
				  	sApplicationSts = (String)MyApplicationList.get("STS_NAME");
				  	sCurrentOpId = (String)MyApplicationList.get("OP_NAME");
				  	sApplicationTime = (String)MyApplicationList.get("TIME");
		if(j%2!=0)
		{
		 %>
		<tr>
			<td class="coltext">(<%=j%>)</td>
			<td class="coltext"><%=sSeq%></td>
			<td class="coltext"><%=sApplicationType%></td>
			<td class="coltext"><%=sApplicationSts%></td>
			<td class="coltext"><%=sCurrentOpId%></td>
			<td class="coltext"><%=sApplicationTime%></td>
			<td class="coltext"><a href="Approval.MyApplicationDetail.jsp?RECORD_SEQ=<%=sSeq%>" target="_blank"><%out.print("详情");%></a></td>
		</tr>
		<%
			}
		 %>
		 <%	
			if(j%2==0)
			{
		 %>
		 	<tr>
			<td class="coltext2">(<%=j%>)</td>
			<td class="coltext2"><%=sSeq%></td>
			<td class="coltext2"><%=sApplicationType%></td>
			<td class="coltext2"><%=sApplicationSts%></td>
			<td class="coltext2"><%=sCurrentOpId%></td>
			<td class="coltext2"><%=sApplicationTime%></td>
			<td class="coltext2"><a href="Approval.MyApplicationDetail.jsp?RECORD_SEQ=<%=sSeq%>" target="_blank"><%out.print("详情");%></a></td>
		</tr>
		<%
			}
		 %>
       <% 
          }
          }
       %>
       		<tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="10%" class="pagecontenttitle">申请单编号</td>
                <td width="20%" class="pagecontenttitle">申请功能</td>
                <td width="25%" class="pagecontenttitle">状态</td>
                <td width="20%" class="pagecontenttitle">当前审批人</td>
                <td width="15%" class="pagecontenttitle">提交申请时间</td>
                <td width="15%" class="pagecontenttitle">操作</td>
              </tr>
	</table>
</td>
</tr>
</table>
<%
	}
%>

<%
	if(vMyApprovalList.size()>0)
	{
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">       
          <td><br></br>待审批列表:
          <br></br>
          </td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  	</tr>
  	
 	 <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="MyApplicationList">
              <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="10%" class="pagecontenttitle">申请单编号</td>
                <td width="20%" class="pagecontenttitle">申请功能</td>
                <td width="25%" class="pagecontenttitle">状态</td>
                <td width="20%" class="pagecontenttitle">当前审批人</td>
                <td width="15%" class="pagecontenttitle">提交申请时间</td>
                <td width="15%" class="pagecontenttitle">操作</td>
              </tr>
		<% 
			String sSeq1="";
			String sApplicationType1="";
			String sApplicationSts1="";
			String sCurrentOpId1="";
			String sApplicationTime1="";
			int j1=0;
			
			if(vMyApprovalList.size()>0)
			{
				for(int i1=vMyApprovalList.size()-1;i1>=0;i1--)
				{
				  	j1++;
				  	HashMap MyApprovalList = (HashMap) vMyApprovalList.get(i1);
				  	sSeq1 = (String)MyApprovalList.get("SEQ");
				  	sApplicationType1 = (String)MyApprovalList.get("TYPE_NAME");
				  	sApplicationSts1 = (String)MyApprovalList.get("STS_NAME");
				  	sCurrentOpId1 = (String)MyApprovalList.get("OP_NAME");
				  	sApplicationTime1 = (String)MyApprovalList.get("TIME");
		if(j1%2!=0)
		{
		 %>
		<tr>
			<td class="coltext">(<%=j1%>)</td>
			<td class="coltext"><%=sSeq1%></td>
			<td class="coltext"><%=sApplicationType1%></td>
			<td class="coltext"><%=sApplicationSts1%></td>
			<td class="coltext"><%=sCurrentOpId1%></td>
			<td class="coltext"><%=sApplicationTime1%></td>
			<td class="coltext"><a href=""><%out.print("审批");%></a></td>
		</tr>
		<%
			}
		 %>
		 <%	
			if(j1%2==0)
			{
		 %>
		 	<tr>
			<td class="coltext2">(<%=j1%>)</td>
			<td class="coltext2"><%=sSeq1%></td>
			<td class="coltext2"><%=sApplicationType1%></td>
			<td class="coltext2"><%=sApplicationSts1%></td>
			<td class="coltext2"><%=sCurrentOpId1%></td>
			<td class="coltext2"><%=sApplicationTime1%></td>
			<td class="coltext2"><a href=""><%out.print("审批");%></a></td>
		</tr>
		<%
			}
		 %>
       <% 
          }
          }
       %>
       		<tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="10%" class="pagecontenttitle">申请单编号</td>
                <td width="20%" class="pagecontenttitle">申请功能</td>
                <td width="25%" class="pagecontenttitle">状态</td>
                <td width="20%" class="pagecontenttitle">当前审批人</td>
                <td width="15%" class="pagecontenttitle">提交申请时间</td>
                <td width="15%" class="pagecontenttitle">操作</td>
              </tr>
	</table>
</td>
</tr>
</table>
<%
	}
 %>

</body>
</html>

