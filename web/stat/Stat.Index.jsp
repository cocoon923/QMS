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
	
	//获取所有查询或统计定义信息
	Vector vStatDef=Stat.getStatDef("");
	
	int iCount=vStatDef.size();


%>

<title>StatIndex</title>

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


function goToURL(url)
{
   var count="<%=iCount%>";
   var statid="";
   var j=0;
   if(count>0)
   {
	 var obj = document.getElementsByName("statdefradio");
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
       window.location=url+"&statid="+statid;
    }  
   }
  else
  {
     alert("没有统计项，不能进行下一步操作!");
  }
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
      if(statid=="1")
      {
      		url="Stat.DevTestTime.jsp";
      }
      else if(statid=="2")
      {
      		url="Stat.DepartmentWork.jsp?GroupType=0";
      }
      else if(statid=="3")
      {
      		url="Stat.DepartmentWork.jsp?GroupType=1";
      }
      else if(statid=="4")
      {
      		url="Stat.DepartmentWorkForDev.jsp";
      }
      else if(statid="5")
      {
      		url="Stat.Performance.Index.jsp";
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
          <td>查询、统计:<br>
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
            <td width="85%" class="pagetextdetails"><a href="Stat.DevTestTime.jsp">统计需求开发、测试时间</a></td>
            </tr>

            <tr  class="contentbg1" style="display: none;">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="2"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.DepartmentWork.jsp?GroupType=0">CRM/PRM统计本部门完成工作（含：需求、bug、故障）</a></td>
            </tr>
            
            <tr class="contentbg" style="display: none;">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="3"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.DepartmentWork.jsp?GroupType=1">网厅统计本部门完成工作（含：需求、bug、故障）</a></td>
            </tr>
           
            <%
            	if(sopId.equals("1")) //只有1工号登录，可见此统计项目
            	{
            %>

            <tr  class="contentbg1">
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="4"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.DepartmentWorkForDev.jsp">统计开发部门工作量</a></td>
            </tr>
                            
            <tr  class="contentbg">
            <td class="pagetitle1">&nbsp;</td>
            <td>&nbsp;</td>
            </tr>                                
            <%
            	} 
            	else
            	{
            %>
            
            <tr  class="contentbg1">
            <td class="pagetitle1">&nbsp;</td>
            <td>&nbsp;</td>
            </tr>  
            
            <%
            	}
            %>
            
	  		<tr> 
	        <td class="contentbottomline"><div align="left"> 
	        <tr> 
	        <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
			</table></td>
	        <td width="101"><table width="80" border="0" cellspacing="1" cellpadding="1">
	        <tr> 
	        <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="next()">下一步</td>
	        </tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>自定义查询、统计：<br>
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
                 
                 <%
                 		int i;
						int j=0;
						String sStatId="";
						String sStatCN="";
						if(vStatDef.size()>0)
						{
						  	for(i=vStatDef.size()-1;i>=0;i--)
						  	{
						  		j++;
						  		HashMap StatDefhash = (HashMap) vStatDef.get(i);
						  		sStatId=(String) StatDefhash.get("STAT_ID");
								sStatCN=(String) StatDefhash.get("STAT_CN");
								if(j%2!=0)
								{
						  	
				%>
				  <tr class="contentbg">
                  <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="statdefradio" value="<%=sStatId%>"></div></td>
                  <td width="85%" class="pagetextdetails"><a href="Stat.Interface.jsp?statid=<%=sStatId%>&wherefiled=index"><%=sStatCN %></a></td>
                </tr>
                <%				
                				}
                				if(j%2==0)
                				{
                
                %>
                
                <tr  class="contentbg1">
                  <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="statdefradio" value="<%=sStatId%>"></div></td>
                  <td width="85%" class="pagetextdetails"><a href="Stat.Interface.jsp?statid=<%=sStatId%>&wherefiled=index"><%=sStatCN %></a></td>
                </tr>
                
                <%
                				}
                			}	
						}
                %>                 
                
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
	             <td class="buttonstyle" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="goToURL(/*href*/'Stat.Interface.jsp?wherefiled=index')">下一步</td>
	             </tr></table></td></tr></table></td></tr></table></td></tr></table></td></tr></table>
	             
             
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title"> 
          <td>绩效考核数据统计:<br>
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
            <td width="15%" class="pagetitle1"><div align="center"><input type="radio" name="radio" value="5"></div></td>
            <td width="85%" class="pagetextdetails"><a href="Stat.Performance.Index.jsp">各部门绩效考评数据</a></td>
            </tr>

             <tr  class="contentbg1">
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
                
