<%@include file="allcheck.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<jsp:useBean id="dataBean" scope="page" class="dbOperation.requirementInfo" />
<jsp:useBean id="dataBean1" scope="page" class="dbOperation.malfunctionInfo" />

<% 
request.setCharacterEncoding("gb2312");
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>

<html>


<head>
<meta http-equiv="Content-Language" content="zh-cn">
<title>主页</title>
<script language="JavaScript">
<!--
function FP_swapImg() {//v1.0
 var doc=document,args=arguments,elm,n; doc.$imgSwaps=new Array(); for(n=2; n<args.length;
 n+=2) { elm=FP_getObjectByID(args[n]); if(elm) { doc.$imgSwaps[doc.$imgSwaps.length]=elm;
 elm.$src=elm.src; elm.src=args[n+1]; } }
}

function FP_preloadImgs() {//v1.0
 var d=document,a=arguments; if(!d.FP_imgs) d.FP_imgs=new Array();
 for(var i=0; i<a.length; i++) { d.FP_imgs[i]=new Image; d.FP_imgs[i].src=a[i]; }
}

function FP_getObjectByID(id,o) {//v1.0
 var c,el,els,f,m,n; if(!o)o=document; if(o.getElementById) el=o.getElementById(id);
 else if(o.layers) c=o.layers; else if(o.all) el=o.all[id]; if(el) return el;
 if(o.id==id || o.name==id) return o; if(o.childNodes) c=o.childNodes; if(c)
 for(n=0; n<c.length; n++) { el=FP_getObjectByID(id,c[n]); if(el) return el; }
 f=o.forms; if(f) for(n=0; n<f.length; n++) { els=f[n].elements;
 for(m=0; m<els.length; m++){ el=FP_getObjectByID(id,els[n]); if(el) return el; } }
 return null;
}

function FP_goToURL(url) {//v1.0
 window.location=url;
}

// -->

</script>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">
</head>
<%
    String sUserName=(String)session.getValue("OpName");  //获取登陆名称
    String sOpId=(String)session.getValue("OpId");
    int iFlag=0;
    int iFlag1=0;
%>
<form method="post" action="casemanager.jsp">
<body>
<% 
   Vector ver=dataBean.getRequirementInfoAll(sOpId);
   if(ver.size()>0)
   {
     iFlag=1;
%>

<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>未完成需求<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 	 <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <!--<td width="5%" class="pagecontenttitle"><div align="center"></div></td> -->
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">需求id</td>
                <td width="60%" class="pagecontenttitle">需求名称<br></td>
                <td width="10%" class="pagecontenttitle">需求状态<br></td>
                <td width="10%" class="pagecontenttitle">case状态<br></td>
                <td width="10%" class="pagecontenttitle">case执行状态<br></td>
              </tr>
		<% 
	     //  for (int i = 0; i < ver.size(); i++) {
	     int j=0;
	      String sCaseId="";
	      String sCaseName="";
	      String sCaseDesc="";
	      String sCaseModule="";
	      String sRunId="";
	       for(int i=ver.size()-1;i>=0;i--)
	     //  for (int i = 0; i < ver.size(); i++) 
	       {
               HashMap hash = (HashMap) ver.get(i);
           //    case_id,case_name,case_desc,case_module,run_id
                sCaseId = (String) hash.get("DEMAND_ID");
                sCaseName = (String) hash.get("DEMAND_TITLE");
                sCaseDesc = (String) hash.get("STA_NAME");
               // sCaseModule = (String) hash.get("CASE_MODULE");
                //sRunId = (String) hash.get("RUN_ID");
             //  out.println(case_id+"   "+case_desc);
               j=j+1;
		%>
		<%	
			if(j%2!=0)
			{
		 %>
		<tr><!-- 
			<td width="32" height="10" class="coltext">
			<input type="radio" value="R<%=sCaseId%>" name="requirement" tabindex="1"></td> -->
			<td class="coltext">(<%=j%>)</td>
			<td class="coltext"><a href="casemanager.jsp?requirement=R<%=sCaseId%>"><%=sCaseId%></a></td>
			<td class="coltext10"><a href="casemanager.jsp?requirement=R<%=sCaseId%>"><%=sCaseName%></a></td>
			<td class="coltext"><%=sCaseDesc%></td>
			<td class="coltext">null</td>
			<td class="coltext">null</td>
		</tr>
		<%
			}
		 %>
		 <%	
			if(j%2==0)
			{
		 %>
		 	<tr><!-- 
			<td width="32" height="10" class="coltext">
			<input type="radio" value="R<%=sCaseId%>" name="requirement" tabindex="1"></td> -->
			<td class="coltext2">(<%=j%>)</td>
			<td class="coltext2"><a href="casemanager.jsp?requirement=R<%=sCaseId%>"><%=sCaseId%></a></td>
			<td class="coltext20"><a href="casemanager.jsp?requirement=R<%=sCaseId%>"><%=sCaseName%></a></td>
			<td class="coltext2"><%=sCaseDesc%></td>
			<td class="coltext2">null</td>
			<td class="coltext2">null</td>
		</tr>
		<%
			}
		 %>
       <% 
          }
       %>
       		<tr> 
                <!--<td width="5%" class="pagecontenttitle"><div align="center"></div></td> -->
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">需求id</td>
                <td width="60%" class="pagecontenttitle">需求名称<br></td>
                <td width="10%" class="pagecontenttitle">需求状态<br></td>
                <td width="10%" class="pagecontenttitle">case状态<br></td>
                <td width="10%" class="pagecontenttitle">case执行状态<br></td>
              </tr>
	</table>
</td>
</tr>
</table>
<%} %>


