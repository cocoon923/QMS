<jsp:useBean id="CaseInfo" scope="page" class="dbOperation.CaseInfo" />
<%@ page contentType="text/html; charset=gb2312" language="java"import="java.util.*,java.io.*,java.sql.*" %>

<%
  request.setCharacterEncoding("gb2312");
%>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
%>

<%
   
String sRMId=request.getParameter("requirement"); 
if(sRMId==null) sRMId="";

String sOpId=request.getParameter("sOpId"); 
if(sOpId==null) sOpId="";


String sRelateFlag=request.getParameter("relateflag"); 
if(sRMId==null) sRMId="";

String sdemandid=request.getParameter("demandid");
if(sdemandid==null) sdemandid="";

String operflag=request.getParameter("operflag"); 
if(operflag==null) operflag="";  

Vector vRemandRelationList=new Vector();
String RemandRelationStr="";
int iList=0;
if(sRelateFlag.equals("1"))
{
	vRemandRelationList=CaseInfo.queryDemandRealtionMore(sRMId,"","0");
	iList=vRemandRelationList.size();
}

Vector vRemandInfoList=new Vector();
int iDemandList=0;
if(!sdemandid.equals(""))
{
	vRemandInfoList=CaseInfo.queryDemandInfo("1",sdemandid);
	iDemandList=vRemandInfoList.size();
}   
   
%>

<html>
<link href="css/rightstyle.css" rel="stylesheet" type="text/css">

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>关联需求</title>
<script language="JavaScript">

function changecolor(obj)
{
	obj.className = "buttonstyle2";
}

function restorcolor(obj)
{
	obj.className = "buttonstyle";
}

function querydemandinfo(url)
{
	var demandid="";
	var operflag="";
	var requirement="<%=sRMId%>"
	var relateflag="<%=sRelateFlag%>"
	var operflag="";
	
	demandid=document.getElementById("relatedemand").value;
	
	for(var i=0;i<document.RelateDemandForm.operflag.length;i++)
	{
	    if(document.RelateDemandForm.operflag[i].checked)
	    {
	      operflag=document.RelateDemandForm.operflag[i].value;
	    }
	}
	
	window.location=url+"?requirement="+requirement+"&relateflag="+relateflag+"&demandid="+demandid+"&sOpId=<%=sOpId%>&operflag="+operflag;  
	
}

function commit(form)
{   
  var RemandRelationStr="<%=RemandRelationStr%>";
  var sRMId="<%=sRMId%>";

  form.submit();

}

function allcheck(formname) 
{
  var objs = formname.getElementsByTagName("input");
  for(var i=0; i<objs.length; i++) 
  {
    if(objs[i].type.toLowerCase() == "checkbox" )
      {
      	objs[i].checked = true;
      }
  }
}

function allcanclecheck(formname) 
{
  var objs = formname.getElementsByTagName("input");
  for(var i=0; i<objs.length; i++) 
  {
    if(objs[i].type.toLowerCase() == "checkbox" )
      {
      	objs[i].checked = false;
      }
  }
}

