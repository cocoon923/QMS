<jsp:useBean id="Stat" scope="page" class="dbOperation.Stat" />

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


<%

//��ȡ��ѯ����
String sStartTime="";
String sEndTime="";
String sGroupId="";
String type="";

type=request.getParameter("type");
if(type==null) type="";

sStartTime=request.getParameter("sStartTime");
if(sStartTime==null) sStartTime="";

sEndTime=request.getParameter("sEndTime");
if(sEndTime==null) sEndTime="";

sGroupId=request.getParameter("groupid");
if(sGroupId==null) sGroupId="";


Vector vStatDemandDetail=new Vector();
Vector vStatDemandOpSum=new Vector();
Vector vStatSlipDetail=new Vector();
Vector vStatSlipOpSum=new Vector();
Vector vStatProjectRequestDetail=new Vector();
Vector vStatProjectRequestOpSum=new Vector();


int iOpSumDemand=0;
int iOpSumSlip=0;
int iOpSumProjectRequest=0;

if(type.equals("1")) //ͳ�Ʋ���
{
	//��ȡ����Աͳ��������
	vStatDemandOpSum = Stat.StatDemandOpSum(sStartTime,sEndTime,sGroupId);
	if(vStatDemandOpSum.size()>0)
  	{
  	  for(int l=0;l<vStatDemandOpSum.size();l++)
  	  {
  	  	HashMap StatDemandOpSumHash = (HashMap) vStatDemandOpSum.get(l);
  	  	String scount = (String)StatDemandOpSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iOpSumDemand = iOpSumDemand+sumscount;
  	  }
  	}
	//��ȡ������ϸ����
	vStatDemandDetail=Stat.StatDemandDetail(sStartTime,sEndTime,sGroupId);
}
if(type.equals("2"))
{	
  	//��ȡ����Աͳ��bug��
  	vStatSlipOpSum = Stat.StatSlipsOpSum(sStartTime,sEndTime,sGroupId);
	if(vStatSlipOpSum.size()>0)
  	{
  	  for(int l=0;l<vStatSlipOpSum.size();l++)
  	  {
  	  	HashMap StatSlipOpSumHash = (HashMap) vStatSlipOpSum.get(l);
  	  	String scount = (String)StatSlipOpSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iOpSumSlip = iOpSumSlip+sumscount;
  	  }
  	}
  	//��ȡbug��ϸ����
	vStatSlipDetail=Stat.StatSlipsDetail(sStartTime,sEndTime,sGroupId);
}
if(type.equals("3"))
{
  	//��ȡ����Աͳ�ƹ�����
  	vStatProjectRequestOpSum = Stat.StatProjectRequestOpSum(sStartTime,sEndTime,sGroupId);
	if(vStatProjectRequestOpSum.size()>0)
  	{
  	  for(int l=0;l<vStatProjectRequestOpSum.size();l++)
  	  {
  	  	HashMap StatProjectRequestOpSumHash = (HashMap) vStatProjectRequestOpSum.get(l);
  	  	String scount = (String)StatProjectRequestOpSumHash.get("COUNT");
  	  	int sumscount=Integer.parseInt(scount);
  	  	iOpSumProjectRequest = iOpSumProjectRequest+sumscount;
  	  }
  	}
  	//��ȡ������ϸ����
	vStatProjectRequestDetail=Stat.StatProjectRequestDetail(sStartTime,sEndTime,sGroupId);
}

%>



<title>StatDepartmentWork</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="../JSFiles/JSCalendar/JSCalendar.js" type="text/JavaScript"></script>
<script language="JavaScript" type="text/JavaScript">

function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}




