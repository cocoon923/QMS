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

String sRecordSeq=request.getParameter("RECORD_SEQ");
//查询我提交的申请单
//@para sSts ：0--只查已经审批的记录；1--查所有记录
Vector vMyApplicationTrackList=Approval.getMyApplicationRecordTrackInfo(sRecordSeq,"1");
  
%>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<title>申请单详情</title>


<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="MyApprovalManager" method="post" action=""> 


<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">       
          <td><br></br>申请单详情:
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
                <td width="10%" class="pagecontenttitle">审批步骤编号</td>
                <td width="20%" class="pagecontenttitle">审批步骤名称</td>
                <td width="20%" class="pagecontenttitle">审批人</td>
                <td width="10%" class="pagecontenttitle">审批结果</td>
                <td width="15%" class="pagecontenttitle">审批时间</td>
                <td width="20%" class="pagecontenttitle">审批描述</td>
              </tr>
		<% 
			String sSequence="";
			String sSequenceName="";
			String sApprovalOfficerID="";
			String sApprovalResult="";
			String sApprovalTime="";
			String sRemark="";
			int j=0;
			
			if(vMyApplicationTrackList.size()>0)
			{
				for(int i=vMyApplicationTrackList.size()-1;i>=0;i--)
				{
				  	j++;
				  	HashMap ApplicationTrackList = (HashMap) vMyApplicationTrackList.get(i);
				  	sSequence = (String)ApplicationTrackList.get("PROCESS_ID");
				  	sSequenceName = (String)ApplicationTrackList.get("PROCESS_NAME");
				  	sApprovalOfficerID = (String)ApplicationTrackList.get("OP_NAME");
				  	sApprovalResult = (String)ApplicationTrackList.get("RESULT_NAME");
				  	sApprovalTime = (String)ApplicationTrackList.get("TIME");
				  	sRemark = (String)ApplicationTrackList.get("REMARK");
		if(j%2!=0)
		{
		 %>
		<tr>
			<td class="coltext">(<%=j%>)</td>
			<td class="coltext"><%=sSequence%></td>
			<td class="coltext"><%=sSequenceName%></td>
			<td class="coltext"><%=sApprovalOfficerID%></td>
			<td class="coltext"><%=sApprovalResult%></td>
			<td class="coltext"><%=sApprovalTime%></td>
			<td class="coltext"><%=sRemark %></td>
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
			<td class="coltext2"><%=sSequence%></td>
			<td class="coltext2"><%=sSequenceName%></td>
			<td class="coltext2"><%=sApprovalOfficerID%></td>
			<td class="coltext2"><%=sApprovalResult%></td>
			<td class="coltext2"><%=sApprovalTime%></td>
			<td class="coltext2"><%=sRemark %></td>
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
                <td width="10%" class="pagecontenttitle">审批步骤编号</td>
                <td width="20%" class="pagecontenttitle">审批步骤名称</td>
                <td width="20%" class="pagecontenttitle">审批人</td>
                <td width="10%" class="pagecontenttitle">审批结果</td>
                <td width="15%" class="pagecontenttitle">审批时间</td>
                <td width="20%" class="pagecontenttitle">审批描述</td>
              </tr>
	</table>
</td>
</tr>
</table>


</body>
</html>

