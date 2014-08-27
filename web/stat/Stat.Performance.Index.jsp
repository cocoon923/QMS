<%@include file="../allcheck.jsp"%>
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
	//获取当前登录操作员
	String sopId=(String)session.getValue("OpId");
	if(sopId==null) sopId="";

%>

<title>StatPerformanceIndex</title>

<link href="../css/rightstyle.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">

function changecolor(obj)
{
	obj.className = "buttonstyle2"
}

function restorcolor(obj)
{
	obj.className = "buttonstyle"
}


function next()
{
   var statid="";
   var j=0;
   var url="";
   
   var obj = document.getElementsByName("radio");
   for(i=0;i<obj.length;i++)
   {
	 if(obj[i].checked)
	 {
	   j=1;
	   statid=obj[i].value;
	   break;
	 }
   }
   if(j==0)
   {
      alert("没有选中查询、统计项，不能进行下一步操作!");
   }
   else
   {
      if(statid=="1") //需求组
      {
      		url="Stat.Performance.Demand.jsp?GroupType=1";
      }
      else if(statid=="2") //开发组
      {
      		url="Stat.Performance.Dev.jsp?GroupType=2,3";
      } 
      else if(statid=="3")  //测试组
      {
      		url="Stat.Performance.QA.jsp?GroupType=4,5";
      }
      else if(statid=="4")  //BM组
      {
      		url="Stat.Performance.BM.jsp?GroupType=6";
      }
      window.location=url;
   }  
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>统计各组类别:<br>
          </td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  </tr>
 
  <tr> 
    <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr>
      <td class="contentoutside"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="contentbottomline"><table width="100%" border="0" cellspacing="0" cellpadding="1">
            <tr class="contentbg">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="1"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.Performance.Demand.jsp?GroupType=1">需求协调</a></td>
            </tr>

            <tr  class="contentbg1">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="2"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.Performance.Dev.jsp?GroupType=2,3">开发</a></td>
            </tr>
            
            <tr class="contentbg">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="3"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.Performance.QA.jsp?GroupType=4,5">测试</a></td>
            </tr>


            <tr  class="contentbg1">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="4"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.Performance.BM.jsp?GroupType=6">BM</a></td>
            </tr>
                            
            <tr  class="contentbg">
            <td class="pagetitle1">&nbsp;</td>
            <td>&nbsp;</td>
            </tr>                                
            
	  		<tr> 
	        <td class="contentbottomline"><div align="left"> 
	        <tr> 
	        <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
			</table></td>
	        <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	        <tr> 
	        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="next()">下一步</td>
	        </tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>

	             
</body>
</html>
                