</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="StatDepWorkDetail" method="post">
<%
	if(type.equals("1"))
	{
%>
 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>��������Աͳ�����������:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">��Ա</td>
      <td width="35%" class="pagecontenttitle">����<br></td>
      <td width="35%" class="pagecontenttitle">�ٷֱ�<br></td>
  </tr>
  <%
  		String sopname="";
  		String scount="";
  		String per="";
  		double dcount=0;
  		if(vStatDemandOpSum.size()>0)
  	    {
  	   	  for(int i=0;i<vStatDemandOpSum.size();i++)
  	   	  {
  	   	  	HashMap StatDemandOpSumHash = (HashMap) vStatDemandOpSum.get(i);
  	   	  	sopname = (String)StatDemandOpSumHash.get("OP_NAME");
  	   	  	scount = (String)StatDemandOpSumHash.get("COUNT");
  	   	  	
  	   	  	dcount = Double.parseDouble(scount); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// С���������λ   
			per = nf.format(dcount/iOpSumDemand);// Ҫת������ 
  %>
   <tr> 
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname%></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount %></td>
	<td class="<%if(i%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per %></td>
   </tr>  
  <%
  		  }
  		}  
  %>
  
   <tr> 
	<td class="coltext">�ϼƣ�</td>
	<td class="coltext" ><%=iOpSumDemand %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">��</td>
      <td width="35%" class="pagecontenttitle">����<br></td>
      <td width="35%" class="pagecontenttitle">�ٷֱ�<br></td>
  </tr>
</table></td></tr></table></td></tr></table>
 
 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>���������ϸ:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">���</td>
      <td width="10%" class="pagecontenttitle">������<br></td>
      <td width="40%" class="pagecontenttitle">��������<br></td>
      <td width="15%" class="pagecontenttitle">����汾<br></td>
      <td width="10%" class="pagecontenttitle">����ʡ��<br></td>
      <td width="10%" class="pagecontenttitle">���ʱ��<br></td>
      <td width="10%" class="pagecontenttitle">������Ա<br></td>
  </tr>
  <%
  		int i1=0;
  		String sdemandid="";
  		String sdemandtitle="";
  		String sqatime="";
  		String stester="";
  		String version="";
  		String area="";
  		if(vStatDemandDetail.size()>0)
  	    {
  	   	  for(int i2=0;i2<vStatDemandDetail.size();i2++)
  	   	  {
  	   	  	i1++;
  	   	  	HashMap StatDemandDetailHash = (HashMap) vStatDemandDetail.get(i2);
  	   	  	sdemandid = (String) StatDemandDetailHash.get("DEMAND_ID");
  	   	  	sdemandtitle = (String) StatDemandDetailHash.get("DEMAND_TITLE");
  	   	  	sqatime = (String) StatDemandDetailHash.get("QA_TIME");
  	   	  	stester = (String) StatDemandDetailHash.get("OP_NAME"); 
  	   	  	version = (String) StatDemandDetailHash.get("VERSION"); 
  	   	  	area = (String) StatDemandDetailHash.get("NAME");  		
  %>
   <tr> 
    <td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=i1%>)</td>
    <td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=<%=sdemandid %>" target="_blank"><%=sdemandid%></a></td>
	<td class="<%if(i1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=sdemandtitle%></td>
	<td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%if(version==null) out.print("&nbsp;");else out.print(version);%></td>
	<td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%if(area==null) out.print("&nbsp;");else out.print(area);%></td>
	<td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sqatime %></td>
	<td class="<%if(i1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=stester %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>

  <tr><td width="5%" class="pagecontenttitle">���</td>
      <td width="10%" class="pagecontenttitle">������<br></td>
      <td width="40%" class="pagecontenttitle">��������<br></td>
      <td width="15%" class="pagecontenttitle">����汾<br></td>
      <td width="10%" class="pagecontenttitle">����ʡ��<br></td>
      <td width="10%" class="pagecontenttitle">���ʱ��<br></td>
      <td width="10%" class="pagecontenttitle">������Ա<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

<%
	}
%>
<%
	if(type.equals("2"))
	{
%>

 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>��������Աͳ���ύbug��:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">��Ա</td>
      <td width="35%" class="pagecontenttitle">����<br></td>
      <td width="35%" class="pagecontenttitle">�ٷֱ�<br></td>
  </tr>
  
    <%
  		String sopname1="";
  		String scount1="";
  		String per1="";
  		double dcount1=0;
  		if(vStatSlipOpSum.size()>0)
  	    {
  	   	  for(int j=0;j<vStatSlipOpSum.size();j++)
  	   	  {
  	   	  	HashMap StatSlipOpSumHash = (HashMap) vStatSlipOpSum.get(j);
  	   	  	sopname1 = (String)StatSlipOpSumHash.get("OP_NAME");
  	   	  	scount1 = (String)StatSlipOpSumHash.get("COUNT");
  	   	  	
  	   	  	dcount1 = Double.parseDouble(scount1); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// С���������λ   
			per1 = nf.format(dcount1/iOpSumSlip);// Ҫת������ 
  %>
   <tr> 
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname1%></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount1 %></td>
	<td class="<%if(j%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per1 %></td>
   </tr>  
  <%
  		  }
  		}  
  %>
  
   <tr> 
	<td class="coltext">�ϼƣ�</td>
	<td class="coltext" ><%=iOpSumSlip %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">��</td>
      <td width="35%" class="pagecontenttitle">����<br></td>
      <td width="35%" class="pagecontenttitle">�ٷֱ�<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>�ύbug��ϸ��<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">���</td>
      <td width="5%" class="pagecontenttitle">bug���<br></td>
      <td width="70%" class="pagecontenttitle">bug����<br></td>
      <td width="10%" class="pagecontenttitle">bugʱ��<br></td>
      <td width="10%" class="pagecontenttitle">������Ա<br></td>
  </tr>
  
    <%
  		int j1=0;
  		String sslipid="";
  		String stitle="";
  		String sopentime="";
  		String sopenname="";
  		if(vStatSlipDetail.size()>0)
  	    {
  	   	  //for(int j2=0;j2<vStatSlipDetail.size();j2++)
  	   	  for(int j2=vStatSlipDetail.size()-1;j2>=0;j2--) //��ϸ������ͳ����������˳���ˣ�����˳��
  	   	  {
  	   	  	j1++;
  	   	  	HashMap StatSlipDetailHash = (HashMap) vStatSlipDetail.get(j2);
  	   	  	sslipid = (String) StatSlipDetailHash.get("SLIP_ID");
  	   	  	stitle = (String) StatSlipDetailHash.get("TITLE");
  	   	  	sopentime = (String) StatSlipDetailHash.get("OPENTIME");
  	   	  	sopenname = (String) StatSlipDetailHash.get("OP_NAME");  		
  %>
   <tr> 
    <td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=j1%>)</td>
    <td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/bug/query/bug_query_result.jsp?op_id=<%=sslipid %>" target="_blank"><%=sslipid%></a></td>
	<td class="<%if(j1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=stitle%></td>
	<td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopentime %></td>
	<td class="<%if(j1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=sopenname %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>  
  

  <tr><td width="5%" class="pagecontenttitle">���</td>
      <td width="5%" class="pagecontenttitle">bug���<br></td>
      <td width="70%" class="pagecontenttitle">bug����<br></td>
      <td width="10%" class="pagecontenttitle">bugʱ��<br></td>
      <td width="10%" class="pagecontenttitle">������Ա<br></td>
  </tr>
  </table></td></tr></table></td></tr></table>

<%
	}
%>
<%
	if(type.equals("3"))
	{
%>

 
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>��������Աͳ�ƴ��������:<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="30%" class="pagecontenttitle">��Ա</td>
      <td width="35%" class="pagecontenttitle">����<br></td>
      <td width="35%" class="pagecontenttitle">�ٷֱ�<br></td>
  </tr>
  
    <%
  		String sopname2="";
  		String scount2="";
  		String per2="";
  		double dcount2=0;
  		if(vStatProjectRequestOpSum.size()>0)
  	    {
  	   	  for(int k=0;k<vStatProjectRequestOpSum.size();k++)
  	   	  {
  	   	  	HashMap StatProjectRequestOpSumHash = (HashMap) vStatProjectRequestOpSum.get(k);
  	   	  	sopname2 = (String)StatProjectRequestOpSumHash.get("OP_NAME");
  	   	  	scount2 = (String)StatProjectRequestOpSumHash.get("COUNT");
  	   	  	
  	   	  	dcount2 = Double.parseDouble(scount2); 	  	  	   	  	
  	   	  	java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();   
			nf.setMinimumFractionDigits(2);// С���������λ   
			per2 = nf.format(dcount2/iOpSumProjectRequest);// Ҫת������ 
  %>
   <tr> 
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=sopname2%></td>
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=scount2 %></td>
	<td class="<%if(k%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=per2 %></td>
   </tr>  
  <%
  		  }
  		}  
  %>
  
   <tr> 
	<td class="coltext">�ϼƣ�</td>
	<td class="coltext" ><%=iOpSumProjectRequest %></td>
	<td class="coltext" >100%</td>
   </tr>
  
  <tr><td width="30%" class="pagecontenttitle">��</td>
      <td width="35%" class="pagecontenttitle">����<br></td>
      <td width="35%" class="pagecontenttitle">�ٷֱ�<br></td>
  </tr>
</table></td></tr></table></td></tr></table>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="title" style= "height: 30px; "> 
  <td>���ϴ�����ϸ��<br></td>
  <td width="24"> <div align="right"><br></div></td>
  </tr>
  </table></td>
  </tr>
  
  <tr> 
  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
  <tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
  <tr><td width="5%" class="pagecontenttitle">���</td>
      <td width="5%" class="pagecontenttitle">���ϱ��<br></td>
      <td width="60%" class="pagecontenttitle">��������<br></td>
      <td width="10%" class="pagecontenttitle">����ʱ��<br></td>
      <td width="10%" class="pagecontenttitle">������Ա<br></td>
      <td width="10%" class="pagecontenttitle">��������<br></td>
  </tr>
  
      <%
  		int k1=0;
  		String srequestid="";
  		String sreptitle="";
  		String smemotime="";
  		String sfromname="";
  		String smemotype="";
  		if(vStatProjectRequestDetail.size()>0)
  	    {
  	   	  //for(int k2=0;k2<vStatProjectRequestDetail.size();k2++)
  	   	  for(int k2=vStatProjectRequestDetail.size()-1;k2>=0;k2--) //��ϸ������ͳ�������ˣ���������
  	   	  {
  	   	  	k1++;
  	   	  	HashMap StatProjectRequestDetailHash = (HashMap) vStatProjectRequestDetail.get(k2);
  	   	  	srequestid = (String) StatProjectRequestDetailHash.get("REQUEST_ID");
  	   	  	sreptitle = (String) StatProjectRequestDetailHash.get("REP_TITLE");
  	   	  	smemotime = (String) StatProjectRequestDetailHash.get("MEMO_TIME");
  	   	  	sfromname = (String) StatProjectRequestDetailHash.get("OP_NAME");  
  	   	  	smemotype = (String) StatProjectRequestDetailHash.get("TYPE_NAME");  			
  %>
   <tr> 
    <td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext2"); %>" >(<%=k1%>)</td>
    <td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=<%=srequestid %>" target="_blank"><%=srequestid%></a></td>
	<td class="<%if(k1%2!=0) out.print("coltext10");else out.print("coltext20"); %>" ><%=sreptitle%></td>
	<td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext2"); %>" ><%=smemotime %></td>
	<td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=sfromname %></td>
	<td class="<%if(k1%2!=0) out.print("coltext");else out.print("coltext"); %>" ><%=smemotype %></td>
   </tr>  
  
  <%
  		  }
  		 }
  %>

  <tr><td width="5%" class="pagecontenttitle">���</td>
      <td width="5%" class="pagecontenttitle">���ϱ��<br></td>
      <td width="60%" class="pagecontenttitle">��������<br></td>
      <td width="10%" class="pagecontenttitle">����ʱ��<br></td>
      <td width="10%" class="pagecontenttitle">������Ա<br></td>
      <td width="10%" class="pagecontenttitle">��������<br></td>
  </tr>

<%
	}
%>
</table></td></tr></table></td></tr></table>

  <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1" align="center">
  <tr> 
  <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="window.close()">�� ��</td>
  </tr>
  </table></td>

</form>         
</body>
</html>
                