<% 
   Vector vMultiDemand=dataBean.getMultiRequirementInfoAll(sOpId);
   if(vMultiDemand.size()>0)
   {
     iFlag=1;
%>
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>待处理集成测试需求<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 	 <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">需求id</td>
                <td width="60%" class="pagecontenttitle">需求名称<br></td>
                <td width="10%" class="pagecontenttitle">父需求状态<br></td>
                <td width="10%" class="pagecontenttitle">联调状态<br></td>
                <td width="10%" class="pagecontenttitle">联调计划时间<br></td>
              </tr>
		<% 
	      int j1=0;
	      String sDemandId="";
	      String sDemandTitle="";
	      String sDemandStatus="";
	      String sIntegration="";
	      String sIntegrationTime="";
	       for(int i1=vMultiDemand.size()-1;i1>=0;i1--)
	     //  for (int i = 0; i < ver.size(); i++) 
	       {
               HashMap HMultiDemand = (HashMap) vMultiDemand.get(i1);
                sDemandId = (String) HMultiDemand.get("DEMAND_ID");
                sDemandTitle = (String) HMultiDemand.get("DEMAND_TITLE");
                sDemandStatus = (String) HMultiDemand.get("STATUS_NAME");
                sIntegration = (String) HMultiDemand.get("INTEGRATION_NAME");
                sIntegrationTime = (String) HMultiDemand.get("TIME");

               j1=j1+1;
		%>
		<%	
			if(j1%2!=0)
			{
		 %>
		<tr>
			<td class="coltext">(<%=j1%>)</td>
			<td class="coltext"><a href="casemanager.jsp?requirement=R<%=sDemandId%>"><%=sDemandId%></a></td>
			<td class="coltext10"><a href="casemanager.jsp?requirement=R<%=sDemandTitle%>"><%=sDemandTitle%></a></td>
			<td class="coltext"><%=sDemandStatus%></td>
			<td class="coltext"><%=sIntegration %></td>
			<td class="coltext"><%if(sIntegrationTime==null) out.print("&nbsp;");else out.print(sIntegrationTime); %></td>
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
			<td class="coltext2"><a href="casemanager.jsp?requirement=R<%=sDemandId%>"><%=sDemandId%></a></td>
			<td class="coltext20"><a href="casemanager.jsp?requirement=R<%=sDemandTitle%>"><%=sDemandTitle%></a></td>
			<td class="coltext2"><%=sDemandStatus%></td>
			<td class="coltext2"><%=sIntegration %></td>
			<td class="coltext2"><%if(sIntegrationTime==null) out.print("&nbsp;");else out.print(sIntegrationTime); %></td>
		</tr>
		<%
			}
		 %>
       <% 
          }
       %>
              <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">需求id</td>
                <td width="60%" class="pagecontenttitle">需求名称<br></td>
                <td width="10%" class="pagecontenttitle">父需求状态<br></td>
                <td width="10%" class="pagecontenttitle">联调状态<br></td>
                <td width="10%" class="pagecontenttitle">联调计划时间<br></td>
              </tr>
	</table>
</td>
</tr>
</table>
<%} %>