function textCounter(field,iCount)
{
   var text=field.value;
   var iCount1=iCount+1;
   if (text==null)
   {
   	 text="";
   }
   if(text.replace(/[^\x00-\xff]/g,"xx").length>iCount)
   {
     alert("输入超出"+iCount1+"字符！");
     var str = "";  
     var l = 0;  
     var schar;  
     for(var i=0; schar=text.charAt(i); i++)  
     {  
        str += schar;  
        l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);  
        if(l >= iCount)  
        {  
            break;  
        }  
     }  
    field.value=str; 
   }
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="RelateDemandForm" method="post" action="CaseManager.OperCaseRelation.jsp">
<input type="hidden" value="<%if(sRMId!=null) out.print(sRMId);%>" name="requirement" id="requirement">
<input type="hidden" value="<%if(sOpId!=null) out.print(sOpId);%>" name="sOpId" id="sOpId">&nbsp;

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr class="title"> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class="title">
          <td>需求关联（注意：请先查询出需求后，再选择操作类型）:<br></td>
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
             <tr>
                <td width="15%" class="pagetitle1">选择操作类型：</td>
                <td class="pagetitle1" align="left">
                <input type="radio" name="operflag" id="operflag" value="1" <%if(operflag.equals("")) out.print("checked"); else if(operflag.equals("1")) out.print("checked");%>>增加关联&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="operflag" id="operflag" value="2" <%if(operflag.equals("2")) out.print("checked");%>>删除关联</td>
              </tr>
                 
			<tr  class="contentbg">
                  <td class="pagetitle1" width="15%">输入需求编号：</td>
                  <td class="pagetextdetails">
                  <input name="relatedemand" id="relatedemand"  type="text" class="inputstyle" id="relatedemand"   size="30">
                  <font class="pagetextdetails">（可输入多个编号，用英文逗号分割，结尾不用逗号，例如：1,2,3）</font>
                  </td></tr>
                
                <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              </table></td>
			 </tr>
	  		<tr> 
	          <td class="contentbottomline"><div align="left"> 
	          <table width="146" border="0" cellspacing="5" cellpadding="5">
	          <tr> 
	          <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
	          <tr> 
	          <td class="buttonstyle" name="querybutton" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="querydemandinfo(/*href*/'CaseManager.RelateDemand.jsp')">查询 
              </td>
	          </tr>
	          </table></td>
	          <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
		      <tr> 
		      <td class="buttonstyle" name="commitbutton" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="hiddenButton.click()">提交数据<br></td>
		      <input type="button" name="hiddenButton" id="hiddenButton" runat="server"  style="display:none;" OnClick="commit(this.form)" >
		      </tr>
		      </table></td>
		      <td width="100" height="30"><table width="80" border="0" cellspacing="1" cellpadding="1">
		      <tr> 
		      <td class="buttonstyle" name="closebutton" onMouseOver = "changecolor(this)" onMouseOut = "restorcolor(this)" onclick="window.close()">关闭<br></td>
		      </tr>
		      </table></td>
	          
	    </tr>
	      </table></td>
	  	</tr>
		</table>
	<%
		if(iDemandList>0)
		{
	%>	
		<div align="center"></div>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title"> 
          <td>待处理需求列表:<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
   <tr class="contentbg">
   <td class="pagetitle1" style= "height: 40px; ">备注:
   <textarea style= "width: 660px; " class="inputstyle" rows="1" name="remark" id="remark" cols="133" onKeyUp="textCounter(this.form.remark,509)"></textarea>
   </td>
   </tr>
   
   <tr>
	<td class="pagetitle1" style= "height: 30px; ">
	<font color=blue  face="宋体" style="text-decoration:underline;" onclick="allcheck(RelateDemandForm)" >全部选中</font>
	<font color=blue  face="宋体" style="text-decoration:underline;" onclick="allcanclecheck(RelateDemandForm)" >全部取消</font>
	</td>
   </tr>   	      

  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="5%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="85%" class="pagecontenttitle">名称</td>
              </tr>
            <%
            	String DemandId="";
            	String DemandName="";
            	int j=0;
            	for(int irow=iDemandList-1;irow>=0;irow--)
            	{
            		j++;
            		HashMap RemandInfoListHash = (HashMap) vRemandInfoList.get(irow);
            		DemandId=(String) RemandInfoListHash.get("ID");
            		DemandName=(String) RemandInfoListHash.get("NAME");
            %>
            	<tr>
			      	<td class="<%if(j%2==0) out.print("coltext");else out.print("coltext2"); %>"><input name="checkbox" type="checkbox" id="checkbox" value="<%=DemandId %>"></td>
			      	<td class="<%if(j%2==0) out.print("coltext");else out.print("coltext2"); %>">(<%=j%>)</td>
			        <td class="<%if(j%2==0) out.print("coltext");else out.print("coltext2"); %>"><a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=<%=DemandId%>" target="_blank"><%if(DemandId!=null)out.print(DemandId); else out.print("&nbsp;");%></a></td>
			        <td class="<%if(j%2==0) out.print("coltext10");else out.print("coltext20"); %>"><%if(DemandName!=null)out.print(DemandName); else out.print("&nbsp;");%></td>
			    </tr>
            	
            <%
            	}
            %>  
			 
            <tr> 
                <td width="5%" class="pagecontenttitle"><div align="center"></div></td>
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="85%" class="pagecontenttitle">名称</td>
              </tr>
            </table></td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        </table>

	<%
		}
		if(iList>0)
		{
	%>        
    <div align="center"></div>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="contentbg"><br></tr>
	<tr class="title"> 
   	 <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="title"> 
          <td>已有关联需求列表:<br></td>
          <td width="24"> <div align="right"><br></div></td>
        </tr>
      </table></td>
  <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0"">
        <tr>
          <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" id="steplist">
              <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="50%" class="pagecontenttitle">名称</td>
                <td width="10%" class="pagecontenttitle">类型</td>
                <td width="10%" class="pagecontenttitle">关联人</td>
                <td width="10%" class="pagecontenttitle">操作时间</td>
                <td width="10%" class="pagecontenttitle">备注</td>
              </tr>
              <%
              	String RelationDemandId="";
              	String RelationDemandName="";
              	String RelateType="";
              	String RelateOpName="";
              	String RelateOpTime="";
              	String Remark="";
              	int i=0;

                for(int inum=iList-1;inum>=0;inum--)
                {
					i++;
					HashMap RemandRelationListHash = (HashMap) vRemandRelationList.get(inum);
					RelationDemandId = (String) RemandRelationListHash.get("DEMAND_RELATE");
					RemandRelationStr=RemandRelationStr+","+RelationDemandId;
					RelationDemandName = (String) RemandRelationListHash.get("RELATION_NAME");
					RelateType = (String) RemandRelationListHash.get("RELATE_TYPE");
					RelateOpName = (String) RemandRelationListHash.get("OP_NAME");
					RelateOpTime = (String) RemandRelationListHash.get("CREATE_TIME");
					Remark = (String) RemandRelationListHash.get("REMARK");						
              %>
             		 <tr>
			             <td class="<%if(i%2==0) out.print("coltext");else out.print("coltext2"); %>">(<%=i%>)</td>
			             <td class="<%if(i%2==0) out.print("coltext");else out.print("coltext2"); %>"><a href="http://10.10.10.158/demand/query/demd_query_detail.jsp?op_id=<%=RelationDemandId%>" target="_blank"><%if(RelationDemandId!=null)out.print(RelationDemandId); else out.print("&nbsp;");%></a></td>
			             <td class="<%if(i%2==0) out.print("coltext10");else out.print("coltext20"); %>"><%if(RelationDemandName!=null)out.print(RelationDemandName); else out.print("&nbsp;");%></td>
			             <td class="<%if(i%2==0) out.print("coltext");else out.print("coltext2"); %>"><%if(RelateType!=null){if(RelateType.equals("0"))out.print("关联需求");else out.print("源需求");} else out.print("&nbsp;");%></td>
			             <td class="<%if(i%2==0) out.print("coltext");else out.print("coltext2"); %>"><%if(RelateOpName!=null) out.print(RelateOpName); else out.print("&nbsp;");%></td>
			         	 <td class="<%if(i%2==0) out.print("coltext");else out.print("coltext2"); %>"><%if(RelateOpTime!=null) out.print(RelateOpTime); else out.print("&nbsp;");%></td>
			         	 <td class="<%if(i%2==0) out.print("coltext");else out.print("coltext2"); %>"><%if(Remark!=null) out.print(Remark); else out.print("&nbsp;");%></td>
			         </tr>
			   <%
					}
			   %>      
			 
            <tr> 
                <td width="5%" class="pagecontenttitle">序号</td>
                <td width="5%" class="pagecontenttitle">ID</td>
                <td width="50%" class="pagecontenttitle">名称</td>
                <td width="10%" class="pagecontenttitle">类型</td>
                <td width="10%" class="pagecontenttitle">关联人</td>
                <td width="10%" class="pagecontenttitle">操作时间</td>
                <td width="10%" class="pagecontenttitle">备注</td>
              </tr>
            </table></td>
        </tr>
        </table>
        </td>
        </tr>
        </table>
        <%
        	}
        %>
        </table>            
       
</form>
</body>	
</html>