<%  
   Vector vMalfunctionInfo=dataBean1.getMalfunctionInfoAll(sOpId);
   if(vMalfunctionInfo.size()>0)
   {
    iFlag1=1;
%>

<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>未关闭故障<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 	 <tr> 
         <td><table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <!--<td width="5%" class="pagecontenttitle"><div align="center"></div></td> -->
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">故障id</td>
                <td width="60%" class="pagecontenttitle">故障名称<br></td>
                <td width="10%" class="pagecontenttitle">故障状态<br></td>
                <td width="10%" class="pagecontenttitle">case状态<br></td>
                <td width="10%" class="pagecontenttitle">case执行状态<br></td>
              </tr>
		<%
		    int z=0;
		    String sMId="";
		    String sMName="";
		    String sMState="";
		    //String sCaseModule;
		    //String sRunId;
		    for (int i = 0; i < vMalfunctionInfo.size(); i++) 
	        {
               HashMap hash = (HashMap) vMalfunctionInfo.get(i);
               //a.request_id,a.rep_title,b.name
                sMId = (String) hash.get("REQUEST_ID");
                sMName = (String) hash.get("REP_TITLE");
                sMState = (String) hash.get("NAME");
                //sCaseModule = (String) hash.get("CASE_MODULE");
                //sRunId = (String) hash.get("RUN_ID");
             //  out.println(case_id+"   "+case_desc);
               z=z+1;
		 %>
		 <%
			if(z%2!=0)
			{		 
		  %>
		<tr><!--  
			<td width="32" height="10" class="coltext">
			<input type="radio" value="F<%=sMId%>" name="requirement" tabindex="1"></td>-->
			<td class="coltext">(<%=z%>)</td>
			<td class="coltext"><a href="casemanager.jsp?requirement=F<%=sMId%>"><%=sMId%></a></td>
			<td class="coltext10"><a href="casemanager.jsp?requirement=F<%=sMId%>"><%=sMName%></a></td>
			<!-- 
			<td width="361" class="coltext">
			<table border="0" cellpadding="0" cellspacing="0" width="361" style="border-collapse:
 collapse;width:150pt">
				<colgroup>
					<col width="361" style="width: 150pt">
				</colgroup>
				<tr height="19" style="height:14.25pt">
					<td height="19" width="200" style="height: 14.25pt; width: 150pt; color: blue; text-decoration: underline; text-underline-style: single; text-align: left; font-size: 12.0pt; font-weight: 400; font-style: normal; font-family: 宋体; vertical-align: middle; white-space: nowrap; border: medium none; padding: 0px">
					<a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=<%=sMId%>">
					<font size="2"><%//=sMName%></font></a></td>
				</tr>
			</table>
			</td> -->
			<td class="coltext"><%=sMState%></td>
			<td class="coltext">null</td>
			<td class="coltext">null</td>
		</tr>
		<%
			}
		 %>
		 <%
		 	if(z%2==0)
		 	{
		  %>
		  	<tr><!--  
			<td width="32" height="10" class="coltext">
			<input type="radio" value="F<%=sMId%>" name="requirement" tabindex="1"></td>-->
			<td class="coltext2">(<%=z%>)</td>
			<td class="coltext2"><a href="casemanager.jsp?requirement=F<%=sMId%>"><%=sMId%></a></td>
			<td class="coltext20"><a href="casemanager.jsp?requirement=F<%=sMId%>"><%=sMName%></a></td>
			<!-- 
			<td width="361" class="coltext">
			<table border="0" cellpadding="0" cellspacing="0" width="361" style="border-collapse:
 collapse;width:150pt">
				<colgroup>
					<col width="361" style="width: 150pt">
				</colgroup>
				<tr height="19" style="height:14.25pt">
					<td height="19" width="200" style="height: 14.25pt; width: 150pt; color: blue; text-decoration: underline; text-underline-style: single; text-align: left; font-size: 12.0pt; font-weight: 400; font-style: normal; font-family: 宋体; vertical-align: middle; white-space: nowrap; border: medium none; padding: 0px">
					<a href="http://10.10.10.158/project/query/proj_query_result.jsp?op_id=<%=sMId%>">
					<font size="2"><%//=sMName%></font></a></td>
				</tr>
			</table>
			</td> -->
			<td class="coltext2"><%=sMState%></td>
			<td class="coltext2">null</td>
			<td class="coltext2">null</td>
		</tr>
		<%
			}
		 %>
		<% 
		  }
		%>
 		<tr> 
          <!--<td width="5%" class="pagecontenttitle"><div align="center"></div></td> -->
          	<td width="5%" class="pagecontenttitle">序号</td>
            <td width="5%" class="pagecontenttitle">故障id</td>
            <td width="60%" class="pagecontenttitle">故障名称<br></td>
            <td width="10%" class="pagecontenttitle">故障状态<br></td>
            <td width="10%" class="pagecontenttitle">case状态<br></td>
            <td width="10%" class="pagecontenttitle">case执行状态<br></td>
          </tr>
	</table>
	</td>
	</tr>
<%} %>
    
<!--input type="button" value="编写case" name="B3" tabindex="6" style="font-family: 微软雅黑" onclick="FP_goToURL(/*href*/'用例管理.htm')"-->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <!--  input type="submit" class="buttonstyle" value="编辑case" name="B4" tabindex="7" size="74" style="font-family: 微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;-->
	<!--input type="button" value="编辑case" name="B4" tabindex="7" style="font-family: 微软雅黑" onclick="FP_goToURL(/*href*/'用例管理.htm')">&nbsp;&nbsp;&nbsp;&nbsp;-->
	<!-- input type="button" class="buttonstyle" value="生成测试文档" name="B5" tabindex="8" style="font-family: 微软雅黑"> -->


<% 

	//界面上如入任何数据，提示操作员点case管理或查询进行操作
	if((iFlag==0)&&(iFlag1==0))
	{
	out.print("<br><br>&nbsp;&nbsp;您暂时没有待处理的需求和故障，如需操作请点以下操作：");
%>
	<td class="coltext1" ><a href=# onclick="FP_goToURL(/*href*/'CaseManager.CaseRecord.jsp')">用例补录</a>;
	<td class="coltext1" ><a href=# onclick="FP_goToURL(/*href*/'CaseManager.Query.jsp')">查&nbsp;询</a>;
<%
   }
%>

</body>
</form>
</html>

